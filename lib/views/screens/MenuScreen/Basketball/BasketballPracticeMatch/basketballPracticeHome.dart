import 'package:cricyard/views/screens/MenuScreen/Basketball/BasketballPracticeMatch/createBasketballPractice.dart';
import 'package:cricyard/views/screens/MenuScreen/Football/views/FootballPracticeMatch/createFootballPractice.dart';
import 'package:cricyard/views/screens/MenuScreen/new_dash/Newdashboard.dart';
import 'package:cricyard/views/screens/practice_match/view/archived_matches_view.dart';
import 'package:cricyard/views/screens/practice_match/view/create_practice_match_view.dart';
import 'package:cricyard/views/screens/practice_match/view/practice_history_view.dart';
import 'package:cricyard/views/screens/practice_match/view/practice_teams_view.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BasketballPracticeMatchHomeScreen extends StatefulWidget {
  const BasketballPracticeMatchHomeScreen({super.key});

  @override
  State<BasketballPracticeMatchHomeScreen> createState() =>
      _BasketballPracticeMatchHomeScreenState();
}

class _BasketballPracticeMatchHomeScreenState
    extends State<BasketballPracticeMatchHomeScreen> {
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = <Widget>[
    const CreateBasketballPracticeMatch(),
    const PracticeTeamsView(),
    PracticeHistoryView()
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        elevation: 0,
        forceMaterialTransparency: true,
        backgroundColor: Colors.grey[200],
        leading: GestureDetector(
          onTap: () {
            // Navigator.pop(context);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Newdashboard(),
              ),
            );
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
        title: Text(
          "Basketball Practice Match",
          style:
              GoogleFonts.getFont('Poppins', fontSize: 20, color: Colors.black),
        ),
        actions: [
          _selectedIndex == 2
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => archivedMatchesView(),
                        ));
                  },
                  icon: Icon(Icons.archive_sharp))
              : Container()
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 0,
        backgroundColor: Colors.grey[200],
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Create',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.accessibility_new_sharp),
            label: 'Teams',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF219ebc),
        onTap: _onItemTapped,
      ),
    );
  }
}
