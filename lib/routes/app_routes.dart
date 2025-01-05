import 'dart:convert';
import 'package:cricyard/views/screens/MenuScreen/profile_screen/views/profile_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/tournament/my_tournamnet_screen/my_tournamnet_screen.dart';
import 'package:cricyard/views/screens/MenuScreen/tournament/views/tournamnetScreen.dart';
import 'package:cricyard/views/screens/splash_screen/splash_screen.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../views/screens/Login Screen/view/login_one_screen.dart';
import '../views/screens/MenuScreen/Matches/views/matches.dart';
import '../views/screens/MenuScreen/Matches/views/score_counting.dart';
import '../views/screens/MenuScreen/NewStreamFolder/VideoPlayer/VideoPlayerWidget.dart';

import '../views/screens/MenuScreen/Notification/GetAllNotification.dart';
import '../views/screens/MenuScreen/Notification/GetNotification.dart';

import '../views/screens/MenuScreen/go_live_screen/go_live_screen.dart';
import '../views/screens/MenuScreen/go_live_screen/live_cricket_fixture.dart';
import '../views/screens/MenuScreen/go_live_screen/live_cricket_points_table.dart';
import '../views/screens/MenuScreen/go_live_screen/live_cricket_team_1.dart';
import '../views/screens/MenuScreen/go_live_screen/live_cricketst_innings.dart';
import '../views/screens/MenuScreen/new_dash/Newdashboard.dart';
import '../views/screens/MenuScreen/profile_screen/views/pro_setting_screen.dart';
import '../views/screens/MenuScreen/profile_screen/views/profile_edit1.dart';
import '../views/screens/MenuScreen/profile_screen/views/setting_screen.dart';
import '../views/screens/MenuScreen/teams_screen/teamView/InvitePlayer_view.dart';
import '../views/screens/MenuScreen/teams_screen/my_teams_screen.dart';
import '../views/screens/MenuScreen/tournament/views/inviteTeam_screen.dart';
import '../views/screens/profileManagement/profile_settings_f.dart';
import '../views/screens/signupF/create_account_f.dart';
import '../views/screens/signupF/registration_details_f.dart';

class AppRoutes {
  Map<String, dynamic> userData = {};
  var isLogin = false;

  Future<void> checkifLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    var userdatastr = prefs.getString('userData');

    if (kDebugMode) {
      print('userData....$userdatastr');
    }

    if (userdatastr != null) {
      try {
        userData = json.decode(userdatastr);
        if (kDebugMode) {
          print(userData['token']);
        }
      } catch (e) {
        if (kDebugMode) {
          print("error is ..................$e");
        }
      }
    }
  }

  static const String loginScreen = '/login_screen';

  static const String loginOneScreen = '/login_one_screen';

  static const String loginTwoScreen = '/login_two_screen';

  static const String loginFourScreen = '/login_four_screen';

  static const String appNavigationScreen = '/app_navigation_screen';

  static const String initialRoute = '/initialRoute';
  static const String splashscreen = '/splash';
  static const String forgotPasswordscreen = '/forgotPassword';
  static const String profilescreen = '/profilescreen';
  static const String dashboard = '/dashboard';
  static const String slide = '/slide';
  static const String tab = '/tab';
  static const String tournament = '/tournament';
  static const String registration = '/registration';
  static const String live = '/live';
  // ignore: constant_identifier_names
  static const String profile_edit1 = '/profile_edit1';

  static const String activityscreen = '/activity';
  static const String profilesettingscreen = '/profilesetting';
  // ignore: constant_identifier_names
  static const String pro_setting = '/pro_setting';
  // ignore: constant_identifier_names
  static const String change_lang_screen = '/change_lang';
  static const String share_app_screen = '/share_app';

  static const String setting_screen = '/setting';
  static const String profileScreen = '/profileScreen';

  static const String newdashboard = '/newdashboard';
  static const String myteam = '/myteam';
  static const String invitePlayer = '/invitePlayer';
  static const String inviteTeam = '/inviteTeam';
  static const String Fixturelive = '/fixturelive';
  static const String pointstable = '/pointstable';

  static const String allinings = '/allinings';
  static const String cricteam1 = '/cricteam';
  static const String notification = '/notification';
  static const String notification1 = '/notification1';
  static const String score = '/score';
  static const String scorecopy = '/scorecopy'; 
  static const String matches = '/matches';
  static const String rtc1 = '/rtc1';
  static const String rtc2 = '/rtc2';
  static const String rtc3 = '/rtc3';

  static const String python1 = '/python1';
  static const String redis1 = '/redis1';
  static const String redis2 = '/redis2';
  static const String redis3 = '/redis3';
  static const String redis4 = '/redis4';
  static const String redis5 = '/redis5';

  static const String redisclient = '/redisclient';
  static const String videoplayer = '/videoplayer';
  static const String account = '/account';

  static Map<String, WidgetBuilder> routes = {
    splashscreen: (context) => const SplashScreen(),
    videoplayer: (context) => const VideoPlayerWidget(),
    account: (context) => const CreateAccountF(),

    // redisclient: (context) => VideoFeedScreenPage2(),

    // redis1: (context) => RedisVideoStreamPage(),
    // redis2: (context) => VideoFeedScreenPage(),
    // redis4: (context) => VideoStreamWidget(),
    // redis5: (context) => VideoStreamPage2(),

    // python1: (context) => CameraCaptureScreen(),

    // rtc1: (context) => webrtc1(),
    // rtc2: (context) => Webrtc2(),
    // rtc3: (context) => mainStreamPage(),

    score: (context) => ScoreCounting(),
    matches: (context) => Matches(),

    notification: (context) => GetAllNotification(),
    notification1: (context) => InviteListWidget(),

    Fixturelive: (context) => LiveCricketFixture(),
    pointstable: (context) => LiveCricketPointsTable(),
    inviteTeam: (context) => InviteTeamScreen(1),
    allinings: (context) => LiveCricketstInnings(),
    cricteam1: (context) => LiveCricketTeam1(),
    invitePlayer: (context) => InvitePlayerView(6),

    myteam: (context) => MyTeamScreen(),

    newdashboard: (context) => Newdashboard(),
    loginOneScreen: (context) => LoginOneScreen(),
    // dashboard: (context) => Dashboardcreen(),
    tournament: (context) => MyTournamnetScreen(),
    live: (context) => GoLiveScreen(),

    // ignore: equal_keys_in_map
    profile_edit1: (context) => ProfileEditScreen1(),

    // activityscreen: (context) =>  ActivityScreen(),
    profileScreen: (context) => const Profile_Screen(),

    profilesettingscreen: (context) => ProfileSettingsScreenF(
          userData: {},
        ),
    // ignore: equal_keys_in_map
    pro_setting: (context) => Settings(),

    setting_screen: (context) => const SettingScreen(),
    registration: (context) =>
        RegstrationDetailsF(email: 'gauravrk215@gmail.com'),
  };
}
