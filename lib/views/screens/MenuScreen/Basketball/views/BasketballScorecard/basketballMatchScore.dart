import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:confetti/confetti.dart';
import 'package:cricyard/core/utils/image_constant.dart';
import 'package:cricyard/views/screens/MenuScreen/Basketball/viewmodel/basketballMatchScoreProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class BasketballScoreboardScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  BasketballScoreboardScreen({required this.entity});
  @override
  _BasketballScoreboardScreenState createState() =>
      _BasketballScoreboardScreenState();
}

class _BasketballScoreboardScreenState
    extends State<BasketballScoreboardScreen> {
  late BasketballMatchScoreProvider provider;
  late String hostTeam;
  late String visitorTeam;
  int homeScore = 0;
  int awayScore = 0;

  int quarter = 1;
  int homeFouls = 0;
  int awayFouls = 0;
  int timeMinutes = 12;
  int timeSeconds = 0;
  int shotClock = 24;
  bool isGameTimerRunning = false;
  bool isShotClockRunning = false;
  Timer? gameTimer;
  Timer? shotClockTimer;
  var matchId = 0;

  @override
  void initState() {
    super.initState();
    matchId = widget.entity['id'];
    print("matchId: $matchId");
    // Extract data from the passed entity
    hostTeam = widget.entity['hostTeam'] ?? "Host Team";
    visitorTeam = widget.entity['visitorTeam'] ?? "Visitor Team";
    provider = BasketballMatchScoreProvider(
      hostTeam: hostTeam,
      visitorTeam: visitorTeam,
      tossWinner: "tossWinner",
      optedTo: "Bat",
      matchId: matchId,
    );
    provider.matchEvents.insert(0, "Lets Go! ");
    provider.getLastRecordBasketball(context);
  }

  // void resetMatch() {
  //   stopGameTimer();
  //   stopShotClock();
  //   setState(() {
  //     homeScore = 0;
  //     awayScore = 0;
  //     homeFouls = 0;
  //     awayFouls = 0;
  //     quarter = 1;
  //     shotClock = 24;
  //     timeMinutes = 12;
  //     timeSeconds = 0;
  //     matchEvents.clear();
  //     undoneEvents.clear();
  //     redoEvents.clear();
  //   });
  // }

  List<String> matchEvents = [];
  List<Map<String, dynamic>> undoneEvents = [];
  List<Map<String, dynamic>> redoEvents = [];
  final ScrollController _scrollController = ScrollController();

  // void startGameTimer() {
  //   if (!isGameTimerRunning) {
  //     isGameTimerRunning = true;
  //     gameTimer = Timer.periodic(Duration(seconds: 1), (timer) {
  //       setState(() {
  //         if (timeMinutes == 0 && timeSeconds == 0) {
  //           stopGameTimer();
  //           addEvent("Quarter $quarter ended");
  //           nextQuarter();
  //         } else {
  //           if (timeSeconds > 0) {
  //             timeSeconds--;
  //           } else {
  //             timeSeconds = 59;
  //             timeMinutes--;
  //           }
  //         }
  //       });
  //     });
  //     addEvent("Game timer started");
  //   }
  // }

  // void stopGameTimer() {
  //   gameTimer?.cancel();
  //   isGameTimerRunning = false;
  //   addEvent("Game timer paused");
  // }

  // void resetGameTimer() {
  //   stopGameTimer();
  //   setState(() {
  //     timeMinutes = 12;
  //     timeSeconds = 0;
  //   });
  //   addEvent("Game timer reset");
  // }

  // void startShotClock() {
  //   if (!isShotClockRunning) {
  //     isShotClockRunning = true;
  //     shotClockTimer = Timer.periodic(Duration(seconds: 1), (timer) {
  //       setState(() {
  //         if (shotClock > 0) {
  //           shotClock--;
  //         } else {
  //           addEvent("Shot clock expired");
  //           resetShotClock();
  //         }
  //       });
  //     });
  //     addEvent("Shot clock started");
  //   }
  // }

  // void resetShotClock() {
  //   stopShotClock();
  //   setState(() {
  //     shotClock = 24;
  //   });
  //   addEvent("Shot clock reset to 24 seconds");
  // }

  // void stopShotClock() {
  //   shotClockTimer?.cancel();
  //   isShotClockRunning = false;
  //   addEvent("Shot clock stopped");
  // }

  // void nextQuarter() {
  //   if (quarter < 4) {
  //     setState(() {
  //       quarter++;
  //       resetGameTimer();
  //     });
  //     addEvent("Quarter $quarter started");
  //   } else {
  //     addEvent("Game ended");
  //   }
  // }

  // void addPoints(String team, int points) {
  //   setState(() {
  //     Map<String, dynamic> event = {
  //       "type": "add_points",
  //       "team": team,
  //       "points": points
  //     };
  //     if (team == 'home') {
  //       homeScore += points;
  //       addEvent("Home team scored $points points");
  //     } else {
  //       awayScore += points;
  //       addEvent("Away team scored $points points");
  //     }
  //     undoneEvents.add(event); // Store for undo
  //     redoEvents.clear(); // Clear redo stack on new action
  //     resetShotClock();
  //   });
  // }
  // void addPoints(String team, int points) {
  //   TextEditingController scorerController = TextEditingController();
  //   TextEditingController assistController = TextEditingController();
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Point Details"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: scorerController,
  //               decoration: InputDecoration(labelText: "Scorer"),
  //             ),
  //             TextField(
  //               controller: assistController,
  //               decoration: InputDecoration(labelText: "Assist (Optional)"),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context); // Close dialog without saving
  //             },
  //             child: Text("Cancel"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               String scorer = scorerController.text.trim();
  //               String assist = assistController.text.trim();

  //               if (scorer.isEmpty) {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(
  //                     content: Text("Please enter the scorer's name."),
  //                     backgroundColor: Colors.red,
  //                   ),
  //                 );
  //                 return;
  //               }

  //               setState(() {
  //                 if (team == '$hostTeam') {
  //                   homeScore += points;
  //                 } else {
  //                   awayScore += points;
  //                 }

  //                 Map<String, dynamic> event = {
  //                   "type": "add_points",
  //                   "team": team,
  //                   "points": points,
  //                   "scorer": scorer,
  //                   "assist": assist.isNotEmpty ? assist : "None",
  //                   "time":
  //                       "$timeMinutes:${timeSeconds.toString().padLeft(2, '0')}"
  //                 };

  //                 // Store event details in match events
  //                 matchEvents.add(
  //                     "$team: $scorer scored $points points at ${event['time']}" +
  //                         (assist.isNotEmpty ? " (Assist: $assist)" : "") +
  //                         " 🏀🔥");

  //                 // Push to undo stack
  //                 undoneEvents.add(event);
  //                 redoEvents.clear(); // Clear redo stack on new action
  //               });

  //               Navigator.pop(context); // Close the dialog
  //               _scrollToBottom(); // Scroll to latest event
  //               bool isHomeTeamScore = (team == "$hostTeam");
  //               _showConfettiAnimation(context, isHomeTeamScore);
  //             },
  //             child: Text("Save"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void addFoul(String team) {
  //   setState(() {
  //     Map<String, dynamic> event = {
  //       "type": "foul",
  //       "team": team,
  //       "time": "$timeMinutes:${timeSeconds.toString().padLeft(2, '0')}"
  //     };

  //     matchEvents.add("$team committed a foul at ${event['time']} ❌");

  //     // Increment foul count for the respective team
  //     if (team == hostTeam) {
  //       homeFouls++;
  //     } else if (team == visitorTeam) {
  //       awayFouls++;
  //     }

  //     // Store event in undo stack
  //     undoneEvents.add(event);
  //     redoEvents.clear();
  //   });

  //   _scrollToBottom(); // Ensure event is visible
  // }

  // void _showConfettiAnimation(BuildContext context, bool isHomeTeamGoal) {
  //   ConfettiController confettiController =
  //       ConfettiController(duration: Duration(seconds: 2));
  //   confettiController.play(); // Start confetti animation

  //   OverlayEntry overlayEntry = OverlayEntry(
  //     builder: (context) {
  //       return Positioned(
  //         top: MediaQuery.of(context).size.height * 0.1, // Adjust height
  //         left: isHomeTeamGoal ? 50 : null, // Confetti on left for home team
  //         right: !isHomeTeamGoal ? 50 : null, // Confetti on right for away team
  //         child: ConfettiWidget(
  //           confettiController: confettiController,
  //           // blastDirection: isHomeTeamGoal ? pi : 0, // Left for home, right for away
  //           blastDirection: pi / 2, // Left for home, right for away
  //           emissionFrequency: 0.05, // Frequency of confetti
  //           numberOfParticles: 80, // Number of confetti particles
  //           gravity: 0.5, // How fast confetti falls
  //           shouldLoop: false, // Run once and stop
  //         ),
  //       );
  //     },
  //   );

  //   Overlay.of(context)?.insert(overlayEntry);

  //   // Remove confetti animation after a delay
  //   Future.delayed(Duration(seconds: 3), () {
  //     confettiController.stop();
  //     overlayEntry.remove();
  //   });
  // }

  // void _scrollToBottom() {
  //   Future.delayed(Duration(milliseconds: 100), () {
  //     if (_scrollController.hasClients) {
  //       _scrollController.animateTo(
  //         _scrollController.position.maxScrollExtent,
  //         duration: Duration(milliseconds: 300),
  //         curve: Curves.easeOut,
  //       );
  //     }
  //   });
  // }

  // void addEvent(String event) {
  //   setState(() {
  //     matchEvents.add(event);
  //   });
  //   _scrollToBottom();
  // }

  // void _scrollUpByAmount() {
  //   Future.delayed(Duration(milliseconds: 100), () {
  //     if (_scrollController.hasClients) {
  //       // Define the amount you want to scroll up, for example, 100 pixels
  //       double offset = 100.0;
  //       // Calculate the new position
  //       double newPosition = _scrollController.position.pixels - offset;
  //       // Ensure that the position doesn't go beyond the scrollable area
  //       newPosition = newPosition < _scrollController.position.minScrollExtent
  //           ? _scrollController.position.minScrollExtent
  //           : newPosition;
  //       _scrollController.animateTo(
  //         newPosition,
  //         duration: Duration(milliseconds: 300),
  //         curve: Curves.easeOut,
  //       );
  //     }
  //   });
  // }

  // void undoEvent() {
  //   if (undoneEvents.isNotEmpty) {
  //     Map<String, dynamic> lastEvent = undoneEvents.removeLast();
  //     redoEvents.add(lastEvent); // Store for redo
  //     setState(() {
  //       // Ensure we remove both shot clock events safely
  //       if (matchEvents.isNotEmpty &&
  //           matchEvents.last.contains("Shot clock reset")) {
  //         matchEvents.removeLast();
  //       }
  //       // Remove the last "Shot clock stopped" if present
  //       if (matchEvents.isNotEmpty &&
  //           matchEvents.last.contains("Shot clock stopped")) {
  //         matchEvents.removeLast();
  //       }
  //       // Remove the main event (e.g., goal scored)
  //       if (matchEvents.isNotEmpty) {
  //         matchEvents.removeLast();
  //       }
  //       if (lastEvent["type"] == "add_points") {
  //         int points =
  //             (lastEvent["points"] as num).toInt(); // Ensure it's an int
  //         if (lastEvent["team"] == hostTeam) {
  //           homeScore = (homeScore - points)
  //               .clamp(0, homeScore); // Prevent negative score
  //         } else {
  //           awayScore = (awayScore - points).clamp(0, awayScore);
  //         }
  //       }

  //       if (lastEvent["type"] == "foul") {
  //         if (lastEvent["team"] == hostTeam) {
  //           homeFouls = (homeFouls - 1).clamp(0, homeFouls);
  //         } else if (lastEvent["team"] == visitorTeam) {
  //           awayFouls = (awayFouls - 1).clamp(0, awayFouls);
  //         }
  //       }
  //       print(lastEvent["type"]);
  //     });
  //   }
  //   _scrollUpByAmount();
  // }

  // void redoEvent() {
  //   if (redoEvents.isNotEmpty) {
  //     Map<String, dynamic> eventToRedo = redoEvents.removeLast();
  //     undoneEvents.add(eventToRedo); // Move back to undo stack
  //     setState(() {
  //       if (eventToRedo["type"] == "add_points") {
  //         int points =
  //             (eventToRedo["points"] as num).toInt(); // Ensure it's an int
  //         if (eventToRedo["team"] == hostTeam) {
  //           homeScore += points;
  //           addEvent("Home team scored $points points");
  //         } else {
  //           awayScore += points;
  //           addEvent("Away team scored $points points");
  //         }
  //         // Restore the associated shot clock messages
  //         addEvent("Shot clock stopped");
  //         addEvent("Shot clock reset to 24 seconds");
  //       }

  //       if (eventToRedo["type"] == "foul") {
  //         if (eventToRedo["team"] == hostTeam) {
  //           homeFouls += 1;
  //         } else if (eventToRedo["team"] == visitorTeam) {
  //           awayFouls += 1;
  //         }
  //         addEvent(
  //             "${eventToRedo['team']} committed a foul at ${eventToRedo['time']} ❌");
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        appBar: AppBar(title: Text("Basketball Scoreboard")),
        body: Consumer<BasketballMatchScoreProvider>(
            builder: (context, provider, child) {
          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  ImageConstant.basketballStadium,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                    child: Container(color: Colors.black.withOpacity(0.2)),
                  ),
                ),
              ),
              SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.10,
                  vertical: MediaQuery.of(context).size.height * 0.06,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(children: [
                          Text("${provider.hostTeam}",
                              style: TextStyle(fontSize: 30)),
                          Text("${provider.homeScore}",
                              style: TextStyle(fontSize: 40)),
                          SizedBox(height: 10), // Space between score and fouls
                          Container(
                            padding: EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(125, 255, 255, 255),
                              borderRadius:
                                  BorderRadius.circular(8.0), // Rounded corners
                            ),
                            child: Text("Fouls: ${provider.homeFouls}",
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black)),
                          ), // Home Team Fouls
                        ]),
                        Column(children: [
                          Text("Quarter", style: TextStyle(fontSize: 20)),
                          Text("${provider.quarter}",
                              style: TextStyle(fontSize: 30))
                        ]),
                        Column(children: [
                          Text("${provider.visitorTeam}",
                              style: TextStyle(fontSize: 30)),
                          Text("${provider.awayScore}",
                              style: TextStyle(fontSize: 40)),
                          SizedBox(height: 10), // Space between score and fouls
                          Container(
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: const Color.fromARGB(125, 255, 255, 255),
                                borderRadius: BorderRadius.circular(
                                    8.0), // Rounded corners
                              ),
                              child: Text("Fouls: ${provider.awayFouls}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.black))), // Away Team Fouls
                        ]),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            "Time: ${provider.timeMinutes} : ${provider.timeSeconds.toString().padLeft(2, '0')}",
                            style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Shot Clock: ${provider.shotClock}",
                            style: TextStyle(fontSize: 20)),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      spacing: 10,
                      children: [
                        customButton(
                            text: "Start Timer",
                            onPressed: () {
                              provider.startGameTimer(context);
                            },
                            width: screenWidth * 0.25),
                        customButton(
                            text: "Pause Timer",
                            onPressed: () {
                              provider.stopGameTimer(context);
                            },
                            width: screenWidth * 0.25),
                        customButton(
                            text: "Reset Timer",
                            onPressed: () {
                              provider.resetGameTimer(context);
                            },
                            width: screenWidth * 0.25),
                      ],
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                      height: 150, // Adjust height as needed
                      child: Consumer<BasketballMatchScoreProvider>(
                        builder: (context, provider, child) {
                          // ✅ Check if matchEvents is empty before building the list
                          if (provider.matchEvents.isEmpty) {
                            return Center(
                              child: Text(
                                "No events yet.",
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            );
                          }

                          return ListView.builder(
                            controller: provider.scrollController,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: provider.matchEvents.length,
                            itemBuilder: (context, index) => ListTile(
                              title: Text(
                                provider.matchEvents[
                                    index], // ✅ Accessing index only if list is not empty
                                style: TextStyle(
                                    fontSize: 16, color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                      // ListView.builder(
                      //   controller: _scrollController,
                      //   shrinkWrap: true,
                      //   physics: ClampingScrollPhysics(),
                      //   itemCount: provider.matchEvents.length,
                      //   itemBuilder: (context, index) => ListTile(
                      //     title: Text(
                      //       matchEvents[index],
                      //       style: TextStyle(fontSize: 16, color: Colors.white),
                      //     ),
                      //   ),
                      // ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.all(16.0), // Padding around the container
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
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 10,
                              children: [
                                customButton(
                                    text: "${provider.hostTeam} (+2)",
                                    onPressed: () {
                                      provider.addPoints(
                                          '$hostTeam', 2, context);
                                    },
                                    width: screenWidth * 0.25),
                                customButton(
                                    text: "${provider.hostTeam}  (+3)",
                                    onPressed: () {
                                      provider.addPoints(
                                          '$hostTeam', 3, context);
                                    },
                                    width: screenWidth * 0.25),
                                customButton(
                                    text: "${provider.hostTeam}  (Free Throw)",
                                    onPressed: () {
                                      provider.addPoints(
                                          '$hostTeam', 1, context);
                                    },
                                    width: screenWidth * 0.25),
                                customButton(
                                    text: "${provider.hostTeam}  (Foul)",
                                    onPressed: () {
                                      provider.addFoul('$hostTeam', context);
                                    },
                                    backgroundColor: Colors.red,
                                    width: screenWidth * 0.25),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              spacing: 10,
                              children: [
                                customButton(
                                    text: "${provider.visitorTeam}  +2",
                                    onPressed: () {
                                      provider.addPoints(
                                          '$visitorTeam', 2, context);
                                    },
                                    width: screenWidth * 0.25),
                                customButton(
                                    text: "${provider.visitorTeam}  +3",
                                    onPressed: () {
                                      provider.addPoints(
                                          '$visitorTeam', 3, context);
                                    },
                                    width: screenWidth * 0.25),
                                customButton(
                                    text: "${provider.visitorTeam}  Free Throw",
                                    onPressed: () {
                                      provider.addPoints(
                                          '$visitorTeam', 1, context);
                                    },
                                    width: screenWidth * 0.25),
                                customButton(
                                    text: "${provider.visitorTeam}  (Foul)",
                                    onPressed: () {
                                      provider.addFoul('$visitorTeam', context);
                                    },
                                    backgroundColor: Colors.red,
                                    width: screenWidth * 0.25),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              spacing: 10,
                              children: [
                                customButton(
                                    text: "Start Shot Clock",
                                    onPressed: () {
                                      provider.startShotClock(context);
                                    },
                                    width: screenWidth * 0.25),
                                customButton(
                                    text: "Reset Shot Clock",
                                    onPressed: () {
                                      provider.resetShotClock(context);
                                    },
                                    width: screenWidth * 0.25),
                              ],
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              customButton(
                                text: "Undo",
                                onPressed: () {
                                  provider.undoEvent(context);
                                },
                                backgroundColor: Color(0xFF219ebc),
                                width:
                                    screenWidth * 0.1, // Optional custom color
                              ),
                              SizedBox(width: 10),
                              customButton(
                                text: "Redo",
                                onPressed: () {
                                  provider.redoEvent(context);
                                },
                                backgroundColor: Color(0xFF219ebc),
                                width:
                                    screenWidth * 0.1, // Optional custom color
                              ),
                              SizedBox(width: 10),
                              customButton(
                                text: "Reset",
                                onPressed: () {
                                  provider.resetMatch(context);
                                },
                                backgroundColor: Color(0xFF219ebc),
                                width:
                                    screenWidth * 0.1, // Optional custom color
                              ),
                              customButton(
                                text: "End Match",
                                onPressed: () {
                                  provider.endMatch(context);
                                  // provider.getupdatedscore(context); // ✅ Manually refresh match data
                                },
                                backgroundColor: Colors.red,
                                width: 100,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
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
