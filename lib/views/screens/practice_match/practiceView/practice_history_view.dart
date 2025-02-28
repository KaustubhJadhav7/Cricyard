import 'package:cricyard/views/screens/MenuScreen/Basketball/views/BasketballScorecard/basketballMatchScore.dart';
import 'package:cricyard/views/screens/MenuScreen/Football/views/FootballScorecard/footballMatchScore.dart';
import 'package:cricyard/views/screens/MenuScreen/Hockey/HockeyScorecard/hockeyMatchScore.dart';
import 'package:cricyard/views/screens/MenuScreen/Tennis/views/TennisScorecard/tennisMatchScoreDoubles.dart';
import 'package:cricyard/views/screens/MenuScreen/Tennis/views/TennisScorecard/tennisMatchScoreSingles.dart';
import 'package:cricyard/views/screens/practice_match/practiceView/score_board_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:cricyard/views/screens/practice_match/practiceRepository/PracticeMatchService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'PracticeMatchScoreScreen.dart';
import '../practiceViewmodel/PracticeMatchViewmodel.dart';

class PracticeHistoryView extends StatefulWidget {
  PracticeHistoryView({super.key});

  @override
  State<PracticeHistoryView> createState() => _PracticeHistoryViewState();
}

class _PracticeHistoryViewState extends State<PracticeHistoryView> {
  String getInitials(String text) {
    return text.isNotEmpty ? text.substring(0, 1).toUpperCase() : "C";
  }

  final PracticeMatchService scoreservice = PracticeMatchService();

  List<Map<String, dynamic>> allmatches = [];
  List<Map<String, dynamic>> footballMatches = [];
  List<Map<String, dynamic>> basketballMatches = [];
  Map<int, dynamic> matchStatus = {};

  bool isLoading = false;
  bool isMatchEnd = false;

  @override
  void initState() {
    super.initState();
    getAllmatches();
  }

