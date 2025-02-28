// ignore_for_file: use_build_context_synchronously
import 'package:cricyard/core/utils/size_utils.dart';
import 'package:cricyard/views/screens/practice_match/practiceGraphs/views/practice_score_graph.dart';
import 'package:cricyard/views/screens/practice_match/practiceView/score_board_screen.dart';
import 'package:cricyard/views/screens/practice_match/practiceView/second_inning_player_entry_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../core/utils/image_constant.dart';
import '../practiceRepository/PracticeMatchService.dart';
import 'matchwon_view.dart';
import 'practice_match_home_View.dart';

class PracticeMatchScoreScreen extends StatefulWidget {
  final Map<String, dynamic> entity;

  const PracticeMatchScoreScreen({super.key, required this.entity});

  @override
  _PracticeMatchScoreScreenState createState() =>
      _PracticeMatchScoreScreenState();
}

class _PracticeMatchScoreScreenState extends State<PracticeMatchScoreScreen> {
  final PracticeMatchService scoreservice = PracticeMatchService();
  Map<String, dynamic> lastRecord = {};
  Map<String, dynamic> strikermap = {};
  Map<String, dynamic> nonstrikermap = {};
  Map<String, dynamic> ballermap = {};
  Map<String, dynamic> extraRunsMap = {};
  List<Map<String, dynamic>> partnershipList = [];
  List<String> playersData = [];
  List<dynamic> overBalls = [];

  var totalRun = 0;
  var wicket = 0;
  var overs = 0;
  var currentBall = 0;
  var inning = 0;

  var battingTeam = 'Batting Team';
  var ballingTeam = 'Balling Team';
  var striker = 'Striker';
  var nonStriker = 'Non Striker';
  var baller = 'Baller';
  var tossWinner = '';
  var opted_to = '';

  var lastBallStatus = '';
  var strikertotalRun = 0;
  var matchId = 0;
  var crr = 0.0;
  int bowlingTeamId = 0;
  int battingTeamId = 0;

  int targetScore = 0;

  String? tempSelectedOption = '';

  String? msg = '';
  String? winningTeamName = '';

  bool isdata = true;
  bool islastrecord = true;

  // innings ending, match ,and over
  bool isInningOver = false;
  bool isMatchOver = false;
  bool isOverEnd = false;

  bool _isLoading = false;
  bool _isButtonDisabled = false;
  bool isLoadingData = false;

  List<String> battingTeamPlayers = [];
  List<String> bowlingTeamPlayers = [];

  final TextEditingController _penaltyRunsController = TextEditingController();

  TextEditingController _newBowlerController = TextEditingController();

  TextEditingController _strikerController = TextEditingController();
  TextEditingController _nonStrikerController = TextEditingController();
  TextEditingController _bowlerController = TextEditingController();
  FocusNode _strikerFocusNode = FocusNode();
  FocusNode _nonStrikerFocusNode = FocusNode();
  FocusNode _bowlerFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    matchId = widget.entity['id'];

