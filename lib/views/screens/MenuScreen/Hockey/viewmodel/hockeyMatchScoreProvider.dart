import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:cricyard/views/screens/practice_match/practiceRepository/PracticeMatchService.dart';
import 'package:flutter/material.dart';

class HockeyMatchScoreProvider extends ChangeNotifier {
  late String hostTeam;
  late String visitorTeam;
  int homeFouls = 0;
  int awayFouls = 0;
  late String tossWinner;
  late String optedTo;
  late int matchId;
  int homeScore = 0;
  int awayScore = 0;
  int homePenalties = 0;
  int awayPenalties = 0;
  int minutes = 0;
  int seconds = 0;
  bool isTimerRunning = false;
  bool isMatchOver = false;
  Timer? matchTimer;
  List<String> matchEvents = [];
  List<Map<String, dynamic>> undoneEvents = [];
  List<Map<String, dynamic>> redoEvents = [];
  final PracticeMatchService scoreservice = PracticeMatchService();


  HockeyMatchScoreProvider({
    required this.hostTeam,
    required this.visitorTeam,
    required this.tossWinner,
    required this.optedTo,
    required this.matchId,
    });

  void startTimer() {
    if (!isTimerRunning) {
      isTimerRunning = true;
      matchTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (seconds < 59) {
          seconds++;
        } else {
          seconds = 0;
          minutes++;
        }
        notifyListeners();
      });
    }
  }

  void stopTimer() {
    if (isTimerRunning) {
      matchTimer?.cancel();
      isTimerRunning = false;
      notifyListeners();
    }
  }

  void resetMatch() {
    stopTimer();
    homeScore = 0;
    awayScore = 0;
    minutes = 0;
    seconds = 0;
    homePenalties = 0;
    awayPenalties = 0;
    matchEvents.clear();
    undoneEvents.clear();
    redoEvents.clear();
    notifyListeners();
  }

  String formattedTime() {
    return "$minutes:${seconds.toString().padLeft(2, '0')}";
  }

  // void addGoal(String team) {
  //   if (team == hostTeam) {
  //     homeScore++;
  //   } else {
  //     awayScore++;
  //   }
  //   _recordEvent({
  //     "type": "goal",
  //     "team": team,
  //     "score": team == hostTeam ? homeScore : awayScore,
  //     "time": formattedTime()
  //   });
  // }

  void addGoal(String team, BuildContext context) {
    TextEditingController goalScorerController = TextEditingController();
    TextEditingController assistController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Goal Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: goalScorerController,
                decoration: InputDecoration(labelText: "Goal Scorer"),
              ),
              TextField(
                controller: assistController,
                decoration: InputDecoration(labelText: "Assist (Optional)"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String goalScorer = goalScorerController.text.trim();
                String assist = assistController.text.trim();
                if (goalScorer.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter the goal scorer's name."),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }
                if (team == hostTeam) {
                  homeScore++;
                } else {
                  awayScore++;
                }
                Map<String, dynamic> event = {
                  "type": "goal",
                  "team": team,
                  "goalScorer": goalScorer,
                  "assist": assist.isNotEmpty ? assist : "None",
                  "time": formattedTime()
                };
                matchEvents.add(
                    "$team: $goalScorer scored at ${event['time']}" +
                        (assist.isNotEmpty ? " (Assist: $assist)" : "") +
                        " 🎉🎉");
                undoneEvents.add(event);
                redoEvents.clear();
                notifyListeners();
                try {
                  print("Add Goal called! ");
                  updateHockeyScore(1, "goal", event, context);
                  getupdatedscore(
                      context); // ✅ Fetch latest match data from backend
                } catch (e) {
                  print("Error on updating backend: $e");
                }
                Navigator.pop(context);
                bool isHomeTeamGoal = (team == hostTeam);
                _showConfettiAnimation(context, isHomeTeamGoal);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showConfettiAnimation(BuildContext context, bool isHomeTeamGoal) {
    ConfettiController confettiController =
        ConfettiController(duration: Duration(seconds: 2));
    confettiController.play(); // Start confetti animation
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) {
        return Positioned(
          top: MediaQuery.of(context).size.height * 0.1, // Adjust height
          left: isHomeTeamGoal ? 50 : null, // Confetti on left for home team
          right: !isHomeTeamGoal ? 50 : null, // Confetti on right for away team
          child: ConfettiWidget(
            confettiController: confettiController,
            // blastDirection: isHomeTeamGoal ? pi : 0, // Left for home, right for away
            blastDirection: pi / 2, // Left for home, right for away
            emissionFrequency: 0.05, // Frequency of confetti
            numberOfParticles: 80, // Number of confetti particles
            gravity: 0.5, // How fast confetti falls
            shouldLoop: false, // Run once and stop
          ),
        );
      },
    );
    Overlay.of(context)?.insert(overlayEntry);
    // Remove confetti animation after a delay
    Future.delayed(Duration(seconds: 3), () {
      confettiController.stop();
      overlayEntry.remove();
    });
  }

  void addFoul(String team, BuildContext context) {
    TextEditingController playerController = TextEditingController();
    String? selectedFoulType;
    String? selectedCard;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Foul Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: playerController,
                decoration:
                    InputDecoration(labelText: "Player Who Committed Foul"),
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "Foul Type"),
                items: ["Normal Foul", "Handball", "Dangerous Play", "Other"]
                    .map((type) =>
                        DropdownMenuItem(value: type, child: Text(type)))
                    .toList(),
                onChanged: (value) {
                  selectedFoulType = value;
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: "Card Given"),
                items: ["None", "Yellow Card", "Red Card"]
                    .map((card) =>
                        DropdownMenuItem(value: card, child: Text(card)))
                    .toList(),
                onChanged: (value) {
                  selectedCard = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close dialog without saving
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String player = playerController.text.trim();
                if (player.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter the player's name."),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                if (team == "$hostTeam") {
                  homeFouls++;
                } else {
                  awayFouls++;
                }
                Map<String, dynamic> event = {
                  "type": "foul",
                  "team": team,
                  "player": player,
                  "foulType": selectedFoulType ?? "Normal Foul",
                  "card": selectedCard ?? "None",
                  "time": "$minutes:${seconds.toString().padLeft(2, '0')}"
                };

                // Add the event to match events
                matchEvents.add(
                    "$team: $player committed a ${selectedFoulType ?? "Normal Foul"} foul at ${event['time']}" +
                        ({selectedCard ?? "No Card"} != "None"
                            ? " (${selectedCard ?? "No Card"} given)"
                            : ""));
                // Push the event onto the undoneEvents stack
                undoneEvents.add(event);
                redoEvents.clear(); // Clear redo stack on new action
                notifyListeners();

                try {
                  updateHockeyScore(0, "foul", event, context);
                  getupdatedscore(
                      context); // ✅ Fetch latest match data from backend
                } catch (e) {
                  print("Error on updating backend: $e");
                }
                Navigator.pop(context); // Close the dialog
                _scrollToBottom(); // Scroll to latest event
                bool isHomeTeamGoal = (team == "$hostTeam");
                if (selectedCard != null && selectedCard != "None") {
                  _showCardAnimation(context, selectedCard!, isHomeTeamGoal);
                }
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void _showCardAnimation(
      BuildContext context, String cardType, bool isHomeTeamGoal) {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) {
        // Adding a delay inside the builder
        return FutureBuilder(
          future: Future.delayed(Duration(milliseconds: 700)), // 1-second delay
          builder: (context, snapshot) {
            // Once the delay is over, the card is shown and the animation begins
            if (snapshot.connectionState == ConnectionState.done) {
              return Positioned(
                left: isHomeTeamGoal ? 0 : null, // Home team goal on the left
                right:
                    !isHomeTeamGoal ? 0 : null, // Away team goal on the right
                top: MediaQuery.of(context).size.height * 0.2,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: 25.0), // Padding to avoid touching the edges
                  child: Center(
                    child: TweenAnimationBuilder(
                      tween: Tween<double>(
                          begin: 0, end: pi), // 0 to 180° rotation
                      duration: Duration(milliseconds: 1000), // Flip speed
                      builder: (context, double angle, child) {
                        bool isFront = angle < pi / 2; // Front side condition

                        return AnimatedOpacity(
                          opacity: angle >= pi / 2
                              ? 0.0
                              : 1.0, // Fade out after the flip is done
                          duration:
                              Duration(milliseconds: 700), // Fade-out duration
                          child: Transform(
                            alignment: Alignment.center,
                            transform: Matrix4.identity()
                              ..setEntry(3, 2, 0.002) // Perspective effect
                              ..rotateY(angle), // Rotate on Y-axis
                            child: Container(
                              width: 100,
                              height: 150,
                              decoration: BoxDecoration(
                                color: isFront
                                    ? (cardType == "Yellow Card"
                                        ? Colors.yellow
                                        : Colors.red)
                                    : (cardType == "Yellow Card"
                                        ? Colors.yellow
                                        : Colors.red),
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black26, blurRadius: 10),
                                ],
                              ),
                              child: Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..rotateY(isFront
                                      ? 0
                                      : pi), // Keep text always upright
                                child: Center(
                                  child: Text(
                                    cardType,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              );
            } else {
              return SizedBox(); // Return an empty widget while waiting for the delay
            }
          },
        );
      },
    );

    Overlay.of(context)?.insert(overlayEntry);

    // Keep it visible for 2 seconds before removing
    Future.delayed(Duration(seconds: 3), () {
      overlayEntry.remove();
    });
  }

  void _scrollToBottom() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _scrollToTop() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _scrollUpByAmount() {
    Future.delayed(Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        // Define the amount you want to scroll up, for example, 100 pixels
        double offset = 50.0;

        // Calculate the new position
        double newPosition = _scrollController.position.pixels - offset;

        // Ensure that the position doesn't go beyond the scrollable area
        newPosition = newPosition < _scrollController.position.minScrollExtent
            ? _scrollController.position.minScrollExtent
            : newPosition;

        _scrollController.animateTo(
          newPosition,
          duration: Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }
  final ScrollController _scrollController = ScrollController();

  void addPenalty(String team, BuildContext context) {
    if (team == hostTeam) {
      homePenalties++;
    } else {
      awayPenalties++;
    }
    Map<String, dynamic> event = {
      "type": "penalty",
      "team": team,
      "penalties": team == hostTeam ? homePenalties : awayPenalties,
      "time": formattedTime()
    };
    matchEvents.add("$team received a penalty at ${event['time']}");
    undoneEvents.add(event);
    redoEvents.clear();
    notifyListeners();
    try {
      updateHockeyScore(0, "penalty", event, context);
    } catch (e) {
      print("Error updating backend: $e");
    }
  }

  void _recordEvent(Map<String, dynamic> event) {
    matchEvents.add("${event['team']} ${event['type']} at ${event['time']}");
    undoneEvents.add(event);
    redoEvents.clear();
    notifyListeners();
  }

  void undoEvent(BuildContext context) {
    if (undoneEvents.isNotEmpty) {
      Map<String, dynamic> lastEvent = undoneEvents.removeLast();
      redoEvents.add(lastEvent);

      if (lastEvent["type"] == "goal") {
        if (lastEvent["team"] == hostTeam && homeScore > 0) {
          homeScore--;
        } else if (lastEvent["team"] == visitorTeam && awayScore > 0) {
          awayScore--;
        }
      } else if (lastEvent["type"] == "penalty") {
        if (lastEvent["team"] == hostTeam && homePenalties > 0) {
          homePenalties--;
        } else if (lastEvent["team"] == visitorTeam && awayPenalties > 0) {
          awayPenalties--;
        }
      }
      try {
        updateHockeyScore(0, "undo", lastEvent, context);
      } catch (e) {
        print("Error on updating backend for undo: $e");
      }

      matchEvents.removeLast();
      notifyListeners();
    }
  }

  void redoEvent(BuildContext context) {
    if (redoEvents.isNotEmpty) {
      Map<String, dynamic> eventToRedo = redoEvents.removeLast();
      undoneEvents.add(eventToRedo);

      if (eventToRedo["type"] == "goal") {
        if (eventToRedo["team"] == hostTeam) {
          homeScore++;
        } else {
          awayScore++;
        }
      } else if (eventToRedo["type"] == "penalty") {
        if (eventToRedo["team"] == hostTeam) {
          homePenalties++;
        } else {
          awayPenalties++;
        }
      }

      matchEvents.add(
          "${eventToRedo['team']} ${eventToRedo['type']} at ${eventToRedo['time']}");
      notifyListeners();
       try {
        // ✅ Send redo update to backend
        updateHockeyScore(0, "redo", eventToRedo, context);
      } catch (e) {
        print("Error updating backend for redo: $e");
      }
    }
  }

  void endMatch(BuildContext context) {
    stopTimer();
    isMatchOver = true;
    matchEvents.add(
        "Match has ended. Final Score: $hostTeam $homeScore - $awayScore $visitorTeam");

    Map<String, dynamic> matchEndEvent = {
      "type": "match_end",
      "home_score": homeScore,
      "away_score": awayScore,
      "home_penalties": homePenalties,
      "away_penalties": awayPenalties,
      "match_end": true,
      "time": formattedTime(),
      "events": matchEvents,
    };
    print("🔄 Sending match end update to backend...");
    updateHockeyScore(0, "match_end", matchEndEvent, context);
    print("✅ Match ended successfully!");

    // ✅ Fetch updated match data from backend to verify
     getupdatedscore(context);

    notifyListeners();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Match Ended"),
          content: Text(
              "Final Score:\n$hostTeam $homeScore - $awayScore $visitorTeam"),
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

  bool showOverLay = false;

  Future<void> updateHockeyScore(
      int scdata, eventType, scoreboard, BuildContext context) async {
    showOverLay = true;
    print(
        "updateHockeyScore called with eventType: $eventType, data: $scdata"); // ✅ Log function call
    notifyListeners();
    Map<String, dynamic> payload = {
      "match_id": matchId,
      "home_score": homeScore,
      "away_score": awayScore,
      "home_fouls": homeFouls,
      "away_fouls": awayFouls,
      "match_end": isMatchOver,
      "current_time": "$minutes:$seconds",
      "events": matchEvents, // ✅ Pass all stored match events
    };
    try {
      // await scoreservice.updateScore(scdata, type, scoreboard).then((_) {
      print(
          "Sending request to backend with payload: $payload"); // ✅ Log request payload

      // Check for any null values
      payload.forEach((key, value) {
        if (value == null) {
          print("❌ ERROR: $key is NULL");
        }
      });
      await scoreservice.updateScore(scdata, eventType, payload).then((_) {
        getLastRecordHockey(context).then(
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
  Map<String, dynamic> lastRecord = {};
bool islastrecord = true;
  var opted_to = '';
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

  bool isLoadingData = false;

  Future<void> getLastRecordHockey(BuildContext context) async {
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


  

}
