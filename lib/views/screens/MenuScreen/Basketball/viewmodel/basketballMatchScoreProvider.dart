import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:cricyard/views/screens/practice_match/practiceRepository/PracticeMatchService.dart';
import 'package:flutter/material.dart';

class BasketballMatchScoreProvider extends ChangeNotifier {
  final PracticeMatchService scoreservice = PracticeMatchService();
  // Match & team details
  String hostTeam;
  String visitorTeam;
  String tossWinner;
  String optedTo;
  int matchId;

  // Score, fouls, and quarter
  int homeScore;
  int awayScore;
  int homeFouls;
  int awayFouls;
  int quarter;

  // Game clock and shot clock
  int timeMinutes;
  int timeSeconds;
  int shotClock;
  bool isGameTimerRunning;
  bool isShotClockRunning;

  Timer? gameTimer;
  Timer? shotClockTimer;

  // Match events and undo/redo stacks
  List<String> matchEvents;
  List<Map<String, dynamic>> undoneEvents;
  List<Map<String, dynamic>> redoEvents;

  // Scroll controller for events list (optional)
  final ScrollController scrollController;

  BasketballMatchScoreProvider({
    required this.hostTeam,
    required this.visitorTeam,
    required this.matchId,
    required this.tossWinner,
    required this.optedTo,
    this.homeScore = 0,
    this.awayScore = 0,
    this.homeFouls = 0,
    this.awayFouls = 0,
    this.quarter = 1,
    this.timeMinutes = 12,
    this.timeSeconds = 0,
    this.shotClock = 24,
    this.isGameTimerRunning = false,
    this.isShotClockRunning = false,
    List<String>? matchEvents,
    List<Map<String, dynamic>>? undoneEvents,
    List<Map<String, dynamic>>? redoEvents,
    ScrollController? scrollController,
  })  : matchEvents = matchEvents ?? [],
        undoneEvents = undoneEvents ?? [],
        redoEvents = redoEvents ?? [],
        scrollController = scrollController ?? ScrollController();

