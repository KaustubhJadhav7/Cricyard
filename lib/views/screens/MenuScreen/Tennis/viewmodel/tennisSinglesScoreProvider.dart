import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:cricyard/views/screens/practice_match/practiceRepository/PracticeMatchService.dart';
import 'package:flutter/material.dart';

class TennisScoreProvider extends ChangeNotifier {
  final String player1;
  final String player2;
  final int matchId; // ✅ Add matchId
  List<int> player1Sets = [0];
  List<int> player2Sets = [0];
  int player1Points = 0;
  int player2Points = 0;
  int player1Games = 0;
  int player2Games = 0;
  String winner = "";
  bool matchEnded = false;
  List<String> matchEvents = [];
  List<Map<String, dynamic>> undoneEvents = [];
  List<Map<String, dynamic>> redoEvents = [];

  final PracticeMatchService scoreservice = PracticeMatchService();
  final ScrollController scrollController = ScrollController();

  TennisScoreProvider({
    required this.player1, 
    required this.player2,
    required this.matchId, // ✅ Ensure matchId is passed
  });

  String get player1Score => _formatPoints(player1Points);
  String get player2Score => _formatPoints(player2Points);

  void addPointToPlayer1(BuildContext context) {
    _updateScore(1, context);
  }

  void addPointToPlayer2(BuildContext context) {
    _updateScore(2, context);
  }

Future<void> sendScoreUpdate(BuildContext context, String eventType) async {
  try {
    await updateTennisScore(
      matchId, // ✅ Match ID
      eventType, // ✅ Type of event (point, game, set)
      {}, // ✅ Unused parameter, keeping for compatibility
      context, // ✅ Pass context for UI feedback
    );
  } catch (e) {
    print("❌ Error updating score: $e");
  }
}


