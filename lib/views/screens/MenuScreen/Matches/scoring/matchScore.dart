// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/core/utils/size_utils.dart';
import 'package:cricyard/views/screens/MenuScreen/Matches/views/my_button.dart';
import 'package:cricyard/views/screens/MenuScreen/Matches/scoring/show_extras_penalty_partnership_frag.dart';
import 'package:cricyard/views/screens/MenuScreen/Matches/scoring/show_retire_and_more_frag.dart';
import 'package:cricyard/views/screens/MenuScreen/Matches/scoring/show_wide_details_frag.dart';
import 'package:cricyard/views/screens/MenuScreen/Matches/views/second_inning_players_entry_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/Matches/tour_graphs/tour_score_graph.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Entity/matches/Match/repository/Match_api_service.dart';
import '../../../../../Entity/matches/Match/views/Match_update_entity_screen.dart';
import '../../../../../Entity/matches/Start_Match/repository/Start_Match_api_service.dart';
import '../../../../../Entity/runs/Score_board/Score_board_api_service.dart';
import '../../../../../Entity/runs/Score_board/Score_board_create_entity_screen.dart';
import '../../../../../Entity/team/viewmodels/Teams_api_service.dart';
import '../../../../../core/utils/image_constant.dart';
import '../../../practice_match/view/matchwon_view.dart';
import '../../NewStreamFolder/TestStreaming/publishVideoAudioWidgetTest.dart';
import '../../tournament/score_board/tournament_scoreboard_screen.dart';

class MatchScoreScreen extends StatefulWidget {
  final Map<String, dynamic> entity;
  final bool status;

  const MatchScoreScreen(
      {super.key, required this.entity, required this.status});

  @override
  _MatchScoreScreenState createState() => _MatchScoreScreenState();
}

class _MatchScoreScreenState extends State<MatchScoreScreen> {
  final MatchApiService matchService = MatchApiService();
  final StartMatchApiService startmatchService = StartMatchApiService();
  final score_boardApiService scoreservice = score_boardApiService();
  final teamsApiService teamApi = teamsApiService();

  ShowWideDetailsFrag showWideDetailsFrag = ShowWideDetailsFrag();
  ShowRetireAndMoreFrag showRetireAndMoreFrag = ShowRetireAndMoreFrag();
  FocusNode _strikerFocusNode = FocusNode();
  FocusNode _nonStrikerFocusNode = FocusNode();
  FocusNode _bowlerFocusNode = FocusNode();
  ShowExtras_Partnership_PenaltyFrag show_penalty_extra_partnership_frag =
      ShowExtras_Partnership_PenaltyFrag();
  Map<String, dynamic> lastRecord = {};
  Map<String, dynamic> strikermap = {};
  Map<String, dynamic> nonstrikermap = {};
  Map<String, dynamic> ballermap = {};
  Map<String, dynamic> extraRunsMap = {};
  List<Map<String, dynamic>> partnershipList = [];
  List<dynamic> overBalls = [];

  List<Map<String, dynamic>> battingTeamPlayers = [];
  List<Map<String, dynamic>> bowlingTeamPlayers = [];

  var totalRun = 0;
  var wicket = 0;
  var overs = 0;
  var actualOver = 0;
  var currentBall = 0;
  var battingTeam = 'Batting Team';
  var ballingTeam = 'Balling Team';
  var striker = 'Striker';
  var nonStriker = 'Non Striker';
  var baller = 'Baller';

  int strikerId = 0;
  int nonStrikerId = 0;
  int ballerId = 0;
  var lastBallStatus = '';
  var strikertotalRun = 0;
  var tournamentId = 0;
  var matchId = 0;
  var crr = 0.0;
  var inning = 0;
  int targetScore = 0;
  int bowlingTeamId = 0;
  int battingTeamId = 0;
  String? msg = '';
  String? winningTeamName = '';

  bool isdata = false;
  bool islastrecord = false;

  bool hasError = false;

  bool isInningOver = false;
  bool isMatchOver = false;
  bool isOverEnd = false;

  bool _isLoading = false;

  bool hasError1 = false;
  bool hasError2 = false;

  bool showOverLay = false;
  bool isLoadingData = false;

  @override
  void initState() {
    getInintials();
    getTeamNames();
    super.initState();
    print('match is ${widget.entity}');
    print('match status  ${widget.status}');
  }

  void getInintials() {
    setState(() {
      isdata = widget.status;
    });
    matchId = widget.entity['id'];

    if (isdata) {
      tournamentId = widget.entity['tournament_id'];
      getLastRecord();
    }
  }

  void getTeamNames() {
    setState(() {
      battingTeam = widget.entity['team_1_name'];
      ballingTeam = widget.entity['team_2_name'];
    });
  }

  Future<void> getLastRecord() async {
    setState(() {
      isLoadingData = true;
    });

    try {
      await getUpdatedScore();
      await getLastRecOfPlayer();
      await fetchBattingPlayers();
      await fetchBowlingPlayers();
      await fetchPartnership();
      await fetchExtraRuns();
      await allBalls();
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
      setState(() {
        isLoadingData = false;
      });
    }
  }

  Future<void> fetchExtraRuns() async {
    final data = await scoreservice.getExtrasDetails(
      matchId,
    );
    setState(() {
      extraRunsMap = data;
    });
  }

  Future<void> fetchPartnership() async {
    final data = await scoreservice.getPartnershipDetails(matchId);
    setState(() {
      partnershipList = data;
    });
  }

