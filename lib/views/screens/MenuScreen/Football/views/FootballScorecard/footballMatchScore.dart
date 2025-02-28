import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:confetti/confetti.dart';
import 'package:cricyard/core/utils/image_constant.dart';
import 'package:cricyard/views/screens/MenuScreen/Football/viewmodel/footballMatchScoreProvider.dart';
import 'package:cricyard/views/screens/practice_match/practiceRepository/PracticeMatchService.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class FootballScoreboardScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  FootballScoreboardScreen({required this.entity});
  @override
  _FootballScoreboardScreenState createState() =>
      _FootballScoreboardScreenState();
}

class _FootballScoreboardScreenState extends State<FootballScoreboardScreen> {
  late FootballMatchScoreProvider provider;
  late String hostTeam;
  late String visitorTeam;
  late String tossWinner;
  late String optedTo;

  var tournamentId = 0;
  bool isLoadingData = false;
  bool showOverLay = false;
  var matchId = 0;
  final PracticeMatchService scoreservice = PracticeMatchService();

  @override
  void initState() {
    super.initState();
    // Extract data from the passed entity
    matchId = widget.entity['id'];
    print("matchId: $matchId");
    hostTeam = widget.entity['hostTeam'] ?? "Host Team";
    visitorTeam = widget.entity['visitorTeam'] ?? "Away Team";
    tossWinner = widget.entity['tossWinner'] ?? "Unknown";
    optedTo = widget.entity['opted_to'] ?? "Unknown";

    provider = FootballMatchScoreProvider(
      hostTeam: hostTeam,
      visitorTeam: visitorTeam,
      tossWinner: tossWinner,
      optedTo: optedTo,
      matchId: matchId,
    );
    provider.matchEvents
        .insert(0, "$tossWinner won the toss and chose $optedTo");
    provider.getLastRecordFootball(context);
  }

  // int homeScore = 0;
  // int awayScore = 0;
  // int homeFouls = 0;
  // int awayFouls = 0;
  // int minutes = 0;
  // int seconds = 0;
  // int stoppageMinutes = 0; // Stoppage time minutes
  // int stoppageSeconds = 0; // Stoppage time seconds
  // bool isTimerRunning = false;
  // bool isStoppageTimerRunning = false;
  // Timer? matchTimer;
  // Timer? stoppageTimer; // Mini timer for stoppage time
  // List<String> matchEvents = [];
  // List<Map<String, dynamic>> undoneEvents = [];
  // List<Map<String, dynamic>> redoEvents = [];
  // Stack for redo events
  final ScrollController _scrollController = ScrollController();

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

  // void _scrollToTop() {
  //   Future.delayed(Duration(milliseconds: 100), () {
  //     if (_scrollController.hasClients) {
  //       _scrollController.animateTo(
  //         _scrollController.position.minScrollExtent,
  //         duration: Duration(milliseconds: 300),
  //         curve: Curves.easeOut,
  //       );
  //     }
  //   });
  // }

  // void _scrollUpByAmount() {
  //   Future.delayed(Duration(milliseconds: 100), () {
  //     if (_scrollController.hasClients) {
  //       // Define the amount you want to scroll up, for example, 100 pixels
  //       double offset = 50.0;

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

  // void endMatch() {
  //   stopTimer();
  //   stopStoppageTimer();
  //   setState(() {
  //     matchEvents.add(
  //         "Match has ended. Final Score: $hostTeam $homeScore - $awayScore $visitorTeam");
  //   });
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Match Ended"),
  //         content: Text(
  //             "Final Score:\n$hostTeam $homeScore - $awayScore $visitorTeam"),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.pop(context);
  //               _scrollToBottom();
  //             },
  //             child: Text("OK"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void startTimer() {
  //   if (!isTimerRunning) {
  //     isTimerRunning = true;
  //     matchTimer = Timer.periodic(Duration(seconds: 1), (timer) {
  //       setState(() {
  //         if (seconds < 59) {
  //           seconds++;
  //         } else {
  //           seconds = 0;
  //           minutes++;
  //         }
  //         if (minutes >= 90) {
  //           stopTimer();
  //           endMatch();
  //         }
  //       });
  //     });
  //     stopStoppageTimer();
  //   }
  // }

