import 'package:cricyard/views/screens/MenuScreen/leaderboard_screen/frag/component/myListTile.dart';
import 'package:flutter/material.dart';

class BoxLeaderboardFrag extends StatefulWidget {
  const BoxLeaderboardFrag({super.key});

  @override
  State<BoxLeaderboardFrag> createState() => _BoxLeaderboardFragState();
}

class _BoxLeaderboardFragState extends State<BoxLeaderboardFrag> {
  int _selectedIndex = 0;

  List<Map<String, dynamic>> playerData = [
    {
      "title": "Player 1",
      "Inn": "50",
      "Runs": "1500",
      "Avg": "30.00",
      "SR": "120.00",
      "rank": "10",
      "img": '', // You can provide an image URL here if needed
    },
    {
      "title": "Player 2",
      "Inn": "45",
      "Runs": "1400",
      "Avg": "31.11",
      "SR": "118.00",
      "rank": "9",
      "img": '', // You can provide an image URL here if needed
    },
    {
      "title": "Player 3",
      "Inn": "48",
      "Runs": "1350",
      "Avg": "32.50",
      "SR": "115.00",
      "rank": "6",
      "img": '', // You can provide an image URL here if needed
    },
    {
      "title": "Player 4",
      "Inn": "55",
      "Runs": "1600",
      "Avg": "29.09",
      "SR": "122.00",
      "rank": "5",
      "img": '', // You can provide an image URL here if needed
    },
    {
      "title": "Player 5",
      "Inn": "52",
      "Runs": "1550",
      "Avg": "30.00",
      "SR": "121.00",
      "rank": "4",
      "img": '', // You can provide an image URL here if needed
    },
    {
      "title": "Player 6",
      "Inn": "49",
      "Runs": "1450",
      "Avg": "31.67",
      "SR": "119.00",
      "rank": "2",
      "img": '', // You can provide an image URL here if needed
    },
    {
      "title": "Player 7",
      "Inn": "51",
      "Runs": "1520",
      "Avg": "29.80",
      "SR": "118.50",
      "rank": "7",
      "img": '', // You can provide an image URL here if needed
    },
    {
      "title": "Player 8",
      "Inn": "47",
      "Runs": "1420",
      "Avg": "31.91",
      "SR": "116.00",
      "rank": "8",
      "img": '', // You can provide an image URL here if needed
    },
    {
      "title": "Player 9",
      "Inn": "53",
      "Runs": "1570",
      "Avg": "30.00",
      "SR": "119.50",
      "rank": "3",
      "img": '', // You can provide an image URL here if needed
    },
    {
      "title": "Player 10",
      "Inn": "46",
      "Runs": "1380",
      "Avg": "32.00",
      "SR": "117.00",
      "rank": "1",
      "img": '', // You can provide an image URL here if needed
    },
  ];
  List<Map<String, dynamic>> bowlingData = [
    {
      "title": "Player 1",
      "Inn": "50",
      "W": "85",
      "Eco": "3.50",
      "SR": "30.00",
      "rank": "10",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 2",
      "Inn": "45",
      "W": "75",
      "Eco": "3.40",
      "SR": "32.00",
      "rank": "9",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 3",
      "Inn": "48",
      "W": "80",
      "Eco": "3.45",
      "SR": "31.50",
      "rank": "6",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 4",
      "Inn": "55",
      "W": "95",
      "Eco": "3.55",
      "SR": "29.00",
      "rank": "5",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 5",
      "Inn": "52",
      "W": "90",
      "Eco": "3.60",
      "SR": "29.50",
      "rank": "4",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 6",
      "Inn": "49",
      "W": "82",
      "Eco": "3.55",
      "SR": "30.50",
      "rank": "2",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 7",
      "Inn": "51",
      "W": "87",
      "Eco": "3.50",
      "SR": "31.00",
      "rank": "7",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 8",
      "Inn": "47",
      "W": "78",
      "Eco": "3.48",
      "SR": "32.50",
      "rank": "8",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 9",
      "Inn": "53",
      "W": "88",
      "Eco": "3.52",
      "SR": "30.00",
      "rank": "3",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 10",
      "Inn": "46",
      "W": "79",
      "Eco": "3.46",
      "SR": "32.00",
      "rank": "1",
      "img": '', // Provide an image URL if needed
    },
  ];
  List<Map<String, dynamic>> fieldingData = [
    {
      "title": "Player 1",
      "Mat": "50",
      "Dismissals": "25",
      "Catches": "20",
      "St": "5",
      "rank": "10",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 2",
      "Mat": "45",
      "Dismissals": "23",
      "Catches": "18",
      "St": "5",
      "rank": "9",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 3",
      "Mat": "48",
      "Dismissals": "24",
      "Catches": "19",
      "St": "5",
      "rank": "6",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 4",
      "Mat": "55",
      "Dismissals": "27",
      "Catches": "21",
      "St": "6",
      "rank": "5",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 5",
      "Mat": "52",
      "Dismissals": "26",
      "Catches": "20",
      "St": "6",
      "rank": "4",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 6",
      "Mat": "49",
      "Dismissals": "24",
      "Catches": "19",
      "St": "5",
      "rank": "2",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 7",
      "Mat": "51",
      "Dismissals": "25",
      "Catches": "20",
      "St": "5",
      "rank": "7",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 8",
      "Mat": "47",
      "Dismissals": "23",
      "Catches": "18",
      "St": "5",
      "rank": "8",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 9",
      "Mat": "53",
      "Dismissals": "26",
      "Catches": "20",
      "St": "6",
      "rank": "3",
      "img": '', // Provide an image URL if needed
    },
    {
      "title": "Player 10",
      "Mat": "46",
      "Dismissals": "22",
      "Catches": "17",
      "St": "5",
      "rank": "1",
      "img": '', // Provide an image URL if needed
    },
  ];





  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Column(
        children: [
          const SizedBox(height: 10,),
          Container(
            height: MediaQuery.of(context).size.height*0.07,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildTabItem(0, 'Batting'),
                const SizedBox(width: 10,),
                _buildTabItem(1, 'Bowling'),
                const SizedBox(width: 10,),
                _buildTabItem(2, 'Fielding'),
              ],
            ),
          ),
          const SizedBox(height: 5,),

          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabItem(int index, String label) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () => _onTabTapped(index),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: isSelected ?const Color(0xFF219ebc) : Colors.grey[300],
          borderRadius: BorderRadius.circular(25),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (_selectedIndex) {
      case 0:
        return ListView.builder(
          itemCount: playerData.length,
          itemBuilder: (context, index) {
            playerData.sort((a, b) => int.parse(a['rank']).compareTo(int.parse(b['rank'])));

            final data = playerData[index];
            return MyLeaderboardListTile(type: 'Batting', title: data['title'], subTitle1: data['Inn'], subTitle2: data['Runs'], subTitle3: data['Avg'], subTitle4: data['SR'], rank: data['rank'], img: data['img']);
          },);
      case 1:
        return ListView.builder(
          itemCount: bowlingData.length,
          itemBuilder: (context, index) {
            bowlingData.sort((a, b) => int.parse(a['rank']).compareTo(int.parse(b['rank'])));

            final data = bowlingData[index];
            return MyLeaderboardListTile(type: 'Bowling', title: data['title'], subTitle1: data['Inn'], subTitle2: data['W'], subTitle3: data['Eco'], subTitle4: data['SR'], rank: data['rank'], img: data['img']);
          },);
      case 2:
        return ListView.builder(
          itemCount: fieldingData.length,
          itemBuilder: (context, index) {
            fieldingData.sort((a, b) => int.parse(a['rank']).compareTo(int.parse(b['rank'])));

            final data = fieldingData[index];
            return MyLeaderboardListTile(type: 'Fielding', title: data['title'], subTitle1: data['Mat'], subTitle2: data['Dismissals'], subTitle3: data['Catches'], subTitle4: data['St'], rank: data['rank'], img: data['img']);
          },);
      default:
        return const Center(child: Text('Batting Stats'));
    }
  }
}
