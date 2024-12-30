// // ignore_for_file: deprecated_member_use

// import 'package:cricyard/core/utils/size_utils.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'dart:ui';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;

// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:readmore/readmore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../core/utils/image_constant.dart';
// import '../../providers/tab_navigation_provider.dart';
// import '../../providers/token_manager.dart';
// import '../../resources/api_constants.dart';
// import '../../theme/app_decoration.dart';
// import '../../theme/custom_text_style.dart';
// import '../../theme/theme_helper.dart';
// import '../../widgets/custom_elevated_button.dart';
// import '../../widgets/custom_floating_button.dart';
// import '../../widgets/custom_icon_button.dart';
// import '../../widgets/custom_image_view.dart';
// import '../Login Screen/login_screen_f.dart';
// import '../LogoutService/Logoutservice.dart';
// import '../profileManagement/change_password_f.dart';
// import '../profileManagement/profile_settings_f.dart';

// class TabbedLayoutComponentcopyF extends StatefulWidget {
//   TabbedLayoutComponentcopyF(this.userData, {super.key});
//   Map<String, dynamic> userData = {};
//   @override
//   _TabbedLayoutComponentcopyFState createState() =>
//       _TabbedLayoutComponentcopyFState();
// }

// class _TabbedLayoutComponentcopyFState
//     extends State<TabbedLayoutComponentcopyF> {
//   int _currentTab = 0;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   Map<String, dynamic> userData = {};

//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//     fetchData();
//     print('user data is ..$userData');
//   }

//   getUserData() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     var userdatastr = prefs.getString('userData');
//     if (userdatastr != null) {
//       try {
//         setState(() {
//           userData = json.decode(userdatastr);
//         });
//         print(userData['token']);
//       } catch (e) {
//         print("error is ..................$e");
//       }
//     }
//   }

//   void setTab(int index) {
//     setState(() {
//       _currentTab = index;
//     });
//   }

//   List<Map<String, dynamic>> notifications = [];

//   Future<void> fetchData() async {
//     String baseUrl = ApiConstants.baseUrl;
//     final apiUrl = '$baseUrl/notification/get_notification';
//     final token = await TokenManager.getToken();
//     final response = await http.get(
//       Uri.parse(apiUrl),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//     if (response.statusCode == 401) {
//       LogoutService.logout();
//     }
//     if (response.statusCode <= 209) {
//       final List<dynamic> data = jsonDecode(response.body);
//       setState(() {
//         notifications = data.cast<Map<String, dynamic>>();
//       });
//       print('notifications are $notifications');
//     } else {
//       // Handle errors
//       print('Failed to fetch data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final userAuthKey = TokenManager.getToken().toString();

//     print('user auth key is .....$userAuthKey');

