import 'dart:async';
import 'dart:ui';
import 'package:cricyard/core/utils/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FootballScoreboardScreen extends StatefulWidget {
  @override
  _FootballScoreboardScreenState createState() =>
      _FootballScoreboardScreenState();
}

class _FootballScoreboardScreenState extends State<FootballScoreboardScreen> {
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
    setState(() {
      if (team == 'Home') {
        homeScore++;
      } else {
        awayScore++;
      }
      Map<String, dynamic> event = {
        "type": "goal",
        "team": team,
        "time": "$minutes:${seconds.toString().padLeft(2, '0')}"
      };

      // Add the event to the match events list
      matchEvents.add("${team} scored a goal at ${event['time']}");

      // Push the event onto the undoneEvents stack
      undoneEvents.add(event);

      // Clear the redoEvents stack since a new action is performed
      redoEvents.clear();
    });
    _scrollToBottom();
  }

  void addFoul(String team) {
    setState(() {
      Map<String, dynamic> event = {
        "type": "foul",
        "team": team,
        "time": "$minutes:${seconds.toString().padLeft(2, '0')}"
      };
      // Add the event to the match events list
      matchEvents.add("${team} committed a foul at ${event['time']}");

      // Push the event onto the undoneEvents stack
      undoneEvents.add(event);

      // Clear the redoEvents stack since a new action is performed
      redoEvents.clear();
    });
    _scrollToBottom();
  }

  void addCard(String team, String cardType) {
    setState(() {
      Map<String, dynamic> event = {
        "type": "card",
        "team": team,
        "card": cardType,
        "time": "$minutes:${seconds.toString().padLeft(2, '0')}"
      };
      // Add the event to the match events list
      matchEvents.add("${team} received a $cardType card at ${event['time']}");

      // Push the event onto the undoneEvents stack
      undoneEvents.add(event);

      // Clear the redoEvents stack since a new action is performed
      redoEvents.clear();
    });
    _scrollToBottom();
  }

  void addSubstitution(String team, String playerOut, String playerIn) {
    setState(() {
      Map<String, dynamic> event = {
        "type": "substitution",
        "team": team,
        "playerOut": playerOut,
        "playerIn": playerIn,
        "time": "$minutes:${seconds.toString().padLeft(2, '0')}"
      };
      // Add the event to the match events list
      matchEvents.add(
          "$team Substitution: $playerOut → $playerIn at ${event['time']}");

      // Push the event onto the undoneEvents stack
      undoneEvents.add(event);

      // Clear the redoEvents stack since a new action is performed
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
                      Text("Home Team",
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
                      Text("Away Team",
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
                      backgroundColor:
                          Color(0xFF219ebc),
                          width: 100, // Optional custom color
                    ),
                    SizedBox(width: 10),
                    customButton(
                      text: "Pause",
                      onPressed: stopTimer,
                      backgroundColor:
                          Color(0xFF219ebc),
                          width: 100, // Optional custom color
                    ),
                    SizedBox(width: 10),                    
                    customButton(
                      text: "Reset",
                      onPressed: resetMatch,
                      backgroundColor:
                          Color(0xFF219ebc),
                          width: 100, // Optional custom color
                    ),
                  ],
                ),

                SizedBox(height: 10), // Spacing

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
                      Expanded(child: 
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          customButton(
                            text: "Home Goal",
                            onPressed: () => addGoal("Home"),
                            backgroundColor: Color(0xFF219ebc),width: screenWidth * 0.25,
                          ),
                          customButton(
                            text: "Home Foul",
                            onPressed: () => addFoul("Home"),
                            backgroundColor: Color(0xFF219ebc),width: screenWidth * 0.25,
                          ),
                          customButton(
                            text: "Home Yellow Card",
                            onPressed: () => addCard("Home", "Yellow"),
                            backgroundColor: Color.fromARGB(255, 203, 206, 8),width: screenWidth * 0.25,
                          ),
                          customButton(
                            text: "Home Red Card",
                            onPressed: () => addCard("Home", "Red"),
                            backgroundColor: Color.fromARGB(255, 255, 0, 0),width: screenWidth * 0.25,
                          ),
                        ],
                      ),),

                      // Away Side
                      Expanded(child: 
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        spacing: 10,
                        children: [
                          customButton(
                            text: "Away Goal",
                            onPressed: () => addGoal("Away"),
                            backgroundColor: Color(0xFF219ebc),width: screenWidth * 0.25,
                          ),
                          customButton(
                            text: "Away Foul",
                            onPressed: () => addFoul("Away"),
                            backgroundColor: Color(0xFF219ebc),width: screenWidth * 0.25,
                          ),
                          customButton(
                            text: "Away Yellow Card",
                            onPressed: () => addCard("Away", "Yellow"),
                            backgroundColor: Color.fromARGB(255, 203, 206, 8),width: screenWidth * 0.25,
                          ),
                          customButton(
                            text: "Away Red Card",
                            onPressed: () => addCard("Away", "Red"),
                            backgroundColor: Color.fromARGB(255, 255, 0, 0),width: screenWidth * 0.25,
                          ),
                        ],
                      ),),
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
                            backgroundColor:
                                Color(0xFF219ebc),
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