  // void stopTimer() {
  //   if (isTimerRunning) {
  //     matchTimer?.cancel();
  //     isTimerRunning = false;
  //     startStoppageTimer();
  //   }
  // }

  // void startStoppageTimer() {
  //   if (!isStoppageTimerRunning) {
  //     isStoppageTimerRunning = true;
  //     stoppageTimer = Timer.periodic(Duration(seconds: 1), (timer) {
  //       if (mounted) {
  //         setState(() {
  //           if (stoppageSeconds < 59) {
  //             stoppageSeconds++;
  //           } else {
  //             stoppageSeconds = 0;
  //             stoppageMinutes++;
  //           }
  //         });
  //       }
  //     });
  //   }
  // }

  // void stopStoppageTimer() {
  //   if (isStoppageTimerRunning) {
  //     stoppageTimer?.cancel();
  //     isStoppageTimerRunning = false;
  //   }
  // }

  // void resetMatch() {
  //   stopTimer();
  //   stopStoppageTimer();
  //   setState(() {
  //     homeScore = 0;
  //     awayScore = 0;
  //     minutes = 0;
  //     seconds = 0;
  //     stoppageMinutes = 0;
  //     stoppageSeconds = 0;
  //     matchEvents.clear();
  //   });
  // }

  // void addGoal(String team) {
  //   TextEditingController goalScorerController = TextEditingController();
  //   TextEditingController assistController = TextEditingController();
  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Goal Details"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: goalScorerController,
  //               decoration: InputDecoration(labelText: "Goal Scorer"),
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
  //               Navigator.pop(context); // Close the dialog without saving
  //             },
  //             child: Text("Cancel"),
  //           ),
  //           TextButton(
  //             onPressed: () {
  //               String goalScorer = goalScorerController.text.trim();
  //               String assist = assistController.text.trim();
  //               if (goalScorer.isEmpty) {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(
  //                     content: Text("Please enter the goal scorer's name."),
  //                     backgroundColor: Colors.red,
  //                   ),
  //                 );
  //                 return;
  //               }

  //               setState(() {
  //                 if (team == '$hostTeam') {
  //                   homeScore++;
  //                 } else {
  //                   awayScore++;
  //                 }

  //                 Map<String, dynamic> event = {
  //                   "type": "goal",
  //                   "team": team,
  //                   "goalScorer": goalScorer,
  //                   "assist": assist.isNotEmpty ? assist : "None",
  //                   "time": "$minutes:${seconds.toString().padLeft(2, '0')}"
  //                 };

  //                 // Store goal details in match events
  //                 matchEvents.add(
  //                     "$team: $goalScorer scored at ${event['time']}" +
  //                         (assist.isNotEmpty ? " (Assist: $assist)" : "") +
  //                         " 🎉🎉");

  //                 // Push to undo stack
  //                 undoneEvents.add(event);
  //                 redoEvents.clear(); // Clear redo stack on new action
  //               });

  //               Navigator.pop(context); // Close the dialog
  //               _scrollToBottom(); // Scroll to latest event
  //               bool isHomeTeamGoal = (team == "$hostTeam");
  //               _showConfettiAnimation(context, isHomeTeamGoal);
  //             },
  //             child: Text("Save"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
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

  // void addFoul(String team) {
  //   TextEditingController playerController = TextEditingController();
  //   String? selectedFoulType;
  //   String? selectedCard;

  //   showDialog(
  //     context: context,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: Text("Foul Details"),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             TextField(
  //               controller: playerController,
  //               decoration:
  //                   InputDecoration(labelText: "Player Who Committed Foul"),
  //             ),
  //             DropdownButtonFormField<String>(
  //               decoration: InputDecoration(labelText: "Foul Type"),
  //               items: ["Normal Foul", "Handball", "Dangerous Play", "Other"]
  //                   .map((type) =>
  //                       DropdownMenuItem(value: type, child: Text(type)))
  //                   .toList(),
  //               onChanged: (value) {
  //                 selectedFoulType = value;
  //               },
  //             ),
  //             DropdownButtonFormField<String>(
  //               decoration: InputDecoration(labelText: "Card Given"),
  //               items: ["None", "Yellow Card", "Red Card"]
  //                   .map((card) =>
  //                       DropdownMenuItem(value: card, child: Text(card)))
  //                   .toList(),
  //               onChanged: (value) {
  //                 selectedCard = value;
  //               },
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
  //               String player = playerController.text.trim();
  //               if (player.isEmpty) {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   SnackBar(
  //                     content: Text("Please enter the player's name."),
  //                     backgroundColor: Colors.red,
  //                   ),
  //                 );
  //                 return;
  //               }

