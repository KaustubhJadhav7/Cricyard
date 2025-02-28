import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:cricyard/views/screens/practice_match/practiceRepository/PracticeMatchService.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';

class TennisDoublesProvider extends ChangeNotifier {
  final List<String> team1;
  final List<String> team2;
  final int matchId; // ✅ Add matchId
  Map<String, dynamic> lastRecord = {};
  bool isLoadingData = false;
  bool showOverLay = false;
  // var matchId = 0;
  bool islastrecord = true;
  var opted_to = '';
  bool isMatchOver = false;
  late String hostTeam;
  late String visitorTeam;
  late String tossWinner;
  late String optedTo;
  final PracticeMatchService scoreservice = PracticeMatchService();

  List<int> team1Sets = [0];
  List<int> team2Sets = [0];
  int team1Points = 0;
  int team2Points = 0;
  int team1Games = 0;
  int team2Games = 0;
  String winner = "";
  bool matchEnded = false;
  List<String> matchEvents = [];
  List<Map<String, dynamic>> undoneEvents = [];
  List<Map<String, dynamic>> redoEvents = [];

  final ScrollController scrollController = ScrollController();

  TennisDoublesProvider({
    required this.team1,
    required this.team2,
    required this.matchId,
  });

  String get team1Score => _formatPoints(team1Points);
  String get team2Score => _formatPoints(team2Points);

  void addPointToTeam1(BuildContext context) {
    showScorerDialog(context, team1, (String player) {
      _updateScore(1, context, player: player); // ✅ Pass player name
    });
  }

  void addPointToTeam2(BuildContext context) {
    showScorerDialog(context, team2, (String player) {
      _updateScore(2, context, player: player); // ✅ Pass player name
    });
  }

  void _updateScore(int team, BuildContext context, {required String player}) {
    List<String> teamList = (team == 1) ? team1 : team2;
    // ✅ Store both `team` and `player`
    Map<String, dynamic> event = {
      "type": "point",
      "team": List<String>.from(teamList),
      "player": player ?? "Unknown Player" // ✅ Prevents null errors
    };
    undoneEvents.add(event);
    redoEvents.clear();
    if (team == 1) {
      team1Points++;
      matchEvents.add(
          "$player scored a point for ${team1.join(' & ')}"); // ✅ Player-specific log
    } else {
      team2Points++;
      matchEvents.add(
          "$player scored a point for ${team2.join(' & ')}"); // ✅ Player-specific log
    }
    _scrollToBottom();

    if (_checkGameWin(team1Points, team2Points)) {
      team1Games++;
      matchEvents.add("${team1.join(' & ')} won a Game!");
      undoneEvents.add({"type": "game", "team": List<String>.from(team1)});
      _scrollToBottom();
      team1Points = 0;
      team2Points = 0;
      if (_checkSetWin(team1Games, team2Games)) {
        team1Sets.last++;
        matchEvents.add("${team1.join(' & ')} won a Set!");
        undoneEvents.add({"type": "set", "team": List<String>.from(team1)});
        _scrollToBottom();
        team1Games = 0;
        team2Games = 0;
        _checkMatchWin();
      }
    }
    notifyListeners();
    // ✅ Send updated score to backend
    updateTennisDoublesScore(team1Points, "point", context);
  }

  bool _checkGameWin(int teamPoints, int opponentPoints) {
    return teamPoints >= 4 && teamPoints >= opponentPoints + 2;
  }

  bool _checkSetWin(int teamGames, int opponentGames) {
    return teamGames >= 6 && teamGames >= opponentGames + 2;
  }

  void _checkMatchWin() {
    if (team1Sets.last == 2) {
      winner = team1.join(" & ");
    } else if (team2Sets.last == 2) {
      winner = team2.join(" & ");
    }
  }

