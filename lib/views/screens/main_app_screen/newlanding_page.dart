
// /../Entity/gaurav/Gauravtest1/Gauravtest1_entity_list_screen.dart';

// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Utils/color_constants.dart';
// import '../../Utils/image_constant.dart';
// import '../../Utils/size_utils.dart';
// import '../../providers/token_manager.dart';
// import '../../resources/api_constants.dart';
// import '../../theme/app_decoration.dart';
// import '../../theme/app_style.dart';
// import '../../widgets/app_bar/appbar_image.dart';
// import '../../widgets/app_bar/appbar_title.dart';
// import '../../widgets/app_bar/custom_app_bar.dart';
// import '../../widgets/custom_image_view.dart';
// import '../Bookmarks/Bookmarks_entity_list_screen.dart';
// import '../Incident_Ticket/ticket_create.dart';
// import '../LayoutReportBuilder/LayoutReportBuilder.dart';
// import '../Login Screen/login_screen.dart';
// import '../LogoutService/Logoutservice.dart';
// import '../QrBarCode/Qr_BarCode/Qr_BarCode_create_entity_screen.dart';
// import '../Setup/setup.dart';
// import '../SysParameters/SystemParameterScreen.dart';
// import '../dynamic_form/list_dynamic_form_screen.dart';
// import '../profileManagement/Profilesettings.dart';
// import '../profileManagement/about.dart';
// import '../profileManagement/changepassword.dart';

// import 'list_group_524.dart';
// import 'list_group__.dart';
// import 'notification_item.dart';
// import 'package:http/http.dart' as http;

// class TabbedLayoutComponentb extends StatefulWidget {
//   // final Map<String, dynamic> userData;
//   // const TabbedLayoutComponentb({required this.userData, Key? key})
//   //     : super(key: key);
//   @override
//   _TabbedLayoutComponentState createState() => _TabbedLayoutComponentState();
// }

// class _TabbedLayoutComponentState extends State<TabbedLayoutComponentb> {
//   List<Map<String, dynamic>> notifications = [];

//   Map<String, dynamic> userData = {};

//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//     fetchData();
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

//   Future<void> _logoutUser() async {
//     try {
//       SharedPreferences prefs = await SharedPreferences.getInstance();

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
//           MaterialPageRoute(builder: (context) => LoginScreen()),
//           (route) => false, // Remove all routes from the stack
//         );
//       } else {
//         const Text('failed to logout');
//       }
//     } catch (error) {
//       print('Error occurred during logout: $error');
//     }
//   }

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
//     } else {
//       // Handle errors
//       print('Failed to fetch data');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: ColorConstant.gray50,
//         appBar: CustomAppBar(
//             height: getVerticalSize(53),
//             leadingWidth: 40,
//             // leading: AppbarImage(
//             //     height: getSize(24),
//             //     width: getSize(24),
//             //     svgPath: ImageConstant.imgArrowleft,
//             //     margin: getMargin(left: 16, top: 12, bottom: 17),
//             //     onTap: () {
//             //       onTapArrowleft(context);
//             //     }),
//             centerTitle: true,
//             title: AppbarTitle(text: "CloudnSure"),
//             actions: [
//               // AppbarImage(
//               //     height: getSize(24),
//               //     width: getSize(24),
//               //
//               //     svgPath: ImageConstant.imgOverflowmenu,
//               //     margin:
//               //     getMargin(left: 16, top: 12, right: 16, bottom: 17)),

