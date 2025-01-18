import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../../Entity/matches/Match/repository/Match_api_service.dart';
import '../../../../../../theme/custom_button_style.dart';
import '../../../../../widgets/custom_elevated_button.dart';
import '../../../Matches/scoring/matchScore.dart';
import '../../score_board/tournament_scoreboard_screen.dart';

class MatchesScreen extends StatefulWidget {
  final int tourId;
  const MatchesScreen({super.key, required this.tourId});

  @override
  State<MatchesScreen> createState() => _MatchesScreenState();
}

class _MatchesScreenState extends State<MatchesScreen> {
  final MatchApiService apiService = MatchApiService();

  List<Map<String, dynamic>> matchDataById = [];
  List<Map<String, dynamic>> allMatches = [];
  List<Map<String, dynamic>> matchLive = [];
  late List<Map<String, dynamic>> filteredMatches = [];
  String selectedMatchType = 'Upcoming';

  bool isLoading = false;

  Future<void> fetchMatchesById(int tId) async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedEntities = await apiService.myMatches(tId);
      for (int i = 0; i < fetchedEntities.length; i++) {
        print('FETCH MATCHES BY ID- $tId is  ${fetchedEntities[i]}');
      }
      setState(() {
        matchDataById = List<Map<String, dynamic>>.from(fetchedEntities);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to fetch Match: $e'),
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

  Future<void> fetchMatchesLive(int tourId) async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedEntities = await apiService.liveMatchesByTourId(tourId);
      print('FETCH LIVE MATCHES BY ID -$tourId is  $matchLive');
      setState(() {
        matchLive = List<Map<String, dynamic>>.from(fetchedEntities);
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: Text('Failed to fetch Match: $e'),
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

  void filterMatches() {
    if (selectedMatchType == 'Completed') {
      filteredMatches = matchDataById.where((match) {
        final matchDateTime = DateTime.parse(match['datetime_field']);
        return matchDateTime.isBefore(DateTime.now());
      }).toList();
    } else if (selectedMatchType == 'Live') {
      filteredMatches = matchLive.where((match) {
        final matchDateTime = DateTime.parse(match['datetime_field']);
        return matchDateTime.isBefore(DateTime.now()) &&
            matchDateTime.isAfter(DateTime.now());
      }).toList();
      // filteredMatches = allMatches.where((match) {
      //   return match['matchStatus'] == 'Started';
      // }).toList();
    } else {
      // Upcoming
      filteredMatches = matchDataById.where((match) {
        final matchDateTime = DateTime.parse(match['datetime_field']);
        return matchDateTime.isAfter(DateTime.now());
      }).toList();
      // Sort upcoming matches by the remaining time
      filteredMatches.sort((a, b) {
        final matchDateTimeA = DateTime.parse(a['datetime_field']);
        final matchDateTimeB = DateTime.parse(b['datetime_field']);
        return matchDateTimeA.compareTo(matchDateTimeB);
      });
    }
  }

  @override
  void initState() {
    fetchMatchesById(widget.tourId);
    fetchMatchesLive(widget.tourId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    filterMatches();
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _buildMyMatchesRow(context),
            isLoading
                ? const Center(child: CircularProgressIndicator())
                : _buildGridText(context),
          ],
        ),
      ),
    );
  }

  Widget _buildMyMatchesRow(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Expanded(
        //   flex: 2,
        //   child: Padding(
        //     padding: const EdgeInsets.symmetric(horizontal: 2.0),
        //     child: _buildCustomElevatedButton(
        //       text: "Schedule Match",
        //       onPressed: () {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //             builder: (context) => matchCreateEntityScreenById(
        //               tourId: widget.tournament['id'],
        //             ),
        //           ),
        //         ).then((_) => fetchMatchesById(widget.tournament['id']));
        //       },
        //     ),
        //   ),
        // ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: _buildCustomElevatedButton(
              text: "Completed Match",
              onPressed: () {
                setState(() {
                  selectedMatchType = 'Completed';
                  filterMatches();
                });
              },
              isSelected: selectedMatchType == 'Completed',
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: _buildCustomElevatedButton(
              text: "Live Match",
              onPressed: () {
                setState(() {
                  selectedMatchType = 'Live';
                  filterMatches();
                });
              },
              isSelected: selectedMatchType == 'Live',
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 2.0),
            child: _buildCustomElevatedButton(
              text: "Upcoming Match",
              onPressed: () {
                setState(() {
                  selectedMatchType = 'Upcoming';
                  filterMatches();
                });
              },
              isSelected: selectedMatchType == 'Upcoming',
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomElevatedButton({
    required String text,
    VoidCallback? onPressed,
    required bool isSelected,
  }) {
    return CustomElevatedButton(
      height: 50.v,
      width: MediaQuery.of(context).size.width * 0.1,
      text: text,
      buttonStyle: CustomButtonStyles.none,
      decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF264653) : Colors.grey[400],
          borderRadius: BorderRadius.circular(12)),
      buttonTextStyle: GoogleFonts.getFont('Poppins',
          fontSize: isSelected ? 14 : 11,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
          color: Colors.white),
      onPressed: onPressed,
    );
  }

  Widget _buildGridText(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (filteredMatches.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'No  matches found.',
            style: TextStyle(fontSize: 16, color: Colors.black),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(right: 11.h),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: filteredMatches.length,
        itemBuilder: (BuildContext context, int index) {
          final entity = filteredMatches[index];
          return _buildListItem(entity);
        },
      ),
    );
  }

  Widget _buildListItem(Map<String, dynamic> entity) {
    final matchDateTime = DateTime.parse(entity['datetime_field']);
    final now = DateTime.now();
    final timeRemaining = matchDateTime.difference(now);
    final hours = timeRemaining.inHours;
    final minutes = timeRemaining.inMinutes % 60;
    final formattedTimeRemaining = "${hours}h : ${minutes}m";

    final matchStatus = entity['matchStatus'];
    bool status = getStatus(matchStatus);

    return GestureDetector(
      onTap: () {
        print('ID-${entity['id']}');
        //***** implement scoreboard navigator screen *******//
        // matchStatus == 'Startedd' ? Navigator.push(context, MaterialPageRoute(builder: (context) => streamVideoWidget(),)) :

        formattedTimeRemaining.contains('-')
            ? Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TournamentScoreBoardScreen(
                    matchId: entity['id'],
                    team1: '',
                    team2: '',
                  ),
                ))
            : Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MatchScoreScreen(
                    entity: entity,
                    status: status,
                  ),
                ),
              );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2.0, vertical: 6),
        child: Container(
          height: 100,
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          AssetImage(ImageConstant.imgEngRoundFlag),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        entity['team_1_name'],
                        style: CustomTextStyles.titleMediumPoppins,
                      ),
                    )
                  ],
                )),
                Expanded(
                    flex: 3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                entity['tournament_name'] ?? 'Match',
                                style: CustomTextStyles.titleMediumPoppins,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                entity['matchStatus'],
                                style: GoogleFonts.getFont('Poppins',
                                    fontSize: 12,
                                    color: entity['matchStatus'] == 'Started'
                                        ? Colors.black
                                        : Colors.red),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                formattedTimeRemaining.contains('-')
                                    ? 'Match Over'
                                    : formattedTimeRemaining,
                                style: formattedTimeRemaining.contains('-')
                                    ? CustomTextStyles.titleSmallRed700
                                    : CustomTextStyles.titleSmallDeeppurpleA400,
                              ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: Text(
                                entity['datetime_field'],
                                style: CustomTextStyles.titleSmallGray600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "Location: ${entity['location']}",
                            style: CustomTextStyles.titleSmallGray600,
                          ),
                        ),
                      ],
                    )),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.transparent,
                      backgroundImage:
                          AssetImage(ImageConstant.imgShriLankaRoundFlag),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        entity['team_2_name'],
                        style: CustomTextStyles.titleMediumPoppins,
                      ),
                    )
                  ],
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool getStatus(String status) {
    if (status == 'Started') {
      return true;
    } else {
      return false;
    }
  }
}
