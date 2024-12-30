import 'package:cricyard/Entity/team/viewmodels/Teams_api_service.dart';
import 'package:cricyard/core/app_export.dart';
import 'package:cricyard/views/screens/MenuScreen/tournament/my_tournamnet_screen/groups/group_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/tournament/my_tournamnet_screen/matches/matches_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../../Entity/matches/Match/viewmodel/Match_api_service.dart';
import '../../teams_screen/myteam_item_widget.dart';


class MyMatchById extends StatefulWidget {
  final Map<String, dynamic> tournament;
  const MyMatchById({super.key, required this.tournament});

  @override
  State<MyMatchById> createState() => _MyMatchByIdState();
}

class _MyMatchByIdState extends State<MyMatchById>
    with TickerProviderStateMixin {
  final MatchApiService apiService = MatchApiService();
  final teamsApiService teamapiService = teamsApiService();

  late TabController _tabController;
  String selectedMatchType = 'Completed';

  List<Map<String, dynamic>> enrolledTeams = []; // Store tournament data here
  List<Map<String, dynamic>> teamMembers = []; // Store team data here
  bool isTeamLoading = false;

  int selectedTeamIndexEnrolled = 0;

  @override
  void initState() {
    // TODO: implement initState
    _tabController = TabController(length: 3, vsync: this);
    fetchMyTeamsbyTournamentId(widget.tournament['id']);
    super.initState();
  }

  Future<void> fetchMyTeamsbyTournamentId(int tId) async {
    try {
      final List<Map<String, dynamic>> myteam =
          await teamapiService.getMyTeamByTourId(tId);
      setState(() {
        enrolledTeams = myteam; // Store the fetched data
      });

      if (enrolledTeams.isNotEmpty) {
        getAllMember(enrolledTeams[selectedTeamIndexEnrolled]['id']);
      }

      print("Response of teams by id : $myteam");
    } catch (e) {
      print("Error fetching myteam: $e");
    }
  }

  Future<void> getAllMember(int teamId) async {
    setState(() {
      isTeamLoading = true;
    });
    try {
      final List<Map<String, dynamic>> data =
          await teamapiService.getAllMembers(teamId);
      setState(() {
        teamMembers = data;
      });
      print("Response of get all member: $data");

      for (int i = 0; i < data.length; i++) {
        print("Team $i: ${data[i]}");
      }
    } catch (e) {
      print("Error fetching Members: $e");
    } finally {
      setState(() {
        isTeamLoading = false;
      });
    }
  }

  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 56.v,
      width: 424.h,
      decoration: BoxDecoration(
        color:
            const Color(0xFF0096c7), //const Color.fromARGB(255, 24, 140, 236),
        // theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(
          10.h,
        ),
      ),
      child: TabBar(
        controller: _tabController,
        labelPadding: EdgeInsets.zero,
        indicatorColor: Colors.white,
        labelColor: Colors.white,
        dividerColor: Colors.transparent,
        unselectedLabelColor: Colors.white,
        unselectedLabelStyle: GoogleFonts.getFont('Poppins',
            color: Colors.white, fontWeight: FontWeight.w200, fontSize: 12),
        labelStyle: GoogleFonts.getFont('Poppins',
            color: Colors.white, fontWeight: FontWeight.w600, fontSize: 18),
        tabs: const [
          Tab(
            child: Text(
              "Matches",
            ),
          ),
          Tab(
            child: Text(
              "Teams",
            ),
          ),
          Tab(
            child: Text(
              "Groups",
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final tourName = widget.tournament['tournament_name'];
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
          backgroundColor: Colors.grey[200],
          title: Text(
            "$tourName",
            style: GoogleFonts.getFont('Poppins', color: Colors.black),
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
          bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: _buildTabview(context))),
      body: TabBarView(controller: _tabController, children: [
        MatchesScreen(
          tourId: widget.tournament['id'],
        ),
        teamsViewWidget(),
        GroupScreen(
          tournament: widget.tournament,
        ),
      ]),
    );
  }

  Widget teamsViewWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          _enrolledTabView(context),
        ],
      ),
    );
    ;
  }

  Widget _enrolledTabView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildTeamCardList(
            context,
            enrolledTeams,
          ),
          SizedBox(height: 54.v),
          enrolledTeams.isEmpty
              ? const Center(
                  child: Text(
                    "No enrolled teams",
                    style: TextStyle(color: Colors.black),
                  ),
                )
              : teamMembers.isEmpty
                  ? _noPlayersWidget(enrolledTeams.isNotEmpty
                      ? enrolledTeams[selectedTeamIndexEnrolled]['team_name']
                      : 'Team')
                  : isTeamLoading
                      ? const Center(child: CircularProgressIndicator())
                      : _newPlayerUi(),
        ],
      ),
    );
  }

  Widget _buildTeamCardList(
    BuildContext context,
    List<Map<String, dynamic>> data,
  ) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: MediaQuery.of(context).size.height*0.15,
        child: ListView.separated(
          padding: EdgeInsets.only(left: 20.h),
          scrollDirection: Axis.horizontal,
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 12.h,
            );
          },
          itemCount: data.length,
          itemBuilder: (context, index) {
            return myteam_item_widget(
              teamData: data[index],
              onTap: () {
                setState(() {
                  selectedTeamIndexEnrolled = index;
                });
                print('id is ${data[index]['id']}');
                getAllMember(data[selectedTeamIndexEnrolled]
                    ['id']); // Assuming 'id' is the team ID
              },
              isEnrolled: true, players: teamMembers.length,
            );
          },
        ),
      ),
    );
  }

  Widget _newPlayerUi() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: double.infinity,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: DecorationImage(
            image: AssetImage(ImageConstant.imgCricketGround),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Text(
              "Wicket Keepers",
              style: CustomTextStyles.titleMediumPoppinsGray50,
            ),
            _playerCategoryRow("Wicket Keeper", 2), // Row for wicket keepers
            const SizedBox(height: 10),
            Text(
              "Batsman",
              style: CustomTextStyles.titleMediumPoppinsGray50,
            ),
            _playerCategoryRow("Batsman", 4),
            const SizedBox(height: 10), // Row for batsmen
            Text(
              "All Rounder",
              style: CustomTextStyles.titleMediumPoppinsGray50,
            ),
            _playerCategoryRow("All Rounders", 4),
            const SizedBox(height: 10), // Row for all-rounders
            Text(
              "Bowlers",
              style: CustomTextStyles.titleMediumPoppinsGray50,
            ),
            _playerCategoryRow("Bowlers", 4), // Row for bowlers
          ],
        ),
      ),
    );
  }

  Widget _noPlayersWidget(String teamName) {
    return Center(
      child: Text(
        "No Players in $teamName Team",
        style: const TextStyle(color: Colors.black, fontSize: 20),
      ),
    );
  }

  Widget _playerCategoryRow(String category, int numberOfColumns) {
    List<Widget> rows = [];
    List<Widget> playersWidgets = [];
    int startIndex = 0;
    Map<int, String> playerRoles =
        {}; // Store player roles using player index as key

    // Determine the starting index for this category based on the previous category
    if (category == "Wicket Keeper") {
      startIndex =
          0; // Start from index 2 (Player 3) for non-wicket keeper categories
    } else if (category == "Batsman") {
      startIndex =
          2; // Start from index 2 (Player 3) for non-wicket keeper categories
    } else if (category == "All Rounders") {
      startIndex =
          5; // Start from index 2 (Player 3) for non-wicket keeper categories
    } else if (category == "Bowlers") {
      startIndex =
          8; // Start from index 2 (Player 3) for non-wicket keeper categories
    }

    int numberOfRows = (category == "Wicket Keeper") ? 1 : 1;

    for (int row = 0; row < numberOfRows; row++) {
      playersWidgets.clear();
      int numberOfPlayers = (row == 0 && category == "Wicket Keeper") ? 2 : 3;
      for (int col = 0; col < numberOfPlayers; col++) {
        int index = startIndex + col;
        if (index < teamMembers.length) {
          final player = teamMembers[index];
          final playerRole =
              playerRoles[index] ?? ''; // Retrieve previously assigned role
          playersWidgets.add(
            GestureDetector(
              onTap: () {
                _showPlayerOptions(index);
              },
              child: Container(
                height: 100,
                width: 90,
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 50,
                      child: Image.asset(ImageConstant.imgImage51),
                    ),
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "${player['player_name']}",
                        style: GoogleFonts.getFont(
                          'Poppins',
                          color: Colors.black,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Text(
                      "${player['player_tag']}",
                      style: GoogleFonts.getFont(
                        'Poppins',
                        color: Colors.grey,
                        fontSize: 10,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      }
      rows.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: playersWidgets,
        ),
      );
      startIndex += numberOfPlayers; // Increment the starting index
    }

    return Column(
      children: rows,
    );
  }

  void _showPlayerOptions(int index) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            "Assign Role",
            style: GoogleFonts.getFont('Poppins', color: Colors.black),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _assignRole(index, "C");
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Captain",
                      style:
                          GoogleFonts.getFont('Poppins', color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _assignRole(index, "VC");
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Vice Captain",
                      style:
                          GoogleFonts.getFont('Poppins', color: Colors.white),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    _assignRole(index, "WK");
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Wicket Keeper",
                      style:
                          GoogleFonts.getFont('Poppins', color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _assignRole(int index, String role) {
    setState(() {
      // Remove the specified role from the previous player, if any
      for (var player in teamMembers) {
        if (player['player_tag'] == role) {
          player['player_tag'] = ''; // Remove the specified role
          final playerId = player['id']; // Assuming each player has a unique ID
          teamapiService.updateTag(playerTag: '', id: playerId);
          break; // Assuming only one player can have each role at a time
        }
      }
      teamMembers[index]['player_tag'] =
          role; // Assign the new role to the selected player
      final playerId =
          teamMembers[index]['id']; // Assuming each player has a unique ID
      teamapiService.updateTag(playerTag: role, id: playerId);
    });
  }
}
