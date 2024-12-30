// // ignore_for_file: deprecated_member_use

// import 'package:cricyard/core/utils/size_utils.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:readmore/readmore.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../core/utils/image_constant.dart';
// import '../../providers/tab_navigation_provider.dart';
// import '../../theme/app_decoration.dart';
// import '../../theme/custom_text_style.dart';
// import '../../theme/theme_helper.dart';
// import '../../widgets/custom_image_view.dart';
// import '../ReuseableWidgets/BottomAppBarWidget.dart';
// import '../ReuseableWidgets/CustomDrawer.dart';
// import '../ReuseableWidgets/headerWidget.dart';

// class TabbedLayoutComponentF extends StatefulWidget {
//   TabbedLayoutComponentF(this.userData, {super.key});
//   Map<String, dynamic> userData = {};
//   @override
//   _TabbedLayoutComponentFState createState() => _TabbedLayoutComponentFState();
// }

// class _TabbedLayoutComponentFState extends State<TabbedLayoutComponentF> {
//   int _currentTab = 0;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   Map<String, dynamic> userData = {};

//   @override
//   void initState() {
//     super.initState();
//     getUserData();
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

//   // List<Map<String, dynamic>> notifications = [];

//   // Future<void> fetchData() async {
//   //   String baseUrl = ApiConstants.baseUrl;
//   //   final apiUrl = '$baseUrl/notification/get_notification';
//   //   final token = await TokenManager.getToken();
//   //   final response = await http.get(
//   //     Uri.parse(apiUrl),
//   //     headers: {
//   //       'Authorization': 'Bearer $token',
//   //       'Content-Type': 'application/json',
//   //     },
//   //   );
//   //   if (response.statusCode == 401) {
//   //     LogoutService.logout();
//   //   }
//   //   if (response.statusCode <= 209) {
//   //     final List<dynamic> data = jsonDecode(response.body);
//   //     setState(() {
//   //       notifications = data.cast<Map<String, dynamic>>();
//   //     });
//   //     print('notifications are $notifications');
//   //   } else {
//   //     // Handle errors
//   //     print('Failed to fetch data');
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       // onWillPop: _onBackPress,
//       child: Scaffold(
//         key: _scaffoldKey,
//         drawer: CustomDrawer(context: context),

//         bottomNavigationBar: BottomAppBarWidget(),
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
//                     headerWidget(context, _scaffoldKey),
//                     // _buildTelevisionRow(context),
//                     SizedBox(height: 21.v),
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

//   //  Section Widget
//   // Widget _buildTelevisionRow(BuildContext context) {
//   //   return GestureDetector(
//   //     child: Padding(
//   //       padding: EdgeInsets.only(left: 1.h),
//   //       child: Row(
//   //         mainAxisAlignment: MainAxisAlignment.center,
//   //         crossAxisAlignment: CrossAxisAlignment.end,
//   //         children: [
//   //           GestureDetector(
//   //             onTap: () {
//   //               _scaffoldKey.currentState?.openDrawer();
//   //             },
//   //             child: CustomImageView(
//   //               svgPath: ImageConstant.imgTelevision,
//   //               height: 24.adaptSize,
//   //               width: 24.adaptSize,
//   //               margin: EdgeInsets.only(
//   //                 top: 11.v,
//   //                 bottom: 2.v,
//   //               ),
//   //             ),
//   //           ),
//   //           CustomImageView(
//   //             imagePath: ImageConstant.imgImageRemovebgPreview,
//   //             height: 75.v,
//   //             width: 272.h,
//   //             margin: EdgeInsets.only(
//   //               left: 15.h,
//   //               bottom: 2.v,
//   //             ),
//   //           ),
//   //           CustomImageView(
//   //             svgPath: ImageConstant.imgTelevisionPrimarycontainer,
//   //             height: 24.adaptSize,
//   //             width: 24.adaptSize,
//   //             margin: EdgeInsets.only(
//   //               left: 15.h,
//   //               top: 11.v,
//   //             ),
//   //           ),
//   //           Padding(
//   //             padding: EdgeInsets.only(
//   //               left: 11.h,
//   //               top: 11.v,
//   //               bottom: 2.v,
//   //             ),
//   //             child: CustomIconButton(
//   //               height: 24.adaptSize,
//   //               width: 24.adaptSize,
//   //               decoration: IconButtonStyleHelper.fillPrimaryContainer,
//   //               child: CustomImageView(
//   //                 svgPath: ImageConstant.imgVector,
//   //               ),
//   //             ),
//   //           )
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }

//   // /// Section Widget
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
// }