  Future<void> getAllmatches() async {
    setState(() {
      isLoading = true;
    });
    try {
      final prefs = await SharedPreferences.getInstance();
      String? preferredSport = prefs.getString('preferred_sport');

      final fetchedEntities = await scoreservice.getAllmatches();
      print("All Matches resp --$fetchedEntities");

      // Filter matches based on preferredSport
      final filteredMatches = fetchedEntities.where((match) {
        return match['preferred_sport'] == preferredSport;
      }).toList();

      if (fetchedEntities != null && fetchedEntities.isNotEmpty) {
        final filteredFootballMatches = fetchedEntities.where((match) {
          return match['preferred_sport'] == preferredSport;
        }).toList();

        final filteredBasketballMatches = fetchedEntities.where((match) {
          return match['preferred_sport'] == preferredSport;
        }).toList();

        setState(() {
          allmatches = fetchedEntities;
          footballMatches = filteredFootballMatches;
          basketballMatches = filteredBasketballMatches;
        });
        for (var match in allmatches) {
          int id = match['id'];
          await getMatchStatus(id);
        }
        for (var match in footballMatches) {
          int id = match['id'];
          await getMatchStatus(id);
        }
        for (var match in basketballMatches) {
          int id = match['id'];
          await getMatchStatus(id);
        }
      }
    } catch (e) {
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
    setState(() {
      isLoading = false;
    });
  }

  Future<void> getMatchStatus(int id) async {
    try {
      final fetchedEntities = await scoreservice.getlastrecord(id);
      if (fetchedEntities != null && fetchedEntities.isNotEmpty) {
        setState(() {
          matchStatus[id] = fetchedEntities['match_end'];
        });
        print("Match-Status --$matchStatus");
      }
    } catch (e) {
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

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //       backgroundColor: Colors.grey[200],
  //       body: isLoading
  //           ? const Center(child: CircularProgressIndicator())
  //           : allmatches.isEmpty
  //               ? const Center(
  //                   child: Text(
  //                   "No data!!",
  //                   style: TextStyle(color: Colors.black, fontSize: 20),
  //                 ))
  //               : Padding(
  //                   padding: const EdgeInsets.all(8.0),
  //                   child: ListView.builder(
  //                     itemCount: allmatches.length,
  //                     itemBuilder: (context, index) {
  //                       final data = allmatches[index];
  //                       return _myContainer(data);
  //                     },
  //                   ),
  //                 ));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : allmatches.isEmpty
              ? const Center(
                  child: Text(
                  "No data!!",
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ))
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: allmatches.length,
                          itemBuilder: (context, index) {
                            final data = allmatches[index];
                            return Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                    MediaQuery.of(context).size.width * 0.9,
                                maxHeight:
                                    MediaQuery.of(context).size.height * 0.5,
                              ),
                              margin: const EdgeInsets.symmetric(vertical: 8.0),
                              child: _myContainer(data),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }

  Widget _myContainer(Map<String, dynamic> data
      // { required String time,required team1,required team2,required team1Runs,required team2Runs,required oversTeam1,required oversTeam2,required team1W,required team2W,required tossWinningTeam,required tossDecision}
      ) {
    var time = data['match_date'] ?? DateTime.now().toString();
    var team1 = data['hostTeam'] ?? '';
    var team2 = data['visitorTeam'] ?? '';
    var team1Runs = data[''] ?? '0';
    var team2Runs = data[''] ?? '0';
    var oversTeam1 = data['match_overs'] ?? '';
    var oversTeam2 = data[''] ?? '0';
    var team1W = data[''] ?? '';
    var team2W = data[''] ?? '';
    var tossWinningTeam = data['tossWinner'] ?? '';
    var tossDecision = data['opted_to'] ?? '';
    var matchId = data['id'];
    bool isOver = matchStatus[matchId] ?? false;

    return Consumer<PracticeMatchviewModel>(builder: (context, value, child) {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          // height: MediaQuery.of(context).size.height * 0.30,
          constraints: BoxConstraints(
            maxHeight: MediaQuery.of(context).size.height * 0.30, // Max height
          ),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  offset: const Offset(0, 5),
                  blurRadius: 10,
                  spreadRadius: 1,
                )
              ],
              borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  time,
                  // "${DateTime.now().toLocal()}",
                  style: GoogleFonts.getFont('Poppins',
                      color: Colors.black, fontSize: 12),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.blue,
                                child: Text(
                                  getInitials(team1),
                                  style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                team1,
                                style: GoogleFonts.getFont('Poppins',
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.orange,
                                child: Text(
                                  getInitials(team2),
                                  style: GoogleFonts.poppins(
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                team2,
                                style: GoogleFonts.getFont('Poppins',
                                    color: Colors.black, fontSize: 12),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "$team1Runs/$team1W",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "($oversTeam1)",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.black, fontSize: 12),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Text(
                              "$team2Runs/$team2W",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "($oversTeam2)",
                              style: GoogleFonts.getFont('Poppins',
                                  color: Colors.black, fontSize: 12),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                // Text(
                //   "$tossWinningTeam won toss and opted to $tossDecision first",
                //   style: GoogleFonts.getFont('Poppins',
                //       color: Colors.black, fontSize: 12),
                // ),
                // const SizedBox(
                //   height: 5,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          isOver
                              ? Container()
                              : TextButton(
                                  onPressed: () async {
                                    String matchType = data['matchType'] ??
                                        'Singles'; // ✅ Get matchType
                                    SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    String preferredSport =
                                        prefs.getString('preferred_sport') ??
                                            'Cricket';
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //       builder: (context) =>
                                    //           PracticeMatchScoreScreen(
                                    //               entity: data),
                                    //     ));
                                    if (preferredSport == 'Football') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              FootballScoreboardScreen(
                                                  entity: data),
                                        ),
                                      );
                                    } else if (preferredSport == 'Basketball') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              BasketballScoreboardScreen(
                                                  entity: data),
                                        ),
                                      );
                                    } else if (preferredSport == 'Hockey') {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              HockeyScoreboardScreen(
                                                  entity: data),
                                        ),
                                      );
                                    } else if (preferredSport == 'Tennis') {
                                      // ✅ Check if matchType is Singles or Doubles
                                      if (matchType == 'Singles') {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TennisScoreboardScreen(
                                              // player1: data['player1'] ??
                                              //     'Player 1', // ✅ Null safety
                                              // player2:
                                              //     data['player2'] ?? 'Player 2',
                                              entity: data,
                                            ),
                                          ),
                                        );
                                      } else {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) =>
                                        //         TennisDoublesScoreboardScreen(
                                        //       entity: data,
                                        //       ],
                                        //     ),
                                        //   ),
                                        // );
                                      }
                                    } else {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              PracticeMatchScoreScreen(
                                                  entity: data),
                                        ),
                                      );
                                    }
                                  },
                                  child: Text("Resume",
                                      style: GoogleFonts.getFont('Poppins',
                                          color: Colors.black, fontSize: 12)),
                                ),
                          const SizedBox(
                            width: 10,
                          ),
                          TextButton(
                            onPressed: () {
                              // pass the match id to scoreboard
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScoreBoardScreen(
                                      matchId: matchId,
                                      team1: team1,
                                      team2: team2,
                                    ),
                                  ));
                            },
                            child: Text("Scoreboard",
                                style: GoogleFonts.getFont('Poppins',
                                    color: Colors.black, fontSize: 12)),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                            onPressed: () {
                              _showDownloadDialog(context, matchId);
                            },
                            icon: const Icon(Icons.archive_outlined)),
                        const SizedBox(
                          width: 10,
                        ),
                        IconButton(
                            onPressed: () {
                              value.deleteEntity(data['id']);
                              deleteMatchHistory(data['id']);
                            },
                            icon: const Icon(Icons.delete)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Future<void> deleteMatchHistory(int id) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Deletion'),
          content:
              const Text('Are you sure you want to delete this match history?'),
          actions: [
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false); // Return false if canceled
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop(true); // Return true if confirmed
              },
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      try {
        await scoreservice.deleteEntity(id);
        setState(() {
          print("Id--$id Deleted");
          allmatches.removeWhere((match) => match['id'] == id);
        });

        if (allmatches.isEmpty) {
          getAllmatches();
        }
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(
                'Failed to delete match history: $e',
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
  }

  void _showDownloadDialog(BuildContext context, int matchId) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return Consumer<PracticeMatchviewModel>(
            builder: (context, value, child) {
          return AlertDialog(
            title: Text(
              'Archive History',
              style: GoogleFonts.getFont('Poppins', color: Colors.black),
            ),
            content: Text(
              'are you sure want to archive match history ',
              style: GoogleFonts.getFont('Poppins', color: Colors.black),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'Cancel',
                  style: GoogleFonts.getFont('Poppins', color: Colors.blue),
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Archive',
                  style: GoogleFonts.getFont('Poppins', color: Colors.blue),
                ),
                onPressed: () async {
                  value.archiveMatch(matchId);
                  // await scoreservice.archiveMatch(matchId);
                  Navigator.pop(ctx);
                },
              ),
            ],
          );
        });
      },
    );
  }
}