//     return WillPopScope(
//       onWillPop: _onBackPress,
//       child: Scaffold(
//         key: _scaffoldKey,
//         bottomNavigationBar: _buildBottomAppBarStack(context),
//         floatingActionButton: CustomFloatingButton(
//           height: 64,
//           width: 64,
//           alignment: Alignment.topCenter,
//           child: CustomImageView(
//             svgPath: ImageConstant.imgLocation,
//             height: 32.0.v,
//             width: 32.0.h,
//           ),
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         drawer: Drawer(
//             backgroundColor: Color.fromARGB(182, 162, 241, 5),
//             width: MediaQuery.of(context).size.width * 80 / 100,
//             child: ListView(
//               children: [
//                 SizedBox(
//                   height: 200,
//                   child: DrawerHeader(
//                     child: Container(
//                       height: 130,
//                       width: 330,
//                       padding: const EdgeInsets.only(right: 3, left: 3),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Container(
//                                   padding: const EdgeInsets.all(5),
//                                   child: Row(
//                                     children: [
//                                       CustomImageView(
//                                         imagePath: ImageConstant.imgImage3,
//                                         height: 136.v,
//                                         width: 167.h,
//                                         radius: BorderRadius.circular(
//                                           5.h,
//                                         ),
//                                       ),
//                                       const SizedBox(
//                                         width: 5,
//                                       ),
//                                       Column(
//                                         crossAxisAlignment:
//                                             CrossAxisAlignment.start,
//                                         children: [
//                                           Container(
//                                             width: 121.h,
//                                             height: 35.h,
//                                             margin:
//                                                 EdgeInsets.only(right: 21.h),
//                                             padding: EdgeInsets.symmetric(
//                                               horizontal: 43.h,
//                                               vertical: 5.v,
//                                             ),
//                                             decoration: AppDecoration
//                                                 .fillPrimary
//                                                 .copyWith(
//                                               borderRadius: BorderRadiusStyle
//                                                   .roundedBorder15,
//                                             ),
//                                             child: Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.start,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 SizedBox(height: 2.v),
//                                                 Text(
//                                                   "Profile",
//                                                   style: CustomTextStyles
//                                                       .titleMediumWhiteA700,
//                                                 )
//                                               ],
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   )),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: 19.v),
//                 _buildleaderBoardButton(context),
//                 SizedBox(height: 23.v),
//                 _buildGoLiveButton(context),
//                 SizedBox(height: 23.v),
//                 _buildMyMatchesButton(context),
//                 SizedBox(height: 23.v),
//                 _buildMyTournamentsButton(context),
//                 SizedBox(height: 21.v),
//                 _buildMyHighlightsButton(context),
//                 SizedBox(height: 23.v),
//                 _buildChangeLanguageButton(context),
//                 SizedBox(height: 18.v),
//                 _buildCommunityButton(context),
//                 SizedBox(height: 18.v),
//                 _buildFindFriendsButton(context),
//                 SizedBox(height: 18.v),
//                 _buildLogoutButton(context),
//                 SizedBox(height: 18.v),
//                 // ListTile(
//                 //   iconColor: Colors.purple.shade900,
//                 //   leading: const Icon(
//                 //     Icons.arrow_upward,
//                 //   ),
//                 //   title: Text(
//                 //     'Raise a Ticket',
//                 //     style: AppStyle.txtpoppinsmedium16.copyWith(
//                 //         fontWeight: FontWeight.w700,
//                 //         color: Colors.purple.shade900),
//                 //   ),
//                 //   onTap: () {
//                 //     Navigator.push(
//                 //       context,
//                 //       MaterialPageRoute(
//                 //         builder: (context) => RaisedTicketScreen(
//                 //           userData: userData,
//                 //         ),
//                 //       ),
//                 //     );
//                 //   },
//                 // ),
//               ],
//             )),
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           toolbarHeight: 70,
//           // title: Text("io81.dev",
//           //     style: GoogleFonts.poppins().copyWith(
//           //         fontSize: 30,
//           //         fontWeight: FontWeight.bold,
//           //         color: const Color.fromARGB(255, 93, 63, 211))),
//         ),
//         backgroundColor: const Color(0xfffefefe),
//         extendBodyBehindAppBar: true,
//         //bottomNavigationBar: AppFooter(),
//         body: SizedBox(
//           width: double.maxFinite,
//           child: Column(
//             children: [
//               Container(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 15.h,
//                   vertical: 43.v,
//                 ),
//                 child: Column(
//                   children: [
//                     _buildTelevisionRow(context),
//                     SizedBox(height: 61.v),
//                     _buildOngoingStack(context),
//                     Divider(
//                       color: theme.colorScheme.primaryContainer,
//                       indent: 37.h,
//                       endIndent: 28.h,
//                     ),
//                     SizedBox(height: 9.v),
//                     Container(
//                       padding: EdgeInsets.symmetric(horizontal: 3.h),
//                       decoration: AppDecoration.fillGray700.copyWith(
//                         borderRadius: BorderRadiusStyle.roundedBorder10,
//                       ),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         mainAxisSize: MainAxisSize.min,
//                         children: [
//                           Container(
//                             margin: EdgeInsets.only(
//                               left: 1.h,
//                               top: 9.v,
//                               bottom: 4.v,
//                             ),
//                             decoration: AppDecoration.outlineBlack,
//                             child: Text(
//                               "Live SCORE ",
//                               style: theme.textTheme.bodySmall,
//                             ),
//                           ),
//                           CustomImageView(
//                             imagePath: ImageConstant.imgLive11,
//                             height: 32.adaptSize,
//                             width: 32.adaptSize,
//                           )
//                         ],
//                       ),
//                     ),
//                     SizedBox(height: 9.v),
//                     Container(
//                       width: 111.h,
//                       padding: EdgeInsets.symmetric(
//                         horizontal: 4.h,
//                         vertical: 5.v,
//                       ),
//                       decoration: AppDecoration.fillGray700.copyWith(
//                         borderRadius: BorderRadiusStyle.roundedBorder10,
//                       ),
//                       child: Text(
//                         "Fixtures/Results",
//                         style: CustomTextStyles.bodyMediumPoppinsBluegray50,
//                       ),
//                     ),
//                     SizedBox(height: 18.v),
//                     Divider(
//                       color: theme.colorScheme.primaryContainer,
//                       indent: 37.h,
//                       endIndent: 28.h,
//                     ),
//                     SizedBox(height: 6.v),
//                     Align(
//                       alignment: Alignment.centerLeft,
//                       child: Padding(
//                         padding: EdgeInsets.only(left: 40.h),
//                         child: Text(
//                           "Stories",
//                           style: CustomTextStyles.headlineLargeSemiBold,
//                         ),
//                       ),
//                     ),
//                     SizedBox(height: 5.v),
//                     CustomImageView(
//                       imagePath: ImageConstant.imgImage3,
//                       height: 125.v,
//                       width: 167.h,
//                       radius: BorderRadius.circular(
//                         5.h,
//                       ),
//                     ),
//                     SizedBox(height: 5.v),
//                     ReadMoreText(
//                       "Lucknow beat Punjab in RUN FEST",
//                       trimLines: 2,
//                       colorClickableText: appTheme.black900,
//                       trimMode: TrimMode.Line,
//                       trimCollapsedText: "Read more",
//                       moreStyle: CustomTextStyles.titleMediumBlack900Medium,
//                       lessStyle: CustomTextStyles.titleMediumBlack900Medium,
//                     )
//                   ],
//                 ),
//               ),
//               SizedBox(height: 8.v),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildleaderBoardButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "Leaderboard",
//       margin: EdgeInsets.only(right: 88.h),
//     );
//   }