    getlastrecord();
  }

  Future<void> getlastrecord() async {
    setState(() {
      isLoadingData = true;
    });

    getupdatedscore().then((_) async {
      await getlastrecordPlayerCareer();
      await allBalls();
      await fetchBowlingPlayers();
      await fetchBattingPlayers();
      fetchExtraRuns();
      // fetchPartnership();
      setState(() {
        isLoadingData = false;
      });
    });
  }

  Future<void> getupdatedscore() async {
    try {
      final fetchedEntities = await scoreservice.getlastrecord(matchId);
      print("LAST RECORD!! --$fetchedEntities");
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
          if (lastRecord['ball'] != null) {
            currentBall = lastRecord['ball'];
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
          if (lastRecord['last_ball_status'] != null) {
            lastBallStatus = lastRecord['last_ball_status'];
          }
          if (lastRecord['striker_total_run'] != null) {
            strikertotalRun = lastRecord['striker_total_run'];
          }
          if (lastRecord['tossWinner'] != null) {
            tossWinner = lastRecord['tossWinner'];
          }
          if (lastRecord['opted_to'] != null) {
            opted_to = lastRecord['opted_to'];
          }
          if (lastRecord['inning'] != null) {
            inning = lastRecord['inning'];
          }
          if (lastRecord['over_end'] != null) {
            isOverEnd = lastRecord['over_end'];
          }
          if (lastRecord['inning_end'] != null) {
            isInningOver = lastRecord['inning_end'];
          }
          if (lastRecord['match_end'] != null) {
            isMatchOver = lastRecord['match_end'];
          }
          if (lastRecord['bowling_team_id'] != null) {
            bowlingTeamId = lastRecord['bowling_team_id'];
          }
          if (lastRecord['batting_team_id'] != null) {
            battingTeamId = lastRecord['batting_team_id'];
          }
          if (lastRecord['targeted_score'] != null) {
            targetScore = lastRecord['targeted_score'];
          }
          if (lastRecord['bowling_team'] != null) {
            ballingTeam = lastRecord['bowling_team'];
          }
        });
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

  Future<void> fetchExtraRuns() async {
    final data = await scoreservice.getExtrasDetails(matchId, inning);
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

  Future<void> fetchBowlingTeamPlayers() async {
    final List<Map<String, dynamic>> data =
        await scoreservice.getAllPlayersInTeam(bowlingTeamId);

    // Extract player names
    final List<String> playerNames =
        data.map((player) => player['name'] as String).toList();

    setState(() {
      playersData = playerNames;
    });
  }

  // get last record of player career
  Future<void> getlastrecordPlayerCareer() async {
    print('match id for getlastrecordPlayerCareer is $matchId');

    var strikerrespone =
        await scoreservice.getlastrecordPlayerCareer(matchId, inning, striker);
    print("Striker Response: $strikerrespone");
    setState(() {
      strikermap = strikerrespone;
    });
    var nonstrikerrespone = await scoreservice.getlastrecordPlayerCareer(
        matchId, inning, nonStriker);
    print("NonStriker Response: $nonstrikerrespone");
    setState(() {
      nonstrikermap = nonstrikerrespone;
    });
    var ballerrespone =
        await scoreservice.getlastrecordPlayerCareer(matchId, inning, baller);
    print("Baller Response: $ballerrespone");
    setState(() {
      ballermap = ballerrespone;
    });
  }

// Strike Rotation
  Future<void> strikeRotation() async {
    Map<String, dynamic> scoreboard = lastRecord;

    await scoreservice.strikerotation(scoreboard);
  }

  Future<void> fetchBattingPlayers() async {
    final data = await scoreservice.getAllPlayersInTeam(battingTeamId);
    setState(() {
      battingTeamPlayers =
          data.map<String>((team) => team['player_name'] as String).toList();
    });
  }

  Future<void> fetchBowlingPlayers() async {
    final data = await scoreservice.getAllPlayersInTeam(bowlingTeamId);
    setState(() {
      bowlingTeamPlayers =
          data.map<String>((team) => team['player_name'] as String).toList();
    });
  }

// over all ball actions
  Future<void> allBalls() async {
    print('match id is $matchId');

    var ballrespone = await scoreservice.allballofOvers(matchId);

    setState(() {
      overBalls = ballrespone;
      print('All BAll $overBalls ');
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
        msg = '$battingTeam won by $winByWicketMargin wickets';
      });
      print("Team2Win");
    }
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
                          : '${lastRecord['bowling_team']} need ${lastRecord['targeted_score']} runs in ${lastRecord['match_overs']} overs',
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
                          await scoreservice.undo(matchId, inning).then(
                                (value) => getlastrecord(),
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
                                    SecondInningPlayerEntryView(
                                  lastRecord: lastRecord,
                                  match: widget.entity,
                                  bowlingTeamId: battingTeamId,
                                  battingTeamId: bowlingTeamId,
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

  Widget _buildNewBowlerEntry(BuildContext context) {
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
              height: 150,
              width: MediaQuery.of(context).size.width * 0.7,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Autocomplete<String>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text.isEmpty) {
                        return bowlingTeamPlayers;
                      }
                      return bowlingTeamPlayers.where((player) => player
                          .toLowerCase()
                          .contains(textEditingValue.text.toLowerCase()));
                    },
                    displayStringForOption: (String option) => option,
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      _newBowlerController = textEditingController;
                      return TextField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        decoration: const InputDecoration(
                          hintText: 'Select new bowler',
                        ),
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
                            height: 120,
                            color: Colors.white,
                            child: ListView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: options.length,
                              itemBuilder: (BuildContext context, int index) {
                                final String option = options.elementAt(index);
                                return InkWell(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Text(
                                      option,
                                      style:
                                          const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                          setState(() {
                            isOverEnd = false;
                          });
                          scoreservice.undo(matchId, inning).then(
                                (_) => getlastrecord(),
                              );
                        },
                        child: const Text('UNDO'),
                      ),
                      TextButton(
                        onPressed: _isButtonDisabled
                            ? null
                            : () async {
                                setState(() {
                                  _isButtonDisabled = true;
                                });

                                await scoreservice
                                    .newPlayerEntry(
                                        'Baller',
                                        _newBowlerController.text,
                                        '',
                                        lastRecord)
                                    .then((_) => getlastrecord());
                                setState(() {
                                  isOverEnd = false;
                                  _isButtonDisabled = false;
                                });
                              },
                        child: Text(
                          'OK',
                          style: TextStyle(
                              color: _isButtonDisabled
                                  ? Colors.grey
                                  : Colors.blue),
                        ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          title: Text(
            "${lastRecord['batting_team']} v/s ${lastRecord['bowling_team']}",
            style: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 18,
              color: Colors.black,
            ),
          ),
          leading: GestureDetector(
            onTap: () {
              // Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PracticeMatchHomeScreen(),
                ),
              );
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
        body: isLoadingData
            ? Stack(
                children: [
                  _newWidget(context),
                  showOverlay(),
                ],
              )
            : Stack(
                children: [
                  _newWidget(context),
                  if (isMatchOver)
                    _buildInningOverDialog(context)
                  else if (isInningOver)
                    _buildInningOverDialog(context)
                  else if (isOverEnd)
                    _buildNewBowlerEntry(context),
                ],
              ));
  }

  Widget _newWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.47,
              width: double.infinity,
              child: Stack(
                children: [
                  // bg img
                  // SizedBox(
                  //   width: double.infinity,
                  //   child: Image.asset(
                  //     "assets/images/istockphoto_177427917170667_a_1.png",
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.37,
                    width: double.infinity,
                    decoration: const BoxDecoration(color: Color(0xFF219ebc)),
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
                                                ScoreBoardScreen(
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
                                                  PracticeScoreGraph(
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
            height: 20,
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
            0: FlexColumnWidth(2),
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
      height: MediaQuery.of(context).size.height * 0.20,
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
              height: 5.v,
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
              // _buildScoreControlItem(
              //     context, 'Dot', 0, 'running', const Color(0xFF3A3A3A)),
              // _buildScoreControlItem(
              //     context, '1', 1, 'running', const Color(0xFF3A3A3A)),
              // _buildScoreControlItem(
              //     context, '2', 2, 'running', const Color(0xFF3A3A3A)),
              // _buildScoreControlItem(
              //     context, 'Undo', 0, 'undo', const Color(0xFF219ebc)),
              // _buildRetireButton(
              //     context, 'Retire', 'retire', const Color(0xFF264653)), // Blue
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
      BuildContext ctx, String text, int? data, String type, Color color) {
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
              _showExtrasAndPenaltyDialog(ctx, 'extras');
            }
            if (type == 'partnership') {
              _showExtrasAndPenaltyDialog(ctx, 'partnership');
            }
            if (type == 'penalty') {
              _showExtrasAndPenaltyDialog(ctx, 'penalty');
            }
            if (type == 'retire') {
              _showRetireAndMoreDialog(ctx, 'retire');
            }
            if (type == 'more') {
              _showRetireAndMoreDialog(ctx, 'more');
            }
            if (type == 'wide' ||
                type == 'NoBall' ||
                type == 'LegBy' ||
                type == 'By') {
              _showWideDialog(ctx, type);
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

  Future<void> updateData(scdata, type, scoreboard) async {
    try {
      print("Trying updateData() ");
      await scoreservice
          .updateScore(scdata, type, scoreboard)
          .then((_) => getlastrecord());
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Success'),
            backgroundColor: Colors.green,
            behavior: SnackBarBehavior.floating, // Ensures it's visible
            margin: EdgeInsets.only(
                bottom: 80.0, left: 16.0, right: 16.0), // Adjusts position
          ),
        );
      }
    } catch (e) {
      print(e);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
            behavior: SnackBarBehavior.floating,
            margin: EdgeInsets.only(bottom: 80.0, left: 16.0, right: 16.0),
          ),
        );
      }
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
      backgroundColor: Colors
          .transparent, // Make background transparent to show custom design
      elevation: 0, // Remove default elevation to apply custom shadow
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
                color: color.withOpacity(0.5),
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
                color: color.withOpacity(0.5),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
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

  Future<void> _showWideDialog(BuildContext ctx, type) async {
    // Show dialog with options
    String? selectedOption = await showDialog<String>(
      context: ctx,
      builder: (_) {
        if (type == 'wide') {
          return AlertDialog(
            title: const Text('Select Wide Option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOptionButton(ctx, 'WD+0', '0'),
                _buildOptionButton(ctx, 'WD+1', '1'),
                _buildOptionButton(ctx, 'WD+2', '2'),
                _buildOptionButton(ctx, 'WD+3', '3'),
                _buildOptionButton(ctx, 'WD+4', '4'),
                _buildOptionButton(ctx, 'WD+6', '6'),

                // Add more option buttons as needed
              ],
            ),
          );
        }
        if (type == 'NoBall') {
          return AlertDialog(
            title: const Text('Select No Ball Option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOptionButton(ctx, 'NB+0', '0'),
                _buildOptionButton(ctx, 'NB+1', '1'),
                _buildOptionButton(ctx, 'NB+2', '2'),
                _buildOptionButton(ctx, 'NB+3', '3'),
                _buildOptionButton(ctx, 'NB+4', '4'),
                _buildOptionButton(ctx, 'NB+5', '5'),
                _buildOptionButton(ctx, 'NB+6', '6'),

                // Add more option buttons as needed
              ],
            ),
          );
        }
        if (type == 'LegBy') {
          return AlertDialog(
            title: const Text('Select LegBy Option'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildOptionButton(ctx, 'LB+0', '0'),
                _buildOptionButton(ctx, 'LB+1', '1'),
                _buildOptionButton(ctx, 'LB+2', '2'),
                _buildOptionButton(ctx, 'LB+3', '3'),
                _buildOptionButton(ctx, 'LB+4', '4'),
                _buildOptionButton(ctx, 'LB+5', '5'),
                _buildOptionButton(ctx, 'LB+6', '6'),

                // Add more option buttons as needed
              ],
            ),
          );
        }
        return AlertDialog(
          title: const Text('Select Bye Option'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildOptionButton(ctx, 'BYE+0', '0'),
              _buildOptionButton(ctx, 'BYE+1', '1'),
              _buildOptionButton(ctx, 'BYE+2', '2'),
              _buildOptionButton(ctx, 'BYE+3', '3'),
              _buildOptionButton(ctx, 'BYE+4', '4'),
              _buildOptionButton(ctx, 'BYE+5', '5'),
              _buildOptionButton(ctx, 'BYE+6', '6'),

              // Add more option buttons as needed
            ],
          ),
        );
      },
    );
    if (selectedOption != null) {
      await _handleSelectedOption(selectedOption, type);
    }
  }

  Future<void> _handleSelectedOption(String runs, String type) async {
    try {
      scoreservice
          .postWideExtra(type, int.parse(runs), matchId, inning, lastRecord)
          .then((_) {
        getlastrecord().then(
          (value) {
            showSnackBar(context, 'Success updated $type with $runs extra run',
                Colors.green);
          },
        );
      }); // type == wide , nb,lb etc // option will be runs
    } catch (error) {
      showSnackBar(
          context, 'Error!! updating $type with $runs extra run', Colors.red);
      // Handle error (e.g., show an error message, log the error, etc.)
    }
  }

  Future<void> _showExtrasAndPenaltyDialog(BuildContext ctx, type) async {
    // Show dialog with options
    showDialog<String>(
      context: context,
      builder: (BuildContext ctx) {
        if (type == 'extras') {
          WidgetsBinding.instance.addPostFrameCallback(
            (timeStamp) {
              setState(() {});
            },
          );
          return AlertDialog(
            title: const Text('Extra runs'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "${extraRunsMap['Bye']} B",
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 12, color: Colors.black),
                    ),
                    Text(
                      "${extraRunsMap['Lb']} LB",
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 12, color: Colors.black),
                    ),
                    Text(
                      "${extraRunsMap['Wide']} WD",
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 12, color: Colors.black),
                    ),
                    Text(
                      "${extraRunsMap['NB']} NB",
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 12, color: Colors.black),
                    ),
                    Text(
                      "${extraRunsMap['P']} P",
                      style: GoogleFonts.getFont('Poppins',
                          fontSize: 12, color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
          );
        } else if (type == 'partnership') {
          return AlertDialog(
            title: const Text('Partnership'),
            content: Container(
              width: MediaQuery.of(context).size.width * 1.4,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: partnershipList.length,
                itemBuilder: (context, index) {
                  final data = partnershipList[index];
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Text(
                          "${data['striker']} - ${data['non-striker']}",
                          style: GoogleFonts.getFont('Poppins',
                              fontSize: 12, color: Colors.black),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          "${data['runsScored']} R  ${data['ballsPlayed']} B",
                          style: GoogleFonts.getFont('Poppins',
                              fontSize: 12, color: Colors.black),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
          );
        }
        return AlertDialog(
          title: const Text('Select Penalty Runs'),
          content: TextField(
            keyboardType: const TextInputType.numberWithOptions(),
            controller: _penaltyRunsController,
            decoration: const InputDecoration(
                labelText: 'Penalty Runs',
                labelStyle: TextStyle(color: Colors.black)),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                'Cancel',
                style: TextStyle(color: Colors.black),
              ),
            ),
            TextButton(
              onPressed: _isLoading
                  ? null
                  : () {
                      setState(() {
                        _isLoading = true;
                      });
                      try {
                        scoreservice
                            .postOverThrowAndPenalty(
                                int.parse(_penaltyRunsController.text),
                                matchId,
                                inning,
                                'Penalty')
                            .then(
                              (_) => getlastrecord(),
                            );
                      } finally {
                        setState(() {
                          _isLoading = false;
                          Navigator.pop(context);
                        });
                      }
                    },
              child: const Text(
                'Confirm',
                style: TextStyle(color: Colors.black),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showRetireAndMoreDialog(BuildContext ctx, type) async {
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
                                  strikeRotation().then((_) {
                                    getlastrecord();
                                    getlastrecordPlayerCareer();
                                  });
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
      _showNewBatsmanDialog(ctx, selectedOption, option);
    }
  }

  void _showNewBatsmanDialog(
      BuildContext context, String selectedOption, String tempSelectedOption) {
    TextEditingController dialogController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return StatefulBuilder(
            builder: (BuildContext ctx, StateSetter setState) {
          return AlertDialog(
            title: Text('Enter new player for $tempSelectedOption'),
            content: tempSelectedOption == 'baller'
                ? _buildAutocompleteTextField(dialogController,
                    'Select new bowler', _bowlerFocusNode, bowlingTeamPlayers)
                : tempSelectedOption == 'striker'
                    ? _buildAutocompleteTextField(dialogController,
                        'Select Striker', _strikerFocusNode, battingTeamPlayers)
                    : _buildAutocompleteTextField(
                        dialogController,
                        'Select non-striker',
                        _nonStrikerFocusNode,
                        battingTeamPlayers),
            actions: [
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  String playerName = dialogController.text;
                  String type = '';
                  // Update the main controller with the selected value
                  if (tempSelectedOption == 'baller') {
                    _bowlerController.text = playerName;
                    type = 'Baller';
                  } else if (tempSelectedOption == 'striker') {
                    _strikerController.text = playerName;
                    type = 'Batsman';
                  } else {
                    _nonStrikerController.text = playerName;
                    type = 'Batsman';
                  }

                  scoreservice
                      .newPlayerEntry(
                          type, playerName, tempSelectedOption, lastRecord)
                      .then((_) {
                    getlastrecord();
                  });
                },
                child: const Text(
                  'Confirm',
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Widget _buildAutocompleteTextField(TextEditingController controller,
      String label, FocusNode focusNode, List<String> data) {
    return Autocomplete<String>(
      optionsBuilder: (TextEditingValue textEditingValue) {
        if (textEditingValue.text.isEmpty) {
          return data;
        }
        return data.where((String option) {
          return option.contains(textEditingValue.text);
        });
      },
      onSelected: (String selection) {
        controller.text = selection;
        setState(() {});
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
            border: const UnderlineInputBorder(),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          ),
          style: const TextStyle(color: Colors.black),
        );
      },
      optionsViewBuilder: (BuildContext context,
          AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
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
                    },
                  );
                },
              ),
            ),
          ),
        );
      },
    );
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

  void _showWicketDetailsDialog(
      BuildContext context, String selectedOption, String type) {
    // Depending on the selected out option, show different details dialog
    switch (selectedOption) {
      case 'lbw':
        // Show dialog for LBW details
        _showLBWDetailsDialog(context, 'lbw', 'LBW Details');
        break;
      case 'bowled':
        // Show dialog for bowled details
        _showLBWDetailsDialog(context, 'bowled', 'Bowled Details');
        break;
      case 'hit_wicket':
        // Show dialog for hit wicket details
        _showLBWDetailsDialog(context, 'hit_wicket', 'Hit Wicket Details');
        break;
      case 'stumping':
        // Show dialog for stumping details
        _showStumpingDetailsDialog(context, 'stumping', 'Stumping Details');
        break;
      case 'run_out_striker':
        // Show dialog for run out striker details
        showRunOutOptions(
            context, 'run_out_striker', 'Run Out Striker Details');
        // _showRunOutNonStrikerDetailsDialog(
        //     context, 'run_out_striker', 'Run Out Striker Details');
        break;
      case 'run_out_non_striker':
        // Show dialog for run out non-striker details
        showRunOutOptions(
            context, 'run_out_non_striker', 'Run Out Non Striker Details');
        // _showRunOutNonStrikerDetailsDialog(
        //     context, 'run_out_non_striker', 'Run Out Non Striker Details');
        break;
      case 'catch_out':
        // Show dialog for catch out details
        _showStumpingDetailsDialog(context, 'catch_out', 'Catch Out Details');
        break;
      default:
        break;
    }
  }

  void _showLBWDetailsDialog(
      BuildContext context, String type, String title) async {
    String newBatsman = '';

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
              content: TextFormField(
                decoration: const InputDecoration(labelText: 'New Batsman'),
                onChanged: (value) {
                  newBatsman = value;
                },
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

                          try {
                            await scoreservice
                                .wicket(
                                  outType: type,
                                  outPlayer: 'Striker',
                                  playerHelped: '',
                                  newPlayer: newBatsman,
                                  lastRec: lastRecord,
                                )
                                .then((_) => getlastrecord());
                          } finally {
                            setState(() {
                              _isLoading = false;
                            });
                            Navigator.of(context).pop();
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

  void _showDialog(BuildContext context, String type, String title) async {
    //String newBatsman = '';
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
                          scoreservice.undo(matchId, inning).then(
                            (_) {
                              getlastrecord();
                              setState(() {
                                _isLoading = false;
                              });
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

  void _showRunOutDetailsDialog(
      BuildContext context, String type, String title, int runs) async {
    String playerHelped = '';
    String newBatsman = '';

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
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Player Helped'),
                  onChanged: (value) {
                    playerHelped = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'New Batsman'),
                  onChanged: (value) {
                    newBatsman = value;
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
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() {
                          _isLoading = true;
                        });

                        try {
                          await scoreservice
                              .runOutwicket(
                                  outType: type,
                                  outPlayer: type == 'run_out_striker'
                                      ? 'Striker'
                                      : 'nonStriker',
                                  playerHelped: playerHelped,
                                  newPlayer: newBatsman,
                                  lastRec: lastRecord,
                                  run: runs)
                              .then(
                                (_) => getlastrecord(),
                              );
                          // Navigator.of(context).pop();
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.of(context).pop();
                        }
                      },
                child: Text(
                  'Confirm',
                  style:
                      TextStyle(color: _isLoading ? Colors.grey : Colors.blue),
                ),
              ),
            ],
          );
        });
      },
    );
  }

  Future<void> showRunOutOptions(
      BuildContext ctx, String runOutOption, String title) async {
    int extraRuns = 0;
    String option = await showDialog(
      context: context,
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
    if (option.isNotEmpty) {
      _showRunOutDetailsDialog(context, runOutOption,
          "$title with extra $extraRuns runs", extraRuns);
    }
  }

  void _showStumpingDetailsDialog(
      BuildContext context, String type, String title) async {
    String playerHelped = '';
    String newBatsman = '';

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
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Player Helped'),
                  onChanged: (value) {
                    playerHelped = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'New Batsman'),
                  onChanged: (value) {
                    newBatsman = value;
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
                onPressed: _isLoading
                    ? null
                    : () async {
                        setState(() {
                          _isLoading = true;
                        });
                        try {
                          await scoreservice
                              .wicket(
                                  outType: type,
                                  outPlayer: 'Striker',
                                  playerHelped: playerHelped,
                                  newPlayer: newBatsman,
                                  lastRec: lastRecord)
                              .then(
                                (_) => getlastrecord(),
                              );
                          // Navigator.of(context).pop();
                        } finally {
                          setState(() {
                            _isLoading = false;
                          });
                          Navigator.of(context).pop();
                        }
                      },
                child: Text(
                  'Confirm',
                  style:
                      TextStyle(color: _isLoading ? Colors.grey : Colors.blue),
                ),
              ),
            ],
          );
        });
      },
    );
  }
}