//               //--
//               PopupMenuButton<String>(
//                 icon: Icon(
//                   Icons.more_vert,
//                   color: Colors.black,
//                 ),
//                 onSelected: (String result) {
//                   // Handle the selected option
//                   print("Selected: $result");
//                 },
//                 itemBuilder: (BuildContext context) => [
//                   PopupMenuItem<String>(
//                     //value: 'Option 1',
//                     child: Text(
//                       'Raise A Ticket',
//                       style: AppStyle.txtGilroySemiBold16,
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => RaisedTicketScreen(
//                             userData: userData,
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                   PopupMenuItem<String>(
//                     //value: 'Option 1',
//                     child: Text(
//                       'Profile Settings',
//                       style: AppStyle.txtGilroySemiBold16,
//                     ),
//                     onTap: () {
//                       // Closes the drawer
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ProfileSettingsScreen(
//                               userData: userData), //go to get all entity
//                         ),
//                       );
//                       // Add your logic for menu 2 here
//                     },
//                   ),
//                   PopupMenuItem<String>(
//                     //value: 'Option 1',
//                     child: Text(
//                       'Change Password',
//                       style: AppStyle.txtGilroySemiBold16,
//                     ),
//                     onTap: () {
//                       // Closes the drawer
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ResetPasswordScreen(
//                               userEmail: userData['email'],
//                               userData: userData), //go to get all entity
//                         ),
//                       );
//                       // Add your logic for menu 2 here
//                     },
//                   ),
//                   PopupMenuItem<String>(
//                     //value: 'Option 1',
//                     child: Text(
//                       'DynamicForm',
//                       style: AppStyle.txtGilroySemiBold16,
//                     ),
//                     onTap: () {
//                       // Closes the drawer
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               DynamicForm(), //go to get all entity
//                         ),
//                       );
//                       // Add your logic for menu 2 here
//                     },
//                   ),
//                   PopupMenuItem<String>(
//                     //value: 'Option 1',
//                     child: Text(
//                       'Setup Screen',
//                       style: AppStyle.txtGilroySemiBold16,
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               SetupScreen(), //go to get all entity
//                         ),
//                       );
//                       // Add your logic for menu 2 here
//                     },
//                   ),
//                   PopupMenuItem<String>(
//                     //value: 'Option 1',
//                     child: Text(
//                       'BookMark',
//                       style: AppStyle.txtGilroySemiBold16,
//                     ),
//                     onTap: () {
//                       // Closes the drawer
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               bookmarks_entity_list_screen(), //go to get all entity
//                         ),
//                       );
//                       // Add your logic for menu 2 here
//                     },
//                   ),
//                   PopupMenuItem<String>(
//                     //value: 'Option 1',
//                     child: Text(
//                       'Report layout builder',
//                       style: AppStyle.txtGilroySemiBold16,
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => ReportEditor(),
//                         ),
//                       );
//                     },
//                   ),
//                   PopupMenuItem<String>(
//                     //value: 'Option 1',
//                     child: Text(
//                       'System Parameter',
//                       style: AppStyle.txtGilroySemiBold16,
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               SysParameter(), //go to get all entity
//                         ),
//                       );
//                       // Add your logic for menu 2 here
//                     },
//                   ),
//                   PopupMenuItem<String>(
//                     //value: 'Option 1',
//                     child: Text(
//                       'Addition Menu',
//                       style: AppStyle.txtGilroySemiBold16,
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => const QrBarCodeScreen(),
//                         ),
//                       );
//                     },
//                   ),
//                   PopupMenuItem<String>(
//                     //value: 'Option 1',
//                     child: Text(
//                       'About',
//                       style: AppStyle.txtGilroySemiBold16,
//                     ),
//                     onTap: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) =>
//                               AboutScreen(), //go to get all entity
//                         ),
//                       );
//                       // Add your logic for menu 2 here
//                     },
//                   ),
//                   PopupMenuItem<String>(
//                     //value: 'Option 1',
//                     child: Text(
//                       'LogOut',
//                       style: AppStyle.txtGilroySemiBold16,
//                     ),
//                     onTap: () {
//                       _logoutUser();
//                     },
//                   ),
//                 ],
//               ),
//             ]),
//         body: SingleChildScrollView(
//           child: Container(
//               width: double.maxFinite,
//               padding: getPadding(left: 16, top: 20, right: 16, bottom: 20),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                         height: getVerticalSize(158),
//                         child: ListView.separated(
//                             separatorBuilder: (context, index) {
//                               return SizedBox(height: getVerticalSize(16));
//                             },
//                             itemCount: 1,
//                             itemBuilder: (context, index) {
//                               return Listgroup524ItemWidget(
//                                 userData: userData,
//                               );
//                             })),
//                     Card(
//                         clipBehavior: Clip.antiAlias,
//                         elevation: 0,
//                         margin: getMargin(top: 5),
//                         color: ColorConstant.whiteA70099,
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadiusStyle.roundedBorder6),
//                         child: Container(
//                             height: getVerticalSize(224),
//                             width: MediaQuery.of(context)
//                                 .size
//                                 .width, //getHorizontalSize(396),
//                             // padding: getPadding(
//                             //     left: 16, top: 17, right: 16, bottom: 17),
//                             decoration: AppDecoration.outlineGray70026.copyWith(
//                                 borderRadius: BorderRadiusStyle.roundedBorder6),
//                             child: Stack(
//                                 alignment: Alignment.centerRight,
//                                 children: [
//                                   Align(
//                                       alignment: Alignment.topCenter,
//                                       child: Padding(
//                                           padding: getPadding(left: 1),
//                                           child: Column(
//                                               mainAxisSize: MainAxisSize.min,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.start,
//                                               children: [
//                                                 Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .center,
//                                                     children: [
//                                                       Text("08",
//                                                           overflow: TextOverflow
//                                                               .ellipsis,
//                                                           textAlign:
//                                                               TextAlign.left,
//                                                           style: AppStyle
//                                                               .txtGilroyMedium10),
//                                                       Expanded(
//                                                           child: Padding(
//                                                               padding: getPadding(
//                                                                   top: 6,
//                                                                   bottom: 5),
//                                                               child: Divider(
//                                                                   height:
//                                                                       getVerticalSize(
//                                                                           1),
//                                                                   thickness:
//                                                                       getVerticalSize(
//                                                                           1),
//                                                                   color: ColorConstant
//                                                                       .blueGray400,
//                                                                   indent:
//                                                                       getHorizontalSize(
//                                                                           9))))
//                                                     ]),
//                                                 Padding(
//                                                     padding:
//                                                         getPadding(top: 28),
//                                                     child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           Text("06",
//                                                               overflow:
//                                                                   TextOverflow
//                                                                       .ellipsis,
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: AppStyle
//                                                                   .txtGilroyMedium10),
//                                                           Expanded(
//                                                               child: Padding(
//                                                                   padding:
//                                                                       getPadding(
//                                                                           top:
//                                                                               6,
//                                                                           bottom:
//                                                                               5),
//                                                                   child: Divider(
//                                                                       height:
//                                                                           getVerticalSize(
//                                                                               1),
//                                                                       thickness:
//                                                                           getVerticalSize(
//                                                                               1),
//                                                                       color: ColorConstant
//                                                                           .blueGray400,
//                                                                       indent:
//                                                                           getHorizontalSize(
//                                                                               9))))
//                                                         ])),
//                                                 Padding(
//                                                     padding:
//                                                         getPadding(top: 28),
//                                                     child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           Text("04",
//                                                               overflow:
//                                                                   TextOverflow
//                                                                       .ellipsis,
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: AppStyle
//                                                                   .txtGilroyMedium10),
//                                                           Expanded(
//                                                               child: Padding(
//                                                                   padding:
//                                                                       getPadding(
//                                                                           top:
//                                                                               6,
//                                                                           bottom:
//                                                                               5),
//                                                                   child: Divider(
//                                                                       height:
//                                                                           getVerticalSize(
//                                                                               1),
//                                                                       thickness:
//                                                                           getVerticalSize(
//                                                                               1),
//                                                                       color: ColorConstant
//                                                                           .blueGray400,
//                                                                       indent:
//                                                                           getHorizontalSize(
//                                                                               9))))
//                                                         ])),
//                                                 Padding(
//                                                     padding:
//                                                         getPadding(top: 28),
//                                                     child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           Text("02",
//                                                               overflow:
//                                                                   TextOverflow
//                                                                       .ellipsis,
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: AppStyle
//                                                                   .txtGilroyMedium10),
//                                                           Expanded(
//                                                               child: Padding(
//                                                                   padding:
//                                                                       getPadding(
//                                                                           top:
//                                                                               6,
//                                                                           bottom:
//                                                                               5),
//                                                                   child: Divider(
//                                                                       height:
//                                                                           getVerticalSize(
//                                                                               1),
//                                                                       thickness:
//                                                                           getVerticalSize(
//                                                                               1),
//                                                                       color: ColorConstant
//                                                                           .blueGray400,
//                                                                       indent: getHorizontalSize(
//                                                                           10))))
//                                                         ])),
//                                                 Padding(
//                                                     padding:
//                                                         getPadding(top: 28),
//                                                     child: Row(
//                                                         mainAxisAlignment:
//                                                             MainAxisAlignment
//                                                                 .center,
//                                                         children: [
//                                                           Text("00",
//                                                               overflow:
//                                                                   TextOverflow
//                                                                       .ellipsis,
//                                                               textAlign:
//                                                                   TextAlign
//                                                                       .left,
//                                                               style: AppStyle
//                                                                   .txtGilroyMedium10),
//                                                           Expanded(
//                                                               child: Padding(
//                                                                   padding:
//                                                                       getPadding(
//                                                                           top:
//                                                                               6,
//                                                                           bottom:
//                                                                               5),
//                                                                   child: Divider(
//                                                                       height:
//                                                                           getVerticalSize(
//                                                                               1),
//                                                                       thickness:
//                                                                           getVerticalSize(
//                                                                               1),
//                                                                       color: ColorConstant
//                                                                           .blueGray400,
//                                                                       indent:
//                                                                           getHorizontalSize(
//                                                                               9))))
//                                                         ]))
//                                               ]))),
//                                   Align(
//                                     alignment: Alignment.centerRight,
//                                     child: Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.center,
//                                       crossAxisAlignment:
//                                           CrossAxisAlignment.end,
//                                       children: [
//                                         buildContainer(
//                                             height: 97,
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.016,
//                                             margin: EdgeInsets.only(top: 45),
//                                             text: "08/21"),
//                                         buildContainer(
//                                             height: 138,
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.016,
//                                             margin: EdgeInsets.only(
//                                                 left: 23, top: 19),
//                                             text: "08/22"),
//                                         buildContainer(
//                                             height: 160,
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.016,
//                                             margin: EdgeInsets.only(
//                                                 left: 21, top: 5),
//                                             text: "08/23"),
//                                         buildContainer(
//                                             height: 83,
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.016,
//                                             margin: EdgeInsets.only(
//                                                 left: 21, top: 53),
//                                             text: "08/24"),
//                                         buildContainer(
//                                             height: 64,
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.016,
//                                             margin: EdgeInsets.only(
//                                                 left: 20, top: 65),
//                                             text: "08/25"),
//                                         buildContainer(
//                                             height: 126,
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.016,
//                                             margin: EdgeInsets.only(
//                                                 left: 21, top: 26),
//                                             text: "08/26"),
//                                         buildContainer(
//                                             height: 83,
//                                             width: MediaQuery.of(context)
//                                                     .size
//                                                     .width *
//                                                 0.016,
//                                             margin: EdgeInsets.only(
//                                                 left: 22, top: 53),
//                                             text: "08/27"),
//                                       ],
//                                     ),
//                                   )
//                                   // Align(
//                                   //     alignment: Alignment.centerRight,
//                                   //     child: Padding(
//                                   //         padding: getPadding(right: 8),
//                                   //         child: Row(
//                                   //             mainAxisAlignment:
//                                   //             MainAxisAlignment.center,
//                                   //             crossAxisAlignment:
//                                   //             CrossAxisAlignment.end,
//                                   //             mainAxisSize: MainAxisSize.min,
//                                   //             children: [
//                                   //               Container(
//                                   //                   width:
//                                   //                   getHorizontalSize(25),
//                                   //                   margin:
//                                   //                   getMargin(top: 63),
//                                   //                   child: Column(
//                                   //                       mainAxisAlignment:
//                                   //                       MainAxisAlignment
//                                   //                           .start,
//                                   //                       children: [
//                                   //                         Container(
//                                   //                             height:
//                                   //                             getVerticalSize(
//                                   //                                 97),
//                                   //                             width:
//                                   //                             getHorizontalSize(
//                                   //                                 24),
//                                   //                             decoration: BoxDecoration(
//                                   //                                 color: ColorConstant
//                                   //                                     .blueA700,
//                                   //                                 borderRadius: BorderRadius.only(
//                                   //                                     topLeft:
//                                   //                                     Radius.circular(getHorizontalSize(
//                                   //                                         4)),
//                                   //                                     topRight:
//                                   //                                     Radius.circular(getHorizontalSize(4))))),
//                                   //                         Padding(
//                                   //                             padding:
//                                   //                             getPadding(
//                                   //                                 top: 9),
//                                   //                             child: Text(
//                                   //                                 "08/21",
//                                   //                                 overflow:
//                                   //                                 TextOverflow
//                                   //                                     .ellipsis,
//                                   //                                 textAlign:
//                                   //                                 TextAlign
//                                   //                                     .left,
//                                   //                                 style: AppStyle
//                                   //                                     .txtGilroyMedium10))
//                                   //                       ])),
//                                   //               Container(
//                                   //                   width:
//                                   //                   getHorizontalSize(28),
//                                   //                   margin: getMargin(
//                                   //                       left: 23, top: 22),
//                                   //                   child: Column(
//                                   //                       mainAxisAlignment:
//                                   //                       MainAxisAlignment
//                                   //                           .start,
//                                   //                       children: [
//                                   //                         Container(
//                                   //                             height:
//                                   //                             getVerticalSize(
//                                   //                                 138),
//                                   //                             width:
//                                   //                             getHorizontalSize(
//                                   //                                 24),
//                                   //                             decoration: BoxDecoration(
//                                   //                                 color: ColorConstant
//                                   //                                     .blueA700,
//                                   //                                 borderRadius: BorderRadius.only(
//                                   //                                     topLeft:
//                                   //                                     Radius.circular(getHorizontalSize(
//                                   //                                         4)),
//                                   //                                     topRight:
//                                   //                                     Radius.circular(getHorizontalSize(4))))),
//                                   //                         Padding(
//                                   //                             padding:
//                                   //                             getPadding(
//                                   //                                 top: 9),
//                                   //                             child: Text(
//                                   //                                 "08/22",
//                                   //                                 overflow:
//                                   //                                 TextOverflow
//                                   //                                     .ellipsis,
//                                   //                                 textAlign:
//                                   //                                 TextAlign
//                                   //                                     .left,
//                                   //                                 style: AppStyle
//                                   //                                     .txtGilroyMedium10))
//                                   //                       ])),
//                                   //               Container(
//                                   //                   width:
//                                   //                   getHorizontalSize(28),
//                                   //                   margin:
//                                   //                   getMargin(left: 21),
//                                   //                   child: Column(
//                                   //                       mainAxisAlignment:
//                                   //                       MainAxisAlignment
//                                   //                           .start,
//                                   //                       children: [
//                                   //                         Container(
//                                   //                             height:
//                                   //                             getVerticalSize(
//                                   //                                 160),
//                                   //                             width:
//                                   //                             getHorizontalSize(
//                                   //                                 24),
//                                   //                             decoration: BoxDecoration(
//                                   //                                 color: ColorConstant
//                                   //                                     .blueA700,
//                                   //                                 borderRadius: BorderRadius.only(
//                                   //                                     topLeft:
//                                   //                                     Radius.circular(getHorizontalSize(
//                                   //                                         4)),
//                                   //                                     topRight:
//                                   //                                     Radius.circular(getHorizontalSize(4))))),
//                                   //                         Padding(
//                                   //                             padding:
//                                   //                             getPadding(
//                                   //                                 top: 9),
//                                   //                             child: Text(
//                                   //                                 "08/23",
//                                   //                                 overflow:
//                                   //                                 TextOverflow
//                                   //                                     .ellipsis,
//                                   //                                 textAlign:
//                                   //                                 TextAlign
//                                   //                                     .left,
//                                   //                                 style: AppStyle
//                                   //                                     .txtGilroyMedium10))
//                                   //                       ])),
//                                   //               Container(
//                                   //                   width:
//                                   //                   getHorizontalSize(29),
//                                   //                   margin: getMargin(
//                                   //                       left: 21, top: 77),
//                                   //                   child: Column(
//                                   //                       mainAxisAlignment:
//                                   //                       MainAxisAlignment
//                                   //                           .start,
//                                   //                       children: [
//                                   //                         Container(
//                                   //                             height:
//                                   //                             getVerticalSize(
//                                   //                                 83),
//                                   //                             width:
//                                   //                             getHorizontalSize(
//                                   //                                 24),
//                                   //                             decoration: BoxDecoration(
//                                   //                                 color: ColorConstant
//                                   //                                     .blueA700,
//                                   //                                 borderRadius: BorderRadius.only(
//                                   //                                     topLeft:
//                                   //                                     Radius.circular(getHorizontalSize(
//                                   //                                         4)),
//                                   //                                     topRight:
//                                   //                                     Radius.circular(getHorizontalSize(4))))),
//                                   //                         Padding(
//                                   //                             padding:
//                                   //                             getPadding(
//                                   //                                 top: 9),
//                                   //                             child: Text(
//                                   //                                 "08/24",
//                                   //                                 overflow:
//                                   //                                 TextOverflow
//                                   //                                     .ellipsis,
//                                   //                                 textAlign:
//                                   //                                 TextAlign
//                                   //                                     .left,
//                                   //                                 style: AppStyle
//                                   //                                     .txtGilroyMedium10))
//                                   //                       ])),
//                                   //               Container(
//                                   //                   width:
//                                   //                   getHorizontalSize(28),
//                                   //                   margin: getMargin(
//                                   //                       left: 20, top: 96),
//                                   //                   child: Column(
//                                   //                       mainAxisAlignment:
//                                   //                       MainAxisAlignment
//                                   //                           .start,
//                                   //                       children: [
//                                   //                         Container(
//                                   //                             height:
//                                   //                             getVerticalSize(
//                                   //                                 64),
//                                   //                             width:
//                                   //                             getHorizontalSize(
//                                   //                                 24),
//                                   //                             decoration: BoxDecoration(
//                                   //                                 color: ColorConstant
//                                   //                                     .blueA700,
//                                   //                                 borderRadius: BorderRadius.only(
//                                   //                                     topLeft:
//                                   //                                     Radius.circular(getHorizontalSize(
//                                   //                                         4)),
//                                   //                                     topRight:
//                                   //                                     Radius.circular(getHorizontalSize(4))))),
//                                   //                         Padding(
//                                   //                             padding:
//                                   //                             getPadding(
//                                   //                                 top: 9),
//                                   //                             child: Text(
//                                   //                                 "08/25",
//                                   //                                 overflow:
//                                   //                                 TextOverflow
//                                   //                                     .ellipsis,
//                                   //                                 textAlign:
//                                   //                                 TextAlign
//                                   //                                     .left,
//                                   //                                 style: AppStyle
//                                   //                                     .txtGilroyMedium10))
//                                   //                       ])),
//                                   //               Container(
//                                   //                   width:
//                                   //                   getHorizontalSize(28),
//                                   //                   margin: getMargin(
//                                   //                       left: 21, top: 34),
//                                   //                   child: Column(
//                                   //                       mainAxisAlignment:
//                                   //                       MainAxisAlignment
//                                   //                           .start,
//                                   //                       children: [
//                                   //                         Container(
//                                   //                             height:
//                                   //                             getVerticalSize(
//                                   //                                 126),
//                                   //                             width:
//                                   //                             getHorizontalSize(
//                                   //                                 24),
//                                   //                             decoration: BoxDecoration(
//                                   //                                 color: ColorConstant
//                                   //                                     .blueA700,
//                                   //                                 borderRadius: BorderRadius.only(
//                                   //                                     topLeft:
//                                   //                                     Radius.circular(getHorizontalSize(
//                                   //                                         4)),
//                                   //                                     topRight:
//                                   //                                     Radius.circular(getHorizontalSize(4))))),
//                                   //                         Padding(
//                                   //                             padding:
//                                   //                             getPadding(
//                                   //                                 top: 9),
//                                   //                             child: Text(
//                                   //                                 "08/26",
//                                   //                                 overflow:
//                                   //                                 TextOverflow
//                                   //                                     .ellipsis,
//                                   //                                 textAlign:
//                                   //                                 TextAlign
//                                   //                                     .left,
//                                   //                                 style: AppStyle
//                                   //                                     .txtGilroyMedium10))
//                                   //                       ])),
//                                   //               Container(
//                                   //                   width:
//                                   //                   getHorizontalSize(27),
//                                   //                   margin: getMargin(
//                                   //                       left: 22, top: 77),
//                                   //                   child: Column(
//                                   //                       mainAxisAlignment:
//                                   //                       MainAxisAlignment
//                                   //                           .start,
//                                   //                       children: [
//                                   //                         Container(
//                                   //                             height:
//                                   //                             getVerticalSize(
//                                   //                                 83),
//                                   //                             width:
//                                   //                             getHorizontalSize(
//                                   //                                 24),
//                                   //                             decoration: BoxDecoration(
//                                   //                                 color: ColorConstant
//                                   //                                     .blueA700,
//                                   //                                 borderRadius: BorderRadius.only(
//                                   //                                     topLeft:
//                                   //                                     Radius.circular(getHorizontalSize(
//                                   //                                         4)),
//                                   //                                     topRight:
//                                   //                                     Radius.circular(getHorizontalSize(4))))),
//                                   //                         Padding(
//                                   //                             padding:
//                                   //                             getPadding(
//                                   //                                 top: 9),
//                                   //                             child: Text(
//                                   //                                 "08/27",
//                                   //                                 overflow:
//                                   //                                 TextOverflow
//                                   //                                     .ellipsis,
//                                   //                                 textAlign:
//                                   //                                 TextAlign
//                                   //                                     .left,
//                                   //                                 style: AppStyle
//                                   //                                     .txtGilroyMedium10))
//                                   //                       ]))
//                                   //             ])))
//                                 ]))),
//                     Padding(
//                         padding: getPadding(top: 29),
//                         child: Text("Notifications",
//                             overflow: TextOverflow.ellipsis,
//                             textAlign: TextAlign.left,
//                             style: AppStyle.txtGilroySemiBold18)),
//                     Padding(
//                         padding: getPadding(top: 21),
//                         child: ListView.separated(
//                             physics: NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             separatorBuilder: (context, index) {
//                               return Padding(
//                                   padding: getPadding(top: 18.5, bottom: 18.5),
//                                   child: SizedBox(
//                                       width: getHorizontalSize(396),
//                                       child: Divider(
//                                           height: getVerticalSize(1),
//                                           thickness: getVerticalSize(1),
//                                           color: ColorConstant.blueGray100)));
//                             },
//                             itemCount: notifications.length,
//                             itemBuilder: (context, index) {
//                               return NotificationItem(
//                                   notification: notifications[index]);
//                             })),
//                     Padding(
//                         padding: getPadding(top: 17, bottom: 5),
//                         child: Divider(
//                             height: getVerticalSize(1),
//                             thickness: getVerticalSize(1),
//                             color: ColorConstant.blueGray100))
//                   ])),
//         ));
//   }

//   Widget buildContainer(
//       {required double height,
//       required double width,
//       required EdgeInsets margin,
//       required String text}) {
//     return Container(
//       width: getHorizontalSize(width),
//       margin: margin,
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           Container(
//             height: getVerticalSize(height),
//             decoration: BoxDecoration(
//               color: ColorConstant.blueA700,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(getHorizontalSize(4)),
//                 topRight: Radius.circular(getHorizontalSize(4)),
//               ),
//             ),
//           ),
//           Padding(
//             padding: getPadding(top: 9),
//             child: Text(
//               text,
//               overflow: TextOverflow.ellipsis,
//               textAlign: TextAlign.left,
//               style: AppStyle.txtGilroyMedium10,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }