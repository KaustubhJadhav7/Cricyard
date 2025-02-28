import 'dart:ui';

import 'package:cricyard/core/utils/image_constant.dart';
import 'package:cricyard/views/screens/MenuScreen/Tennis/viewmodel/tennisSinglesScoreProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class TennisScoreboardScreen extends StatefulWidget {
  // final String player1;
  // final String player2;
  final Map<String, dynamic> entity;

  TennisScoreboardScreen({required this.entity});

  @override
  _TennisScoreboardScreenState createState() => _TennisScoreboardScreenState();
}

class _TennisScoreboardScreenState extends State<TennisScoreboardScreen> {
  late TennisScoreProvider provider;
  late String player1;
  late String player2;
  var matchId = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    player1 = widget.entity['hostTeam'] ?? "Host Team";
    player2 = widget.entity['visitorTeam'] ?? "Away Team";
    matchId = widget.entity['id'];
    provider = TennisScoreProvider(
        player1: player1, player2: player2, matchId: matchId);
    provider.getLastRecordTennis(context);
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: provider,
      child: Scaffold(
        appBar: AppBar(title: Text("Tennis Scoreboard")),
        body: Consumer<TennisScoreProvider>(
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
                      filter: ImageFilter.blur(
                          sigmaX: 3, sigmaY: 3), // Adjust blur intensity
                      child: Container(
                        color: Colors.black.withOpacity(
                            0.2), // Optional overlay to enhance blur
                      ),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.1,
                    // vertical: MediaQuery.of(context).size.height * 0.06,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Table to display scores
                      DataTable(
                        columns: [
                          DataColumn(
                              label: Text(
                            "Player",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          )),
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
                              Text(provider.player1,
                                  style: TextStyle(
                                      fontSize: 17, color: Colors.white)),
                            ),
                            DataCell(Text(provider.player1Score,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(provider.player1Games.toString(),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(provider.player1Sets.toString(),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(
                                provider.winner == provider.player1
                                    ? "Winner"
                                    : "-",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white))),
                          ]),
                          DataRow(cells: [
                            DataCell(Text(provider.player2,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(provider.player2Score,
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(provider.player2Games.toString(),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(provider.player2Sets.toString(),
                                style: TextStyle(
                                    fontSize: 17, color: Colors.white))),
                            DataCell(Text(
                                provider.winner == provider.player2
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
                          color: Colors.black.withOpacity(
                              0.6), // Adjust opacity for translucency
                          borderRadius: BorderRadius.circular(
                              10), // Optional rounded corners
                        ),
                        child: ListView.builder(
                          controller: provider.scrollController,
                          shrinkWrap:
                              true, // Ensures ListView takes only required space
                          physics:
                              ClampingScrollPhysics(), // Prevents unnecessary scrolling issues
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
                        // margin: EdgeInsets.all(10),
                        height: 220, // Adjust height as needed
                        width: MediaQuery.of(context).size.width * 0.8,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(
                              0.3), // Adjust opacity for translucency
                          borderRadius: BorderRadius.circular(
                              10), // Optional rounded corners
                        ),
                        child: Row(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customButton(
                                  text: "${provider.player1} Scores",
                                  onPressed: () {
                                    provider.addPointToPlayer1(context);
                                  },
                                  backgroundColor: Color(0xFF219ebc),
                                  width: 100,
                                ),
                                SizedBox(height: 10),
                                customButton(
                                  text: "${provider.player2} Scores",
                                  onPressed: () {
                                    provider.addPointToPlayer2(context);
                                  },
                                  backgroundColor: Color(0xFF219ebc),
                                  width: 100,
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
                                  onPressed: () {
                                    provider.redoEvent(context);
                                    // provider.getupdatedscore(context); // ✅ Manually refresh match data
                                  },
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
                                    // provider.getupdatedscore(context); // ✅ Manually refresh match data
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

class ScoreRow extends StatelessWidget {
  final String player;
  final String score;
  final List<int> setScores;

  ScoreRow(
      {required this.player, required this.score, required this.setScores});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(player,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          Text(score, style: TextStyle(fontSize: 24)),
          Row(
              children: setScores
                  .map((set) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        child: Text(set.toString(),
                            style: TextStyle(fontSize: 18)),
                      ))
                  .toList()),
        ],
      ),
    );
  }
}

// class TennisScoreProvider extends ChangeNotifier {
//   final String player1;
//   final String player2;

//   List<int> player1Sets = [];
//   List<int> player2Sets = [];
//   int player1Points = 0;
//   int player2Points = 0;

//   TennisScoreProvider({required this.player1, required this.player2});

//   String get player1Score => _formatPoints(player1Points);
//   String get player2Score => _formatPoints(player2Points);

//   void addPointToPlayer1() {
//     _updateScore(1);
//   }

//   void addPointToPlayer2() {
//     _updateScore(2);
//   }

//   void _updateScore(int player) {
//     if (player == 1) {
//       player1Points++;
//     } else {
//       player2Points++;
//     }
//     notifyListeners();
//   }

//   String _formatPoints(int points) {
//     switch (points) {
//       case 0: return "Love";
//       case 1: return "15";
//       case 2: return "30";
//       case 3: return "40";
//       default: return "Game";
//     }
//   }

//   void resetMatch() {
//     player1Points = 0;
//     player2Points = 0;
//     player1Sets.clear();
//     player2Sets.clear();
//     notifyListeners();
//   }
// }