  //               setState(() {
  //                 if (team == "$hostTeam") {
  //                   homeFouls++;
  //                 } else {
  //                   awayFouls++;
  //                 }
  //                 Map<String, dynamic> event = {
  //                   "type": "foul",
  //                   "team": team,
  //                   "player": player,
  //                   "foulType": selectedFoulType ?? "Normal Foul",
  //                   "card": selectedCard ?? "None",
  //                   "time": "$minutes:${seconds.toString().padLeft(2, '0')}"
  //                 };

  //                 // Add the event to match events
  //                 matchEvents.add(
  //                     "$team: $player committed a ${selectedFoulType ?? "Normal Foul"} foul at ${event['time']}" +
  //                         ({selectedCard ?? "No Card"} != "None"
  //                             ? " (${selectedCard ?? "No Card"} given)"
  //                             : ""));

  //                 // Push the event onto the undoneEvents stack
  //                 undoneEvents.add(event);
  //                 redoEvents.clear(); // Clear redo stack on new action
  //               });

  //               Navigator.pop(context); // Close the dialog
  //               _scrollToBottom(); // Scroll to latest event

  //               bool isHomeTeamGoal = (team == "$hostTeam");
  //               if (selectedCard != null && selectedCard != "None") {
  //                 _showCardAnimation(context, selectedCard!, isHomeTeamGoal);
  //               }
  //             },
  //             child: Text("Save"),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void _showCardAnimation(
  //     BuildContext context, String cardType, bool isHomeTeamGoal) {
  //   OverlayEntry overlayEntry;
  //   overlayEntry = OverlayEntry(
  //     builder: (context) {
  //       // Adding a delay inside the builder
  //       return FutureBuilder(
  //         future: Future.delayed(Duration(milliseconds: 700)), // 1-second delay
  //         builder: (context, snapshot) {
  //           // Once the delay is over, the card is shown and the animation begins
  //           if (snapshot.connectionState == ConnectionState.done) {
  //             return Positioned(
  //               left: isHomeTeamGoal ? 0 : null, // Home team goal on the left
  //               right:
  //                   !isHomeTeamGoal ? 0 : null, // Away team goal on the right
  //               top: MediaQuery.of(context).size.height * 0.2,
  //               child: Padding(
  //                 padding: EdgeInsets.symmetric(
  //                     horizontal: 25.0), // Padding to avoid touching the edges
  //                 child: Center(
  //                   child: TweenAnimationBuilder(
  //                     tween: Tween<double>(
  //                         begin: 0, end: pi), // 0 to 180° rotation
  //                     duration: Duration(milliseconds: 1000), // Flip speed
  //                     builder: (context, double angle, child) {
  //                       bool isFront = angle < pi / 2; // Front side condition

  //                       return AnimatedOpacity(
  //                         opacity: angle >= pi / 2
  //                             ? 0.0
  //                             : 1.0, // Fade out after the flip is done
  //                         duration:
  //                             Duration(milliseconds: 700), // Fade-out duration
  //                         child: Transform(
  //                           alignment: Alignment.center,
  //                           transform: Matrix4.identity()
  //                             ..setEntry(3, 2, 0.002) // Perspective effect
  //                             ..rotateY(angle), // Rotate on Y-axis
  //                           child: Container(
  //                             width: 100,
  //                             height: 150,
  //                             decoration: BoxDecoration(
  //                               color: isFront
  //                                   ? (cardType == "Yellow Card"
  //                                       ? Colors.yellow
  //                                       : Colors.red)
  //                                   : (cardType == "Yellow Card"
  //                                       ? Colors.yellow
  //                                       : Colors.red),
  //                               borderRadius: BorderRadius.circular(10),
  //                               boxShadow: [
  //                                 BoxShadow(
  //                                     color: Colors.black26, blurRadius: 10),
  //                               ],
  //                             ),
  //                             child: Transform(
  //                               alignment: Alignment.center,
  //                               transform: Matrix4.identity()
  //                                 ..rotateY(isFront
  //                                     ? 0
  //                                     : pi), // Keep text always upright
  //                               child: Center(
  //                                 child: Text(
  //                                   cardType,
  //                                   style: TextStyle(
  //                                     color: Colors.black,
  //                                     fontSize: 22,
  //                                     fontWeight: FontWeight.bold,
  //                                   ),
  //                                   textAlign: TextAlign.center,
  //                                 ),
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //                 ),
  //               ),
  //             );
  //           } else {
  //             return SizedBox(); // Return an empty widget while waiting for the delay
  //           }
  //         },
  //       );
  //     },
  //   );

