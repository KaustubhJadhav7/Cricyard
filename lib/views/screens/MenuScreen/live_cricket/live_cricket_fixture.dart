import 'package:cricyard/Entity/matches/Match/viewmodel/Match_api_service.dart';
import 'package:cricyard/core/app_export.dart';
import 'package:cricyard/views/screens/MenuScreen/NewStreamFolder/LiveMatchStreamingActual/streamVideoWidget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../../ReuseableWidgets/BottomAppBarWidget.dart';
import '../NewStreamFolder/TestStreaming/streamVideoWidgetTest.dart';

class LiveCricketFixture extends StatefulWidget {
  const LiveCricketFixture({super.key});

  @override
  _LiveCricketFixtureState createState() => _LiveCricketFixtureState();
}

class _LiveCricketFixtureState extends State<LiveCricketFixture> {
  final MatchApiService _apiService = MatchApiService();

  List<Map<String, dynamic>> liveMatches = [];
  List<Map<String, dynamic>> searchEntities = [];

  void _searchEntities(String keyword) {
    setState(() {
      searchEntities = liveMatches
          .where((entity) => entity['location']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()))
          .toList();
    });
  }

  TextEditingController searchController = TextEditingController();

  bool isDataLoading = false;

  Future<void> fetchData() async {
    setState(() {
      isDataLoading = true;
    });
    final data = await _apiService.liveMatches();
    setState(() {
      liveMatches = data;
      isDataLoading = false;
      print("Live Match Data-- $liveMatches");
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isDataLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: searchController,
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _searchEntities(value);
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: searchController.text.isEmpty
                        ? liveMatches.length
                        : searchEntities.length,
                    itemBuilder: (context, index) {
                      final data = searchController.text.isEmpty
                          ? liveMatches[index]
                          : searchEntities[index];
                      DateTime datetime =
                          DateTime.parse(data['datetime_field']);
                      String shortDay = DateFormat('EEE').format(datetime);

                      // Extract the time portion
                      String time =
                          '${datetime.hour}:${datetime.minute.toString().padLeft(2, '0')}';

                      return _myContainer(
                          index: index,
                          cupTitle: data['tournament_name'],
                          matchNo: data['matchNo'],
                          time: time,
                          day: shortDay,
                          team1: data['team_1_name'],
                          team2: data['team_2_name'],
                          team1Runs: data['extn12'],
                          team2Runs: data['extn12'],
                          team1Wkts: data['extn12'],
                          team2Wkts: data['extn12'],
                          team1OversPlayed: data['extn12'],
                          team2OversPlayed: data['extn12'],
                          matchResult: data['location'],
                          team1Logo: ImageConstant.imgEngRoundFlag,
                          team2Logo: ImageConstant.imgEngRoundFlag,
                          matchId: data['id']);
                    },
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomAppBarWidget(),
    );
  }

  onTapBtnpointtable(BuildContext context) {
    Navigator.pushNamed(context, AppRoutes.pointstable);
  }

  Widget _myContainer(
      {required int index,
      required String cupTitle,
      required matchNo,
      required time,
      required day,
      required team1,
      required team2,
      required team1Runs,
      required team2Runs,
      required team1Wkts,
      required team2Wkts,
      required team1OversPlayed,
      required team2OversPlayed,
      required matchResult,
      required team1Logo,
      required team2Logo,
      required matchId}) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StreamVideoWidgetTest(matchId: matchId),
            ),
          );
        },
        child: Container(
          height: MediaQuery.of(context).size.height * 0.25,
          decoration: BoxDecoration(
              // color: Colors.black,
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            children: [
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "$cupTitle | ${matchNo} Match",
                            style: GoogleFonts.getFont('Poppins',
                                color: Colors.white, fontSize: 14),
                          ),
                          Text(
                            "$day | $time",
                            style: GoogleFonts.getFont('Poppins',
                                color: Colors.grey, fontSize: 12),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(5)),
                        child: Text(
                          "Live",
                          style: GoogleFonts.getFont('Poppins',
                              color: Colors.white, fontSize: 10),
                        ),
                      )
                    ],
                  ),
                ),
              )),
              Expanded(
                  flex: 2,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      // borderRadius: BorderRadius.only(bottomRight: Radius.circular(12),bottomLeft: Radius.circular(12))
                    ),
                    child: Row(
                      children: [
                        Expanded(
                            flex: 2,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                // img and team name
                                Padding(
                                  padding: const EdgeInsets.only(left: 12.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: AssetImage(team1Logo),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "$team1",
                                          style: GoogleFonts.getFont('Poppins',
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // runs overs
                                Padding(
                                  padding: const EdgeInsets.only(left: 14.0),
                                  child: Row(
                                    children: [
                                      Text(
                                        "$team1Runs-$team1Wkts",
                                        style: GoogleFonts.getFont('Poppins',
                                            color: Colors.white, fontSize: 14),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        "($team1OversPlayed Over)",
                                        style: GoogleFonts.getFont('Poppins',
                                            color: Colors.grey, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            )),
                        SizedBox(
                            height: 15,
                            child: Image.asset(
                              ImageConstant.imgTransfer,
                              color: Colors.white,
                            )),
                        Expanded(
                            flex: 2,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // img and team name
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      FittedBox(
                                        fit: BoxFit.scaleDown,
                                        child: Text(
                                          "$team2",
                                          style: GoogleFonts.getFont('Poppins',
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      CircleAvatar(
                                        backgroundImage: AssetImage(team2Logo),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  // runs overs
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          "$team2Runs-$team2Wkts",
                                          style: GoogleFonts.getFont('Poppins',
                                              color: Colors.white,
                                              fontSize: 14),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          "($team2OversPlayed Over)",
                                          style: GoogleFonts.getFont('Poppins',
                                              color: Colors.grey, fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            )),
                      ],
                    ),
                  )),
              Expanded(
                  child: Container(
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(12),
                        bottomLeft: Radius.circular(12))),
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: Divider(
                        color: Colors.grey,
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Center(
                        child: Text(
                      "$matchResult",
                      style: GoogleFonts.getFont('Poppins',
                          color: const Color(0xFFFFBB0E), fontSize: 12),
                    ))
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }
}