import 'package:flutter/material.dart';
import 'package:cricyard/core/app_export.dart';
import 'package:google_fonts/google_fonts.dart';

import 'live_cricket_fixture.dart';
import 'live_cricket_points_table.dart';

class LiveCricketScreen extends StatefulWidget {
  const LiveCricketScreen({super.key});

  @override
  State<LiveCricketScreen> createState() => _LiveCricketScreenState();
}

class _LiveCricketScreenState extends State<LiveCricketScreen> with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey[200],
        title: Text("Live Circket",style: CustomTextStyles.titleLargePoppinsBlack,),
        leading:  GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color:const Color(0xFF219ebc),
                  borderRadius: BorderRadius.circular(12)
              ),
              child: const Icon(Icons.arrow_back_ios_new,color: Colors.white,),
            ),
          ),
        ),
        bottom: PreferredSize(preferredSize: Size.fromHeight(65), child: _buildTabBar(context)),
      ),
      body: TabBarView(
        controller: _tabController,
          children: [
          const LiveCricketFixture(),
        LiveCricketPointsTable(),
          ])
    );
  }

  Widget _buildTabBar(BuildContext context) {
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
              "Fixture",
            ),
          ),
          Tab(
            child: Text(
              "Points table",
            ),
          ),
        ],
      ),
    );
  }

}