  void showScorerDialog(
      BuildContext context, List<String> team, Function(String) addPoint) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Who Scored the Point?"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: team.map((player) {
              return ListTile(
                title: Text(player),
                onTap: () {
                  // ✅ Ensure we store valid data
                  Map<String, dynamic> event = {
                    "type": "point",
                    "team": List<String>.from(
                        team), // ✅ Ensure team is a List<String>
                    "player": player.isNotEmpty
                        ? player
                        : "Unknown Player", // ✅ Prevent null player
                  };
                  undoneEvents.add(event);
                  redoEvents.clear();

                  // ✅ Log which player scored
                  // matchEvents.add("$player scored a point for ${team.join(" & ")}");

                  _scrollToBottom();

                  addPoint(player); // ✅ Now we pass the player name
                  Navigator.pop(context);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  void resetMatch(BuildContext context) async {
    team1Points = 0;
    team2Points = 0;
    team1Games = 0;
    team2Games = 0;
    team1Sets = [0];
    team2Sets = [0];
    winner = "";
    matchEvents.clear();
    undoneEvents.clear();
    redoEvents.clear();
    notifyListeners();

    // ✅ Prepare backend payload
    Map<String, dynamic> resetPayload = {
      "match_id": matchId,
      "match_end": false, // Reset match status
      "events": [], // Clear events in backend
      'team1Points': 0,
      'team2Points': 0,
      'team1Games': 0,
      'team2Games': 0,
      'team1Sets': 0,
      'team2Sets': 0,
      'winner': "",
    };

    try {
      print("🔄 Resetting match with matchId: $matchId");
      await scoreservice.updateScore(0, "reset", resetPayload);
      showSnackBar(context, "Match Reset Successfully", Colors.green);
    } catch (e) {
      print("❌ Error resetting match: $e");
      showSnackBar(context, "Failed to reset match. Try again!", Colors.red);
    } finally {
      notifyListeners();
    }
  }

  String _formatPoints(int points) {
    switch (points) {
      case 0:
        return "Love";
      case 1:
        return "15";
      case 2:
        return "30";
      case 3:
        return "40";
      default:
        return "Game";
    }
  }

  void endMatch(BuildContext context) async {
    matchEnded = true;
    matchEvents.add(
        "Match has ended. Final Score: ${team1.join(" & ")} ${team1Sets.last} - ${team2Sets.last} ${team2.join(" & ")}");
    _scrollToBottom();
    notifyListeners();

    // ✅ Prepare backend payload
    Map<String, dynamic> endMatchPayload = {
      "match_id": matchId,
      "match_end": true, // ✅ Mark match as ended
      "events": matchEvents, // ✅ Log all match events
      'team1Points': team1Points,
      'team2Points': team2Points,
      'team1Games': team1Games,
      'team2Games': team2Games,
      'team1Sets': team1Sets.last,
      'team2Sets': team2Sets.last,
      'winner': winner.isNotEmpty
          ? winner
          : "${team1Sets.last > team2Sets.last ? team1.join(" & ") : team2.join(" & ")}",
    };

    try {
      print("🏆 Ending match with matchId: $matchId");
      await scoreservice.updateScore(0, "end", endMatchPayload);
      showSnackBar(context, "Match Ended Successfully", Colors.green);
    } catch (e) {
      print("❌ Error ending match: $e");
      showSnackBar(context, "Failed to end match. Try again!", Colors.red);
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Match Ended"),
          content: Text(
              "Final Score:\n${team1.join(" & ")} ${team1Sets.last} - ${team2Sets.last} ${team2.join(" & ")}"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  bool _areTeamsEqual(List<String> teamA, List<String> teamB) {
    return ListEquality().equals(teamA, teamB);
  }

  void undoEvent(BuildContext context) async {
    if (undoneEvents.isNotEmpty) {
      Map<String, dynamic> lastEvent = undoneEvents.removeLast();
      redoEvents.add(lastEvent);

      if (matchEvents.isNotEmpty) {
        matchEvents.removeLast();
      }

      String player = lastEvent["player"] ?? "Unknown Player";
      List<String> team = lastEvent["team"] is List<String>
          ? lastEvent["team"]
          : ["Unknown Team"];

      switch (lastEvent["type"]) {
        case "point":
          if (_areTeamsEqual(team, team1) && team1Points > 0) {
            team1Points--;
          } else if (_areTeamsEqual(team, team2) && team2Points > 0) {
            team2Points--;
          }
          matchEvents.add("Undo: Lost a point for ${team.join(" & ")}");
          break;

        case "game":
          if (_areTeamsEqual(team, team1) && team1Games > 0) {
            team1Games--;
            team1Points = 40; // ✅ Restore points to before winning
          } else if (_areTeamsEqual(team, team2) && team2Games > 0) {
            team2Games--;
            team2Points = 40; // ✅ Restore points to before winning
          }
          break;

        case "set":
          if (_areTeamsEqual(team, team1) && team1Sets.last > 0) {
            team1Sets.last--;
          } else if (_areTeamsEqual(team, team2) && team2Sets.last > 0) {
            team2Sets.last--;
          }
          break;
      }
      notifyListeners();
      await _syncUndoWithBackend(context);
    }
  }

  void redoEvent(BuildContext context) async {
    if (redoEvents.isNotEmpty) {
      Map<String, dynamic> eventToRedo = redoEvents.removeLast();
      undoneEvents.add(eventToRedo);

      String player = eventToRedo["player"] ?? "Unknown Player";
      List<String> team = eventToRedo["team"] is List<String>
          ? eventToRedo["team"]
          : ["Unknown Team"];

      switch (eventToRedo["type"]) {
        case "point":
          if (_areTeamsEqual(team, team1)) {
            team1Points++;
          } else if (_areTeamsEqual(team, team2)) {
            team2Points++;
          }
          matchEvents.add("Regained a point for ${team.join(" & ")}");
          break;

        case "game":
          if (_areTeamsEqual(team, team1)) {
            team1Games++;
            matchEvents.add("${team1.join(" & ")} regained a Game");
          } else if (_areTeamsEqual(team, team2)) {
            team2Games++;
            matchEvents.add("${team2.join(" & ")} regained a Game");
          }
          break;

        case "set":
          if (_areTeamsEqual(team, team1)) {
            team1Sets.last++;
            matchEvents.add("${team1.join(" & ")} regained a Set");
          } else if (_areTeamsEqual(team, team2)) {
            team2Sets.last++;
            matchEvents.add("${team2.join(" & ")} regained a Set");
          }
          break;
      }
      notifyListeners();
      _scrollToBottom();
      // ✅ Send updated score to backend
      await _syncRedoWithBackend(context);
    }
  }

  Future<void> _syncUndoWithBackend(BuildContext context) async {
    if (matchId == 0) {
      print("❌ Error: matchId is missing! Cannot undo event.");
      showSnackBar(context, "Error!! Match ID is missing.", Colors.red);
      return;
    }

    // ✅ Prepare undo payload
    Map<String, dynamic> undoPayload = {
      "match_id": matchId,
      "match_end": matchEnded,
      "events": matchEvents,
      'team1Points': team1Points,
      'team2Points': team2Points,
      'team1Games': team1Games,
      'team2Games': team2Games,
      'team1Sets': team1Sets.last,
      'team2Sets': team2Sets.last,
      'winner': winner.isNotEmpty ? winner : "TBD",
    };

    try {
      print("⏪ Undoing last event for matchId: $matchId");
      await scoreservice.updateScore(0, "undo", undoPayload);
      showSnackBar(context, "Undo Successful", Colors.green);
    } catch (e) {
      print("❌ Error undoing event: $e");
      showSnackBar(context, "Failed to undo event. Try again!", Colors.red);
    }
  }

  Future<void> _syncRedoWithBackend(BuildContext context) async {
    if (matchId == 0) {
      print("❌ Error: matchId is missing! Cannot redo event.");
      showSnackBar(context, "Error!! Match ID is missing.", Colors.red);
      return;
    }

    // ✅ Prepare redo payload
    Map<String, dynamic> redoPayload = {
      "match_id": matchId,
      "match_end": matchEnded,
      "events": matchEvents,
      'team1Points': team1Points,
      'team2Points': team2Points,
      'team1Games': team1Games,
      'team2Games': team2Games,
      'team1Sets': team1Sets.last,
      'team2Sets': team2Sets.last,
      'winner': winner.isNotEmpty ? winner : "TBD",
    };

    try {
      print("🔄 Redoing last event for matchId: $matchId");
      await scoreservice.updateScore(0, "redo", redoPayload);
      showSnackBar(context, "Redo Successful", Colors.green);
    } catch (e) {
      print("❌ Error redoing event: $e");
      showSnackBar(context, "Failed to redo event. Try again!", Colors.red);
    }
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  Future<void> updateTennisDoublesScore(
      int scdata, String eventType, BuildContext context) async {
    if (matchId == 0) {
      print("❌ Error: matchId is not set. Fetching match data...");
      await getLastRecordTennisDoubles(context); // ✅ Fetch matchId if missing
      if (matchId == 0) {
        showSnackBar(context, 'Error!! Match ID is missing.', Colors.red);
        return;
      }
    }

    showOverLay = true;
    notifyListeners();

    Map<String, dynamic> payload = {
      "match_id": matchId, // ✅ Ensure matchId is included
      "match_end": matchEnded,
      "events": matchEvents,
      'team1Points': team1Points,
      'team2Points': team2Points,
      'team1Games': team1Games,
      'team2Games': team2Games,
      'team1Sets': team1Sets.last,
      'team2Sets': team2Sets.last,
      'winner': winner,
    };

    try {
      print("🔄 Sending updated Tennis Doubles score with matchId: $matchId");
      await scoreservice.updateScore(scdata, eventType, payload).then((_) {
        getLastRecordTennisDoubles(context).then((_) {
          showOverLay = false;
          notifyListeners();
          showSnackBar(context, 'Update Successful', Colors.green);
        });
      });
    } catch (e) {
      showOverLay = false;
      notifyListeners();
      showSnackBar(context, 'Error updating score: $e', Colors.red);
    } finally {
      showOverLay = false;
      notifyListeners();
    }
  }

  void showSnackBar(BuildContext context, String msg, Color color) {
    final mediaQuery = MediaQuery.of(context);
    final topPadding = mediaQuery.viewPadding.bottom;
    const snackBarHeight = 50.0; // Approximate height of SnackBar
    final topMargin = topPadding + snackBarHeight + 700; // Add some padding
    SnackBar snackBar = SnackBar(
      margin: EdgeInsets.only(bottom: topMargin, left: 16.0, right: 16.0),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      // Make background transparent to show custom design
      elevation: 0,
      // Remove default elevation to apply custom shadow
      content: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [color.withOpacity(0.8), color],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  offset: Offset(0, 4),
                  blurRadius: 10.0,
                ),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                const Icon(
                  Icons.info_rounded,
                  color: Colors.white,
                  size: 28.0, // Slightly larger icon
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    msg,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 16.0, // Slightly larger text
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  },
                ),
              ],
            ),
          ),
          Positioned(
            left: -15,
            top: -15,
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Positioned(
            right: -10,
            bottom: -10,
            child: Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  Future<void> getLastRecordTennisDoubles(BuildContext context) async {
    isLoadingData = true;
    notifyListeners(); // ✅ Notify UI update

    try {
      final fetchedEntities = await scoreservice.getlastrecord(matchId);
      print("🎾 LAST RECORD!! --$fetchedEntities");

      if (fetchedEntities != null && fetchedEntities.isNotEmpty) {
        islastrecord = true;
        lastRecord = fetchedEntities;

        // ✅ Fetch and update match data safely
        team1Points = lastRecord['team1Points'] ?? team1Points;
        team2Points = lastRecord['team2Points'] ?? team2Points;
        team1Games = lastRecord['team1Games'] ?? team1Games;
        team2Games = lastRecord['team2Games'] ?? team2Games;
        team1Sets = [lastRecord['team1Sets'] ?? team1Sets.last];
        team2Sets = [lastRecord['team2Sets'] ?? team2Sets.last];
        winner = lastRecord['winner'] ?? winner;
        matchEnded = lastRecord['match_end'] ?? false;

        notifyListeners();
      } else {
        print("❌ Warning: Empty last record received.");
      }
    } catch (e) {
      print("❌ Error fetching last record: $e");
      showSnackBar(context, 'Failed to fetch last match record.', Colors.red);
    } finally {
      isLoadingData = false;
      notifyListeners();
    }
  }
}
