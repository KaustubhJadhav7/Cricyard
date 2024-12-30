import 'dart:convert';

import 'package:cricyard/views/screens/profileManagement/contact_us_f.dart';
import 'package:cricyard/views/screens/profileManagement/policy_details_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../Utils/color_constants.dart';
import '../../../Utils/image_constant.dart';
import '../../../Utils/size_utils.dart';
import '../../../theme/app_style.dart';
import '../../widgets/app_bar/appbar_image.dart';
import '../../widgets/app_bar/appbar_title.dart';
import '../../widgets/app_bar/custom_app_bar.dart';

class AboutScreen extends StatefulWidget {
  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen>
    with SingleTickerProviderStateMixin {
  Map<String, dynamic> userData = {};

  var _selectedTabIndex = 0;
  final Map<String, dynamic> formData = {};

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
    getUserData();
  }

  Widget About = Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset(
          'assets/images/Transparent .png',
          height: 200,
          width: 200,
          alignment: Alignment.center,
        ),
        const SizedBox(
          height: 100,
        ),
        Text(
          'About Us',
          style: AppStyle.fieldlabel.copyWith(fontSize: 24),
        ),
        const SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Text(
            'Create a new project if you have access, if you don\'t have access, then contact the admin.',
            textAlign: TextAlign.center,
            style: AppStyle.fieldlabel.copyWith(color: ColorConstant.purple900),
          ),
        ),
      ],
    ),
  );

  Widget HelpCenter = Center(
    child: Text(
      'Help Center',
      style: GoogleFonts.poppins().copyWith(
          fontSize: 24,
          color: ColorConstant.purple900,
          fontWeight: FontWeight.w700),
    ),
  );

  late TabController _tabController;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
          appBar: CustomAppBar(
            height: getVerticalSize(130),
            leadingWidth: 40,
            leading: AppbarImage(
                height: getSize(24),
                width: getSize(24),
                svgPath: ImageConstant.imgArrowleftBlueGray900,
                margin: getMargin(left: 16, top: 12, bottom: 13),
                onTap: () {
                  Navigator.pop(context);
                }),
            centerTitle: true,
            title: AppbarTitle(text: "About Us"),
            bottom: TabBar(controller: _tabController, tabs: [
              Tab(
                child: Text(
                  "About",
                  style: GoogleFonts.poppins().copyWith(
                      color: _tabController.index == 0
                          ? ColorConstant.purple900
                          : Colors.black54,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Tab(
                child: Text(
                  "Help Center",
                  style: GoogleFonts.poppins().copyWith(
                      color: _tabController.index == 1
                          ? ColorConstant.purple900
                          : Colors.black54,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Tab(
                child: Text(
                  "Contact Us",
                  style: GoogleFonts.poppins().copyWith(
                      color: _tabController.index == 2
                          ? ColorConstant.purple900
                          : Colors.black54,
                      fontWeight: FontWeight.w700),
                ),
              ),
              Tab(
                child: Text(
                  "Policies",
                  style: GoogleFonts.poppins().copyWith(
                      color: _tabController.index == 3
                          ? ColorConstant.purple900
                          : Colors.black54,
                      fontWeight: FontWeight.w700),
                ),
              )
            ]),
          ),
          body: TabBarView(controller: _tabController, children: [
            About,
            HelpCenter,
            ContactUsScreenF(),
            Column(
              children: [
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (ctx) => PolicyDetails(
                              data: 'data', title: 'Privacy Policy')));
                    },
                    child: Text('Privacy Policy'))
              ],
            )
          ])),
    );
  }
}