  Future<void> updateTennisScore(
      int scdata, eventType, scoreboard, BuildContext context) async {
    showOverLay = true;
    if (matchId == 0) {
    print("⚠ Warning: matchId is not set!");
    showSnackBar(context, 'Error!! Match ID is missing.', Colors.red);
    return; // ✅ Prevents function from executing with an uninitialized matchId
  }

    print(
        "updateTennisScore called with eventType: $eventType, data: $scdata"); // ✅ Log function call
    notifyListeners();
    Map<String, dynamic> payload = {
      "match_id": matchId,
      "match_end": isMatchOver,
      "events": matchEvents, // ✅ Pass all stored match events
      'player1Points': player1Points,
      'player2Points': player2Points,
      'player1Games': player1Games,
      'player2Games': player2Games,
      'player1Sets': player1Sets.last,
      'player2Sets': player2Sets.last,
      'winner': winner,
    };
    try {
      print(
          "Sending request to backend with payload: $payload"); // ✅ Log request payload

      // Check for any null values
      payload.forEach((key, value) {
        if (value == null) {
          print("❌ ERROR: $key is NULL");
        }
      });
      await scoreservice.updateScore(scdata, eventType, payload).then((_) {
        getLastRecordTennis(context).then(
          (value) {
            showOverLay = false;
            notifyListeners();
            showSnackBar(context, 'Update Successful', Colors.green);
          },
        );
      });
    } catch (e) {
      showOverLay = false;
      notifyListeners();
      showSnackBar(context, 'Error updating $e', Colors.red);
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

  void _updateScore(int player, BuildContext context) async {
    Map<String, dynamic> event = {"type": "point", "player": player};
    undoneEvents.add(event);
    redoEvents.clear();

    if (player == 1) {
      player1Points++;
      matchEvents.add("$player1 won a point");
      _scrollToBottom();
      if (_checkGameWin(player1Points, player2Points)) {
        player1Games++;
        matchEvents.add("$player1 won a Game!");
        undoneEvents.add({"type": "game", "player": 1}); // ✅ Store game event
        _scrollToBottom();
        player1Points = 0;
        player2Points = 0;
        if (_checkSetWin(player1Games, player2Games)) {
          player1Sets.last++;
          matchEvents.add("$player1 won a Set!");
          undoneEvents.add({"type": "set", "player": 1}); // ✅ Store set event
          _scrollToBottom();
          player1Games = 0;
          player2Games = 0;
          _checkMatchWin();
        }
      }
    } else {
      player2Points++;
      matchEvents.add("$player1 won a point");
      _scrollToBottom();
      if (_checkGameWin(player2Points, player1Points)) {
        player2Games++;
        matchEvents.add("$player2 won a Game!");
        undoneEvents.add({"type": "game", "player": 2}); // ✅ Store game event
        _scrollToBottom();
        player1Points = 0;
        player2Points = 0;
        if (_checkSetWin(player2Games, player1Games)) {
          player2Sets.last++;
          matchEvents.add("$player2 won a Set!");
          undoneEvents.add({"type": "set", "player": 2}); // ✅ Store set event
          _scrollToBottom();
          player1Games = 0;
          player2Games = 0;
          _checkMatchWin();
        }
      }
    }
    notifyListeners();
    // ✅ Send update to backend after score change
  await sendScoreUpdate(context, "point");
  }

  bool _checkGameWin(int playerPoints, int opponentPoints) {
    return playerPoints >= 4 && playerPoints >= opponentPoints + 2;
  }

  bool _checkSetWin(int playerGames, int opponentGames) {
    return playerGames >= 6 && playerGames >= opponentGames + 2;
  }

  void _checkMatchWin() {
    if (player1Sets.last == 2) {
      winner = player1;
    } else if (player2Sets.last == 2) {
      winner = player2;
    }
  }

  void resetMatch(BuildContext context) async {
    player1Points = 0;
    player2Points = 0;
    player1Games = 0;
    player2Games = 0;
    player1Sets = [0];
    player2Sets = [0];
    winner = "";
    matchEvents.clear();
    undoneEvents.clear();
    redoEvents.clear();
    notifyListeners();
    await sendScoreUpdate(context, "reset");
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

  void endMatch(BuildContext context) async{
    matchEnded = true;
    matchEvents.add(
        "Match has ended. Final Score: $player1 ${player1Sets.last} - ${player2Sets.last} $player2");
    _scrollToBottom();
    notifyListeners();

    // ✅ Sync with backend
  await sendScoreUpdate(context, "match_end");

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Match Ended"),
          content: Text(
              "Final Score:\n$player1 ${player1Sets.last} - ${player2Sets.last} $player2"),
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

   void undoEvent(BuildContext context) async {
  if (undoneEvents.isNotEmpty) {
    Map<String, dynamic> lastEvent = undoneEvents.removeLast();
    redoEvents.add(lastEvent);
    matchEvents.removeLast();

    switch (lastEvent["type"]) {
      case "point":
        if (lastEvent["player"] == 1 && player1Points > 0) {
          player1Points--;
        } else if (lastEvent["player"] == 2 && player2Points > 0) {
          player2Points--;
        }
        break;
      
      case "game":
        if (lastEvent["player"] == 1 && player1Games > 0) {
          player1Games--;
        } else if (lastEvent["player"] == 2 && player2Games > 0) {
          player2Games--;
        }
        break;
      
      case "set":
        if (lastEvent["player"] == 1 && player1Sets.last > 0) {
          player1Sets.last--;
        } else if (lastEvent["player"] == 2 && player2Sets.last > 0) {
          player2Sets.last--;
        }
        break;
    }
    notifyListeners();
    // ✅ Sync with backend
    await sendScoreUpdate(context, "undo");
  }
}


  void redoEvent(BuildContext context) async {
  if (redoEvents.isNotEmpty) {
    Map<String, dynamic> eventToRedo = redoEvents.removeLast();
    undoneEvents.add(eventToRedo);

    switch (eventToRedo["type"]) {
      case "point":
        if (eventToRedo["player"] == 1) {
          player1Points++;
          matchEvents.add("$player1 regained a point");
        } else if (eventToRedo["player"] == 2) {
          player2Points++;
          matchEvents.add("$player2 regained a point");
        }
        break;

      case "game":
        if (eventToRedo["player"] == 1) {
          player1Games++;
          matchEvents.add("$player1 regained a Game");
        } else if (eventToRedo["player"] == 2) {
          player2Games++;
          matchEvents.add("$player2 regained a Game");
        }
        break;

      case "set":
        if (eventToRedo["player"] == 1) {
          player1Sets.last++;
          matchEvents.add("$player1 regained a Set");
        } else if (eventToRedo["player"] == 2) {
          player2Sets.last++;
          matchEvents.add("$player2 regained a Set");
        }
        break;
    }
    notifyListeners();
    _scrollToBottom();
    // ✅ Sync with backend
    await sendScoreUpdate(context, "redo");
  }
}

  late String hostTeam;
  late String visitorTeam;
  late String tossWinner;
  late String optedTo;
  // int matchId = 0;

  Future<void> getupdatedscore(BuildContext context) async {
    try {
      final fetchedEntities = await scoreservice.getlastrecord(matchId);
      print("LAST RECORD!! --$fetchedEntities");
      if (fetchedEntities != null && fetchedEntities.isNotEmpty) {
        islastrecord = true;
        lastRecord = fetchedEntities;
        // if (lastRecord['hostTeam'] != null) {
        //   hostTeam = lastRecord['hostTeam'];
        // }
        // if (lastRecord['visitorTeam'] != null) {
        //   visitorTeam = lastRecord['visitorTeam'];
        // }
        // if (lastRecord['tossWinner'] != null) {
        //   tossWinner = lastRecord['tossWinner'];
        // }
        // if (lastRecord['opted_to'] != null) {
        //   opted_to = lastRecord['opted_to'];
        // }
        // if (lastRecord['match_end'] != null) {
        //   isMatchOver = lastRecord['match_end'];
        // }
        // ✅ Simplified Null-Safe Access
        hostTeam = lastRecord['hostTeam'] ?? hostTeam;
        visitorTeam = lastRecord['visitorTeam'] ?? visitorTeam;
        tossWinner = lastRecord['tossWinner'] ?? tossWinner;
        opted_to = lastRecord['opted_to'] ?? opted_to;
        isMatchOver = lastRecord['match_end'] ?? false;
        notifyListeners(); // ✅ Notify UI to update stoppage time
      } else {
        print("❌ Warning: Empty last record received.");
      }
    } catch (e) {
      print("❌ Error fetching last record: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
              'Failed to fetch : $e',
              style: const TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

   Map<String, dynamic> lastRecord = {};
   bool isLoadingData = false;
  bool showOverLay = false;
  // var matchId = 0;
  bool islastrecord = true;
  var opted_to = '';
  bool isMatchOver = false;

  Future<void> getLastRecordTennis(BuildContext context) async {
    isLoadingData = true;
    notifyListeners(); // ✅ Notify UI to update stoppage time

    try {
      await getupdatedscore(context);
      // await getLastRecOfPlayer();
      // await fetchBattingPlayers();
      // await fetchBowlingPlayers();
      // await fetchPartnership();
      // await fetchExtraRuns();
      // await allBalls();
    } catch (e) {
      // Log the error and display a message to the user
      print("Error occurred: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
              'Failed to fetch data: $e',
              style: const TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                child: const Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } finally {
      // Ensure isLoadingData is set to false regardless of success or failure

      // isLoadingData = false;
      notifyListeners(); // ✅ Notify UI to update stoppage time
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
}
