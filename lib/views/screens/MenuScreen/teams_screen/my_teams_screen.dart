import 'dart:async';

import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../Entity/team/Teams/repository/Teams_api_service.dart';
import 'myteam_item_widget.dart';

// Define a class for player data
class Player {
  final String image;
  final String name;
  final double rating; // Change the rating type to double

  Player({required this.image, required this.name, required this.rating});
}

class MyTeamScreen extends StatefulWidget {
  @override
  _MyTeamScreenState createState() => _MyTeamScreenState();
}

class _MyTeamScreenState extends State<MyTeamScreen> with TickerProviderStateMixin{
  final teamsApiService teamapiService = teamsApiService();
  String? token;

  List<Map<String, dynamic>> teams = []; // Store tournament data here
  List<Map<String, dynamic>> enrolledTeams = []; // Store tournament data here
  List<Map<String, dynamic>> teamMembers = []; // Store team data here
  bool isLoading = false;
  bool isteamLoading = false;

  int selectedTeamIndex = 0;
  int selectedTeamIndexEnrolled = 0;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    _tabController.addListener(_handleTabChange);
    fetchMyTeams();
    fetchEnrolledTeams();
  }

  void _handleTabChange() {
    getAllMember(teams[selectedTeamIndex]['id']);
    setState(() {
      teamMembers = []; // Clear the team members list when switching tabs
    });
  }

  @override
  void dispose() {
    _tabController.removeListener(_handleTabChange);
    _tabController.dispose();
    super.dispose();
  }

  Future<void> fetchMyTeams() async {
    try {
      setState(() {
        isteamLoading = true;
      });
      final List<Map<String, dynamic>> myteam = await teamapiService.getMyTeam();

      setState(() {
        teams = myteam; // Store the fetched data
      });

      if (teams.isNotEmpty) {
        getAllMember(teams[selectedTeamIndex]['id']);
      }

      print("Response: $myteam");

      for (int i = 0; i < myteam.length; i++) {
        print("Team $i: ${myteam[i]}");
      }
    } catch (e) {
      print("Error fetching myteam: $e");
    } finally {
      setState(() {
        isteamLoading = false;
      });
    }
  }

  Future<void> fetchMyTeamsbyTournamentId(int tourId) async {
    try {
      final List<Map<String, dynamic>> myteam =
      await teamapiService.getMyTeamByTourId(tourId);
      setState(() {
        teams = myteam; // Store the fetched data
      });

      if (teams.isNotEmpty) {
        getAllMember(teams[selectedTeamIndex]['id']);
      }

      print("Response: $myteam");

      for (int i = 0; i < myteam.length; i++) {
        print("Team $i: ${myteam[i]}");
      }
    } catch (e) {
      print("Error fetching myteam: $e");
    }
  }

  Future<void> getAllMember(int teamId) async {
    setState(() {
      isLoading = true;
    });
    try {
      final List<Map<String, dynamic>> data =
      await teamapiService.getAllMembers(teamId);
      teamMembers.clear();
      setState(() {
        teamMembers = data;
      });
      print("Response: $data");

      for (int i = 0; i < data.length; i++) {
        print("Team $i: ${data[i]}");
      }
    } catch (e) {
      print("Error fetching Members: $e");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> fetchEnrolledTeams() async {
    try {
      setState(() {
        isteamLoading = true;
      });
      final List<Map<String, dynamic>> myteam = await teamapiService.getEnrolledTeam();

      setState(() {
        enrolledTeams = myteam; // Store the fetched data
      });

      if (teams.isNotEmpty) {
        getAllMember(teams[selectedTeamIndex]['id']);
      }

      print(" Enroll Response: $myteam");

      for (int i = 0; i < myteam.length; i++) {
        print(" Enroll Team $i: ${myteam[i]}");
      }
    } catch (e) {
      print("Error fetching Enroll Team: $e");
    } finally {
      setState(() {
        isteamLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        title: Padding(
          padding: EdgeInsets.only(left: 20.h),
          child: Text(
            "My Team",
            style: theme.textTheme.headlineLarge,
          ),
        ),
          leading:GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color:const Color(0xFF219ebc),
                    borderRadius: BorderRadius.circular(12)),
                child: const Icon(
                  Icons.arrow_back_ios_new,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          bottom: PreferredSize(
              preferredSize:const Size.fromHeight(60) ,
              child: _buildTabview(context))
      ),
      body: isteamLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(
        controller: _tabController,
        children: [
         teams.isEmpty ? const Center(child: Text("No Teams Created Yet!!",style: TextStyle(color: Colors.black,fontSize: 20),)) : _createdTabView(context),
          enrolledTeams.isEmpty ? const Center(child: Text("No Teams Enrolled Yet!!",style: TextStyle(color: Colors.black,fontSize: 20),)) : _enrolledTabView(context),
        ],
      ),
    );
  }

  Widget _createdTabView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 54.v),
          _buildTeamCardList(context,teams,_tabController.index,false),
          SizedBox(height: 54.v),
          isLoading ?  const Center(child: CircularProgressIndicator()): teamMembers.isEmpty
              ? _noPlayersWidget(
              teams.isNotEmpty
                  ? teams[selectedTeamIndex]['team_name']
                  : 'Team')
              : _newPlayerUi(),
        ],
      ),
    );
  }

  Widget _buildTabview(BuildContext context) {
    return Container(
      height: 56.v,
      width: 424.h,
      decoration: BoxDecoration(
        color: const Color(0xFF0096c7), //const Color.fromARGB(255, 24, 140, 236),
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
        unselectedLabelStyle: GoogleFonts.getFont('Poppins',color: Colors.white,fontWeight: FontWeight.w200,fontSize: 12),
        labelStyle: GoogleFonts.getFont('Poppins',color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18),
        tabs: const [
          Tab(
            child: Text(
              "Created",
            ),
          ),
          Tab(
            child: Text(
              "Enrolled",
            ),
          ),
        ],
      ),
    );
  }

  Widget _enrolledTabView(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 54.v),
          _buildTeamCardList(context,enrolledTeams,_tabController.index,true),
          SizedBox(height: 54.v),
          isLoading ?  const Center(child: CircularProgressIndicator()):  teamMembers.isEmpty
              ? _noPlayersWidget(
              enrolledTeams.isNotEmpty
                  ? enrolledTeams[selectedTeamIndexEnrolled]['team_name']
                  : 'Team')
              : _newPlayerUi(),
        ],
      ),
    );
  }

  Widget _buildTeamCardList(BuildContext context,List<Map<String, dynamic>> data,int tabIndex,bool isEnrolled) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 210.v,
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
                 tabIndex == 0? selectedTeamIndex = index : selectedTeamIndexEnrolled = index;
                });
                print('id is ${data[index]['id']}');
                tabIndex == 0? getAllMember(data[selectedTeamIndex]['id']) :  getAllMember(data[selectedTeamIndexEnrolled]['id']); // Assuming 'id' is the team ID
              }, isEnrolled: isEnrolled, players: teamMembers.length,
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
            const SizedBox(height: 10,),
            Text("Wicket Keepers", style: CustomTextStyles.titleMediumPoppinsGray50,),
            _playerCategoryRow("Wicket Keeper", 2), // Row for wicket keepers
            const SizedBox(height: 10),
            Text("Batsman", style: CustomTextStyles.titleMediumPoppinsGray50,),
            _playerCategoryRow("Batsman", 4),
            const SizedBox(height: 10),// Row for batsmen
            Text("All Rounder", style: CustomTextStyles.titleMediumPoppinsGray50,),
            _playerCategoryRow("All Rounders", 4),
            const SizedBox(height: 10),// Row for all-rounders
            Text("Bowlers", style: CustomTextStyles.titleMediumPoppinsGray50,),
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
    Map<int, String> playerRoles = {}; // Store player roles using player index as key

    // Determine the starting index for this category based on the previous category
    if (category == "Wicket Keeper") {
      startIndex = 0; // Start from index 2 (Player 3) for non-wicket keeper categories
    } else if (category == "Batsman") {
      startIndex = 2; // Start from index 2 (Player 3) for non-wicket keeper categories
    } else if (category == "All Rounders") {
      startIndex = 5; // Start from index 2 (Player 3) for non-wicket keeper categories
    } else if (category == "Bowlers") {
      startIndex = 8; // Start from index 2 (Player 3) for non-wicket keeper categories
    }

    int numberOfRows = (category == "Wicket Keeper") ? 1 : 1;

    for (int row = 0; row < numberOfRows; row++) {
      playersWidgets.clear();
      int numberOfPlayers = (row == 0 && category == "Wicket Keeper") ? 2 : 3;
      for (int col = 0; col < numberOfPlayers; col++) {
        int index = startIndex + col;
        if (index < teamMembers.length) {
          final player = teamMembers[index];
          final playerRole = playerRoles[index] ?? ''; // Retrieve previously assigned role
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
                        style: GoogleFonts.getFont('Poppins', color: Colors.black, fontSize: 14,),
                      ),
                    ),
                    Text(
                      "${player['player_tag']}",
                      style: GoogleFonts.getFont('Poppins', color: Colors.grey, fontSize: 10,),
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
                      style: GoogleFonts.getFont('Poppins', color: Colors.white),
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
                      style: GoogleFonts.getFont('Poppins', color: Colors.white),
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
                      style: GoogleFonts.getFont('Poppins', color: Colors.white),
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
      teamMembers[index]['player_tag'] = role; // Assign the new role to the selected player
      final playerId = teamMembers[index]['id']; // Assuming each player has a unique ID
      teamapiService.updateTag(playerTag: role, id: playerId);
    });
  }
}