//   /// Section Widget
//   Widget _buildGoLiveButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "Go Live",
//       margin: EdgeInsets.only(right: 88.h),
//     );
//   }

//   /// Section Widget
//   Widget _buildMyMatchesButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "My Matches",
//       margin: EdgeInsets.only(right: 88.h),
//     );
//   }

//   /// Section Widget
//   Widget _buildMyTournamentsButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "My Tournaments",
//       margin: EdgeInsets.only(right: 88.h),
//     );
//   }

//   /// Section Widget
//   Widget _buildMyHighlightsButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "My Highlights",
//       margin: EdgeInsets.only(right: 88.h),
//     );
//   }

//   /// Section Widget
//   Widget _buildChangeLanguageButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "Change language",
//       margin: EdgeInsets.only(right: 88.h),
//     );
//   }

//   /// Section Widget
//   Widget _buildCommunityButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "Community",
//       margin: EdgeInsets.only(right: 88.h),
//     );
//   }

//   /// Section Widget
//   Widget _buildFindFriendsButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "Find Friends",
//       margin: EdgeInsets.only(right: 88.h),
//     );
//   }

//   /// Section Widget
//   Widget _buildLogoutButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "Logout",
//       margin: EdgeInsets.only(right: 88.h),
//       onPressed: _logoutUser,
//     );
//   }

//   /// Section Widget
//   Widget _buildProfileSettingButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "Profile Settings",
//       margin: EdgeInsets.only(right: 88.h),
//       onPressed: () {
//         // Closes the drawer
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => ProfileSettingsScreenF(userData: userData),
//           ),
//         );
//         // Add your logic for menu 2 here
//       },
//     );
//   }

