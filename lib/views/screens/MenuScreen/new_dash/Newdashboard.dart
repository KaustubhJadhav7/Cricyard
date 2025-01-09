// ignore_for_file: deprecated_member_use

import 'package:another_carousel_pro/another_carousel_pro.dart';
import 'package:cricyard/core/app_export.dart';
import 'package:cricyard/views/screens/Login%20Screen/view/decision.dart';
import 'package:cricyard/views/screens/MenuScreen/live_cricket/live_cricket.dart';
import 'package:cricyard/views/screens/ReuseableWidgets/new_drawer.dart';
import 'package:dotted_border/dotted_border.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../Entity/matches/Match/repository/Match_api_service.dart';
import '../../../../providers/tab_navigation_provider.dart';
import '../../ReuseableWidgets/BottomAppBarWidget.dart';
import '../Notification/GetAllNotification.dart';

class Newdashboard extends StatefulWidget {
  Newdashboard({super.key});

  @override
  _NewdashboardState createState() => _NewdashboardState();
}

class _NewdashboardState extends State<Newdashboard> {
  int _currentTab = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Map<String, dynamic> userData = {};
  final MatchApiService apiService = MatchApiService();
  List<Map<String, dynamic>> matchLive = [];
  bool isLoading = false;

  List<Map<String, dynamic>> dummyData2 = [
    {
      'title': 'India vs\nWest indies',
      'imgPath': 'assets/images/img_image_2.png',
      'color': Color(0xff1289bd)
    },
    {
      'title': 'Australia \nTour',
      'imgPath': 'assets/images/img_image_2.png',
      'color': Color(0xff010593),
    },
    {
      'title': 'England \nTour',
      'imgPath': 'assets/images/img_image_1.png',
      'color': Color(0xff930101),
    },
  ];

