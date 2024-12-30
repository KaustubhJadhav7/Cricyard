import 'package:cricyard/core/app_export.dart';
import 'package:cricyard/views/screens/MenuScreen/live_cricket/widgets/expandable_container.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveCricketInnings extends StatefulWidget {
  final int index;
  final String team1Name;
  final String team2Name;

  const LiveCricketInnings(
      {super.key,
      required this.index,
      required this.team1Name,
      required this.team2Name});

  @override
  State<LiveCricketInnings> createState() => _LiveCricketInningsState();
}

class _LiveCricketInningsState extends State<LiveCricketInnings>  with TickerProviderStateMixin{
  late TabController _tabController;

  int _selectedIndex = 0;
  int _selectedIndexSec = 0;

  List<Map<String, dynamic>> dummyData = [
    {
      'overCount': 1,
      'runsInCurrentOver': 6,
      'wktsInCurrentOver': 1,
      'totalScore': 10,
      'totalWkts': 1,
      'balls': [
        {
          'ballStatus': '1',
          'time': '07:00 PM',
          'score': 1,
          'wkts': 0,
          'overs': 0.1,
          'overCount': 1,
        },
        {
          'ballStatus': 'W',
          'time': '07:01 PM',
          'score': 1,
          'wkts': 1,
          'overs': 0.2,
          'overCount': 1,
        },
        {
          'ballStatus': '4',
          'time': '07:02 PM',
          'score': 5,
          'wkts': 1,
          'overs': 0.3,
          'overCount': 1,
        },
        {
          'ballStatus': '1',
          'time': '07:03 PM',
          'score': 6,
          'wkts': 1,
          'overs': 0.4,
          'overCount': 1,
        },
        {
          'ballStatus': '0',
          'time': '07:04 PM',
          'score': 6,
          'wkts': 1,
          'overs': 0.5,
          'overCount': 1,
        },
        {
          'ballStatus': '1',
          'time': '07:05 PM',
          'score': 7,
          'wkts': 1,
          'overs': 0.6,
          'overCount': 1,
        },
      ]
    },
    {
      'overCount': 2,
      'runsInCurrentOver': 8,
      'wktsInCurrentOver': 0,
      'totalScore': 18,
      'totalWkts': 1,
      'balls': [
        {
          'ballStatus': '1',
          'time': '07:06 PM',
          'score': 8,
          'wkts': 1,
          'overs': 1.1,
          'overCount': 2,
        },
        {
          'ballStatus': '2',
          'time': '07:07 PM',
          'score': 10,
          'wkts': 1,
          'overs': 1.2,
          'overCount': 2,
        },
        {
          'ballStatus': '1',
          'time': '07:08 PM',
          'score': 11,
          'wkts': 1,
          'overs': 1.3,
          'overCount': 2,
        },
        {
          'ballStatus': '4',
          'time': '07:09 PM',
          'score': 15,
          'wkts': 1,
          'overs': 1.4,
          'overCount': 2,
        },
        {
          'ballStatus': '0',
          'time': '07:10 PM',
          'score': 15,
          'wkts': 1,
          'overs': 1.5,
          'overCount': 2,
        },
        {
          'ballStatus': '1',
          'time': '07:11 PM',
          'score': 16,
          'wkts': 1,
          'overs': 1.6,
          'overCount': 2,
        },
      ]
    },
    {
      'overCount': 3,
      'runsInCurrentOver': 12,
      'wktsInCurrentOver': 2,
      'totalScore': 30,
      'totalWkts': 3,
      'balls': [
        {
          'ballStatus': '1',
          'time': '07:12 PM',
          'score': 17,
          'wkts': 1,
          'overs': 2.1,
          'overCount': 3,
        },
        {
          'ballStatus': '1',
          'time': '07:13 PM',
          'score': 18,
          'wkts': 1,
          'overs': 2.2,
          'overCount': 3,
        },
        {
          'ballStatus': '4',
          'time': '07:14 PM',
          'score': 22,
          'wkts': 1,
          'overs': 2.3,
          'overCount': 3,
        },
        {
          'ballStatus': '1',
          'time': '07:15 PM',
          'score': 23,
          'wkts': 1,
          'overs': 2.4,
          'overCount': 3,
        },
        {
          'ballStatus': '6',
          'time': '07:16 PM',
          'score': 29,
          'wkts': 1,
          'overs': 2.5,
          'overCount': 3,
        },
        {
          'ballStatus': '1',
          'time': '07:17 PM',
          'score': 30,
          'wkts': 1,
          'overs': 2.6,
          'overCount': 3,
        },
      ]
    },
    {
      'overCount': 4,
      'runsInCurrentOver': 10,
      'wktsInCurrentOver': 0,
      'totalScore': 40,
      'totalWkts': 3,
      'balls': [
        {
          'ballStatus': '2',
          'time': '07:18 PM',
          'score': 32,
          'wkts': 1,
          'overs': 3.1,
          'overCount': 4,
        },
        {
          'ballStatus': '4',
          'time': '07:19 PM',
          'score': 36,
          'wkts': 1,
          'overs': 3.2,
          'overCount': 4,
        },
        {
          'ballStatus': '1',
          'time': '07:20 PM',
          'score': 37,
          'wkts': 1,
          'overs': 3.3,
          'overCount': 4,
        },
        {
          'ballStatus': '2',
          'time': '07:21 PM',
          'score': 39,
          'wkts': 1,
          'overs': 3.4,
          'overCount': 4,
        },
        {
          'ballStatus': '0',
          'time': '07:22 PM',
          'score': 39,
          'wkts': 1,
          'overs': 3.5,
          'overCount': 4,
        },
        {
          'ballStatus': '1',
          'time': '07:23 PM',
          'score': 40,
          'wkts': 1,
          'overs': 3.6,
          'overCount': 4,
        },
      ]
    },
    {
      'overCount': 5,
      'runsInCurrentOver': 15,
      'wktsInCurrentOver': 1,
      'totalScore': 55,
      'totalWkts': 4,
      'balls': [
        {
          'ballStatus': '1',
          'time': '07:24 PM',
          'score': 41,
          'wkts': 1,
          'overs': 4.1,
          'overCount': 5,
        },
        {
          'ballStatus': '2',
          'time': '07:25 PM',
          'score': 43,
          'wkts': 1,
          'overs': 4.2,
          'overCount': 5,
        },
        {
          'ballStatus': '1',
          'time': '07:26 PM',
          'score': 44,
          'wkts': 1,
          'overs': 4.3,
          'overCount': 5,
        },
        {
          'ballStatus': '4',
          'time': '07:27 PM',
          'score': 48,
          'wkts': 1,
          'overs': 4.4,
          'overCount': 5,
        },
        {
          'ballStatus': '6',
          'time': '07:28 PM',
          'score': 54,
          'wkts': 1,
          'overs': 4.5,
          'overCount': 5,
        },
        {
          'ballStatus': '1',
          'time': '07:29 PM',
          'score': 55,
          'wkts': 1,
          'overs': 4.6,
          'overCount': 5,
        },
      ]
    },
  ];

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
        bottom: PreferredSize(preferredSize: const Size.fromHeight(65), child: _buildTabBar(context)),
      ),
      body: TabBarView(
          controller: _tabController,
          children: [
          SingleChildScrollView(
            child: Column(
            children: [
              const SizedBox(height: 10,),
            _secTabBar(),
            _selectedTabContentSec(widget.team1Name),
                  ],
              ),
          ),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  _secTabBar(),
                  _selectedTabContentSec(widget.team2Name),
                ],
              ),
            )
          ]),
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
              "1st inning",
            ),
          ),
          Tab(
            child: Text(
              "2nd inning",
            ),
          ),
        ],
      ),
    );
  }

 
  

  Widget _selectedTabContentSec(String teamName) {
    switch (_selectedIndexSec) {
      case 0:
        return _myPlayingXIWidget();
      case 1:
        return _myContent(teamName);
      case 2:
        return _myStatsWidget(teamName);
      default:
        return _myContent(teamName);
    }
  }

  Widget _tabItemSec({required String text, required int index, required int selectedIndex, required String imgPath, required VoidCallback onTap,}) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: 20,
              child: Image.asset(
                imgPath,
                color: index == selectedIndex ? Colors.white : Colors.grey,
              )),
          Text(
            text,
            style: GoogleFonts.getFont(
              'Poppins',
              color: index == selectedIndex ? Colors.white : Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _secTabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Expanded(
                child: _tabItemSec(
              text: 'Playing XI',
              index: 0,
              selectedIndex: _selectedIndexSec,
              imgPath: ImageConstant.imgCricketHelmet,
              onTap: () {
                setState(() {
                  _selectedIndexSec = 0;
                });
              },
            )),
            Expanded(
                child: _tabItemSec(
              text: 'Match Odd',
              index: 1,
              selectedIndex: _selectedIndexSec,
              imgPath: ImageConstant.imgCricketWicket,
              onTap: () {
                setState(() {
                  _selectedIndexSec = 1;
                });
              },
            )),
            Expanded(
                child: _tabItemSec(
              text: 'Stats',
              index: 2,
              selectedIndex: _selectedIndexSec,
              imgPath: ImageConstant.imgCricketStats,
              onTap: () {
                setState(() {
                  _selectedIndexSec = 2;
                });
              },
            )),
          ],
        ),
      ),
    );
  }

  Widget _myContent(String teamName) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            itemCount: dummyData.length,
            itemBuilder: (context, index) {
              final data = dummyData[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ExpandableContainer(data: data, teamName: teamName),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _myStatsWidget(String teamName) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.black, borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "$teamName innings",
                style: GoogleFonts.getFont('Poppins',
                    color: Colors.yellow, fontSize: 20),
              ),
              Text(
                "hdsdsndsndhsudsadasdsn dnskdjs\n dhsdhsahd  njhsjdwuidfhdbbjbcjhbcjas",
                style: GoogleFonts.getFont('Poppins', color: Colors.grey),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _myPlayingXIWidget() {
    return Center(
      child: Text(
        "Playing 11",
        style: CustomTextStyles.titleSmallPoppinsBlack900,
      ),
    );
  }
}
