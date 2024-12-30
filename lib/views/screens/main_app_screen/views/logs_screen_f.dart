import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../Utils/color_constants.dart';
import '../../../../Utils/size_utils.dart';
import '../../../widgets/app_bar/appbar_title.dart';
import '../../../widgets/app_bar/custom_app_bar.dart';

class LogsScreen extends StatefulWidget {
  const LogsScreen({
    super.key,
  });

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen>
    with SingleTickerProviderStateMixin {
  int _selectedTabIndex = 0;
  late TabController _tabController;

  Map<String, dynamic> userData = {};

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
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
    });
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(
          height: getVerticalSize(130),
          leadingWidth: 50,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(Icons.arrow_back)),
          centerTitle: true,

          title: AppbarTitle(text: "Logs"),
          //   actions: [
          // Text(
          // widget.project['projectName'],
          //     style: AppStyle.txtGilroySemiBold24.copyWith(
          //       color: ColorConstant.blueGray900,
          //     ),
          // ),
          // ],
          bottom: TabBar(
            controller: _tabController,
            labelPadding: EdgeInsets.zero,
            unselectedLabelColor: Colors.blue,
            labelColor: Colors.black,
            indicatorColor: ColorConstant.purple211,
            // indicatorSize: TabBarIndicatorSize.tab,
            // indicatorPadding: EdgeInsets.symmetric(horizontal:20),
            indicatorWeight: 5,
            tabs: [
              Tab(
                height: 50,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Color.fromARGB(255, 198, 183, 232),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Activity',
                        style: GoogleFonts.poppins().copyWith(
                            fontSize: 18,
                            color: _tabController.index == 0
                                ? ColorConstant.purple900
                                : Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Tab(
                height: 50,
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  color: Color.fromARGB(255, 198, 183, 232),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Suggestions',
                        style: GoogleFonts.poppins().copyWith(
                            fontSize: 18,
                            color: _tabController.index == 1
                                ? ColorConstant.purple900
                                : Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            // NotificationsScreenF(),
            // SuggestionsScreen(type: 'myproject', userData: userData)
          ],
        ),
      ),
    );
  }
}