//   /// Section Widget
//   Widget _buildChangePasswordButton(BuildContext context) {
//     return CustomElevatedButton(
//       text: "Change Password",
//       margin: EdgeInsets.only(right: 88.h),
//       onPressed: () {
//         Navigator.push(context,
//             MaterialPageRoute(builder: (context) => ResetPasswordScreenF()));
//       },
//     );
//   }

//   Future<void> _logoutUser() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();

//       // Remove 'userData' and 'isLoggedIn' from SharedPreferences
//       await prefs.remove('userData');
//       await prefs.remove('isLoggedIn');
//       String logouturl = "${ApiConstants.baseUrl}/token/logout";
//       var response = await http.get(Uri.parse(logouturl));
//       if (response.statusCode == 401) {
//         LogoutService.logout();
//       }
//       if (response.statusCode <= 209) {
//         // ignore: use_build_context_synchronously
//         Navigator.pushAndRemoveUntil(
//           context,
//           MaterialPageRoute(builder: (context) => const LoginScreenF(false)),
//           (route) => false, // Remove all routes from the stack
//         );
//       } else {
//         const Text('failed to logout');
//       }
//     } catch (error) {
//       print('Error occurred during logout: $error');
//     }
//   }

//   void _onTabChange(int index) {
//     if (_currentTab == 1 || _currentTab == 2) {
//       FocusManager.instance.primaryFocus?.unfocus();
//     }
//     Provider.of<TabNavigationProvider>(context, listen: false)
//         .updateTabs(_currentTab);
//     setState(() {
//       _currentTab = index;
//     });
//   }

//   Future<bool> _onBackPress() {
//     if (_currentTab == 0) {
//       return Future.value(true);
//     } else {
//       int lastTab =
//           Provider.of<TabNavigationProvider>(context, listen: false).lastTab;
//       Provider.of<TabNavigationProvider>(context, listen: false)
//           .removeLastTab();
//       setTab(lastTab);
//     }
//     return Future.value(false);
//   }

