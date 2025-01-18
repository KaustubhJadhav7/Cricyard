import 'dart:convert';
import 'dart:typed_data' as typed_data; // Import 'dart:typed_data' with prefix

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cricyard/resources/api_constants.dart';
import 'package:http/http.dart' as http;
import 'package:cricyard/views/screens/MenuScreen/profile_screen/views/profile_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/leaderboard_screen/leaderboard_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/go_live_screen/go_live_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/live_cricket/live_cricket.dart';
import 'package:cricyard/views/screens/MenuScreen/tournament/views/tournamnetScreen.dart';
import 'package:cricyard/views/screens/MenuScreen/teams_screen/TeamsScreen.dart';
import 'package:cricyard/views/screens/MenuScreen/find_friends_screen/find_friends_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/feedback_form/feedback.dart';
import 'package:cricyard/views/screens/MenuScreen/merch/screens/home_screen.dart';
import 'package:cricyard/views/screens/Login%20Screen/view/decision.dart';
import 'package:cricyard/views/screens/Login%20Screen/view/login_screen_f.dart';

import '../../../providers/token_manager.dart';
import '../LogoutService/Logoutservice.dart';
import '../practice_match/view/practice_match_home_View.dart';
import '../profileManagement/change_password_f.dart';

class NewDrawer extends StatefulWidget {
  final BuildContext context;
  NewDrawer({super.key, required this.context});

  @override
  State<NewDrawer> createState() => _NewDrawerState();
}

class _NewDrawerState extends State<NewDrawer> {
  var isLogin = false;
  var isGuest = true;
  typed_data.Uint8List? _imageBytes;
  bool isLoading = false;

  @override
  void initState() {
    getLoginState();
    fetchProfileImageData();
    super.initState();
  }