  void getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = prefs.getBool('isLoggedIn') ?? false;
    });
    print("LoginState-$isLogin");
  }

  var isLogin = false;

  int _selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    fetchMatchesLive();
    getUserData();
    getLoginState();
    // fetchData();
    print('user data is ..$userData');
  }

  getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var userdatastr = prefs.getString('userData');
    if (userdatastr != null) {
      try {
        setState(() {
          userData = json.decode(userdatastr);
        });
        print(userData['token']);
      } catch (e) {
        print("error is ..................$e");
      }
    }
  }

  Future<void> fetchMatchesLive() async {
    setState(() {
      isLoading = true;
    });
    try {
      final fetchedEntities = await apiService.liveMatches();
      print('live match is $fetchedEntities');
      setState(() {
        matchLive = fetchedEntities;
        isLoading = false;
      });
      print('Match by id .. $matchLive');
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  void setTab(int index) {
    setState(() {
      _currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        forceMaterialTransparency: true,
        elevation: 2,
        leading: IconButton(
            onPressed: (){
              _scaffoldKey.currentState?.openDrawer();
            }, icon: const Icon(Icons.menu,color:  Color(0xFF219ebc),size: 30,)),
        title: Image.asset(ImageConstant.imgImageRemovebgPreview,scale: 4,),
        actions: [
          SizedBox(
              height: 26,
              child: Image.asset(ImageConstant.imgNotification3)),
          const SizedBox(width: 20,),
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
                height: 26,
                child: Image.asset(ImageConstant.imgBell)),
          ),
          SizedBox(width: 10,),
        ],
      ),
      key: _scaffoldKey,
      //drawer: CustomDrawer(context: context),
      drawer: NewDrawer(context: context,),

      bottomNavigationBar: BottomAppBarWidget(),

      backgroundColor: Colors.grey[200],
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Trending now",
                style: CustomTextStyles.headlineSmallSemiBold,
              ),
              _buildOngoingStack(context),
              SizedBox(height: 10.v),
              _bannerWidget(),
              SizedBox(height: 10.v),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: _slidingBannerWidget(),
              ),
              SizedBox(height: 10.v),
              _customTabBar(),
              SizedBox(height: 10.v),
              _headlineWidget(),
              SizedBox(height: 10.v),
              // bottom card
              SizedBox(
                height: 270,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: dummyData2.length,
                  itemBuilder: (context, index) {
                    final data = dummyData2[index];
                    return _bottomCardWidget(
                        data['imgPath'], data['title'], data['color']);
                  },
                ),
              ),
              //_bottomCardWidget(),
            ],
          ),
        ),
      ),
    );
  }
  
  Widget _loginReqWidget(BuildContext context){
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Please Login to access this feature",style: GoogleFonts.getFont('Poppins',color: Colors.black),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const DecisionScreen(),));
                  },
                  child: Text("Click here",style: GoogleFonts.getFont('Poppins',color: Colors.blue),)),
              SizedBox(width: 6,),
              Text("to login ",style: GoogleFonts.getFont('Poppins',color: Colors.black),),
            ],
          ),
        ],
      ),
    );
  }

  // /// Section Widget
  Widget _buildOngoingStack(BuildContext context) {
    return DottedBorder(
        color: Colors.purple,
        borderType: BorderType.RRect,
        radius: const Radius.circular(12),
        dashPattern: const [8, 4],
        padding: const EdgeInsets.all(6),
        child: SizedBox(
            height: 260,
            child:!isLogin ? _loginReqWidget(context): isLoading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: matchLive.length,
                    itemBuilder: (context, index) {
                      final data = matchLive[index];
                      return _myContainer(context,
                          matchTitle: data['tournament_name'],
                          team1: data['team_1_name'],
                          team1Status: data['team1Status'] ?? 'nope',
                          team2: data['team_2_name'],
                          team1S: data['extn1'] ?? '0',
                          team2S: data['extn1'] ?? '0',
                          team1Wkts: data['extn1'] ?? '0',
                          team2Wkts: data['extn1'] ?? '0',
                          team1Overs: data['extn1'] ?? '0',
                          team2Overs: data['extn1'] ?? '0',
                          team1Crr: data['extn1'] ?? '0',
                          tossBy: data['extn1'] ?? '0',
                          team1Logo: data['team1Logo'] ??
                              ImageConstant.imgEngRoundFlag,
                          team2Logo: data['team2Logo'] ??
                              ImageConstant.imgShriLankaRoundFlag);
                    })));
  }

  Widget _myContainer(BuildContext context,
      {required String matchTitle,
      required team1,
      required team1Status,
      required team2,
      required team1S,
      required team2S,
      required team1Wkts,
      required team2Wkts,
      required team1Overs,
      required team2Overs,
      required team1Crr,
      required tossBy,
      required team1Logo,
      required team2Logo}) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context) => LiveCricketScreen(),));
      },
      child: Column(
        children: [
          // top section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.87,
              child: Container(
                width: double.infinity,
                height: 240,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12), color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // top section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                      ),
                      child: SizedBox(
                        height: 55,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              matchTitle,
                              style: CustomTextStyles.titleMediumBlack900Medium,
                            ),
                            Text(
                              '$team1 vs $team2',
                              style: CustomTextStyles.titleMediumBlack900Medium,
                            ),
                            Row(
                              children: [
                                Text("Live",
                                    style: CustomTextStyles.titleSmallGray600),
                                const SizedBox(
                                  width: 10,
                                ),
                                Image.asset(
                                  ImageConstant.imgLive,
                                  scale: 16,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[200],
                    ),
                    // middle most section
                    SizedBox(
                      height: 140,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Expanded(
                              flex: 3,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [

                                  ListTile(
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: AssetImage(team1Logo),
                                      ),
                                      title: SizedBox(
                                        width: 130,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            team1,
                                            style: CustomTextStyles
                                                .titleMediumBlack900Medium,
                                          ),
                                        ),
                                      ),
                                      trailing: SizedBox(
                                        width: 40,
                                        child: team1Status == 'Bat'
                                            ? FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: RichText(
                                                    text: TextSpan(
                                                        text:
                                                            "$team1S- $team1Wkts",
                                                        style: CustomTextStyles
                                                            .titleMedium18,
                                                        children: const [
                                                      TextSpan(
                                                          text: '*',
                                                          style: TextStyle(
                                                              color: Colors.red)),
                                                    ])),
                                              )
                                            : const FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'Yet to Bat',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16),
                                                ),
                                              ),
                                      )),
                                  ListTile(
                                      leading: CircleAvatar(
                                        backgroundImage: AssetImage(team2Logo),
                                        backgroundColor: Colors.transparent,
                                      ),
                                      title: SizedBox(
                                        width: 130,
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            team2,
                                            style: CustomTextStyles
                                                .titleMediumBlack900Medium,
                                          ),
                                        ),
                                      ),
                                      trailing: SizedBox(
                                        width: 40,
                                        child: team1Status == 'Ball'
                                            ? FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: RichText(
                                                    text: TextSpan(
                                                        text:
                                                            "$team2S -$team2Wkts",
                                                        style: CustomTextStyles
                                                            .titleMedium18,
                                                        children: const [
                                                      TextSpan(
                                                          text: '*',
                                                          style: TextStyle(
                                                              color: Colors.red)),
                                                    ])),
                                              )
                                            : const FittedBox(
                                                fit: BoxFit.scaleDown,
                                                child: Text(
                                                  'Yet to bat',
                                                  style: TextStyle(
                                                      color: Colors.grey,
                                                      fontSize: 16),
                                                ),
                                              ),
                                      )),
                                ],
                              )),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: VerticalDivider(
                              color: Colors.grey[200],
                            ),
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                team1Status == 'Bat'
                                    ? "($team2Overs)Overs"
                                    : "($team1Overs)Overs",
                                style: CustomTextStyles.titleMediumMedium,
                              ),
                              Text(
                                "$team1Crr crr",
                                style: const TextStyle(
                                    color: Colors.grey,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14),
                              )
                            ],
                          ))
                        ],
                      ),
                    ),
                    Divider(
                      color: Colors.grey[200],
                    ),
                    // bottom section
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 10),
                      child: Text(
                        tossBy,
                        style: CustomTextStyles.titleSmallGray600,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bannerWidget() {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [
              Color(0xff3efafa),
              Color(0xff52ecfd),
              Color(0xffa058f1),
              Color(0xff913bf3),
              Color(0xff9a3bf3)
            ],
          )),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: SizedBox(
                height: 80.v,
                child: Image.asset(
                  "assets/images/image_65.png",
                  scale: 4,
                )),
          )),
          Expanded(
              flex: 2,
              child: SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.asset(
                    "assets/images/image_204.png",
                    fit: BoxFit.fill,
                  ))),
          Expanded(
              flex: 2,
              child: Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Align(
                        alignment: Alignment.bottomRight,
                        child: SizedBox(
                            height: 240.v,
                            child: Image.asset(
                              "assets/images/image_4.png",
                              color: Colors.black.withOpacity(0.2),
                              scale: 1,
                              fit: BoxFit.cover,
                            ))),
                  ),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "FOR STATS, LATEST \n SCORE & NEWS",
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 8.v,
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.4),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Text(
                              "CLICK HERE",
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget _slidingBannerWidget() {
    return SizedBox(
      height: 400,
      width: double.infinity,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: AnotherCarousel(
          images: const [
            AssetImage(
              "assets/images/image_195.png",
            ),
            AssetImage(
              "assets/images/image_195.png",
            ),
            AssetImage(
              "assets/images/image_195.png",
            ),
          ],
          borderRadius: true,
          radius: const Radius.circular(4),
          autoplay: false,
          dotColor: Colors.grey,
          dotIncreasedColor: Colors.yellowAccent,
          indicatorBgPadding: 1,
          dotSize: 6,
        ),
      ),
    );
  }

  Widget _customTabBar() {
    return Container(
      height: 70,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          _tabItem(
            index: 0,
            selectedIndex: _selectedIndex,
            onTap: () {
              setState(() {
                _selectedIndex = 0;
              });
            },
            text: "Top Headline",
          ),
          _tabItem(
            index: 1,
            selectedIndex: _selectedIndex,
            onTap: () {
              setState(() {
                _selectedIndex = 1;
              });
            },
            text: "Most Popular",
          ),
        ],
      ),
    );
  }

  Widget _tabItem(
      {required int index,
      selectedIndex,
      required VoidCallback onTap,
      required String text}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                color:
                    index == selectedIndex ? Colors.yellow : Colors.transparent,
                borderRadius: BorderRadius.circular(12)),
            child: Center(
              child: Text(text,
                  style: index == selectedIndex
                      ? CustomTextStyles.titleSmallPoppinsBlack900
                      : CustomTextStyles.titleSmallGray600),
            ),
          ),
        ),
      ),
    );
  }

  Widget _headlineWidget() {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                    height: 100,
                    child: Image.asset(
                      "assets/images/image.png",
                      fit: BoxFit.cover,
                    ))),
          )),
          Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const Text(
                      "hey how are you,hey how are you,hey how are you,hey how are you,",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        const Text(
                          "PTI",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 6.h,
                        ),
                        const Text(
                          "•",
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 6.h,
                        ),
                        const Text(
                          "1 hour ago",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              )),
        ],
      ),
    );
  }

  Widget _bottomCardWidget(String imgPath, title, Color color) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 200,
        decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(12),
            image: const DecorationImage(
                image: AssetImage(
                  "assets/images/image_2.png",
                ),
                fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              child: Image.asset(imgPath),
            ),
            SizedBox(
              height: 10.v,
            ),
            Text(
              "$title",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            )
          ],
        ),
      ),
    );
  }

  Widget _imageSliderBannerWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 400,
        width: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12), color: Colors.red),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.asset(
              "assets/images/image_195.png",
              fit: BoxFit.fill,
            )),
      ),
    );
  }

  void _onTabChange(int index) {
    if (_currentTab == 1 || _currentTab == 2) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
    Provider.of<TabNavigationProvider>(context as BuildContext, listen: false)
        .updateTabs(_currentTab);
    setState(() {
      _currentTab = index;
    });
  }

  Future<bool> _onBackPress() {
    if (_currentTab == 0) {
      return Future.value(true);
    } else {
      int lastTab = Provider.of<TabNavigationProvider>(context as BuildContext,
              listen: false)
          .lastTab;
      Provider.of<TabNavigationProvider>(context as BuildContext, listen: false)
          .removeLastTab();
      setTab(lastTab);
    }
    return Future.value(false);
  }
}