//   //  Section Widget
//   Widget _buildTelevisionRow(BuildContext context) {
//     return GestureDetector(
//       child: Padding(
//         padding: EdgeInsets.only(left: 13.h),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: [
//             IconButton(
//                 icon: const Icon(
//                   Icons.circle_outlined,
//                   color: Colors.black,
//                 ),
//                 onPressed: () {}),
//             CustomImageView(
//               svgPath: ImageConstant.imgTelevision,
//               height: 24.adaptSize,
//               width: 24.adaptSize,
//               margin: EdgeInsets.only(
//                 top: 11.v,
//                 bottom: 2.v,
//               ),
//             ),
//             CustomImageView(
//               imagePath: ImageConstant.imgImageRemovebgPreview,
//               height: 35.v,
//               width: 272.h,
//               margin: EdgeInsets.only(
//                 left: 15.h,
//                 bottom: 2.v,
//               ),
//             ),
//             CustomImageView(
//               svgPath: ImageConstant.imgTelevisionPrimarycontainer,
//               height: 24.adaptSize,
//               width: 24.adaptSize,
//               margin: EdgeInsets.only(
//                 left: 15.h,
//                 top: 11.v,
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.only(
//                 left: 11.h,
//                 top: 11.v,
//                 bottom: 2.v,
//               ),
//               child: CustomIconButton(
//                 height: 24.adaptSize,
//                 width: 24.adaptSize,
//                 decoration: IconButtonStyleHelper.fillPrimaryContainer,
//                 child: CustomImageView(
//                   svgPath: ImageConstant.imgVector,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildOngoingStack(BuildContext context) {
//     return SizedBox(
//       height: 204.v,
//       width: 350.h,
//       child: Stack(
//         alignment: Alignment.bottomLeft,
//         children: [
//           Align(
//             alignment: Alignment.topCenter,
//             child: Text(
//               "Ongoing",
//               style: CustomTextStyles.headlineLargeSemiBold,
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Padding(
//               padding: EdgeInsets.only(
//                 left: 10.h,
//                 right: 191.h,
//                 bottom: 33.v,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       "4.3 Ov.",
//                       style: theme.textTheme.titleLarge,
//                     ),
//                   ),
//                   SizedBox(height: 5.v),
//                   Text(
//                     "Team 1",
//                     style: theme.textTheme.headlineSmall,
//                   )
//                 ],
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomLeft,
//             child: Padding(
//               padding: EdgeInsets.only(left: 80.h),
//               child: Text(
//                 "Run Rate 2.80",
//                 style: theme.textTheme.headlineSmall,
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.topLeft,
//             child: Padding(
//               padding: EdgeInsets.only(
//                 left: 96.h,
//                 top: 65.v,
//               ),
//               child: Text(
//                 "12/0-",
//                 style: theme.textTheme.titleLarge,
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.bottomRight,
//             child: Padding(
//               padding: EdgeInsets.only(
//                 right: 2.h,
//                 bottom: 31.v,
//               ),
//               child: Text(
//                 "Team 2",
//                 style: theme.textTheme.headlineSmall,
//               ),
//             ),
//           ),
//           CustomImageView(
//             imagePath: ImageConstant.imgImage1,
//             height: 102.v,
//             width: 95.h,
//             alignment: Alignment.topLeft,
//             margin: EdgeInsets.only(top: 38.v),
//           ),
//           CustomImageView(
//             imagePath: ImageConstant.imgImage2,
//             height: 102.adaptSize,
//             width: 102.adaptSize,
//             alignment: Alignment.topRight,
//             margin: EdgeInsets.only(top: 41.v),
//           ),
//           Align(
//             alignment: Alignment.center,
//             child: SizedBox(
//               height: 100.v,
//               child: VerticalDivider(
//                 width: 1.h,
//                 thickness: 1.v,
//               ),
//             ),
//           ),
//           Align(
//             alignment: Alignment.topRight,
//             child: Padding(
//               padding: EdgeInsets.only(
//                 left: 187.h,
//                 top: 66.v,
//                 right: 100.h,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "To Bat",
//                     style: theme.textTheme.titleLarge,
//                   ),
//                   Text(
//                     "0 Ov.",
//                     style: theme.textTheme.titleLarge,
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   /// Section Widget
//   Widget _buildBottomAppBarStack(BuildContext context) {
//     return SizedBox(
//       child: SizedBox(
//         height: 115.v,
//         width: 409.h,
//         child: Stack(
//           alignment: Alignment.topCenter,
//           children: [
//             Align(
//               alignment: Alignment.bottomCenter,
//               child: Container(
//                 width: 409.h,
//                 margin: EdgeInsets.only(top: 35.v),
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 13.h,
//                   vertical: 15.v,
//                 ),
//                 decoration: BoxDecoration(
//                   image: DecorationImage(
//                     image: fs.Svg(
//                       ImageConstant.imgGroup146,
//                     ),
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     CustomIconButton(
//                       height: 50.adaptSize,
//                       width: 50.adaptSize,
//                       padding_f: EdgeInsets.all(13.h),
//                       child: CustomImageView(
//                         svgPath: ImageConstant.imgSearch,
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 27.h),
//                       child: CustomIconButton(
//                         height: 50.adaptSize,
//                         width: 50.adaptSize,
//                         padding_f: EdgeInsets.all(12.h),
//                         child: CustomImageView(
//                           svgPath: ImageConstant.imgBxCricketBall,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 123.h),
//                       child: CustomIconButton(
//                         height: 50.adaptSize,
//                         width: 50.adaptSize,
//                         padding_f: EdgeInsets.all(12.h),
//                         child: CustomImageView(
//                           svgPath: ImageConstant.imgFluentLive24Filled,
//                         ),
//                       ),
//                     ),
//                     Padding(
//                       padding: EdgeInsets.only(left: 26.h),
//                       child: CustomIconButton(
//                         height: 50.adaptSize,
//                         width: 50.adaptSize,
//                         padding_f: EdgeInsets.all(10.h),
//                         child: CustomImageView(
//                           svgPath: ImageConstant.imgNotification,
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             CustomFloatingButton(
//               height: 64,
//               width: 64,
//               alignment: Alignment.topCenter,
//               child: CustomImageView(
//                 svgPath: ImageConstant.imgLocation,
//                 height: 32.0.v,
//                 width: 32.0.h,
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