  // GAME TIMER METHODS
  void startGameTimer(BuildContext context) {
    if (!isGameTimerRunning) {
      isGameTimerRunning = true;
      gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (timeMinutes == 0 && timeSeconds == 0) {
          stopGameTimer(context);
          addEvent("Quarter $quarter ended", context);
          nextQuarter(context);
        } else {
          if (timeSeconds > 0) {
            timeSeconds--;
          } else {
            timeSeconds = 59;
            timeMinutes--;
          }
        }
        notifyListeners();
      });
      addEvent("Game timer started", context);
      notifyListeners();
    }
  }

  void stopGameTimer(BuildContext context) {
    gameTimer?.cancel();
    isGameTimerRunning = false;
    addEvent("Game timer paused", context);
    notifyListeners();
  }

  void resetGameTimer(BuildContext context) {
    stopGameTimer(context);
    timeMinutes = 12;
    timeSeconds = 0;
    addEvent("Game timer reset", context);
    notifyListeners();
  }

  // SHOT CLOCK METHODS
  void startShotClock(BuildContext context) {
    if (!isShotClockRunning) {
      isShotClockRunning = true;
      shotClockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        if (shotClock > 0) {
          shotClock--;
        } else {
          addEvent("Shot clock expired", context);
          resetShotClock(context);
        }
        notifyListeners();
      });
      addEvent("Shot clock started", context);
      notifyListeners();
    }
  }

  void resetShotClock(BuildContext context) {
    stopShotClock(context);
    shotClock = 24;
    addEvent("Shot clock reset to 24 seconds", context);
    notifyListeners();
  }

  void stopShotClock(BuildContext context) {
    shotClockTimer?.cancel();
    isShotClockRunning = false;
    addEvent("Shot clock stopped", context);
    notifyListeners();
  }

  // QUARTER MANAGEMENT
  void nextQuarter(BuildContext context) {
    if (quarter < 4) {
      quarter++;
      resetGameTimer(context);
      addEvent("Quarter $quarter started", context);
    } else {
      addEvent("Game ended", context);
    }
    notifyListeners();
  }

  // SCORE & FOULS METHODS
  /// Adds points after showing a dialog for details.
  /// In your UI you can call this method (after collecting scorer/assist details)

  void addPoints(String team, int points, BuildContext context) {
    TextEditingController scorerController = TextEditingController();
    TextEditingController assistController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Point Details"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: scorerController,
                decoration: InputDecoration(labelText: "Scorer"),
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
                Navigator.pop(context); // Close dialog without saving
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                String scorer = scorerController.text.trim();
                String assist = assistController.text.trim();

                if (scorer.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter the scorer's name."),
                      backgroundColor: Colors.red,
                    ),
                  );
                  return;
                }

                // Update scores
                if (team == hostTeam) {
                  homeScore += points;
                } else {
                  awayScore += points;
                }
                resetShotClock(context);
                notifyListeners();
                String eventTime =
                    "$timeMinutes:${timeSeconds.toString().padLeft(2, '0')}";

                Map<String, dynamic> event = {
                  "type": "add_points",
                  "team": team,
                  "points": points,
                  "scorer": scorer,
                  "assist": assist.isNotEmpty ? assist : "None",
                  "time": eventTime
                };

                // Store event details in match events
                matchEvents.add(
                    "$team: $scorer scored $points points at $eventTime" +
                        (assist.isNotEmpty ? " (Assist: $assist)" : "") +
                        " 🏀🔥");

                // Push to undo stack
                undoneEvents.add(event);
                redoEvents.clear(); // Clear redo stack on new action

                notifyListeners(); // ✅ Update UI

                try {
                  print("Add Points called! ");
                  updateBasketballScore(points, "points", event, context);
                  getUpdatedBasketballScore(
                      context); // ✅ Fetch latest match data from backend
                } catch (e) {
                  print("Error on updating backend: $e");
                }

                Navigator.pop(context); // Close the dialog
                scrollToBottom(); // Scroll to latest event

                // Trigger confetti animation if it's a home team score
                bool isHomeTeamScore = (team == hostTeam);
                showConfettiAnimation(context, isHomeTeamScore);
              },
              child: Text("Save"),
            ),
          ],
        );
      },
    );
  }

  void showConfettiAnimation(BuildContext context, bool isHomeTeamGoal) {
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

  /// Adds a foul event.
  void addFoul(String team, BuildContext context) {
    bool isHomeTeam = (team == hostTeam);
    String timeStr = "$timeMinutes:${timeSeconds.toString().padLeft(2, '0')}";
    Map<String, dynamic> event = {
      "type": "foul",
      "team": team,
      "time": timeStr,
      "home_foul": isHomeTeam ? 1 : 0, // ✅ If home team, increment home_foul
      "away_foul": isHomeTeam ? 0 : 1, // ✅ If away team, increment away_foul
    };
    matchEvents.add("$team committed a foul at $timeStr ❌");
    if (team == hostTeam) {
      homeFouls++;
    } else if (team == visitorTeam) {
      awayFouls++;
    }
    undoneEvents.add(event);
    redoEvents.clear();
    notifyListeners();

    try {
      print("🏀 Add Foul called! Sending event to backend...");
      updateBasketballScore(0, "foul", event, context).then((_) {
        print("✅ Foul event successfully updated in backend!");
        getUpdatedBasketballScore(
            context); // ✅ Fetch latest match data from backend
      }).catchError((e) {
        print("❌ Error updating backend for foul: $e");
      });
    } catch (e) {
      print("❌ Unexpected error on updating backend: $e");
    }

    scrollToBottom();
  }

  // EVENT LOG MANAGEMENT
  void addEvent(String event, BuildContext context) {
    matchEvents.add(event);
    notifyListeners();
    // ✅ Prepare event payload for backend
    // Map<String, dynamic> eventPayload = {
    //   "type": "custom_event",
    //   "description": event,
    //   "time": "$timeMinutes:${timeSeconds.toString().padLeft(2, '0')}"
    // };

    // try {
    //   print("📡 Sending event update to backend...");
    //   updateBasketballScore(0, "custom_event", eventPayload, context).then((_) {
    //     print("✅ Event successfully updated in backend!");
    //     getUpdatedBasketballScore(context); // ✅ Fetch latest match data from backend
    //   }).catchError((e) {
    //     print("❌ Error updating event in backend: $e");
    //   });
    // } catch (e) {
    //   print("❌ Unexpected error on updating backend: $e");
    // }
  }

  void undoEvent(BuildContext context) {
    if (undoneEvents.isNotEmpty) {
      Map<String, dynamic> lastEvent = undoneEvents.removeLast();
      redoEvents.add(lastEvent);
      // Ensure we remove both shot clock events safely
      if (matchEvents.isNotEmpty &&
          matchEvents.last.contains("Shot clock reset")) {
        matchEvents.removeLast();
      }
      // Remove the last "Shot clock stopped" if present
      if (matchEvents.isNotEmpty &&
          matchEvents.last.contains("Shot clock stopped")) {
        matchEvents.removeLast();
      }
      if (matchEvents.isNotEmpty) {
        matchEvents.removeLast();
      }
      if (lastEvent["type"] == "add_points") {
        int points = (lastEvent["points"] as int);
        if (lastEvent["team"] == hostTeam) {
          homeScore = (homeScore - points).clamp(0, homeScore);
        } else {
          awayScore = (awayScore - points).clamp(0, awayScore);
        }
        print(lastEvent["type"]);
      } else if (lastEvent["type"] == "foul") {
        if (lastEvent["team"] == hostTeam) {
          homeFouls = (homeFouls - 1).clamp(0, homeFouls);
        } else if (lastEvent["team"] == visitorTeam) {
          awayFouls = (awayFouls - 1).clamp(0, awayFouls);
        }
        print(lastEvent["type"]);
      }
      notifyListeners();
    }
  }

  void redoEvent(BuildContext context) {
    if (redoEvents.isNotEmpty) {
      Map<String, dynamic> eventToRedo = redoEvents.removeLast();
      undoneEvents.add(eventToRedo);
      if (eventToRedo["type"] == "add_points") {
        int points = (eventToRedo["points"] as int);
        if (eventToRedo["team"] == hostTeam) {
          homeScore += points;
          addEvent("$hostTeam scored $points points", context);
        } else {
          awayScore += points;
          addEvent("$visitorTeam scored $points points", context);
        }
      } else if (eventToRedo["type"] == "foul") {
        if (eventToRedo["team"] == hostTeam) {
          homeFouls++;
        } else if (eventToRedo["team"] == visitorTeam) {
          awayFouls++;
        }
        addEvent(
            "${eventToRedo['team']} committed a foul at ${eventToRedo['time']} ❌",
            context);
      }
      notifyListeners();
    }
  }

  bool isMatchOver = false;

  void endMatch(BuildContext context) {
    stopGameTimer(context); // ✅ Stop the game timer
    stopShotClock(context); // ✅ Stop the shot clock
    isMatchOver = true; // ✅ Mark match as ended

    // Add final score to match events
    matchEvents.add(
        "🏀 Match has ended. Final Score: $hostTeam $homeScore - $awayScore $visitorTeam");

    // Create match-end event payload for backend
    Map<String, dynamic> matchEndEvent = {
      "type": "match_end",
      "match_id": matchId,
      "home_score": homeScore,
      "away_score": awayScore,
      "home_fouls": homeFouls,
      "away_fouls": awayFouls,
      "match_end": true,
      "quarter": quarter,
      "time": "$timeMinutes:${timeSeconds.toString().padLeft(2, '0')}",
      "events": matchEvents, // ✅ Pass all stored match events
    };

    print("🔄 Sending match end update to backend...");
    updateBasketballScore(0, "match_end", matchEndEvent, context);
    print("✅ Basketball match ended successfully!");

    // ✅ Fetch updated match data from backend to verify
    getUpdatedBasketballScore(context);

    notifyListeners();

    // Show dialog to confirm match end
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("🏀 Match Ended"),
          content: Text(
              "Final Score:\n$hostTeam $homeScore - $awayScore $visitorTeam"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                scrollToBottom();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  bool showOverLay = false;
  Map<String, dynamic> lastRecord = {};
  // var matchId = 0;
  bool islastrecord = true;

  Future<void> getUpdatedBasketballScore(BuildContext context) async {
    try {
      final fetchedEntities = await scoreservice.getlastrecord(matchId);
      print("🏀 LAST RECORD FETCHED: $fetchedEntities");

      if (fetchedEntities != null && fetchedEntities.isNotEmpty) {
        islastrecord = true;
        lastRecord = fetchedEntities;

        // ✅ Simplified Null-Safe Access
        hostTeam = lastRecord['hostTeam'] ?? hostTeam;
        visitorTeam = lastRecord['visitorTeam'] ?? visitorTeam;
        isMatchOver = lastRecord['match_end'] ?? false;
        quarter = lastRecord['quarter'] ?? quarter;
        homeScore = lastRecord['home_score'] ?? homeScore;
        awayScore = lastRecord['away_score'] ?? awayScore;
        homeFouls = lastRecord['home_fouls'] ?? homeFouls;
        awayFouls = lastRecord['away_fouls'] ?? awayFouls;
        timeMinutes = lastRecord['current_time_minutes'] ?? timeMinutes;
        timeSeconds = lastRecord['current_time_seconds'] ?? timeSeconds;
        shotClock =
            lastRecord['shot_clock'] ?? 24; // Default to 24 sec if not found

        // matchEvents = List<String>.from(lastRecord['events'] ?? []);
        // ✅ Append new events instead of replacing the list
        List<String> newEvents = List<String>.from(lastRecord['events'] ?? []);
        if (newEvents.isNotEmpty) {
          matchEvents.addAll(newEvents
              .where((event) => !matchEvents.contains(event))
              .toList()); // Prevent duplicate entries
        }

        notifyListeners(); // ✅ Notify UI to update scores and time
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
              'Failed to fetch: $e',
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

  Future<void> updateBasketballScore(int scdata, String eventType,
      Map<String, dynamic> scoreboard, BuildContext context) async {
    showOverLay = true;
    print(
        "🏀 updateBasketballScore called with eventType: $eventType, data: $scdata");

    notifyListeners();

    Map<String, dynamic> payload = {
      "match_id": matchId,
      "home_score": homeScore,
      "away_score": awayScore,
      "home_fouls": homeFouls,
      "away_fouls": awayFouls,
      "match_end": isMatchOver,
      "quarter": quarter,
      "current_time": "$timeMinutes:${timeSeconds.toString().padLeft(2, '0')}",
      "shot_clock": shotClock,
      "events": matchEvents, // ✅ Pass all stored match events
    };

    try {
      print("📡 Sending request to backend with payload: $payload");

      // Check for any null values
      payload.forEach((key, value) {
        if (value == null) {
          print("❌ ERROR: $key is NULL");
        }
      });

      await scoreservice.updateScore(scdata, eventType, payload).then((_) {
        getLastRecordBasketball(context).then(
          (value) {
            showOverLay = false;
            notifyListeners();
            showSnackBar(context, '🏀 Update Successful!', Colors.green);
          },
        );
      });
    } catch (e) {
      showOverLay = false;
      notifyListeners();
      showSnackBar(context, '❌ Error updating: $e', Colors.red);
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

  bool isLoadingData = false;

  Future<void> getLastRecordBasketball(BuildContext context) async {
    isLoadingData = true;
    notifyListeners(); // ✅ Notify UI to update match data

    try {
      await getUpdatedBasketballScore(context);
      // ✅ Add other necessary API calls here if needed
      // await fetchTopScorers();
      // await fetchFoulDetails();
      // await fetchQuarterStats();
    } catch (e) {
      // Log the error and display a message to the user
      print("❌ Error occurred in getLastRecordBasketball: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text(
              'Failed to fetch basketball match data: $e',
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
      notifyListeners(); // ✅ Ensure UI updates regardless of success or failure
    }
  }

  // OPTIONAL: For scrolling to the latest event in your UI
  void scrollToBottom() {
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

  // OPTIONAL: Reset all match data
  void resetMatch(BuildContext context) {
    stopGameTimer(context);
    stopShotClock(context);
    homeScore = 0;
    awayScore = 0;
    homeFouls = 0;
    awayFouls = 0;
    quarter = 1;
    timeMinutes = 12;
    timeSeconds = 0;
    shotClock = 24;
    matchEvents.clear();
    undoneEvents.clear();
    redoEvents.clear();
    notifyListeners();
  }
}
