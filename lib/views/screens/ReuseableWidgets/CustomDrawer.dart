import 'dart:async';

import 'package:cricyard/core/app_export.dart';
import 'package:cricyard/views/screens/Login%20Screen/view/decision.dart';
// ignore_for_file: deprecated_member_use
import 'package:cricyard/views/screens/MenuScreen/find_friends_screen/find_friends_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/leaderboard_screen/leaderboard_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/live_cricket/live_cricket.dart';
import 'package:cricyard/views/screens/MenuScreen/teams_screen/TeamsScreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../resources/api_constants.dart';
import '../../widgets/custom_elevated_button.dart';
import '../Login Screen/view/login_screen_f.dart';
import '../LogoutService/Logoutservice.dart';
import '../MenuScreen/feedback_form/feedback.dart';
import '../MenuScreen/go_live_screen/go_live_screen.dart';
import '../MenuScreen/merch/screens/home_screen.dart';
import '../MenuScreen/profile_screen/views/profile_screen.dart';
import '../MenuScreen/tournament/views/tournamnetScreen.dart';
import '../practice_match/view/practice_match_home_View.dart';
import '../profileManagement/change_password_f.dart';

// Define custom theme for button color
final ThemeData drawerButtonTheme = ThemeData(
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor:
          MaterialStateProperty.all<Color>(Colors.black), // Example color
    ),
  ),
);

class CustomDrawer extends StatefulWidget {
  final BuildContext context;
  CustomDrawer({super.key, required this.context});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  void getLoginState() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      isLogin = prefs.getBool('isLoggedIn') ?? false;
      isGuest = isLogin ? false : true;
    });
    print("LoginState-$isLogin");
  }

  var isLogin = false;
  var isGuest = true;

  @override
  void initState() {
    // TODO: implement initState
    getLoginState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: drawerButtonTheme, // Custom theme for buttons
      child: Drawer(
        backgroundColor: Colors.blue[50],
        width: MediaQuery.of(context).size.width * 80 / 100,
        child: Container(
          padding: EdgeInsets.only(left: 15.v),
          child: ListView(
            children: [
              SizedBox(
                height: 100,
                child: DrawerHeader(
                  child: SizedBox(
                    height: 50,
                    child: Image.asset(
                      ImageConstant.imgImageRemovebgPreview,
                      scale: 4,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 19.v),
              _buildSwitch(),
              SizedBox(height: 19.v),
              _myButton(
                context,
                "Practice Match",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PracticeMatchHomeScreen(),
                    ),
                  );
                },
                false,
              ),
              SizedBox(height: 23.v),
              _myButton(
                context,
                "Profile Setting",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Profile_Screen(),
                    ),
                  );
                },
                true,
              ),
              SizedBox(height: 18.v),
              _myButton(
                context,
                "Change Password",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ResetPasswordScreenF(),
                    ),
                  );
                },
                true,
              ),
              SizedBox(height: 18.v),
              _myButton(
                context,
                "Leaderboard",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeaderboardScreen(),
                    ),
                  );
                },
                true,
              ),
              SizedBox(height: 23.v),
              _myButton(
                context,
                "Go Live",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GoLiveScreen(),
                    ),
                  );
                },
                true,
              ),
              SizedBox(height: 23.v),
              _myButton(
                context,
                "Live Cricket",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LiveCricketScreen(),
                    ),
                  );
                },
                true,
              ),
              SizedBox(height: 23.v),
              _myButton(
                context,
                "My Tournaments",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TournamnetScreen(),
                    ),
                  );
                },
                true,
              ),
              SizedBox(height: 23.v),
              _myButton(
                context,
                "My Teams",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TeamsSubScreen(),
                    ),
                  );
                },
                true,
              ),
              SizedBox(height: 23.v),
              _myButton(
                context,
                "My Highlight",
                () {},
                true,
              ),
              SizedBox(height: 23.v),
              _myButton(
                context,
                "Change Language",
                () {},
                true,
              ),
              SizedBox(height: 18.v),
              _myButton(
                context,
                "Community",
                () {},
                true,
              ),
              SizedBox(height: 18.v),
              _myButton(
                context,
                "Find Friends",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FindFriendsScreen(),
                    ),
                  );
                },
                true,
              ),
              SizedBox(height: 18.v),
              _myButton(
                context,
                "Feedback",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => feedbackScreen(),
                    ),
                  );
                },
                true,
              ),
              SizedBox(height: 18.v),
              _myButton(
                context,
                "Merch",
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ProductHomeScreen(),
                    ),
                  );
                },
                false,
              ),
              SizedBox(height: 21.v),
              _myButton(
                context,
                "Logout",
                () => _logoutUser(context),
                true,
              ),
              SizedBox(height: 18.v),
            ],
          ),
        ),
      ),
    );
  }

  Widget _myButton1(BuildContext context, String title, VoidCallback onTap) {
    return CustomElevatedButton(
        text: title,
        margin: EdgeInsets.only(right: 20.h, left: 20.h),
        onPressed: onTap);
  }

  Widget _myButton(BuildContext context, String title, VoidCallback onTap,
      bool requiresLogin) {
    return CustomElevatedButton(
      text: title,
      margin: EdgeInsets.only(right: 20.h, left: 20.h),
      onPressed: () {
        if (requiresLogin && !isLogin) {
          showAlert(widget.context, 'Please login to access this feature');
        } else {
          onTap();
        }
      },
    );
  }

  void showSnackBar(BuildContext context, String msg, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          msg,
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: color,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void showAlert(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Oops!!"),
          content: Text(
            message,
            style: GoogleFonts.getFont('Poppins', color: Colors.black),
          ),
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
                      builder: (context) => const DecisionScreen(),
                    ));
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

      // Remove 'userData' and 'isLoggedIn' from SharedPreferences
      await prefs.remove('userData');
      await prefs.remove('isLoggedIn');
      String logouturl = "${ApiConstants.baseUrl}/token/logout";
      var response = await http.get(Uri.parse(logouturl));
      if (response.statusCode == 401) {
        LogoutService.logout();
      }
      if (response.statusCode <= 209) {
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreenF(false)),
          (route) => false, // Remove all routes from the stack
        );
      } else {
        const Text('failed to logout');
      }
    } catch (error) {
      print('Error occurred during logout: $error');
    }
  }

  Widget _buildSwitch() {
    return SwitchListTile(
      title: Text(!isGuest ? 'Pro' : 'Lite'),
      value: !isGuest,
      onChanged: (bool value) {
        setState(() {
          isGuest = !value;
        });
        if (isLogin == false) {
          Navigator.pop(context);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DecisionScreen(),
              ));
        }
      },
    );
  }
}
