import 'package:cricyard/core/app_export.dart';
import 'package:cricyard/views/screens/ReuseableWidgets/new_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../ReuseableWidgets/BottomAppBarWidget.dart';
import '../../../ReuseableWidgets/CustomDrawer.dart';
import '../../../ReuseableWidgets/headerWidget.dart';
import '../../Matches/views/matches.dart';
import '../../Notification/GetAllNotification.dart';
import 'TournamentSubScreen.dart';

class TournamentScreen extends StatefulWidget {
  const TournamentScreen({Key? key})
      : super(
          key: key,
        );

  @override
  TournamentScreenState createState() => TournamentScreenState();
}

// ignore_for_file: must_be_immutable
class TournamentScreenState extends State<TournamentScreen>
    with TickerProviderStateMixin {
  late TabController tabviewController;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    tabviewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[400],
          forceMaterialTransparency: true,
          elevation: 2,
          leading: IconButton(
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              icon: const Icon(
                Icons.menu,
                color: Color(0xFF219ebc),
                size: 30,
              )),
          title: Image.asset(
            ImageConstant.imgImageRemovebgPreview,
            scale: 4,
          ),
          actions: [
            SizedBox(
                height: 26, child: Image.asset(ImageConstant.imgNotification3)),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GetAllNotification(),
                  ),
                );
              },
              child: SizedBox(
                  height: 26, child: Image.asset(ImageConstant.imgBell)),
            ),
            SizedBox(
              width: 10,
            ),
          ],
        ),
        key: _scaffoldKey,
        drawer: NewDrawer(
          context: context,
        ),
        body: SingleChildScrollView(
          // Wrap the Column with SingleChildScrollView
          child: SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                Column(
                  children: [
                    _buildTabview(context),
                    SizedBox(
                      height: 627.v,
                      child: TabBarView(
                        controller: tabviewController,
                        children: const [
                          TournamentSubScreen(),
                          Matches(),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 7.v)
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomAppBarWidget(),
      ),
    );
  }

  /// Section Widget
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
        controller: tabviewController,
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
              "Tournaments",
            ),
          ),
          Tab(
            child: Text(
              "Matches",
            ),
          ),
        ],
      ),
    );
  }
}
