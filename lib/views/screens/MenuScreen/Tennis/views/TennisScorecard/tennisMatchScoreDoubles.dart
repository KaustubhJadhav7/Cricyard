import 'dart:ui';

import 'package:cricyard/core/utils/image_constant.dart';
import 'package:cricyard/views/screens/MenuScreen/Tennis/viewmodel/tennisDoublesScoreProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TennisDoublesScoreboardScreen extends StatefulWidget {
  final List<String> team1;
  final List<String> team2;
  final Map<String, dynamic> entity;

  // 'tossWinner': _team1Player1Controller.text,
  //   'striker_player_name': _team1Player2Controller.text,

  //   'non_striker_player_name': _team2Player1Controller.text,
  //   'baller_player_name': _team2Player2Controller.text,

  TennisDoublesScoreboardScreen(
      {required this.team1, required this.team2, required this.entity});

  @override
  _TennisDoublesScoreboardScreenState createState() =>
      _TennisDoublesScoreboardScreenState();
}

class _TennisDoublesScoreboardScreenState
    extends State<TennisDoublesScoreboardScreen> {
  late TennisDoublesProvider provider;
  late String hostTeam;
  late String visitorTeam;
  late String tossWinner;
  late String optedTo;
  late String striker_player_name;
  late String non_striker_player_name;
  late String baller_player_name;
  // final ScrollController _scrollController = ScrollController();
  var matchId = 0;
  @override
  void initState() {
    super.initState();
    matchId = widget.entity['id'];
    print("✅ Tennis Doubles matchId: $matchId");
    hostTeam = widget.entity['hostTeam'] ?? "Host Team";
    visitorTeam = widget.entity['visitorTeam'] ?? "Away Team";
    tossWinner = widget.entity['tossWinner'] ?? "Unknown";
    striker_player_name = widget.entity['striker_player_name'] ?? "Unknown";
    non_striker_player_name =
        widget.entity['non_striker_player_name'] ?? "Unknown";
    baller_player_name = widget.entity['baller_player_name'] ?? "Unknown";
    provider = TennisDoublesProvider(
        team1: widget.team1, team2: widget.team2, matchId: matchId);
    provider.getLastRecordTennisDoubles(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        appBar: AppBar(title: Text("Tennis Doubles Scoreboard")),
        body: Consumer<TennisDoublesProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    ImageConstant.tennisCourt,
                    fit: BoxFit.cover,
                  ),
                ),

                // Blur effect overlay
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
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Table to display scores
                      DataTable(
                        columns: [
                          DataColumn(
                              label: Text("Team",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))),
                          DataColumn(
                              label: Text("Points",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))),
                          DataColumn(
                              label: Text("Games",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))),
                          DataColumn(
                              label: Text("Sets",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))),
                          DataColumn(
                              label: Text("Winner",
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white))),
                        ],
                        rows: [
                          DataRow(cells: [
                            DataCell(
                              Text(provider.team1.join(" & "),
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white)),
                            ),
                            DataCell(Text(provider.team1Score,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(provider.team1Games.toString(),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(provider.team1Sets.toString(),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(
                                provider.winner == provider.team1.join(" & ")
                                    ? "Winner"
                                    : "-",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white))),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(provider.team2.join(" & "),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(provider.team2Score,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(provider.team2Games.toString(),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(provider.team2Sets.toString(),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(
                                provider.winner == provider.team2.join(" & ")
                                    ? "Winner"
                                    : "-",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white))),
                          ]),
                        ],
                      ),

                      SizedBox(height: 30),
                      Container(
                        height: 150, // Adjust height as needed
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListView.builder(
                          controller: provider.scrollController,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                          itemCount: provider.matchEvents.length,
                          itemBuilder: (context, index) => ListTile(
                            title: Text(
                              provider.matchEvents[index],
                              style:
                                  TextStyle(fontSize: 16, color: Colors.white),
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: 20),

                      // Controls
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.1,
                          vertical: MediaQuery.of(context).size.height * 0.06,
                        ),
                        height: 220,
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customButton(
                                  text: "${provider.team1.join(" & ")} Scores",
                                  onPressed: () => provider.addPointToTeam1(
                                      context), // ✅ Pass context properly

                                  backgroundColor: Color(0xFF219ebc),
                                  width: 150,
                                ),
                                SizedBox(height: 10),
                                customButton(
                                  text: "${provider.team2.join(" & ")} Scores",
                                  onPressed: () => provider.addPointToTeam2(
                                      context), // ✅ Pass context properly

                                  backgroundColor: Color(0xFF219ebc),
                                  width: 150,
                                ),
                              ],
                            ),

                            SizedBox(width: 20),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customButton(
                                  text: "Undo",
                                  onPressed: () {
                                    provider.undoEvent(context);
                                  },
                                  backgroundColor: Color(0xFF219ebc),
                                  width: 100,
                                ),
                                SizedBox(height: 10),
                                customButton(
                                  text: "Redo",
                                  onPressed: (){provider.redoEvent(context);},
                                  backgroundColor: Color(0xFF219ebc),
                                  width: 100,
                                ),
                              ],
                            ),
                            SizedBox(width: 20),
                            // Reset Match Button
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customButton(
                                  text: "Reset Match",
                                  onPressed: () {
                                    provider.resetMatch(context);
                                  },
                                  backgroundColor: Color(0xFF219ebc),
                                  width: 100,
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
                      ),
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
}

Widget customButton({
  required String text,
  required VoidCallback onPressed,
  Color backgroundColor = const Color(0xFF219ebc),
  double? width,
  double? height,
}) {
  width ??= 150;
  height ??= 30;
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