  void getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = prefs.getBool('isLoggedIn') ?? false;
      isGuest = isLogin ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          _createHeader(),
          _createDrawerItem(
            icon: Icons.sports_cricket,
            text: 'Practice Match',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PracticeMatchHomeScreen(),
                ),
              );
            },
          ),
          _createDrawerItem(
            icon: Icons.person,
            text: 'Profile Setting',
            onTap: () {
              if (isGuest) {
                showLoginAlert(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Profile_Screen(),
                  ),
                );
              }
            },
          ),
          _createDrawerItem(
            icon: Icons.lock,
            text: 'Change Password',
            onTap: () {
              if (isGuest) {
                showLoginAlert(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResetPasswordScreenF(),
                  ),
                );
              }
            },
          ),
          _createDrawerItem(
            icon: Icons.leaderboard,
            text: 'Leaderboard',
            onTap: () {
              if (isGuest) {
                showLoginAlert(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LeaderboardScreen(),
                  ),
                );
              }
            },
          ),
          _createDrawerItem(
            icon: Icons.live_tv,
            text: 'Go Live',
            onTap: () {
              if (isGuest) {
                showLoginAlert(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GoLiveScreen(),
                  ),
                );
              }
            },
          ),
          _createDrawerItem(
            icon: Icons.live_tv_rounded,
            text: 'Live Cricket',
            onTap: () {
              if (isGuest) {
                showLoginAlert(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LiveCricketScreen(),
                  ),
                );
              }
            },
          ),
          _createDrawerItem(
            icon: Icons.sports,
            text: 'My Tournaments',
            onTap: () {
              if (isGuest) {
                showLoginAlert(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TournamnetScreen(),
                  ),
                );
              }
            },
          ),
          _createDrawerItem(
            icon: Icons.people,
            text: 'My Teams',
            onTap: () {
              if (isGuest) {
                showLoginAlert(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TeamsSubScreen(),
                  ),
                );
              }
            },
          ),
          _createDrawerItem(
            icon: Icons.highlight,
            text: 'My Highlight',
            onTap: () {
              if (isGuest) {
                showLoginAlert(context);
              } // Handle action
            },
          ),
          _createDrawerItem(
            icon: Icons.language,
            text: 'Change Language',
            onTap: () {
              if (isGuest) {
                showLoginAlert(context);
              } // Handle action
            },
          ),
          _createDrawerItem(
            icon: Icons.group,
            text: 'Community',
            onTap: () {
              if (isGuest) {
                showLoginAlert(context);
              } // Handle action
            },
          ),
          _createDrawerItem(
            icon: Icons.person_add,
            text: 'Find Friends',
            onTap: () {
              if (isGuest) {
                showLoginAlert(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FindFriendsScreen(),
                  ),
                );
              }
            },
          ),
          _createDrawerItem(
            icon: Icons.feedback,
            text: 'Feedback',
            onTap: () {
              if (isGuest) {
                showLoginAlert(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => feedbackScreen(),
                  ),
                );
              }
            },
          ),
          _createDrawerItem(
            icon: Icons.store,
            text: 'Merch',
            onTap: () {
              if (isGuest) {
                showLoginAlert(context);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ProductHomeScreen(),
                  ),
                );
              }
            },
          ),
          _createDrawerItem(
            icon: isGuest ? Icons.login : Icons.logout,
            text: isGuest ? 'Login' : 'Logout',
            onTap: () {
              if (isGuest) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreenF(false),
                  ),
                );
              } else {
                _logoutUser(context);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.25,
      decoration: const BoxDecoration(
        color: Color(0xFF219ebc),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            CircleAvatar(
                radius: 70,
                backgroundImage: _imageBytes != null
                    ? MemoryImage(_imageBytes!)
                    : const NetworkImage(
                            'https://media.istockphoto.com/id/1332100919/vector/man-icon-black-icon-person-symbol.jpg?s=612x612&w=0&k=20&c=AVVJkvxQQCuBhawHrUhDRTCeNQ3Jgt0K1tXjJsFy1eg=')
                        as ImageProvider),
            const SizedBox(height: 10),
            Text(
              'Welcome',
              style: GoogleFonts.poppins(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createDrawerItem({
    required IconData icon,
    required String text,
    required GestureTapCallback onTap,
  }) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: [
              Icon(icon, color: const Color(0xFF219ebc)),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child:
                    Text(text, style: GoogleFonts.poppins(color: Colors.black)),
              ),
            ],
          ),
          const Icon(Icons.arrow_forward_ios_outlined,
              color: Color(0xFF219ebc), size: 12)
        ],
      ),
      onTap: onTap,
    );
  }

  void showLoginAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Oops!!"),
          content: Text('Please login to access this feature',
              style: GoogleFonts.getFont('Poppins', color: Colors.black)),
          actions: <Widget>[
            TextButton(
              child: const Text("CANCEL"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("LOGIN NOW"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const DecisionScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _logoutUser(BuildContext context) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('userData');
      await prefs.remove('isLoggedIn');
      String logoutUrl = "${ApiConstants.baseUrl}/token/logout";
      var response = await http.get(Uri.parse(logoutUrl));
      if (response.statusCode <= 209) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreenF(false)),
          (route) => false,
        );
      } else {
        // Handle error cases
      }
    } catch (error) {
      print('Error occurred during logout: $error');
    }
  }

  Future<void> fetchProfileImageData() async {
    setState(() {
      isLoading = true;
    });
    final token = await TokenManager.getToken();
    const String baseUrl = ApiConstants.baseUrl;
    const String apiUrl = '$baseUrl/api/retrieve-image';

    // print('Image URL: $apiUrl');
    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 401) {
        LogoutService.logout();
      }
      if (response.statusCode >= 200 && response.statusCode <= 209) {
        String responseData =
            response.body.replaceAll('"}', ''); // Remove trailing '"}'
        // print("Response: $responseData");
        // Find the index of the comma (",") after the prefix
        final commaIndex = responseData.indexOf(',');
        if (commaIndex != -1) {
          final imageData = responseData.substring(commaIndex + 1);
          // Decode base64-encoded image data
          final bytes = base64Decode(imageData);
          setState(() {
            _imageBytes = bytes;
          });
          print('Image data is decoded.');
        } else {
          print('Invalid image data format');
        }
      } else {
        print('Failed to load image data: ${response.statusCode}');
      }
      setState(() {
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching image data: $e');
    }
  }
}
