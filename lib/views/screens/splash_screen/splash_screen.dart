import 'dart:convert';
import 'package:cricyard/core/utils/size_utils.dart';
import 'package:cricyard/views/screens/Login%20Screen/view/decision.dart';
import 'package:cricyard/views/screens/SportSelection/view/sportSelection.dart';
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
  @override
  void initState() {
    super.initState();
    _checkSportSelection();
    // Future.delayed(Duration(seconds: 5)).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Newdashboard(),)));
    // Future.delayed(Duration(seconds: 5)).then((value) => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SportSelectionScreen())));
  }

  Future<void> _checkSportSelection() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? selectedSport = prefs.getString('preferred_sport');
    print('My sport is: $selectedSport');

    if (selectedSport != null) {
      // Sport is selected, navigate directly to the dashboard or home screen
      Future.delayed(Duration(seconds: 5))
          .then((value) => Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Newdashboard()),
              ));
    } else {
      // No sport selected, navigate to the sport selection screen
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) => SportSelectionScreen()),
      // );
      Future.delayed(Duration(seconds: 5)).then((value) =>
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => SportSelectionScreen())));
    }
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
}
