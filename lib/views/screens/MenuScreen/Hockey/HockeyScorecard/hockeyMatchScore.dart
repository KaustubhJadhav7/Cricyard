import 'dart:ui';
import 'package:cricyard/views/screens/MenuScreen/Hockey/viewmodel/hockeyMatchScoreProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cricyard/core/utils/image_constant.dart';

class HockeyScoreboardScreen extends StatefulWidget {
  final Map<String, dynamic> entity;
  HockeyScoreboardScreen({required this.entity});
  @override
  _HockeyScoreboardScreenState createState() => _HockeyScoreboardScreenState();
}

class _HockeyScoreboardScreenState extends State<HockeyScoreboardScreen> {
  late HockeyMatchScoreProvider provider;
  late String hostTeam;
  late String visitorTeam;
  late String tossWinner;
  late String optedTo;
  var matchId = 0;

  @override
  void initState() {
    super.initState();
    matchId = widget.entity['id'];
    print("matchId: $matchId");
    hostTeam = widget.entity['hostTeam'] ?? "Home Team";
    visitorTeam = widget.entity['visitorTeam'] ?? "Away Team";
    tossWinner = widget.entity['tossWinner'] ?? "Unknown";
    optedTo = widget.entity['opted_to'] ?? "Unknown";
    provider = HockeyMatchScoreProvider(
      hostTeam: hostTeam,
      visitorTeam: visitorTeam,
      tossWinner: tossWinner,
      optedTo: optedTo,
      matchId: matchId,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        appBar: AppBar(title: Text("Hockey Scoreboard")),
        body: Consumer<HockeyMatchScoreProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    ImageConstant.hockeyStadium,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned.fill(
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: Container(
                        color: Colors.black.withOpacity(0.2),
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.1,
                    vertical: screenHeight * 0.06,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _teamScore(hostTeam, provider.homeScore),
                          Text(
                              "Time: ${provider.minutes}:${provider.seconds.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          _teamScore(visitorTeam, provider.awayScore),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          customButton(
                            text: "Start",
                            onPressed: provider.startTimer,
                            backgroundColor: Color(0xFF219ebc),
                            width: 100,
                          ),
                          SizedBox(width: 10),
                          customButton(
                            text: "Pause",
                            onPressed: provider.stopTimer,
                            backgroundColor: Color(0xFF219ebc),
                            width: 100,
                          ),
                          SizedBox(width: 10),
                          customButton(
                            text: "Reset",
                            onPressed: provider.resetMatch,
                            backgroundColor: Color(0xFF219ebc),
                            width: 100,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      SizedBox(height: 150, child: _eventLog(provider)),
                      SizedBox(height: 10),
                      _actionButtons(screenWidth, provider),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _teamScore(String team, int score) {
    return Column(
      children: [
        Text(team, style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text("$score", style: TextStyle(fontSize: 50)),
      ],
    );
  }

  Widget _eventLog(HockeyMatchScoreProvider provider) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        shrinkWrap: true,
        physics: ClampingScrollPhysics(),
        itemCount: provider.matchEvents.length,
        itemBuilder: (context, index) => ListTile(
          title: Text(provider.matchEvents[index],
              style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _actionButtons(double screenWidth, HockeyMatchScoreProvider provider) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Color.fromARGB(125, 255, 255, 255),
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _teamActions(hostTeam, provider, screenWidth),
          _teamActions(visitorTeam, provider, screenWidth),
          Column(
            children: [
              customButton(
                text: "Undo",
                onPressed: () {
                  provider.undoEvent(context);
                },
                backgroundColor: Color(0xFF219ebc),
                width: screenWidth * 0.2,
              ),
              SizedBox(height: 10),
              customButton(
                text: "Redo",
                onPressed: () {
                  provider.redoEvent(context);
                },
                backgroundColor: Color(0xFF219ebc),
                width: screenWidth * 0.2,
              ),
              SizedBox(height: 10),
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
    );
  }

  Widget _teamActions(
      String team, HockeyMatchScoreProvider provider, double screenWidth) {
    return Column(
      children: [
        customButton(
          text: "$team Goal",
          onPressed: () => provider.addGoal(team, context),
          backgroundColor: Color(0xFF219ebc),
          width: screenWidth * 0.25,
        ),
        SizedBox(height: 10),
        customButton(
          text: "$team Foul",
          onPressed: () {
            provider.addFoul(team, context);
          },
          backgroundColor: Color(0xFF219ebc),
          width: screenWidth * 0.25,
        ),
        SizedBox(height: 10),
        customButton(
          text: "$team Penalty",
          onPressed: () => provider.addPenalty(team, context),
          backgroundColor: Color(0xFF219ebc),
          width: screenWidth * 0.25,
        ),
      ],
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