  //   Overlay.of(context)?.insert(overlayEntry);

  //   // Keep it visible for 2 seconds before removing
  //   Future.delayed(Duration(seconds: 3), () {
  //     overlayEntry.remove();
  //   });
  // }

  // void addCard(String team, String cardType) async {
  //   String? selectedPlayer;

  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             title: Text("Select Player for $cardType Card"),
  //             content: TextField(
  //               onChanged: (value) {
  //                 selectedPlayer = value;
  //               },
  //               decoration: InputDecoration(
  //                 labelText: "Player Name",
  //                 border: OutlineInputBorder(),
  //               ),
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context); // Close dialog without saving
  //                 },
  //                 child: Text("Cancel"),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   if (selectedPlayer == null || selectedPlayer!.isEmpty) {
  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                       SnackBar(
  //                         content: Text("Please enter a player name"),
  //                         backgroundColor: Colors.red,
  //                       ),
  //                     );
  //                     return;
  //                   }
  //                   Navigator.pop(context, selectedPlayer);
  //                 },
  //                 child: Text("OK"),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );

  //   if (selectedPlayer == null || selectedPlayer!.isEmpty) return;

  //   setState(() {
  //     Map<String, dynamic> event = {
  //       "type": "card",
  //       "team": team,
  //       "player": selectedPlayer,
  //       "card": cardType,
  //       "time": "$minutes:${seconds.toString().padLeft(2, '0')}"
  //     };

  //     // Add event to match log
  //     matchEvents.add(
  //         "$team: $selectedPlayer received a $cardType card at ${event['time']}");

  //     // Push to undo stack
  //     undoneEvents.add(event);
  //     redoEvents.clear();
  //   });

  //   _scrollToBottom();
  // }

  // void addSubstitution(String team) async {
  //   String? playerOut;
  //   String? playerIn;

  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return StatefulBuilder(
  //         builder: (context, setState) {
  //           return AlertDialog(
  //             title: Text("Substitution for $team"),
  //             content: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 TextField(
  //                   onChanged: (value) {
  //                     playerOut = value;
  //                   },
  //                   decoration: InputDecoration(
  //                     labelText: "Player Out",
  //                     border: OutlineInputBorder(),
  //                   ),
  //                 ),
  //                 SizedBox(height: 10),
  //                 TextField(
  //                   onChanged: (value) {
  //                     playerIn = value;
  //                   },
  //                   decoration: InputDecoration(
  //                     labelText: "Player In",
  //                     border: OutlineInputBorder(),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //             actions: [
  //               TextButton(
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 },
  //                 child: Text("Cancel"),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   if (playerOut == null ||
  //                       playerOut!.isEmpty ||
  //                       playerIn == null ||
  //                       playerIn!.isEmpty) {
  //                     ScaffoldMessenger.of(context).showSnackBar(
  //                       SnackBar(
  //                         content: Text("Please enter both players"),
  //                         backgroundColor: Colors.red,
  //                       ),
  //                     );
  //                     return;
  //                   }
  //                   Navigator.pop(context, [playerOut, playerIn]);
  //                 },
  //                 child: Text("OK"),
  //               ),
  //             ],
  //           );
  //         },
  //       );
  //     },
  //   );
  //   if (playerOut == null || playerIn == null) return;
  //   setState(() {
  //     Map<String, dynamic> event = {
  //       "type": "substitution",
  //       "team": team,
  //       "playerOut": playerOut,
  //       "playerIn": playerIn,
  //       "time": "$minutes:${seconds.toString().padLeft(2, '0')}"
  //     };
  //     // Add event to match log
  //     matchEvents.add(
  //         "$team Substitution: $playerOut → $playerIn at ${event['time']}");
  //     // Push to undo stack
  //     undoneEvents.add(event);
  //     redoEvents.clear();
  //   });
  //   _scrollToBottom();
  // }

  // Future<void> updateData(int scdata, type, scoreboard) async {
  //   setState(() {
  //     showOverLay = true;
  //   });
  //   Map<String, dynamic> payload = {
  //     "match_id": matchId,
  //     "home_score": homeScore,
  //     "away_score": awayScore,
  //     "home_fouls": homeFouls,
  //     "away_fouls": awayFouls,
  //     "match_end": isMatchOver,
  //     "current_time": "$minutes:$seconds",
  //     "events": matchEvents, // ✅ Pass all stored match events
  //   };
  //   try {
  //     // await scoreservice.updateScore(scdata, type, scoreboard).then((_) {
  //     await scoreservice.updateScore(scdata, type, payload).then((_) {
  //       getLastRecordFootball().then(
  //         (value) {
  //           setState(() {
  //             showOverLay = false;
  //           });
  //           showSnackBar(context, 'Success', Colors.green);
  //         },
  //       );
  //     });
  //   } catch (e) {
  //     setState(() {
  //       showOverLay = false;
  //     });
  //     showSnackBar(context, 'Error updating $e', Colors.red);
  //   } finally {
  //     setState(() {
  //       showOverLay = false;
  //     });
  //   }
  // }

  // void showSnackBar(BuildContext context, String msg, Color color) {
  //   final mediaQuery = MediaQuery.of(context);
  //   final topPadding = mediaQuery.viewPadding.bottom;
  //   const snackBarHeight = 50.0; // Approximate height of SnackBar
  //   final topMargin = topPadding + snackBarHeight + 700; // Add some padding
  //   SnackBar snackBar = SnackBar(
  //     margin: EdgeInsets.only(bottom: topMargin, left: 16.0, right: 16.0),
  //     behavior: SnackBarBehavior.floating,
  //     backgroundColor: Colors.transparent,
  //     // Make background transparent to show custom design
  //     elevation: 0,
  //     // Remove default elevation to apply custom shadow
  //     content: Stack(
  //       clipBehavior: Clip.none,
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //             gradient: LinearGradient(
  //               colors: [color.withOpacity(0.8), color],
  //               begin: Alignment.topLeft,
  //               end: Alignment.bottomRight,
  //             ),
  //             borderRadius: BorderRadius.circular(12.0),
  //             boxShadow: const [
  //               BoxShadow(
  //                 color: Colors.black26,
  //                 offset: Offset(0, 4),
  //                 blurRadius: 10.0,
  //               ),
  //             ],
  //           ),
  //           padding: const EdgeInsets.all(16.0),
  //           child: Row(
  //             children: [
  //               const Icon(
  //                 Icons.info_rounded,
  //                 color: Colors.white,
  //                 size: 28.0, // Slightly larger icon
  //               ),
  //               const SizedBox(width: 10),
  //               Expanded(
  //                 child: Text(
  //                   msg,
  //                   style: const TextStyle(
  //                     fontWeight: FontWeight.bold,
  //                     color: Colors.white,
  //                     fontSize: 16.0, // Slightly larger text
  //                   ),
  //                   overflow: TextOverflow.ellipsis,
  //                 ),
  //               ),
  //               IconButton(
  //                 icon: const Icon(Icons.close, color: Colors.white),
  //                 onPressed: () {
  //                   ScaffoldMessenger.of(context).hideCurrentSnackBar();
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //         Positioned(
  //           left: -15,
  //           top: -15,
  //           child: Container(
  //             width: 40,
  //             height: 40,
  //             decoration: BoxDecoration(
  //               color: color,
  //               shape: BoxShape.circle,
  //             ),
  //           ),
  //         ),
  //         Positioned(
  //           right: -10,
  //           bottom: -10,
  //           child: Container(
  //             width: 30,
  //             height: 30,
  //             decoration: BoxDecoration(
  //               color: color,
  //               shape: BoxShape.circle,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  //   ScaffoldMessenger.of(context).showSnackBar(snackBar);
  // }

  //
  // Map<String, dynamic> lastRecord = {};

  // bool islastrecord = true;
  // var opted_to = '';
  // bool isMatchOver = false;

  // Future<void> getupdatedscore() async {
  //   try {
  //     final fetchedEntities = await scoreservice.getlastrecord(matchId);
  //     print("LAST RECORD!! --$fetchedEntities");
  //     if (fetchedEntities != null && fetchedEntities.isNotEmpty) {
  //       setState(() {
  //         islastrecord = true;

  //         lastRecord = fetchedEntities;
  //         if (lastRecord['hostTeam'] != null) {
  //           hostTeam = lastRecord['hostTeam'];
  //         }
  //         if (lastRecord['visitorTeam'] != null) {
  //           visitorTeam = lastRecord['visitorTeam'];
  //         }
  //         if (lastRecord['tossWinner'] != null) {
  //           tossWinner = lastRecord['tossWinner'];
  //         }
  //         if (lastRecord['opted_to'] != null) {
  //           opted_to = lastRecord['opted_to'];
  //         }
  //         if (lastRecord['match_end'] != null) {
  //           isMatchOver = lastRecord['match_end'];
  //         }
  //       });
  //     }
  //   } catch (e) {
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: Text(
  //             'Failed to fetch : $e',
  //             style: const TextStyle(color: Colors.black),
  //           ),
  //           actions: [
  //             TextButton(
  //               child: const Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   }
  // }

  // Future<void> getLastRecordFootball() async {
  //   setState(() {
  //     isLoadingData = true;
  //   });

  //   try {
  //     // await getUpdatedScore();
  //     // await getLastRecOfPlayer();
  //     // await fetchBattingPlayers();
  //     // await fetchBowlingPlayers();
  //     // await fetchPartnership();
  //     // await fetchExtraRuns();
  //     // await allBalls();
  //   } catch (e) {
  //     // Log the error and display a message to the user
  //     print("Error occurred: $e");
  //     showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: const Text('Error'),
  //           content: Text(
  //             'Failed to fetch data: $e',
  //             style: const TextStyle(color: Colors.black),
  //           ),
  //           actions: [
  //             TextButton(
  //               child: const Text('OK'),
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //               },
  //             ),
  //           ],
  //         );
  //       },
  //     );
  //   } finally {
  //     // Ensure isLoadingData is set to false regardless of success or failure
  //     setState(() {
  //       // isLoadingData = false;
  //     });
  //   }
  // }

  // void undoEvent() {
  //   if (undoneEvents.isNotEmpty) {
  //     Map<String, dynamic> lastEvent = undoneEvents.removeLast();
  //     redoEvents.add(lastEvent); // Store for redo

  //     setState(() {
  //       matchEvents.removeLast(); // Remove event text from the list

  //       // Handle different event types
  //       switch (lastEvent["type"]) {
  //         case "goal":
  //           if (lastEvent["team"] == "$hostTeam") {
  //             homeScore = (homeScore > 0) ? homeScore - 1 : 0;
  //           } else {
  //             awayScore = (awayScore > 0) ? awayScore - 1 : 0;
  //           }
  //           break;
  //         case "foul":
  //           // No additional action needed, just remove from matchEvents
  //           break;
  //         case "card":
  //           // No additional action needed, just remove from matchEvents
  //           break;
  //         case "substitution":
  //           // No additional action needed, just remove from matchEvents
  //           break;
  //       }
  //     });
  //   }
  //   _scrollUpByAmount();
  // }

  // void redoEvent() {
  //   if (redoEvents.isNotEmpty) {
  //     Map<String, dynamic> eventToRedo = redoEvents.removeLast();
  //     undoneEvents.add(eventToRedo); // Move back to undo stack

  //     setState(() {
  //       String eventText = "";
  //       switch (eventToRedo["type"]) {
  //         case "goal":
  //           eventText =
  //               "${eventToRedo['team']} scored a goal at ${eventToRedo['time']}";
  //           if (eventToRedo["team"] == "$hostTeam") {
  //             homeScore++;
  //           } else {
  //             awayScore++;
  //           }
  //           break;
  //         case "foul":
  //           eventText =
  //               "${eventToRedo['team']} committed a foul at ${eventToRedo['time']}";
  //           break;
  //         case "card":
  //           eventText =
  //               "${eventToRedo['team']} received a ${eventToRedo['card']} card at ${eventToRedo['time']}";
  //           break;
  //         case "substitution":
  //           eventText =
  //               "${eventToRedo['team']} Substitution: ${eventToRedo['playerOut']} → ${eventToRedo['playerIn']} at ${eventToRedo['time']}";
  //           break;
  //       }
  //       matchEvents.add(eventText);
  //     });
  //   }
  //   _scrollToBottom();
  // }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        appBar: AppBar(title: Text("Football Scoreboard")),
        body: Consumer<FootballMatchScoreProvider>(
            builder: (context, provider, child) {
          return Stack(
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
                      color: Colors.black.withOpacity(0.2), // Optional overlay to enhance blur
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
                          Text("${provider.homeScore}",
                              style: TextStyle(fontSize: 50)),
                        ]),
                        Column(children: [
                          Text("Time",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 10),
                          Text(
                            "${provider.minutes}:${provider.seconds.toString().padLeft(2, '0')}",
                            style: TextStyle(
                              fontSize: 30,
                            ), // Timer color changed to black
                          ),
                        ]),
                        Column(children: [
                          Text(visitorTeam,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(height: 10),
                          Text("${provider.awayScore}",
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
                          onPressed: () {
                            provider.startTimer(context);
                            provider.getupdatedscore(
                                context); 
                          },
                          backgroundColor: Color(0xFF219ebc),
                          width: 100, // Optional custom color
                        ),
                        SizedBox(width: 10),
                        customButton(
                          text: "Pause",
                          onPressed: () {
                            provider.stopTimer(context);
                            provider.getupdatedscore(context);
                          },
                          backgroundColor: Color(0xFF219ebc),
                          width: 100,
                        ),
                        SizedBox(width: 10),
                        customButton(
                          text: "Reset",
                          onPressed: () {
                            provider.resetMatch(context);
                            provider.getupdatedscore(context);
                          },
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
                            "Stoppage Time: ${provider.stoppageMinutes}:${provider.stoppageSeconds.toString().padLeft(2, '0')}",
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
                        itemCount: provider.matchEvents.length,
                        itemBuilder: (context, index) => ListTile(
                          title: Text(provider.matchEvents[index],
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white)),
                        ),
                      ),
                    ),

                    SizedBox(height: 10), // Spacing

                    Container(
                      padding:
                          EdgeInsets.all(16.0),
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
                                  onPressed: () {
                                    provider.addGoal("$hostTeam", context);
                                  },
                                  backgroundColor: Color(0xFF219ebc),
                                  width: screenWidth * 0.25,
                                ),
                                customButton(
                                  text: "$hostTeam Foul",
                                  onPressed: () {
                                    provider.addFoul("$hostTeam", context);
                                  },
                                  backgroundColor: Color(0xFF219ebc),
                                  width: screenWidth * 0.25,
                                ),
                                customButton(
                                  text: "$hostTeam Substitution",
                                  onPressed: () {
                                    provider.addSubstitution(
                                        "$hostTeam", context);
                                  },
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
                                  text: "$visitorTeam Goal",
                                  onPressed: () {
                                    provider.addGoal("$visitorTeam", context);
                                  },
                                  backgroundColor: Color(0xFF219ebc),
                                  width: screenWidth * 0.25,
                                ),
                                customButton(
                                  text: "$visitorTeam Foul",
                                  onPressed: () {
                                    provider.addFoul("$visitorTeam", context);
                                    },
                                  backgroundColor: Color(0xFF219ebc),
                                  width: screenWidth * 0.25,
                                ),
                                customButton(
                                  text: "$visitorTeam Substitution",
                                  onPressed: () {
                                    provider.addSubstitution(
                                        "$visitorTeam", context);
                                  },
                                  backgroundColor: Color(0xFF219ebc),
                                  width: screenWidth * 0.25,
                                ),
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
                                    screenWidth * 0.2, // Optional custom color
                              ),
                              SizedBox(width: 10),
                              customButton(
                                text: "Redo",
                                onPressed: () {
                                  provider.redoEvent(context);
                                },
                                backgroundColor: Color(0xFF219ebc),
                                width:
                                    screenWidth * 0.2, // Optional custom color
                              ),
                              customButton(
                                text: "End Match",
                                onPressed: () {
                                  provider.endMatch(context);
                                },
                                backgroundColor: Colors.red,
                                width: 100,
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
