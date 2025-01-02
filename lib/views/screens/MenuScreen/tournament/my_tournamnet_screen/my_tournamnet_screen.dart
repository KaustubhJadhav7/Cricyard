import 'dart:ui';

import 'package:cricyard/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../providers/token_manager.dart';
import '../../../../widgets/custom_icon_button.dart';
import '../../../ReuseableWidgets/BottomAppBarWidget.dart';
import 'my_data_ui.dart';
import 'widgets/scoreboardcardlist_item_widget.dart';
import 'package:cricyard/Entity/add_tournament/My_Tournament/repository/My_Tournament_api_service.dart';

class MyTournamnetScreen extends StatefulWidget {
  const MyTournamnetScreen({Key? key}) : super(key: key);

  @override
  _MyTournamnetScreenState createState() => _MyTournamnetScreenState();
}

class _MyTournamnetScreenState extends State<MyTournamnetScreen>
    with TickerProviderStateMixin {
  final MyTournamentApiService _apiService = MyTournamentApiService();
  String? _token;

  List<Map<String, dynamic>> _tournaments = []; // Store tournament data here
  List<Map<String, dynamic>> _tournamentsbyuser =
      []; // Store tournament data here

  bool isTournamentLoading = false;
  bool isSwitchOn = false; // Add a variable to manage the switch state

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    // Call your service here, for example:

    _tabController = TabController(length: 2, vsync: this);
    _fetchMyTournaments();
    _fetchTournamentsByUserId();
  }

  // Existing working code
  Future<void> _fetchMyTournaments() async {
    try {
      setState(() {
        isTournamentLoading = true;
      });
      _token = await TokenManager.getToken();
      print("token is:$_token");
      // Replace 'token' with the actual token.
      final List<Map<String, dynamic>> tournaments =
          await _apiService.getMyTournament(_token!);
      setState(() {
        _tournaments = tournaments; // Store the fetched data
      });
      // Handle the retrieved data here.
      print("Response: $tournaments");

      // Print data from the tournaments array
      for (int i = 0; i < tournaments.length; i++) {
        print("Tournament $i: ${tournaments[i]}");
      }
    } catch (e) {
      // Handle errors.
      print("Error fetching tournaments: $e");
    } finally {
      setState(() {
        isTournamentLoading = false;
      });
    }
  }

  // by user
  Future<void> _fetchTournamentsByUserId() async {
    try {
      setState(() {
        isTournamentLoading = true;
      });
      _token = await TokenManager.getToken();
      print("token is: $_token");

      if (_token != null) {
        final List<Map<String, dynamic>> tournamentsbyuser =
            await _apiService.getAllByUserId(_token!);
        setState(() {
          _tournamentsbyuser = tournamentsbyuser; // Store the fetched data
        });
        // Handle the retrieved data here
        print("Response of getTournamentbyuser: $tournamentsbyuser");

        // Print data from the tournaments array
        for (int i = 0; i < tournamentsbyuser.length; i++) {
          print("Tournamentbyuser $i: ${tournamentsbyuser[i]}");
        }
      } else {
        print("Token is null");
      }
    } catch (e) {
      // Handle errors
      print("Error fetching tournamentsbyuser: $e");
    } finally {
      setState(() {
        isTournamentLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        backgroundColor: Colors.grey[200],
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomIconButton(
            height: 32.adaptSize,
            width: 32.adaptSize,
            padding_f: EdgeInsets.all(6.h),
            decoration: IconButtonStyleHelper.outlineIndigo,
            onTap: () {
              onTapBtnArrowleftone(context);
            },
            child: CustomImageView(
              svgPath: ImageConstant.imgArrowLeft,
            ),
          ),
        ),
        title: Text(
          "My Tournament",
          style: GoogleFonts.getFont('Poppins',
              fontWeight: FontWeight.w500, color: Colors.black),
        ),
        bottom: PreferredSize(
            preferredSize:const Size.fromHeight(60) ,
            child: _buildTabview(context))
      ),
      body: isTournamentLoading
          ? const Center(child: CircularProgressIndicator())
          : TabBarView(controller: _tabController, children: [
              createdTour(),
              enrolledTour(),
            ]),
      bottomNavigationBar: BottomAppBarWidget(),
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
  Widget createdTour() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          _buildScoreboardCardList(context),
          SizedBox(height: 9.v),
          Padding(
            padding: EdgeInsets.only(left: 33.h),
            child: Text(
              "Top stories",
              style: theme.textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 14.v),
          _buildStackCreateFrom(context),
          SizedBox(height: 16.v),
          _buildNewsCard(context)
        ],
      ),
    );
  }

  Widget enrolledTour() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20,),
          _buildScoreboardCardList2(context),
          SizedBox(height: 9.v),
          Padding(
            padding: EdgeInsets.only(left: 33.h),
            child: Text(
              "Top stories",
              style: theme.textTheme.headlineSmall,
            ),
          ),
          SizedBox(height: 14.v),
          _buildStackCreateFrom(context),
          SizedBox(height: 16.v),
          _buildNewsCard(context)
        ],
      ),
    );
  }

  /// Section Widget for where I have to show dynamically
  Widget _buildScoreboardCardList(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 150.v, // Adjust the height as needed
        child: isTournamentLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                padding: EdgeInsets.only(left: 20.h),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 12.h,
                  );
                },
                itemCount: _tournaments.length,
                itemBuilder: (context, index) {
                  return ScoreboardcardlistItemWidget(
                    tournamentData: _tournaments[index],
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MyMatchById(
                                  tournament: _tournaments[index])));
                    },
                    tournamentName: '',
                  );
                },
              ),
      ),
    );
  }

  /// Section Widget for where I have to show dynamically for 2nd data of tournament
  Widget _buildScoreboardCardList2(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 150.v, // Adjust the height as needed
        child: isTournamentLoading
            ? const Center(child: CircularProgressIndicator())
            : ListView.separated(
                padding: EdgeInsets.only(left: 20.h),
                scrollDirection: Axis.horizontal,
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 12.h,
                  );
                },
                itemCount: _tournamentsbyuser.length,
                itemBuilder: (context, index) {
                  final tournament = _tournamentsbyuser[index];
                  final tournamentName =
                      tournament['tournament_name']?.toString() ??
                          'Unnamed Tournament';

                  // Debugging prints to check the tournament data and name
                  print("Tournament by user id $index data: $tournament");
                  print("Tournament by userid $index name: $tournamentName");

                  return ScoreboardcardlistItemWidget(
                    tournamentData: tournament,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyMatchById(
                            tournament: _tournamentsbyuser[index],
                          ),
                        ),
                      );
                    },
                    tournamentName: '',
                  );
                },
              ),
      ),
    );
  }

  /// Section Widget
  Widget _buildStackCreateFrom(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 492.v,
        width: 395.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 492.v,
                width: 361.h,
                decoration: BoxDecoration(
                  color: appTheme.whiteA700.withOpacity(0.6),
                  border: Border(
                    bottom: BorderSide(
                      color: appTheme.gray300,
                      width: 1.h,
                    ),
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "Asia Cup 2023".toUpperCase(),
                    "Asia Cup 2023",
                    style: CustomTextStyles.labelLargeSFProTextErrorContainer,
                  ),
                  SizedBox(height: 6.v),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 7.h),
                        child: CustomImageView(
                          imagePath: ImageConstant.imgImage3,
                          height: 222.v,
                          width: 170.h,
                        ),
                      ),
                      CustomImageView(
                        imagePath: ImageConstant.imgImage3,
                        height: 222.v,
                        width: 170.h,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildNewsCard(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: SizedBox(
        height: 230.v,
        width: 395.h,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                height: 230.v,
                width: 361.h,
                decoration: BoxDecoration(
                  color: appTheme.whiteA700.withOpacity(0.6),
                  border: Border(
                    bottom: BorderSide(
                      color: appTheme.gray300,
                      width: 1.h,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  onTapBtnArrowleftone(BuildContext context) {
    Navigator.pop(context);
  }
}
