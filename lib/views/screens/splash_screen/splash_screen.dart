import 'dart:convert';
import 'package:cricyard/core/utils/size_utils.dart';
import 'package:cricyard/views/screens/Login%20Screen/view/decision.dart';
import 'package:cricyard/views/screens/main_app_screen/tabbed_layout_component_f.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/utils/image_constant.dart';
import '../../../theme/theme_helper.dart';
import '../../widgets/custom_image_view.dart';
import '../MenuScreen/new_dash/Newdashboard.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  // var isLogin = false;
  //
  // Map<String, dynamic> userData = {};
  //
  // Future<void> checkifLogin() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   bool? isLoggedIn = prefs.getBool('isLoggedIn');
  //   var userdatastr = prefs.getString('userData');
  //
  //   if (kDebugMode) {
  //     print('userData....$userdatastr');
  //   }
  //   if (isLoggedIn != null && isLoggedIn) {
  //     setState(() {
  //       isLogin = true;
  //     });
  //   }
  //
  //   if (userdatastr != null) {
  //     try {
  //       userData = json.decode(userdatastr);
  //       if (kDebugMode) {
  //         print(userData['token']);
  //       }
  //     } catch (e) {
  //       if (kDebugMode) {
  //         print("error is ..................$e");
  //       }
  //     }
  //   } else {
  //     setState(() {
  //       isLogin = false;
  //     });
  //   }
  // }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 5)).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Newdashboard(),)));
    // checkifLogin().then((value) async => {
    //       Future.delayed(const Duration(seconds: 3), () {
    //         Navigator.pushReplacement(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) =>
    //                   isLogin ? Newdashboard() : const DecisionScreen()),
    //           // isLogin ? Dashboardcreen() : const LoginScreenF(false)),
    //         );
    //       })
    //     });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        backgroundColor: appTheme.black900,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            color: appTheme.black900,
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgLogin,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            height: 64,
            padding: EdgeInsets.symmetric(
              horizontal: 23.h,
              vertical: 83.v,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomImageView(
                  imagePath: ImageConstant.imgImageRemovebgPreview,
                  // height: 59.v,
                  // width: 382.h,
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.height * 0.98,
                ),
                const Spacer(
                  flex: 62,
                ),
                CustomImageView(
                  imagePath: ImageConstant.imgCricyard1,
                  // height: 251.v,
                  // width: 291.h,
                  height: MediaQuery.of(context).size.height * 0.45,
                  width: MediaQuery.of(context).size.height * 0.45,
                ),
                const Spacer(
                  flex: 37,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: SingleChildScrollView(
  //       child: SizedBox(
  //         width: MediaQuery.of(context).size.width,
  //         height: MediaQuery.of(context).size.height,
  //         child: Center(
  //           child: SvgPicture.asset(
  //             'assets/images/cloudnsuresp.svg',
  //             width: 100,
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
