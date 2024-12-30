
import 'package:cricyard/views/screens/MenuScreen/leaderboard_screen/frag/box_board_frag/box_leaderboard_frag.dart';
import 'package:cricyard/views/screens/MenuScreen/leaderboard_screen/frag/leather_board_frag/leather_leaderboard_frag.dart';
import 'package:cricyard/views/screens/MenuScreen/leaderboard_screen/frag/tennis_board_frag/tennis_leaderboard_frag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../theme/theme_helper.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({Key? key}) : super(key: key,);

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> with TickerProviderStateMixin {
  late TabController _tabController;
  @override
  void initState() {
    _tabController  = TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appTheme.gray100,
      appBar: AppBar(
        title: Text(
          "LeaderBoards",
          style: theme.textTheme.headlineLarge,
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
        bottom: TabBar(
          dividerColor: Colors.transparent,
          controller: _tabController,
            indicatorColor:const Color(0xFF219ebc),
            unselectedLabelColor: Colors.grey,
            labelStyle: GoogleFonts.getFont('Poppins',color: const Color(0xFF219ebc),fontSize: 16,fontWeight: FontWeight.bold),
            tabs: const [
              Tab(
                text: "Leather",
              ),
              Tab(
                text: "Tennis",
              ),
              Tab(
                text: "Box cricket",
              ),
            ]),
      ),
      body:  TabBarView(
          controller:_tabController ,
          children:const [
            LeatherLeaderboardFrag(),
            TennisLeaderboardFrag(),
            BoxLeaderboardFrag()
          ]),
    );
  }
}
