import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:confetti/confetti.dart';
import 'package:cricyard/core/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FootballScoreboardScreen extends StatefulWidget {
  final Map<String, String> entity;

  FootballScoreboardScreen({required this.entity});
  @override
  _FootballScoreboardScreenState createState() =>
      _FootballScoreboardScreenState();
}

class _FootballScoreboardScreenState extends State<FootballScoreboardScreen> {
  late String hostTeam;
  late String awayTeam;
  late String tossWinner;
  late String optedTo;

  @override
  void initState() {
    super.initState();
    // Extract data from the passed entity
    hostTeam = widget.entity['hostTeam'] ?? "Host Team";
    awayTeam = widget.entity['awayTeam'] ?? "Away Team";
    tossWinner = widget.entity['tossWinner'] ?? "Unknown";
    optedTo = widget.entity['opted_to'] ?? "Unknown";
    matchEvents.insert(0, "$tossWinner won the toss and chose $optedTo");
  }

  int homeScore = 0;
  int awayScore = 0;
  int minutes = 0;
  int seconds = 0;
  int stoppageMinutes = 0; // Stoppage time minutes
  int stoppageSeconds = 0; // Stoppage time seconds
  bool isTimerRunning = false;
  bool isStoppageTimerRunning = false;
  Timer? matchTimer;
  Timer? stoppageTimer; // Mini timer for stoppage time
  List<String> matchEvents = [];
  List<Map<String, dynamic>> undoneEvents = [];
  List<Map<String, dynamic>> redoEvents = [];
  // Stack for redo events
  final ScrollController _scrollController = ScrollController();

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