  Widget showOverlay() {
    return Positioned.fill(
      child: Container(
        color: Colors.black.withOpacity(0.6),
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  Future<void> getUpdatedScore() async {
    print("Fetching getUpdatedScoer");
    try {
      final fetchedEntities =
          await scoreservice.getlastrecord(tournamentId, matchId);
      print("last record --$fetchedEntities");
      if (fetchedEntities != null && fetchedEntities.isNotEmpty) {
        setState(() {
          islastrecord = true;
          lastRecord = fetchedEntities;
          if (lastRecord['total_run'] != null) {
            totalRun = lastRecord['total_run'];
          }
          if (lastRecord['wicket'] != null) {
            wicket = lastRecord['wicket'];
          }
          if (lastRecord['current_over'] != null) {
            overs = lastRecord['current_over'];
          }
          if (lastRecord['actual_over'] != null) {
            actualOver = lastRecord['actual_over'];
          }
          if (lastRecord['ball'] != null) {
            currentBall = lastRecord['ball'];
          }
          if (lastRecord['over_end'] != null) {
            isOverEnd = lastRecord['over_end'];
          }

          if (lastRecord['batting_team'] != null) {
            battingTeam = lastRecord['batting_team'];
          }
          if (lastRecord['striker_player_name'] != null) {
            striker = lastRecord['striker_player_name'];
          }
          if (lastRecord['non_striker_player_name'] != null) {
            nonStriker = lastRecord['non_striker_player_name'];
          }
          if (lastRecord['baller_player_name'] != null) {
            baller = lastRecord['baller_player_name'];
          }

          if (lastRecord['striker'] != null) {
            strikerId = lastRecord['striker'];
          }
          if (lastRecord['non_striker'] != null) {
            nonStrikerId = lastRecord['non_striker'];
          }
          if (lastRecord['baller'] != null) {
            ballerId = lastRecord['baller'];
          }
          if (lastRecord['last_ball_status'] != null) {
            lastBallStatus = lastRecord['last_ball_status'];
          }

          if (lastRecord['striker_total_run'] != null) {
            strikertotalRun = lastRecord['striker_total_run'];
          }
          if (lastRecord['inning'] != null) {
            inning = lastRecord['inning'];
          }
          if (lastRecord['targeted_score'] != null) {
            targetScore = lastRecord['targeted_score'];
          }
          if (lastRecord['bowling_team_id'] != null) {
            bowlingTeamId = lastRecord['bowling_team_id'];
          }
          if (lastRecord['batting_team_id'] != null) {
            battingTeamId = lastRecord['batting_team_id'];
          }

          // if (lastRecord['tossWinner'] != null) {
          //   tossWinner = lastRecord['tossWinner'];
          // }

          // if (lastRecord['opted_to'] != null) {
          //   opted_to = lastRecord['opted_to'];
          // }

          if (lastRecord['over_end'] != null) {
            isOverEnd = lastRecord['over_end'];
          }
          if (lastRecord['inning_end'] != null) {
            isInningOver = lastRecord['inning_end'];
          }
          if (lastRecord['match_end'] != null) {
            isMatchOver = lastRecord['match_end'];
          }

          if (lastRecord['bowling_team'] != null) {
            ballingTeam = lastRecord['bowling_team'];
          }
        });
      }
    } catch (e) {
      setState(() {
        isLoadingData = false;
      });
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

  // get last record of player career
  Future<void> getLastRecOfPlayer() async {
    print("Fetching getLastRecOfPlayer");

    try {
      var strikerrespone = await scoreservice.getlastrecordPlayerCareer(
          matchId, inning, strikerId);

      setState(() {
        strikermap = strikerrespone;
      });
      var nonstrikerrespone = await scoreservice.getlastrecordPlayerCareer(
          matchId, inning, nonStrikerId);
      setState(() {
        nonstrikermap = nonstrikerrespone;
      });
      var ballerrespone = await scoreservice.getlastrecordPlayerCareer(
          matchId, inning, ballerId);
      setState(() {
        ballermap = ballerrespone;
      });
    } catch (e) {
      setState(() {
        isLoadingData = false;
      });
    }
  }

// over all ball actions
  Future<void> allBalls() async {
    print("Fetching allBalls ");
    print('match id is $matchId');
    var ballrespone = await scoreservice.allballofOvers(tournamentId, matchId);

    setState(() {
      overBalls = ballrespone;
      print('All BAll $overBalls ');
    });
  }

  Future<void> fetchBattingPlayers() async {
    print("Fetching batting players");

    final data = await teamApi.getAllMembers(battingTeamId);
    setState(() {
      battingTeamPlayers = data.map<Map<String, dynamic>>((player) {
        return {
          'player_name': player['player_name'] as String,
          'id': player['user_id'] as int
        };
      }).toList();
    });
    print("BattingTeam--$battingTeamPlayers");
  }

  Future<void> fetchBowlingPlayers() async {
    print("Fetching bowling players");
    final data = await teamApi.getAllMembers(bowlingTeamId);
    setState(() {
      bowlingTeamPlayers = data.map<Map<String, dynamic>>((player) {
        return {
          'player_name': player['player_name'] as String,
          'id': player['user_id'] as int
        };
      }).toList();
    });
    print("Bowling--$bowlingTeamPlayers");
  }

  void calculateWin() {
    if (targetScore > totalRun) {
      // win by runs margin
      var winRunsMargin = targetScore - totalRun;
      setState(() {
        winningTeamName = ballingTeam;
        msg = '$ballingTeam won by $winRunsMargin runs';
      });
      print("Team1Win");
    } else if (targetScore == totalRun) {
      setState(() {
        winningTeamName = '';
        msg = 'Match tie between $battingTeam and $ballingTeam';
      });
    } else {
      // win by wickets margin
      int totalWicketInHand = 11;
      var winByWicketMargin = totalWicketInHand - wicket;
      setState(() {
        winningTeamName = ballingTeam;
        msg = '$ballingTeam won by $winByWicketMargin wickets';
      });
      print("Team2Wing");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PublishVideoAudioWidgetTest(
                          matchId: matchId,
                        ),
                      ));
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  height: 30,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(8)),
                  child: Center(
                      child: Text(
                    "Start Streaming",
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white, fontSize: 10),
                  )),
                ),
              ),
            )
          ],
          title: Text(
            "$battingTeam v/s $ballingTeam",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: const Color(0xFF219ebc),
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        backgroundColor: Colors.grey[200],
        body: isdata
            ? isLoadingData
                ? Stack(
                    children: [
                      _newWidget(context),
                      showOverlay(),
                    ],
                  )
                : Stack(
                    children: [
                      _newWidget(context),
                      if (isMatchOver) _buildInningOverDialog(context),
                      if (isInningOver) _buildInningOverDialog(context),
                      if (isOverEnd) _buildNewBowlerEntry(),
                      if (showOverLay) showOverlay(),
                      if (!islastrecord)
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: () {
                              // _showStartScoringDialog(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        ScoreBoardCreateEntityScreen(
                                          matchId: matchId,
                                          tourId: tournamentId,
                                          overs: actualOver,
                                        )),
                              )
                                  .then((value) => Navigator.of(context))
                                  .then((value) => getLastRecord());
                            },
                            child: Container(
                              color: Colors.black.withOpacity(0.6),
                              child: Center(
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: Colors.blueAccent,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Text(
                                    'Start Scoring',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  )
            : Stack(
                children: [
                  _buildRestructure(context),
                  if (showOverLay) showOverlay(),
                ],
              ));
  }

  Widget _buildRestructure(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              MyElevatedButton(
                height: 67.v,
                width: MediaQuery.of(context).size.width * 0.45,
                text: "Reschedule",
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            matchUpdateEntityScreen(entity: widget.entity)),
                  );
                },
              ),
              const SizedBox(width: 2),
              MyElevatedButton(
                height: 67.v,
                width: MediaQuery.of(context).size.width * 0.45,
                text: "Cancel",
                onPressed: () async {
                  await matchService.cancel(widget.entity['id']);
                },
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        // Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: MyElevatedButton(
        //     height: 67.v,
        //     width: MediaQuery.of(context).size.width,
        //     text: "Start Match",
        //     onPressed: () async {
        //       final Map<String, dynamic> formData = {};
        //       formData['match_id'] = widget.entity['id'];
        //
        //       startmatchService.createEntity(formData);
        //       setState(() {
        //         isdata = true;
        //       });
        //     },
        //   ),
        // ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: MyElevatedButton(
            height: 67.0, // Changed '67.v' to '67.0' for consistency
            width: MediaQuery.of(context).size.width,
            text: "Start Match",
            onPressed: () async {
              setState(() {
                showOverLay = true;
              });
              final Map<String, dynamic> formData = {};
              formData['match_id'] = widget.entity['id'];

              try {
                final response = await startmatchService.createEntity(formData);
                if (response != null) {
                  setState(() {
                    isdata = true;
                    showOverLay = false;
                  });
                }
              } catch (e) {
                setState(() {
                  showOverLay = false;
                });
                // Handle error here, e.g., show a snackbar or dialog
                print("Error starting match: $e");
              } finally {
                setState(() {
                  showOverLay = false;
                });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _buildInningOverDialog(BuildContext context) {
    calculateWin();
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: GestureDetector(
        onTap: () {
          // Optionally handle tap outside to dismiss the dialog
        },
        child: Container(
          color: Colors.black45, // Dim the background
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isMatchOver
                        ? 'End of Second Innings'
                        : 'End of the first inning',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                      isMatchOver
                          ? '$msg'
                          : '${lastRecord['bowling_team']} need ${lastRecord['total_run']} runs in ${lastRecord['match_overs']} overs',
                      style:
                          GoogleFonts.getFont('Poppins', color: Colors.black)),
                  const SizedBox(height: 10),
                  Text(
                      isMatchOver
                          ? ''
                          : 'Required Run Rate: ${lastRecord['current_runrate']} ',
                      style:
                          GoogleFonts.getFont('Poppins', color: Colors.black)),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () async {
                          await scoreservice.undo(tournamentId, matchId).then(
                                (value) => getLastRecord(),
                              );
                        },
                        child: const Text('Undo'),
                      ),
                      TextButton(
                        onPressed: () {
                          if (isMatchOver) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MatchWonView(
                                  winningTeam: '$winningTeamName',
                                  msg: '$msg',
                                ),
                              ),
                            );
                          } else {
                            setState(() {
                              isInningOver = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SecondInningPlayerEntryScreen2(
                                  lastRecord: lastRecord,
                                  match: widget.entity,
                                  bowlingTeamId: battingTeamId,
                                  battingTeamId: bowlingTeamId,
                                  status: widget.status,
                                ),
                              ),
                            );
                          }
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNewBowlerEntry() {
    TextEditingController dialogController = TextEditingController();
    int? selectedPlayerId;
    return Container(
      color: Colors.black45, // Dim the background
      child: Center(
        child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            title: const Text('Enter new bowler'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Autocomplete<String>(
                  optionsBuilder: (TextEditingValue textEditingValue) {
                    final inputText = textEditingValue.text;
                    if (inputText.isEmpty) {
                      return bowlingTeamPlayers
                          .map((player) => player['player_name'] as String)
                          .toList();
                    }
                    return bowlingTeamPlayers
                        .map((player) => player['player_name'] as String)
                        .where((playerName) => playerName
                            .toLowerCase()
                            .contains(inputText.toLowerCase()));
                  },
                  onSelected: (String selection) {
                    dialogController.text = selection;
                    selectedPlayerId = bowlingTeamPlayers.firstWhere((player) =>
                        player['player_name'] == selection)['id'] as int?;
                    setState(() {
                      hasError = false; // Reset error state on valid selection
                    });
                  },
                  fieldViewBuilder: (context, textEditingController, focusNode,
                      onFieldSubmitted) {
                    textEditingController.addListener(() {
                      setState(() {});
                    });
                    return TextField(
                      controller: textEditingController,
                      focusNode: focusNode,
                      decoration: InputDecoration(
                        labelText: 'Select Bowler',
                        errorText:
                            hasError ? 'Please select a valid option.' : null,
                        border: const OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          hasError = false; // Reset error state on input change
                        });
                      },
                    );
                  },
                  optionsViewBuilder: (context, onSelected, options) {
                    return Align(
                      alignment: Alignment.topLeft,
                      child: Material(
                        elevation: 4.0,
                        child: Container(
                          height: 160,
                          color: Colors.white,
                          width: 300.0,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(0.0),
                            itemCount: options.length,
                            itemBuilder: (context, index) {
                              final String option = options.elementAt(index);
                              return ListTile(
                                title: Text(
                                  option,
                                  style: TextStyle(color: Colors.black),
                                ),
                                onTap: () {
                                  onSelected(option);
                                  dialogController.text = option;
                                  selectedPlayerId =
                                      bowlingTeamPlayers.firstWhere((player) =>
                                          player['player_name'] ==
                                          option)['id'] as int?;
                                  setState(() {
                                    hasError =
                                        false; // Reset error state on selection
                                  });
                                },
                              );
                            },
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
            actions: [
              TextButton(
                child: const Text('Undo'),
                onPressed: () {
                  try {
                    scoreservice.undo(tournamentId, matchId).then(
                      (value) {
                        getLastRecord().then(
                          (_) {
                            showSnackBar(context, 'Success ', Colors.green);
                          },
                        );
                        Navigator.pop(context, "Undo");
                      },
                    );
                  } catch (e) {
                    showSnackBar(context, 'Error $e ', Colors.red);
                  }
                },
              ),
              TextButton(
                onPressed: () async {
                  if (dialogController.text.isEmpty) {
                    setState(() {
                      hasError = true;
                    });
                    return;
                  }
                  if (selectedPlayerId != null) {
                    try {
                      await scoreservice
                          .newPlayerEntry(tournamentId, 'Baller',
                              selectedPlayerId!, '', lastRecord)
                          .then((value) {
                        getLastRecord().then(
                          (value) {
                            showSnackBar(context, 'Success ', Colors.green);
                          },
                        );
                      });
                      setState(() {
                        isOverEnd = false;
                        // Navigator.pop(context, "Confirm");
                      });
                    } catch (e) {
                      showSnackBar(context, 'Error $e', Colors.red);
                    }
                  } else {
                    setState(() {
                      hasError =
                          true; // Indicate an error if no player is selected
                    });
                  }
                },
                child: const Text(
                  'Confirm',
                  style: TextStyle(color: Colors.blueAccent),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _newWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.27,
              width: double.infinity,
              child: Stack(
                children: [
                  // bg img
                  SizedBox(
                    width: double.infinity,
                    child: Image.asset(
                      "assets/images/istockphoto_177427917170667_a_1.png",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.27,
                    width: double.infinity,
                    decoration:
                        BoxDecoration(color: Colors.black.withOpacity(0.6)),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "$totalRun/$wicket",
                                    style: GoogleFonts.getFont('Poppins',
                                        color: Colors.white, fontSize: 22),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "($overs.$currentBall)",
                                    style: GoogleFonts.getFont('Poppins',
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Crr:- ${lastRecord['current_runrate']}",
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                TournamentScoreBoardScreen(
                                              matchId: matchId,
                                              team1: battingTeam,
                                              team2: ballingTeam,
                                            ),
                                          ));
                                    },
                                    child: SizedBox(
                                        height: 30,
                                        child: Image.asset(
                                          ImageConstant.imgScoreboard,
                                          color: Colors.white,
                                        )),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  TournamentScoreGraph(
                                                matchId: matchId,
                                              ),
                                            ));
                                      },
                                      icon: const Icon(
                                        Icons.show_chart,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          _buildScoreBoard(),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              children: [
                _buildPlayerInfo(),
                const SizedBox(
                  height: 20,
                ),
                _buildScoreControls(context),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildScoreBoard() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Table(
          columnWidths: const {
            0: FlexColumnWidth(3),
            1: FlexColumnWidth(1),
            2: FlexColumnWidth(1),
            3: FlexColumnWidth(1),
            4: FlexColumnWidth(1),
            5: FlexColumnWidth(1),
          },
          children: [
            TableRow(
              children: [
                Text('Batsman',
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18)),
                Text('R',
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18)),
                Text('B',
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18)),
                Text('4s',
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18)),
                Text('6s',
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18)),
                Text('SR',
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18)),
              ],
            ),
            const TableRow(children: [
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8)
            ]),
            // striker row
            TableRow(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text('$striker *',
                        style: GoogleFonts.getFont('Poppins',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                Text('${strikermap['current_match_run']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
                Text('${strikermap['current_match_ball']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
                Text('${strikermap['current_match_four']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
                Text('${strikermap['current_match_six']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
                Text('${strikermap['current_match_strike_rate']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
              ],
            ),
            const TableRow(children: [
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8)
            ]),
            TableRow(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(nonStriker,
                        style: GoogleFonts.getFont('Poppins',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                Text('${nonstrikermap['current_match_run']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
                Text('${nonstrikermap['current_match_ball']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
                Text('${nonstrikermap['current_match_four']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
                Text('${nonstrikermap['current_match_six']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
                Text('${nonstrikermap['current_match_strike_rate']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
              ],
            ),
            const TableRow(children: [
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8)
            ]),
            TableRow(
              children: [
                Text('Bowler',
                    style: GoogleFonts.getFont(
                      'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    )),
                Text('O',
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18)),
                Text('M',
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18)),
                Text('R',
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18)),
                Text('W',
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18)),
                Text('ER',
                    style: GoogleFonts.getFont('Poppins',
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 18)),
              ],
            ),
            const TableRow(children: [
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8),
              SizedBox(height: 8)
            ]),
            TableRow(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(baller,
                        style: GoogleFonts.getFont('Poppins',
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w400)),
                  ),
                ),
                Text('${ballermap['current_match_over']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
                Text('${ballermap['current_match_maidan_over']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
                Text('${ballermap['current_match_run']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
                Text('${ballermap['current_match_wicket']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
                Text('${ballermap['current_match_economy_rate']}',
                    style: GoogleFonts.getFont('Poppins',
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w300)),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPlayerInfo() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.12,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 2),
            blurRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildPlayerName(),
            SizedBox(
              height: 10.v,
            ),
            _buildScoreEntryRow(overBalls),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerName() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Image.asset(
            'assets/images/cricket_ball_14.png',
            width: 18,
            height: 18,
          ),
          const SizedBox(width: 10),
          Text(
            baller,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: const Color(0xFF000000),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreEntryRow(List<dynamic> scores) {
    return Row(
      children: scores.map((score) {
        return _buildScoreItem(score);
      }).toList(),
    );
  }

  Widget _buildScoreItem(String score) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        width: 34,
        height: 34,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF264653),
          boxShadow: [
            BoxShadow(
              color: Color(0x40000000),
              offset: Offset(2, 2),
              blurRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: Text(
            score,
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 12,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildScoreControls(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white, // Light background color for contrast
        boxShadow: const [
          BoxShadow(
            color: Color(0x20000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            _buildScoreControlRow(context, [
              _newButton(context, '0', 0, 'running', const Color(0xFF3A3A3A)),
              _newButton(context, '1', 1, 'running', const Color(0xFF3A3A3A)),
              _newButton(context, '2', 2, 'running', const Color(0xFF3A3A3A)),
              _newButton(context, 'Undo', 0, 'undo', const Color(0xFF219ebc)),
              _newButton(
                  context, 'Retire', 0, 'retire', const Color(0xFF264653)),
            ]),
            const SizedBox(height: 14),
            _buildScoreControlRow(context, [
              _newButton(context, '3', 3, 'running', const Color(0xFF3A3A3A)),
              _newButton(context, '4', 4, 'four', const Color(0xFF3A3A3A)),
              _newButton(context, '5', 5, 'running', const Color(0xFF3A3A3A)),
              _newButton(context, '6', 6, 'six', const Color(0xFF3A3A3A)),
              _newButton(context, 'Out', 0, 'wicket', const Color(0xFFef233c)),
            ]),
            const SizedBox(height: 14),
            _buildScoreControlRow(context, [
              _newButton(context, 'WD', 1, 'wide', const Color(0xFF3A3A3A)),
              _newButton(context, 'NB', 1, 'NoBall', const Color(0xFF3A3A3A)),
              _newButton(context, 'LB', 1, 'LegBy', const Color(0xFF3A3A3A)),
              _newButton(context, 'BYE', 1, 'By', const Color(0xFF3A3A3A)),
              _newButton(
                  context, 'Extras', 0, 'extras', const Color(0xFF264653)),
            ]),
            const SizedBox(height: 14),
            _buildScoreControlRow(context, [
              _newButton(context, 'Partnership', 0, 'partnership',
                  const Color(0xFF264653)),
              _newButton(
                  context, 'Penalty', 0, 'penalty', const Color(0xFF264653)),
              _newButton(context, 'More', 0, 'more', const Color(0xFF264653)),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildScoreControlRow(BuildContext context, List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: children.map((child) => Expanded(child: child)).toList(),
    );
  }

  Widget _newButton(
      BuildContext ctx, String text, int data, String type, Color color) {
    Map<String, dynamic> scoreboard = lastRecord;
    scoreboard['match_id'] = matchId;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: TextButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(color),
              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)))),
          onPressed: () {
            if (type == 'running') {
              updateData(data, type, scoreboard);
            }
            if (type == 'four' || type == 'six') {
              updateData(data, type, scoreboard);
            }

            if (type == 'undo') {
              _showDialog(context, type, 'undo');
            }
            if (type == 'wicket') {
              _showWicketDialog(ctx, 'wicket');
            }
            if (type == 'extras') {
              show_penalty_extra_partnership_frag.showExtrasAndPenaltyDialog(
                  ctx,
                  'extras',
                  extraRunsMap,
                  partnershipList,
                  matchId,
                  inning,
                  tournamentId,
                  striker,
                  nonStriker,
                  baller,
                  context);
              // _showExtrasAndPenaltyDialog(ctx, );
            }
            if (type == 'partnership') {
              show_penalty_extra_partnership_frag.showExtrasAndPenaltyDialog(
                  ctx,
                  'partnership',
                  extraRunsMap,
                  partnershipList,
                  matchId,
                  inning,
                  tournamentId,
                  striker,
                  nonStriker,
                  baller,
                  context);
              // _showExtrasAndPenaltyDialog(ctx, 'partnership');
            }
            if (type == 'penalty') {
              show_penalty_extra_partnership_frag
                  .showExtrasAndPenaltyDialog(
                      ctx,
                      'penalty',
                      extraRunsMap,
                      partnershipList,
                      matchId,
                      inning,
                      tournamentId,
                      striker,
                      nonStriker,
                      baller,
                      context)
                  .then(
                (_) {
                  getLastRecord().then(
                    (_) {
                      showSnackBar(context, 'Success ', Colors.green);
                    },
                  );
                },
              );
              //_showExtrasAndPenaltyDialog(ctx, );
            }

            if (type == 'retire') {
              showRetireAndMoreDialog(ctx, 'retire');
            }
            if (type == 'more') {
              showRetireAndMoreDialog(
                ctx,
                'more',
              );
            }
            if (type == 'wide' ||
                type == 'NoBall' ||
                type == 'LegBy' ||
                type == 'By') {
              showWideDetailsFrag
                  .showWideDialog(ctx, type, matchId, inning, lastRecord,
                      tournamentId, striker, nonStriker, baller)
                  .then(
                (value) {
                  print("showWide details. then called");
                  getLastRecord();
                },
              );
              //_showWideDialog(ctx, type);
            }
          },
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                text,
                style: GoogleFonts.getFont('Poppins',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ))),
    );
  }

  Future<void> updateData(int scdata, type, scoreboard) async {
    setState(() {
      showOverLay = true;
    });
    try {
      await scoreservice
          .updateScore(tournamentId, scdata, type, scoreboard)
          .then((_) {
        getLastRecord().then(
          (value) {
            setState(() {
              showOverLay = false;
            });
            showSnackBar(context, 'Success', Colors.green);
          },
        );
      });
    } catch (e) {
      setState(() {
        showOverLay = false;
      });
      showSnackBar(context, 'Error updating $e', Colors.red);
    } finally {
      setState(() {
        showOverLay = false;
      });
    }
  }

  // Strike Rotation
  Future<void> strikeRotation(int tourId) async {
    print("Rotate Strike, called");
    await scoreservice.strikerotation(tourId, lastRecord).then(
      (value) async {
        getLastRecord().then(
          (value) {
            showSnackBar(context, 'Success', Colors.green);
          },
        );
      },
    );
  }

  Future<void> showRetireAndMoreDialog(BuildContext ctx, String type) async {
    var option = '';
    String? selectedOption = await showDialog<String>(
      context: ctx,
      builder: (BuildContext context) {
        String? tempSelectedOption;
        bool showNewPlayerOptions = false;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                  type == 'more' ? 'Select option' : 'Select Retire Option'),
              content: IntrinsicHeight(
                child: Column(
                  children: type == 'more' && !showNewPlayerOptions
                      ? [
                          // Rotate strike button
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 35.0,
                              width: 170,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF264653),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  strikeRotation(tournamentId);
                                  Navigator.pop(context);
                                },
                                child: Center(
                                  child: Text(
                                    'Rotate Strike',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          // New player entry button
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: SizedBox(
                              height: 35.0,
                              width: 170,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF264653),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    showNewPlayerOptions = true;
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    'New player entry',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]
                      : [
                          // Radio list tiles for selecting the retiring player
                          RadioListTile<String>(
                            title: Text(
                              striker,
                              style: const TextStyle(color: Colors.black),
                            ),
                            value: striker,
                            groupValue: tempSelectedOption,
                            onChanged: (value) {
                              setState(() {
                                tempSelectedOption = value;
                                option = 'striker';
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: Text(
                              nonStriker,
                              style: const TextStyle(color: Colors.black),
                            ),
                            value: nonStriker,
                            groupValue: tempSelectedOption,
                            onChanged: (value) {
                              setState(() {
                                tempSelectedOption = value;
                                option = 'nonStriker';
                              });
                            },
                          ),
                          type == 'more'
                              ? RadioListTile<String>(
                                  title: Text(
                                    baller,
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  value: baller,
                                  groupValue: tempSelectedOption,
                                  onChanged: (value) {
                                    setState(() {
                                      tempSelectedOption = value;
                                      option = 'baller';
                                    });
                                  },
                                )
                              : Container()
                        ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop(tempSelectedOption);
                  },
                ),
              ],
            );
          },
        );
      },
    );

    if (selectedOption != null) {
      showNewBatsmanDialog(ctx, option);
    }
  }

  Future<void> showNewBatsmanDialog(
    BuildContext context,
    String tempSelectedOption,
  ) async {
    TextEditingController dialogController = TextEditingController();
    ValueNotifier<String?> selectedPlayerId = ValueNotifier<String?>(null);
    ValueNotifier<bool> hasError = ValueNotifier<bool>(false);

    await showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
          builder: (BuildContext ctx, StateSetter setState) {
            return AlertDialog(
              title: Text('Enter new player for $tempSelectedOption'),
              content: tempSelectedOption == 'baller'
                  ? _buildAutocompleteTextField(
                      dialogController,
                      'Select new bowler',
                      _bowlerFocusNode,
                      bowlingTeamPlayers
                          .where((element) => element['name'] != null)
                          .toList(),
                      selectedPlayerId,
                      hasError)
                  : tempSelectedOption == 'striker'
                      ? _buildAutocompleteTextField(
                          dialogController,
                          'Select Striker',
                          _strikerFocusNode,
                          battingTeamPlayers,
                          selectedPlayerId,
                          hasError)
                      : _buildAutocompleteTextField(
                          dialogController,
                          'Select non-striker',
                          _nonStrikerFocusNode,
                          battingTeamPlayers,
                          selectedPlayerId,
                          hasError),
              actions: [
                TextButton(
                  child: const Text('Cancel'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                TextButton(
                  onPressed: () async {
                    if (selectedPlayerId.value == null) {
                      setState(() {
                        hasError.value = true;
                      });
                      return;
                    }
                    Navigator.pop(context);
                    String playerId = selectedPlayerId.value!;
                    String type = '';
                    if (tempSelectedOption == 'baller') {
                      type = 'Baller';
                    } else if (tempSelectedOption == 'striker') {
                      type = 'batsman';
                    } else {
                      type = 'batsman';
                    }

                    print("NewPlayerEntry");
                    print("Type--$type");
                    print("PlayerID--$playerId");
                    print("tempOption--$tempSelectedOption");

                    await scoreservice
                        .newPlayerEntry(tournamentId, type, int.parse(playerId),
                            tempSelectedOption, lastRecord)
                        .then(
                      (value) {
                        getLastRecord().then(
                          (value) =>
                              showSnackBar(context, 'Success', Colors.green),
                        );
                      },
                    );
                  },
                  child: const Text('Confirm'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildAutocompleteTextField(
      TextEditingController controller,
      String label,
      FocusNode focusNode,
      List<Map<String, dynamic>> data,
      ValueNotifier<String?> selectedPlayerId,
      ValueNotifier<bool> hasError) {
    return ValueListenableBuilder<bool>(
      valueListenable: hasError,
      builder: (context, error, child) {
        String? errorMessage = error ? 'Please select a valid option.' : null;
        return Autocomplete<String>(
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text.isEmpty) {
              return data.map((player) => player['player_name'] as String);
            }
            return data
                .where((player) => player['player_name']
                    .toLowerCase()
                    .contains(textEditingValue.text.toLowerCase()))
                .map((player) => player['player_name'] as String);
          },
          onSelected: (String selection) {
            controller.text = selection;
            final player =
                data.firstWhere((player) => player['player_name'] == selection);
            print(
                "Selected player: ${player['player_name']}, ID: ${player['id']}"); // Debug line
            selectedPlayerId.value =
                player['id'].toString(); // Ensure this is a string
            hasError.value = false;
          },
          fieldViewBuilder: (BuildContext context,
              TextEditingController textEditingController,
              FocusNode fieldFocusNode,
              VoidCallback onFieldSubmitted) {
            textEditingController.text = controller.text;
            textEditingController.addListener(() {
              controller.text = textEditingController.text;
            });
            return TextField(
              controller: textEditingController,
              focusNode: fieldFocusNode,
              decoration: InputDecoration(
                labelText: label,
                errorText: errorMessage,
                errorStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: error ? Colors.red : Colors.blue,
                    width: 2,
                  ),
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blue, width: 2),
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              ),
              style: const TextStyle(color: Colors.black),
            );
          },
          optionsViewBuilder: (BuildContext context,
              AutocompleteOnSelected<String> onSelected,
              Iterable<String> options) {
            return Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                child: Container(
                  height: 160,
                  color: Colors.white,
                  width: 300.0,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(0.0),
                    itemCount: options.length,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return ListTile(
                        title: Text(
                          option,
                          style: const TextStyle(color: Colors.black),
                        ),
                        onTap: () {
                          onSelected(option);
                          final player = data.firstWhere(
                              (player) => player['player_name'] == option);
                          print(
                              "Tapped player: ${player['player_name']}, ID: ${player['id']}"); // Debug line
                          selectedPlayerId.value = player['id']
                              .toString(); // Ensure this is a string
                          hasError.value = false;
                        },
                      );
                    },
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showDialog(BuildContext context, String type, String title) async {
    setState(() {
      showOverLay = true;
    });
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                title,
                style: const TextStyle(color: Colors.black),
              ),
              content: Text(
                "Are you sure want to undo",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.black, fontSize: 12),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () async {
                          setState(() {
                            _isLoading = true;
                          });
                          scoreservice.undo(tournamentId, matchId).then(
                            (_) {
                              getLastRecord().then(
                                (value) {
                                  setState(() {
                                    _isLoading = false;
                                    showOverLay = false;
                                  });
                                  showSnackBar(
                                      context, 'Success', Colors.green);
                                },
                              );

                              Navigator.of(context).pop();
                            },
                          );
                        },
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      color: _isLoading ? Colors.grey : Colors.blue,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showWicketDialog(BuildContext ctx, type) async {
    // Show dialog with options
    String? selectedOption = await showDialog<String>(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: const Text('Select Out Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionButton(context, 'LBW', 'lbw'),
              _buildOptionButton(context, 'Bowled', 'bowled'),
              _buildOptionButton(context, 'Hit Wicket', 'hit_wicket'),
              _buildOptionButton(context, 'Stumping', 'stumping'),
              _buildOptionButton(context, 'Run Out Striker', 'run_out_striker'),
              _buildOptionButton(
                  context, 'Run Out Non-Striker', 'run_out_non_striker'),
              _buildOptionButton(context, 'Catch Out', 'catch_out'),

              // Add more option buttons as needed
            ],
          ),
        );
      },
    );

    if (selectedOption != null) {
      _showWicketDetailsDialog(context, selectedOption, type);
    }
  }

  void _showWicketDetailsDialog(
      BuildContext context, String selectedOption, String type) {
    // Depending on the selected out option, show different details dialog
    switch (selectedOption) {
      case 'lbw':
        // Show dialog for LBW details
        _showWicketOptionsDetailsDialog(
            context, selectedOption, 'LBW Details', 0,
            showPlayerHelp: false);
        break;
      case 'bowled':
        // Show dialog for bowled details
        _showWicketOptionsDetailsDialog(
            context, selectedOption, 'Bowled Details', 0,
            showPlayerHelp: false);
        break;
      case 'hit_wicket':
        // Show dialog for hit wicket details
        _showWicketOptionsDetailsDialog(
            context, selectedOption, 'Hit Wicket Details', 0,
            showPlayerHelp: true);
        break;
      case 'stumping':
        // Show dialog for stumping details
        _showWicketOptionsDetailsDialog(
            context, selectedOption, 'Stumping Details', 0,
            showPlayerHelp: true);
        break;
      case 'run_out_striker':
        // Show dialog for run out striker details
        showRunOutOptions(context, selectedOption, 'Run Out Striker Details');
        // _showWicketOptionsDetailsDialog(
        //     context, selectedOption, 'Run Out Striker Details',
        //     showPlayerHelp: true);
        break;
      case 'run_out_non_striker':
        // Show dialog for run out non-striker details
        showRunOutOptions(
            context, selectedOption, 'Run Out Non-Striker Details');
        // _showWicketOptionsDetailsDialog(
        //     context, selectedOption, 'Run Out Non-Striker Details',
        //     showPlayerHelp: true);
        break;
      case 'catch_out':
        // Show dialog for catch out details
        _showWicketOptionsDetailsDialog(
            context, selectedOption, 'Catch Out Details', 0,
            showPlayerHelp: true);
        break;
      default:
        break;
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

  Widget _buildOptionButton(BuildContext context, String text, String option) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: SizedBox(
        height: 35.0,
        width: 170, // Set a fixed height for the buttons
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF264653),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
          onPressed: () => Navigator.of(context).pop(option),
          child: Center(
            child: Text(
              text,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> showRunOutOptions(
      BuildContext ctx, String runOutOption, String title) async {
    int extraRuns = 0;

    String option = await showDialog(
      context: ctx,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Select runs'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          setState(() {
                            if (extraRuns > 0) extraRuns--;
                          });
                        },
                      ),
                      Text(
                        '$extraRuns',
                        style:
                            const TextStyle(fontSize: 20, color: Colors.black),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          setState(() {
                            extraRuns++;
                          });
                        },
                      ),
                    ],
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(extraRuns.toString());
                    },
                    child: const Text(
                      'OK',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (option != null && option.isNotEmpty) {
      _showWicketOptionsDetailsDialog(
          ctx, runOutOption, "$title with extra $extraRuns runs", extraRuns,
          showPlayerHelp: true);
    }
  }

  void _showWicketOptionsDetailsDialog(
      BuildContext context, String type, String title, int runs,
      {bool showPlayerHelp = false}) async {
    ValueNotifier<String> selectedBatsmanName = ValueNotifier<String>('');
    ValueNotifier<int?> selectedBatsmanId = ValueNotifier<int?>(null);
    ValueNotifier<String> selectedHelpedPlayerName = ValueNotifier<String>('');
    ValueNotifier<int?> selectedHelpedPlayerId = ValueNotifier<int?>(null);
    bool hasError1 = false;
    bool hasError2 = false;
    bool _isLoading = false;
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: Text(
                title,
                style: const TextStyle(color: Colors.black),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (showPlayerHelp) ...[
                    Autocomplete<String>(
                      optionsBuilder: (TextEditingValue textEditingValue) {
                        final inputText = textEditingValue.text;
                        if (inputText.isEmpty) {
                          return bowlingTeamPlayers
                              .map((player) => player['player_name'] as String)
                              .toList();
                        }
                        return bowlingTeamPlayers
                            .map((player) => player['player_name'] as String)
                            .where((playerName) => playerName
                                .toLowerCase()
                                .contains(inputText.toLowerCase()));
                      },
                      onSelected: (String selection) {
                        final selectedPlayer = bowlingTeamPlayers.firstWhere(
                            (player) => player['player_name'] == selection);
                        selectedHelpedPlayerName.value = selection;
                        selectedHelpedPlayerId.value =
                            selectedPlayer['id'] as int?;
                        setState(() {
                          hasError2 = false;
                        });
                      },
                      fieldViewBuilder: (context, textEditingController,
                          focusNode, onFieldSubmitted) {
                        textEditingController.addListener(() {
                          setState(() {});
                        });
                        return TextField(
                          controller: textEditingController,
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            labelText: 'Player Helped',
                            errorText: hasError2
                                ? 'Please select a valid option.'
                                : null,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: hasError2 ? Colors.red : Colors.blue,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: hasError2 ? Colors.red : Colors.blue,
                              ),
                            ),
                          ),
                        );
                      },
                      optionsViewBuilder: (context, onSelected, options) {
                        return Align(
                          alignment: Alignment.topLeft,
                          child: Material(
                            elevation: 4.0,
                            child: Container(
                              height: 160,
                              color: Colors.white,
                              width: MediaQuery.of(context).size.width * 0.8,
                              child: ListView.builder(
                                padding: const EdgeInsets.all(0.0),
                                itemCount: options.length,
                                itemBuilder: (context, index) {
                                  final String option =
                                      options.elementAt(index);
                                  return ListTile(
                                    title: Text(option),
                                    onTap: () {
                                      onSelected(option);
                                      final selectedPlayer = bowlingTeamPlayers
                                          .firstWhere((player) =>
                                              player['player_name'] == option);
                                      selectedHelpedPlayerName.value = option;
                                      selectedHelpedPlayerId.value =
                                          selectedPlayer['id'] as int?;
                                      setState(() {
                                        hasError2 = false;
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                  const SizedBox(height: 10),
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      final inputText = textEditingValue.text;
                      if (inputText.isEmpty) {
                        return battingTeamPlayers
                            .map((player) => player['player_name'] as String)
                            .toList();
                      }
                      return battingTeamPlayers
                          .map((player) => player['player_name'] as String)
                          .where((playerName) => playerName
                              .toLowerCase()
                              .contains(inputText.toLowerCase()));
                    },
                    onSelected: (String selection) {
                      final selectedPlayer = battingTeamPlayers.firstWhere(
                          (player) => player['player_name'] == selection);
                      selectedBatsmanName.value = selection;
                      selectedBatsmanId.value = selectedPlayer['id'] as int?;
                      setState(() {
                        hasError1 = false;
                      });
                    },
                    fieldViewBuilder: (context, textEditingController,
                        focusNode, onFieldSubmitted) {
                      textEditingController.addListener(() {
                        setState(() {});
                      });
                      return TextField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        decoration: InputDecoration(
                          labelText: 'New Batsman',
                          errorText: hasError1
                              ? 'Please select a valid option.'
                              : null,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: hasError1 ? Colors.red : Colors.blue,
                            ),
                          ),
                        ),
                      );
                    },
                    optionsViewBuilder: (context, onSelected, options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 4.0,
                          child: Container(
                            height: 160,
                            color: Colors.white,
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: ListView.builder(
                              padding: const EdgeInsets.all(0.0),
                              itemCount: options.length,
                              itemBuilder: (context, index) {
                                final String option = options.elementAt(index);
                                return ListTile(
                                  title: Text(option),
                                  onTap: () {
                                    onSelected(option);
                                    final selectedPlayer = battingTeamPlayers
                                        .firstWhere((player) =>
                                            player['player_name'] == option);
                                    selectedBatsmanName.value = option;
                                    selectedBatsmanId.value =
                                        selectedPlayer['id'] as int?;
                                    setState(() {
                                      hasError1 = false;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () async {
                    setState(() {
                      _isLoading = true;
                    });

                    // Validate before processing
                    if (selectedBatsmanName.value.isEmpty ||
                        (showPlayerHelp &&
                            selectedHelpedPlayerName.value.isEmpty)) {
                      setState(() {
                        hasError1 = true;
                        hasError2 = true;
                        _isLoading = false;
                      });
                      return;
                    } else {
                      try {
                        if (type == 'run_out_non_striker' ||
                            type == 'run_out_striker') {
                          print("Run Out ");
                          await scoreservice
                              .runOutwicket(
                                tournamentId: tournamentId,
                                type: 'wicket',
                                outType: type,
                                outPlayer: type == 'run_out_non_striker'
                                    ? 'nonStriker'
                                    : 'Striker',
                                playerHelped:
                                    selectedHelpedPlayerId.value?.toString() ??
                                        '',
                                newPlayer:
                                    selectedBatsmanId.value?.toString() ?? '',
                                lastRec: lastRecord,
                                runs: runs,
                              )
                              .then((_) => getLastRecord());
                        } else {
                          await scoreservice
                              .wicket(
                                tournamentId: tournamentId,
                                type: 'wicket',
                                outType: type,
                                outPlayer: type == 'run_out_non_striker'
                                    ? 'nonStriker'
                                    : 'Striker',
                                playerHelped:
                                    selectedHelpedPlayerId.value?.toString() ??
                                        '',
                                newPlayer:
                                    selectedBatsmanId.value?.toString() ?? '',
                                lastRec: lastRecord,
                              )
                              .then((_) => getLastRecord());
                        }
                      } finally {
                        setState(() {
                          _isLoading = false;
                        });
                        Navigator.of(context).pop();
                      }
                    }
                  },
                  child: Text(
                    'Confirm',
                    style: TextStyle(
                      color: _isLoading ? Colors.grey : Colors.blue,
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