  void startTimer() {
    if (!isTimerRunning) {
      isTimerRunning = true;
      matchTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (seconds < 59) {
            seconds++;
          } else {
            seconds = 0;
            minutes++;
          }
          if (minutes >= 90) {
            stopTimer();
          }
        });
      });
      stopStoppageTimer();
    }
  }

  void stopTimer() {
    if (isTimerRunning) {
      matchTimer?.cancel();
      isTimerRunning = false;
      startStoppageTimer();
    }
  }

  void startStoppageTimer() {
    if (!isStoppageTimerRunning) {
      isStoppageTimerRunning = true;
      stoppageTimer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          if (stoppageSeconds < 59) {
            stoppageSeconds++;
          } else {
            stoppageSeconds = 0;
            stoppageMinutes++;
          }
        });
      });
    }
  }

  void stopStoppageTimer() {
    if (isStoppageTimerRunning) {
      stoppageTimer?.cancel();
      isStoppageTimerRunning = false;
    }
  }

  void resetMatch() {
    stopTimer();
    stopStoppageTimer();
    setState(() {
      homeScore = 0;
      awayScore = 0;
      minutes = 0;
      seconds = 0;
      stoppageMinutes = 0;
      stoppageSeconds = 0;
      matchEvents.clear();
    });
  }

  void addGoal(String team) {
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
                Navigator.pop(context); // Close the dialog without saving
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

                setState(() {
                  if (team == '$hostTeam') {
                    homeScore++;
                  } else {
                    awayScore++;
                  }

                  Map<String, dynamic> event = {
                    "type": "goal",
                    "team": team,
                    "goalScorer": goalScorer,
                    "assist": assist.isNotEmpty ? assist : "None",
                    "time": "$minutes:${seconds.toString().padLeft(2, '0')}"
                  };

                  // Store goal details in match events
                  matchEvents.add(
                      "$team: $goalScorer scored at ${event['time']}" +
                          (assist.isNotEmpty ? " (Assist: $assist)" : "") + " 🎉🎉");

                  // Push to undo stack
                  undoneEvents.add(event);
                  redoEvents.clear(); // Clear redo stack on new action
                });

                Navigator.pop(context); // Close the dialog
                _scrollToBottom(); // Scroll to latest event
                bool isHomeTeamGoal = (team == "$hostTeam");
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
  ConfettiController confettiController = ConfettiController(duration: Duration(seconds: 2));
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
          blastDirection:  pi/2 , // Left for home, right for away
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


  void addFoul(String team) {
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

                setState(() {
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
                });

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


  

  void _showCardAnimation(BuildContext context, String cardType, bool isHomeTeamGoal) {
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
              right: !isHomeTeamGoal ? 0 : null, // Away team goal on the right
              top: MediaQuery.of(context).size.height * 0.2,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25.0), // Padding to avoid touching the edges
                child: Center(
                  child: TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: pi), // 0 to 180° rotation
                    duration: Duration(milliseconds: 1000), // Flip speed
                    builder: (context, double angle, child) {
                      bool isFront = angle < pi / 2; // Front side condition
                
                      return AnimatedOpacity(
                        opacity: angle >= pi / 2 ? 0.0 : 1.0, // Fade out after the flip is done
                        duration: Duration(milliseconds: 700), // Fade-out duration
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
                                BoxShadow(color: Colors.black26, blurRadius: 10),
                              ],
                            ),
                            child: Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..rotateY(isFront ? 0 : pi), // Keep text always upright
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


  void addCard(String team, String cardType) async {
    String? selectedPlayer;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Select Player for $cardType Card"),
              content: TextField(
                onChanged: (value) {
                  selectedPlayer = value;
                },
                decoration: InputDecoration(
                  labelText: "Player Name",
                  border: OutlineInputBorder(),
                ),
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
                    if (selectedPlayer == null || selectedPlayer!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please enter a player name"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    Navigator.pop(context, selectedPlayer);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      },
    );

    if (selectedPlayer == null || selectedPlayer!.isEmpty) return;

    setState(() {
      Map<String, dynamic> event = {
        "type": "card",
        "team": team,
        "player": selectedPlayer,
        "card": cardType,
        "time": "$minutes:${seconds.toString().padLeft(2, '0')}"
      };

      // Add event to match log
      matchEvents.add(
          "$team: $selectedPlayer received a $cardType card at ${event['time']}");

      // Push to undo stack
      undoneEvents.add(event);
      redoEvents.clear();
    });

    _scrollToBottom();
  }

  void addSubstitution(String team) async {
    String? playerOut;
    String? playerIn;

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text("Substitution for $team"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      playerOut = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Player Out",
                      border: OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      playerIn = value;
                    },
                    decoration: InputDecoration(
                      labelText: "Player In",
                      border: OutlineInputBorder(),
                    ),
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
                    if (playerOut == null ||
                        playerOut!.isEmpty ||
                        playerIn == null ||
                        playerIn!.isEmpty) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please enter both players"),
                          backgroundColor: Colors.red,
                        ),
                      );
                      return;
                    }
                    Navigator.pop(context, [playerOut, playerIn]);
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
      },
    );

    if (playerOut == null || playerIn == null) return;

    setState(() {
      Map<String, dynamic> event = {
        "type": "substitution",
        "team": team,
        "playerOut": playerOut,
        "playerIn": playerIn,
        "time": "$minutes:${seconds.toString().padLeft(2, '0')}"
      };

      // Add event to match log
      matchEvents.add(
          "$team Substitution: $playerOut → $playerIn at ${event['time']}");

      // Push to undo stack
      undoneEvents.add(event);
      redoEvents.clear();
    });

    _scrollToBottom();
  }

  void undoEvent() {
    if (undoneEvents.isNotEmpty) {
      Map<String, dynamic> lastEvent = undoneEvents.removeLast();
      redoEvents.add(lastEvent); // Store for redo

      setState(() {
        matchEvents.removeLast(); // Remove event text from the list

        // Handle different event types
        switch (lastEvent["type"]) {
          case "goal":
            if (lastEvent["team"] == "Home") {
              homeScore = (homeScore > 0) ? homeScore - 1 : 0;
            } else {
              awayScore = (awayScore > 0) ? awayScore - 1 : 0;
            }
            break;
          case "foul":
            // No additional action needed, just remove from matchEvents
            break;
          case "card":
            // No additional action needed, just remove from matchEvents
            break;
          case "substitution":
            // No additional action needed, just remove from matchEvents
            break;
        }
      });
    }
    _scrollUpByAmount();
  }

  void redoEvent() {
    if (redoEvents.isNotEmpty) {
      Map<String, dynamic> eventToRedo = redoEvents.removeLast();
      undoneEvents.add(eventToRedo); // Move back to undo stack

      setState(() {
        String eventText = "";
        switch (eventToRedo["type"]) {
          case "goal":
            eventText =
                "${eventToRedo['team']} scored a goal at ${eventToRedo['time']}";
            if (eventToRedo["team"] == "Home") {
              homeScore++;
            } else {
              awayScore++;
            }
            break;
          case "foul":
            eventText =
                "${eventToRedo['team']} committed a foul at ${eventToRedo['time']}";
            break;
          case "card":
            eventText =
                "${eventToRedo['team']} received a ${eventToRedo['card']} card at ${eventToRedo['time']}";
            break;
          case "substitution":
            eventText =
                "${eventToRedo['team']} Substitution: ${eventToRedo['playerOut']} → ${eventToRedo['playerIn']} at ${eventToRedo['time']}";
            break;
        }
        matchEvents.add(eventText);
      });
    }
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(title: Text("Football Scoreboard")),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              ImageConstant.footballStadium,
              fit: BoxFit.cover,
            ),
          ),

          // Blur effect overlay
          Positioned.fill(
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 3, sigmaY: 3), // Adjust blur intensity
                child: Container(
                  color: Colors.black
                      .withOpacity(0.2), // Optional overlay to enhance blur
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.1,
              vertical: MediaQuery.of(context).size.height * 0.06,
            ),
            child: Column(
              children: [
                // Scoreboard
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(children: [
                      Text(hostTeam,
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                      SizedBox(height: 10),
                      Text("$homeScore", style: TextStyle(fontSize: 50)),
                    ]),
                    Column(children: [
                      Text("Time",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 10),
                      Text(
                        "$minutes:${seconds.toString().padLeft(2, '0')}",
                        style: TextStyle(
                          fontSize: 30,
                        ), // Timer color changed to black
                      ),
                    ]),
                    Column(children: [
                      Text(awayTeam,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          )),
                      SizedBox(height: 10),
                      Text("$awayScore",
                          style: TextStyle(
                            fontSize: 50,
                          )),
                    ]),
                  ],
                ),

                SizedBox(height: 10), // Spacing

                // Timer Controls
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customButton(
                      text: "Start",
                      onPressed: startTimer,
                      backgroundColor: Color(0xFF219ebc),
                      width: 100, // Optional custom color
                    ),
                    SizedBox(width: 10),
                    customButton(
                      text: "Pause",
                      onPressed: stopTimer,
                      backgroundColor: Color(0xFF219ebc),
                      width: 100, // Optional custom color
                    ),
                    SizedBox(width: 10),
                    customButton(
                      text: "Reset",
                      onPressed: resetMatch,
                      backgroundColor: Color(0xFF219ebc),
                      width: 100, // Optional custom color
                    ),
                  ],
                ),

                SizedBox(height: 20), // Spacing

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Stoppage Time: $stoppageMinutes:${stoppageSeconds.toString().padLeft(2, '0')}",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(
                  height: 150, // Adjust height as needed
                  child: ListView.builder(
                    controller: _scrollController,
                    shrinkWrap:
                        true, // Ensures the ListView takes only the required space
                    physics:
                        ClampingScrollPhysics(), // Prevents unnecessary scrolling issues
                    itemCount: matchEvents.length,
                    itemBuilder: (context, index) => ListTile(
                      title: Text(matchEvents[index],
                          style: TextStyle(fontSize: 16, color: Colors.white)),
                    ),
                  ),
                ),

                SizedBox(height: 10), // Spacing

                Container(
                  padding: EdgeInsets.all(16.0), // Padding around the container
                  // color: Colors.white, // White background for the container
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(125, 255, 255, 255),
                    borderRadius:
                        BorderRadius.circular(12.0), // Rounded corners
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    spacing: 10,
                    children: [
                      // Home Side
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 10,
                          children: [
                            customButton(
                              text: "$hostTeam Goal",
                              onPressed: () => addGoal("$hostTeam"),
                              backgroundColor: Color(0xFF219ebc),
                              width: screenWidth * 0.25,
                            ),
                            customButton(
                              text: "$hostTeam Foul",
                              onPressed: () => addFoul("$hostTeam"),
                              backgroundColor: Color(0xFF219ebc),
                              width: screenWidth * 0.25,
                            ),
                            customButton(
                              text: "$hostTeam Substitution",
                              onPressed: () => addSubstitution("$hostTeam"),
                              backgroundColor: Color(0xFF219ebc),
                              width: screenWidth * 0.25,
                            ),
                            
                          ],
                        ),
                      ),

                      // Away Side
                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          spacing: 10,
                          children: [
                            customButton(
                              text: "$awayTeam Goal",
                              onPressed: () => addGoal("$awayTeam"),
                              backgroundColor: Color(0xFF219ebc),
                              width: screenWidth * 0.25,
                            ),
                            customButton(
                              text: "$awayTeam Foul",
                              onPressed: () => addFoul("$awayTeam"),
                              backgroundColor: Color(0xFF219ebc),
                              width: screenWidth * 0.25,
                            ),
                            customButton(
                              text: "$awayTeam Substitution",
                              onPressed: () => addSubstitution("$awayTeam"),
                              backgroundColor: Color(0xFF219ebc),
                              width: screenWidth * 0.25,
                            ),
                            // customButton(
                            //   text: "$awayTeam Yellow Card",
                            //   onPressed: () => addCard("$awayTeam", "Yellow"),
                            //   backgroundColor: Color.fromARGB(255, 203, 206, 8),
                            //   width: screenWidth * 0.25,
                            // ),
                            // customButton(
                            //   text: "$awayTeam Red Card",
                            //   onPressed: () => addCard("$awayTeam", "Red"),
                            //   backgroundColor: Color.fromARGB(255, 255, 0, 0),
                            //   width: screenWidth * 0.25,
                            // ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 10,
                        children: [
                          customButton(
                            text: "Undo",
                            onPressed: undoEvent,
                            backgroundColor: Color(0xFF219ebc),
                            width: screenWidth * 0.2, // Optional custom color
                          ),
                          SizedBox(width: 10),
                          customButton(
                            text: "Redo",
                            onPressed: redoEvent,
                            backgroundColor: Color(0xFF219ebc),
                            width: screenWidth * 0.2, // Optional custom color
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget customButton({
    required String text,
    required VoidCallback onPressed,
    Color backgroundColor = const Color(0xFF219ebc),
    double? width, // Optional width
    double? height, // Optional height // Default color
  }) {
    width ??= 150; // Default width 150 if no width is passed
    height ??= 30; // Default height 50 if no height is passed
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: WidgetStatePropertyAll(backgroundColor),
        minimumSize: WidgetStateProperty.all(Size(width, height)),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          text,
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
