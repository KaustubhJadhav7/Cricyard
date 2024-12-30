// import 'dart:typed_data';

// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// import 'dart:async';
// import 'dart:convert';
// import 'dart:ui';

// import 'package:fluentui_system_icons/fluentui_system_icons.dart';
// import 'package:flutter/material.dart';

// import 'package:google_nav_bar/google_nav_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import '../../Utils/color_constants.dart';
// import '../../Utils/size_utils.dart';
// import '../../providers/tab_navigation_provider.dart';
// import '../../providers/token_manager.dart';
// import '../../resources/api_constants.dart';
// import '../../theme/app_decoration.dart';
// import '../../theme/app_style.dart';
// import '../Incident_Ticket/ticket_create.dart';
// import '../Login Screen/login_screen_f.dart';
// import '../LogoutService/Logoutservice.dart';
// import '../dynamic_form/dynamic_form_screen_list_f.dart';
// import '../profileManagement/about.dart';
// import '../profileManagement/apiserviceprofilemanagement.dart';
// import '../profileManagement/change_password_f.dart';
// import '../profileManagement/profile_settings_f.dart';
// import 'logs_screen_f.dart';

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
//     fetchData();
//     print('user data is');
//     print(userData);
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

//     List<Widget> screens = [
//       Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: StaticChartsScreen(
//           userData: userData,
//         ),
//       ),
//       Padding(
//         padding: const EdgeInsets.all(10),
//         child: HomeDashboardScreen(
//           userData: userData,
//         ),
//       ),
//       const SizedBox(height: 15),
//     ];
//     var _currentIndex = 0;
//     String? fetchedimageurl =
//         'http://43.205.154.152:30165/assets/images/profile-icon.png';
//     return WillPopScope(
//       onWillPop: _onBackPress,
//       child: Scaffold(
//         key: _scaffoldKey,
//         bottomNavigationBar: BottomNavigationBar(
//           elevation: 12,
//           showSelectedLabels: false,
//           // <-- HERE
//           showUnselectedLabels: false,
//           currentIndex: _currentIndex,
//           selectedItemColor: const Color(0xFF5E41D3), // Selected item color
//           unselectedItemColor: Colors.black, // Unselected item color
//           onTap: (index) {
//             setState(() {
//               _currentIndex = index;
//               if (_currentIndex == 2) {
//                 Navigator.of(context).push(MaterialPageRoute(
//                     builder: (ctx) =>
//                         ProfileSettingsScreenF(userData: userData)));
//               }
//               if (_currentIndex == 0) {
//                 // Navigator.of(context)
//                 //     .push(MaterialPageRoute(builder: (ctx) => SearchScreen()));
//               }
//             });
//           },
//           items: [
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.search,
//                 color: ColorConstant.purple211,
//               ),
//               label: 'Search',
//               backgroundColor: ColorConstant.purple211,
//             ),
//             const BottomNavigationBarItem(
//               icon: SizedBox.shrink(),
//               label: '',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(
//                 Icons.person_2_outlined,
//                 color: ColorConstant.purple211,
//               ),
//               label: 'Profile',
//               backgroundColor: ColorConstant.purple211,
//             ),
//           ],
//         ),
//         floatingActionButton: FloatingActionButton(
//           highlightElevation: 10,
//           onPressed: () {
//             // Handle button press
//             Navigator.of(context)
//                 .push(MaterialPageRoute(builder: (ctx) => const LogsScreen()));
//           }, // Replace with your image path
//           elevation: 15.0,
//           backgroundColor: ColorConstant.purple211, // Set the color to purple
//           shape: const CircleBorder(),
//           child: Image.asset(
//             'assets/images/panther.png',
//             height: 40,
//             width: 40,
//           ), // Make the button circular
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

//         drawer: Drawer(
//             backgroundColor: const Color.fromARGB(255, 245, 244, 246),
//             width: MediaQuery.of(context).size.width * 80 / 100,
//             child: ListView(
//               children: [
//                 SizedBox(
//                   height: 200,
//                   child: DrawerHeader(
//                     child: Card(
//                       elevation: 3,
//                       color: const Color.fromARGB(255, 212, 218, 247),
//                       child: Container(
//                         height: 130,
//                         width: 330,
//                         // decoration: BoxDecoration(
//                         //   border: Border.all(
//                         //     color: Colors.grey
//                         //   )

//                         // ),
//                         padding: const EdgeInsets.only(right: 3, left: 3),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Container(
//                               child: Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Container(
//                                       padding: const EdgeInsets.all(5),
//                                       child: Row(
//                                         children: [
//                                           Image.asset(
//                                             'assets/images/Transparent.png',
//                                             height: 70,
//                                             width: 70,
//                                           ),
//                                           const SizedBox(
//                                             width: 5,
//                                           ),
//                                           SingleChildScrollView(
//                                             child: Container(
//                                               width: MediaQuery.of(context)
//                                                       .size
//                                                       .width *
//                                                   48 /
//                                                   100,
//                                               alignment: Alignment.centerLeft,
//                                               child: Column(
//                                                 crossAxisAlignment:
//                                                     CrossAxisAlignment.start,
//                                                 children: [
//                                                   Text(
//                                                     ' Hello ${userData['firstName'] ?? 'N/A'}!',
//                                                     overflow: TextOverflow.clip,
//                                                     style: GoogleFonts.poppins()
//                                                         .copyWith(
//                                                             fontSize: 18,
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .bold),
//                                                   ),
//                                                   Row(
//                                                     children: [
//                                                       const SizedBox(
//                                                         width: 4,
//                                                       ),
//                                                       Text(
//                                                         userData['email'] ??
//                                                             "N/A",
//                                                         style: const TextStyle(
//                                                             fontWeight:
//                                                                 FontWeight
//                                                                     .w300),
//                                                       ),
//                                                     ],
//                                                   )
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ],
//                                       )),
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   iconColor: Colors.purple.shade900,
//                   leading: const Icon(
//                     Icons.arrow_upward,
//                   ),
//                   title: Text(
//                     'Raise a Ticket',
//                     style: AppStyle.txtpoppinsmedium16.copyWith(
//                         fontWeight: FontWeight.w700,
//                         color: Colors.purple.shade900),
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => RaisedTicketScreen(
//                           userData: userData,
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//                 ListTile(
//                   iconColor: Colors.purple.shade900,
//                   leading: const Icon(Icons.person_2_rounded),
//                   title: Text(
//                     'Profile Settings',
//                     style: AppStyle.txtpoppinsmedium16.copyWith(
//                         fontWeight: FontWeight.w700,
//                         color: Colors.purple.shade900),
//                   ),
//                   onTap: () {
//                     // Closes the drawer
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             ProfileSettingsScreenF(userData: userData),
//                       ),
//                     );
//                     // Add your logic for menu 2 here
//                   },
//                 ),
//                 ListTile(
//                   iconColor: Colors.purple.shade900,
//                   leading: const Icon(Icons.password),
//                   title: Text(
//                     'Change Password',
//                     style: AppStyle.txtpoppinsmedium16.copyWith(
//                         fontWeight: FontWeight.w700,
//                         color: Colors.purple.shade900),
//                   ),
//                   onTap: () {
//                     // Closes the drawer
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             ResetPasswordScreenF(), //go to get all entity
//                       ),
//                     );
//                     // Add your logic for menu 2 here
//                   },
//                 ),
//                 ListTile(
//                   iconColor: Colors.purple.shade900,
//                   leading: const Icon(Icons.group),
//                   title: Text(
//                     'My Workspace',
//                     style: AppStyle.txtpoppinsmedium16.copyWith(
//                         fontWeight: FontWeight.w700,
//                         color: Colors.purple.shade900),
//                   ),
//                   // onTap: () {
//                   //   // Closes the drawer
//                   //   Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //       builder: (context) => MyWorkspaceF(
//                   //           userData: userData), //go to get all entity
//                   //     ),
//                   //   );
//                   //   // Add your logic for menu 2 here
//                   // },
//                 ),
//                 ListTile(
//                   iconColor: Colors.purple.shade900,
//                   leading: const Icon(Icons.subject),
//                   title: Text(
//                     'Dynamic Form',
//                     style: AppStyle.txtpoppinsmedium16.copyWith(
//                         fontWeight: FontWeight.w700,
//                         color: Colors.purple.shade900),
//                   ),
//                   onTap: () {
//                     // Closes the drawer
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             const DynamicFormF(), //go to get all entity
//                       ),
//                     );
//                     // Add your logic for menu 2 here
//                   },
//                 ),
//                 ListTile(
//                   iconColor: Colors.purple.shade900,
//                   leading: const Icon(Icons.bookmark_outlined),
//                   title: Text(
//                     'Bookmarks',
//                     style: AppStyle.txtpoppinsmedium16.copyWith(
//                         fontWeight: FontWeight.w700,
//                         color: Colors.purple.shade900),
//                   ),
//                   // onTap: () {
//                   //   // Closes the drawer
//                   //   Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //       builder: (context) =>
//                   //           BookmarksEntityListScreenF(), //go to get all entity
//                   //     ),
//                   //   );
//                   //   // Add your logic for menu 2 here
//                   // },
//                 ),
//                 ListTile(
//                   iconColor: Colors.purple.shade900,
//                   leading: const Icon(Icons.info),
//                   title: Text(
//                     'About',
//                     style: AppStyle.txtpoppinsmedium16.copyWith(
//                         fontWeight: FontWeight.w700,
//                         color: Colors.purple.shade900),
//                   ),
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) =>
//                             AboutScreen(), //go to get all entity
//                       ),
//                     );
//                     // Add your logic for menu 2 here
//                   },
//                 ),
//                 ListTile(
//                   iconColor: Colors.purple.shade900,
//                   leading: const Icon(Icons.password),
//                   title: Text(
//                     'live Stream',
//                     style: AppStyle.txtpoppinsmedium16.copyWith(
//                         fontWeight: FontWeight.w700,
//                         color: Colors.purple.shade900),
//                   ),
//                   // onTap: () {
//                   //   // Closes the drawer
//                   //   Navigator.push(
//                   //     context,
//                   //     MaterialPageRoute(
//                   //       builder: (context) =>
//                   //           VideoStreamPage(), //go to get all entity
//                   //     ),
//                   //   );
//                   //   // Add your logic for menu 2 here
//                   // },
//                 ),
//                 ListTile(
//                   iconColor: Colors.purple.shade900,
//                   leading: const Icon(Icons.logout_rounded),
//                   title: Text(
//                     'Log Out',
//                     style: AppStyle.txtpoppinsmedium16.copyWith(
//                         fontWeight: FontWeight.w700,
//                         color: Colors.purple.shade900),
//                   ),
//                   onTap: () {
//                     _logoutUser();
//                   },
//                 ),
//               ],
//             )),
//         appBar: AppBar(
//           centerTitle: true,
//           backgroundColor: Colors.white,
//           toolbarHeight: 70,
//           title: Text("io8.dev",
//               style: GoogleFonts.poppins().copyWith(
//                   fontSize: 30,
//                   fontWeight: FontWeight.bold,
//                   color: const Color.fromARGB(255, 93, 63, 211))),
//         ),
//         backgroundColor: const Color(0xfffefefe),
//         extendBodyBehindAppBar: true,
//         //bottomNavigationBar: AppFooter(),
//         body: screens.isEmpty
//             ? const Text("Loading...")
//             : ListView.builder(
//                 itemCount: screens.length,
//                 scrollDirection: Axis.vertical,
//                 itemBuilder: (context, index) => screens[index],
//               ),
//       ),
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

//   Widget googleNavBar() {
//     return Container(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 6.18, vertical: 1),
//         child: GNav(
//           haptic: false,
//           gap: 6,
//           activeColor: const Color(0xFF0070BA),
//           iconSize: 24,
//           padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 11),
//           duration: const Duration(milliseconds: 300),
//           color: const Color(0xFF243656),
//           tabs: [
//             GButton(
//               icon: FluentIcons.home_32_regular,
//               iconSize: 36,
//               text: 'Home',
//               onPressed: () {
//                 print('home');
//               },
//             ),
//             GButton(
//               icon: FluentIcons.people_32_regular,
//               iconSize: 36,
//               text: 'Contacts',
//               onPressed: () {
//                 print('contacts');
//                 // Navigator.push(
//                 //   context,
//                 //   MaterialPageRoute(
//                 //     builder: (context) => AllContactsScreen(
//                 //       setTab: setTab,
//                 //     ),
//                 //   ),
//                 // );
//               },
//             ),
//             GButton(
//               icon: Icons.wallet,
//               text: 'Wallet',
//               iconSize: 34,
//               onPressed: () {
//                 print('wallet');
//               },
//             ),
//           ],
//           selectedIndex: _currentTab,
//           onTabChange: _onTabChange,
//         ),
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

// class StaticChartsScreen extends StatefulWidget {
//   final Map<String, dynamic> userData;
//   const StaticChartsScreen({required this.userData, Key? key})
//       : super(key: key);
//   @override
//   _StaticChartsScreenState createState() => _StaticChartsScreenState();
// }

// class _StaticChartsScreenState extends State<StaticChartsScreen> {
//   int myProjectcount = 0;
//   int sharedWithMeCount = 0;
//   int allprojectCount = 0;
//   Map<String, dynamic> userData = {};
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

//   @override
//   void initState() {
//     super.initState();
//     fetchData();
//     getUserData();
//     fetchProfileImageData();
//   }

//   Future<void> fetchData() async {
//     print("working");
//     final token = await TokenManager.getToken();
//     print(token);
//     String baseUrl = ApiConstants.baseUrl;
//     var myProjectcountres = await http.get(
//       Uri.parse('$baseUrl/workspace/secworkspaceuser/count_myproject'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type':
//             'application/json', // You may need to adjust the content type as needed
//       },
//     );
//     var sharedWithMeCountres = await http.get(
//       Uri.parse('$baseUrl/workspace/secworkspaceuser/count_sharedwithme'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type':
//             'application/json', // You may need to adjust the content type as needed
//       },
//     );
//     var allProjectsCountres = await http.get(
//       Uri.parse('$baseUrl/workspace/secworkspaceuser/count_allproject'),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type':
//             'application/json', // You may need to adjust the content type as needed
//       },
//     );
//     if (myProjectcountres.statusCode == 401) {
//       LogoutService.logout();
//     }
//     print(myProjectcountres.statusCode);
//     if (myProjectcountres.statusCode <= 209 &&
//         sharedWithMeCountres.statusCode <= 209) {
//       final myProjectData = jsonDecode(myProjectcountres.body);
//       final sharedData = jsonDecode(sharedWithMeCountres.body);
//       final allData = jsonDecode(allProjectsCountres.body);
//       if (myProjectData == 0) {
//         ScaffoldMessenger.of(context)
//             .showSnackBar(SnackBar(
//               elevation: 0,
//               behavior: SnackBarBehavior.floating,
//               content: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Container(
//                       padding: const EdgeInsets.all(16),
//                       height: 100,
//                       decoration: const BoxDecoration(
//                           borderRadius: BorderRadius.all(Radius.circular(20)),
//                           color: Color.fromARGB(255, 233, 155, 38)),
//                       child: const Row(
//                         children: [
//                           const SizedBox(
//                             width: 48,
//                           ),
//                           Expanded(
//                             child: Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 Text(
//                                   'Oh Snap!',
//                                   style: TextStyle(
//                                       fontSize: 18, color: Colors.white),
//                                 ),
//                                 Text(
//                                   "Looks like you don't have a project in progress, Start with adding one",
//                                   style: TextStyle(
//                                       fontSize: 12, color: Colors.white),
//                                   maxLines: 2,
//                                   overflow: TextOverflow.ellipsis,
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       )),
//                   Positioned(
//                     bottom: 0,
//                     child: ClipRRect(
//                       borderRadius: const BorderRadius.only(
//                           bottomLeft: Radius.circular(20)),
//                       child: SvgPicture.asset('assets/icon/bubbles.svg',
//                           height: 48,
//                           width: 40,
//                           colorFilter: const ColorFilter.mode(
//                               Color.fromARGB(255, 228, 111, 22),
//                               BlendMode.srcIn)),
//                     ),
//                   ),
//                   Positioned(
//                     top: -20,
//                     left: 0,
//                     child: Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         SvgPicture.asset(
//                           'assets/icon/fail.svg',
//                           height: 40,
//                         ),
//                         Positioned(
//                             top: 10,
//                             child: InkWell(
//                                 onTap: () {
//                                   ScaffoldMessenger.of(context)
//                                       .clearSnackBars();
//                                 },
//                                 child: SvgPicture.asset('assets/icon/close.svg',
//                                     height: 16)))
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               backgroundColor: Colors.transparent,
//             ))
//             .closed;
//       }
//       setState(() {
//         myProjectcount = myProjectData;
//         sharedWithMeCount = sharedData;
//         allprojectCount = allData;
//       });
//     } else {
//       // Handle errors
//       print('Failed to fetch data');
//     }
//   }

//   String? fetchedimageurl;
//   Uint8List? _imageBytes; // Uint8List to store the image data
//   String? _imageFileName;
//   Future<void> fetchProfileImageData() async {
//     final token = await TokenManager.getToken();
//     final String baseUrl = ApiConstants.baseUrl;
//     final String apiUrl = '$baseUrl/api/retrieve-image';
//     try {
//       final response = await http.get(
//         Uri.parse(apiUrl),
//         headers: {
//           'Authorization': 'Bearer $token',
//         },
//       );
//       if (response.statusCode == 401) {
//         LogoutService.logout();
//       }
//       if (response.statusCode >= 200 && response.statusCode <= 209) {
//         final Map<String, dynamic> jsonData = json.decode(response.body);
//         final trustedImageUrl = Uri.dataFromString(jsonData['image'],
//                 mimeType: 'image/*', encoding: Encoding.getByName('utf-8'))
//             .toString();
//         fetchedimageurl = trustedImageUrl;
//       } else {
//         throw Exception('Failed to load data: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to load data: $e');
//     }
//   }

//   void _openInvitePeoplePopup() {
//     // showDialog(
//     //   context: context,
//     //   // builder: (BuildContext context) {
//     //   //   // return InvitePeoplePopup(
//     //   //   //   onClose: _closeInvitePeoplePopup,
//     //   //   //   onInvite: _handleInvite,
//     //   //   // );
//     //   // },
//     // );
//   }

//   // Close the Invite People Popup
//   void _closeInvitePeoplePopup() {
//     Navigator.of(context).pop();
//   }

//   // Handle the Invite action (Replace with your API call logic)
//   void _handleInvite() async {
//     // Replace with your API call logic
//     // After the API call is done, close the popup
//     _closeInvitePeoplePopup();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Card(
//           elevation: 3,
//           color: const Color.fromARGB(255, 212, 218, 247),
//           child: Container(
//             height: 130,
//             width: MediaQuery.of(context).size.width - 20,
//             // decoration: BoxDecoration(
//             //   border: Border.all(
//             //     color: Colors.grey
//             //   )

//             // ),
//             padding: const EdgeInsets.only(right: 3, left: 3),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: [
//                 Container(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                           padding: const EdgeInsets.all(5),
//                           child: Row(
//                             children: [
//                               fetchedimageurl == null
//                                   ? Image.asset(
//                                       'assets/images/Transparent .png',
//                                       height: 100,
//                                       width: 100,
//                                     )
//                                   : CircleAvatar(
//                                       radius: 45,
//                                       backgroundImage:
//                                           NetworkImage("$fetchedimageurl")
//                                               as ImageProvider,
//                                     ),
//                               const SizedBox(
//                                 width: 10,
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width *
//                                     48 /
//                                     100,
//                                 alignment: Alignment.centerLeft,
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       'Hello ${userData['firstName'] ?? 'N/A'}!',
//                                       overflow: TextOverflow.clip,
//                                       style: GoogleFonts.poppins().copyWith(
//                                           fontSize: 18,
//                                           fontWeight: FontWeight.bold),
//                                     ),
//                                     Text(
//                                       userData['email'] ?? "N/A",
//                                       style: const TextStyle(
//                                           fontWeight: FontWeight.w300),
//                                     )
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           )),
//                       IconButton(
//                           onPressed: () {
//                             _openInvitePeoplePopup();
//                           },
//                           icon: const Icon(
//                             Icons.person_add_alt_rounded,
//                             size: 30,
//                           )),
//                       const SizedBox(
//                         width: 10,
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         const SizedBox(
//           height: 8,
//         ),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             GestureDetector(
//               // onTap: () {
//               //   Navigator.push(
//               //     context,
//               //     MaterialPageRoute(
//               //       builder: (context) => ProjectListScreenF(
//               //           type: "myproject"), // Get all projects
//               //       // VideoStreamPage(),
//               //     ),
//               //   );
//               // },
//               child: Card(
//                 color: const Color.fromARGB(255, 125, 81, 172),
//                 elevation: 2.0,
//                 child: Container(
//                   // height: 70, width: 70,
//                   height: 120,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           'assets/images/myproj.png',
//                           height: 60,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(
//                           height: 6,
//                         ),
//                         const Text(
//                           'My Projects',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               // onTap: () {
//               //   Navigator.push(
//               //     context,
//               //     MaterialPageRoute(
//               //       builder: (context) => ProjectListScreenF(
//               //           type: "sharedproject"), // Get all projects
//               //     ),
//               //   );
//               // },
//               child: Card(
//                 color: const Color.fromARGB(255, 110, 172, 253),
//                 elevation: 2.0,
//                 child: Container(
//                   height: 120,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         const SizedBox(
//                           height: 6,
//                         ),
//                         Image.asset(
//                           'assets/images/sharedwme.png',
//                           height: 42,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(
//                           height: 19,
//                         ),
//                         Container(
//                           width: MediaQuery.of(context).size.width * 18 / 100,
//                           child: const Text(
//                             'Shared',
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Colors.white,
//                                 fontSize: 14,
//                                 fontWeight: FontWeight.w600),
//                           ),
//                         ),
//                         // Text(
//                         //   sharedWithMeCount.toString(),
//                         //   style: const TextStyle(
//                         //     fontSize: 12,
//                         //     fontWeight: FontWeight.w800
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             GestureDetector(
//               // onTap: () {
//               //   Navigator.push(
//               //     context,
//               //     MaterialPageRoute(
//               //       builder: (context) => ProjectListScreenF(
//               //           type: "allproject"), // Get all projects
//               //     ),
//               //   );
//               // },
//               child: Card(
//                 color: Colors.green.shade300,
//                 elevation: 2.0,
//                 child: Container(
//                   height: 120,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       children: [
//                         Image.asset(
//                           'assets/images/allproj.png',
//                           height: 60,
//                           color: Colors.white,
//                         ),
//                         const SizedBox(
//                           height: 6,
//                         ),
//                         const Text(
//                           'All Projects',
//                           style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 14,
//                               fontWeight: FontWeight.w600),
//                         ),
//                         // Text(
//                         //   allprojectCount.toString(),
//                         //   style: const TextStyle(
//                         //     fontSize: 12,
//                         //     fontWeight: FontWeight.w800
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }

// class HomeDashboardScreen extends StatelessWidget {
//   final Map<String, dynamic> userData;

//   const HomeDashboardScreen({super.key, required this.userData});

//   @override
//   Widget build(BuildContext context) {
//     var firstName = userData['firstName'].toString();
//     return Card(
//       color: Colors.white,
//       shadowColor: Colors.white,
//       elevation: 2,
//       margin: const EdgeInsets.symmetric(horizontal: 10),
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 8,
//           ),
//           const Text(
//             'Activity',
//             style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
//           ),
//           Container(
//               child: Padding(
//             padding: const EdgeInsets.all(12.0),
//             child: Card(
//                 clipBehavior: Clip.antiAlias,
//                 elevation: 0,
//                 margin: getMargin(top: 5),
//                 color: ColorConstant.whiteA70099,
//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadiusStyle.roundedBorder6),
//                 child: Container(
//                     height: getVerticalSize(210),
//                     width: MediaQuery.of(context)
//                         .size
//                         .width, //getHorizontalSize(396),
//                     // padding: getPadding(
//                     //     left: 16, top: 17, right: 16, bottom: 17),
//                     decoration: AppDecoration.outlineGray70026.copyWith(
//                         borderRadius: BorderRadiusStyle.roundedBorder6),
//                     child: Stack(alignment: Alignment.centerRight, children: [
//                       Align(
//                           alignment: Alignment.topCenter,
//                           child: Padding(
//                               padding: getPadding(left: 1),
//                               child: Column(
//                                   mainAxisSize: MainAxisSize.min,
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   children: [
//                                     Row(
//                                         mainAxisAlignment:
//                                             MainAxisAlignment.center,
//                                         children: [
//                                           Text("08",
//                                               overflow: TextOverflow.ellipsis,
//                                               textAlign: TextAlign.left,
//                                               style: AppStyle.txtGilroyMedium10
//                                                   .copyWith(
//                                                       color: Colors.black,
//                                                       fontSize: 12)),
//                                           Expanded(
//                                               child: Padding(
//                                             padding:
//                                                 getPadding(top: 6, bottom: 5),
//                                             // child: Divider(
//                                             //     height: getVerticalSize(1),
//                                             //     thickness: getVerticalSize(1),
//                                             //     color:
//                                             //         ColorConstant.blueGray400,
//                                             //     indent: getHorizontalSize(9))
//                                           ))
//                                         ]),
//                                     Padding(
//                                         padding: getPadding(top: 28),
//                                         child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text("06",
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   textAlign: TextAlign.left,
//                                                   style: AppStyle
//                                                       .txtGilroyMedium10
//                                                       .copyWith(
//                                                           color: Colors.black,
//                                                           fontSize: 12)),
//                                               Expanded(
//                                                   child: Padding(
//                                                 padding: getPadding(
//                                                     top: 6, bottom: 5),
//                                                 // child: Divider(
//                                                 //     height: getVerticalSize(1),
//                                                 //     thickness:
//                                                 //         getVerticalSize(1),
//                                                 //     color: ColorConstant
//                                                 //         .blueGray400,
//                                                 //     indent:
//                                                 //         getHorizontalSize(9))
//                                               ))
//                                             ])),
//                                     Padding(
//                                         padding: getPadding(top: 28),
//                                         child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text("04",
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   textAlign: TextAlign.left,
//                                                   style: AppStyle
//                                                       .txtGilroyMedium10
//                                                       .copyWith(
//                                                           color: Colors.black,
//                                                           fontSize: 12)),
//                                               Expanded(
//                                                   child: Padding(
//                                                 padding: getPadding(
//                                                     top: 6, bottom: 5),
//                                                 // child: Divider(
//                                                 //     height: getVerticalSize(1),
//                                                 //     thickness:
//                                                 //         getVerticalSize(1),
//                                                 //     color: ColorConstant
//                                                 //         .blueGray400,
//                                                 //     indent:
//                                                 //         getHorizontalSize(9))
//                                               ))
//                                             ])),
//                                     Padding(
//                                         padding: getPadding(top: 28),
//                                         child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text("02",
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   textAlign: TextAlign.left,
//                                                   style: AppStyle
//                                                       .txtGilroyMedium10
//                                                       .copyWith(
//                                                           color: Colors.black,
//                                                           fontSize: 12)),
//                                               Expanded(
//                                                   child: Padding(
//                                                 padding: getPadding(
//                                                     top: 6, bottom: 5),
//                                                 // child: Divider(
//                                                 //     height: getVerticalSize(1),
//                                                 //     thickness:
//                                                 //         getVerticalSize(1),
//                                                 //     color: ColorConstant
//                                                 //         .blueGray400,
//                                                 //     indent:
//                                                 //         getHorizontalSize(10))
//                                               ))
//                                             ])),
//                                     Padding(
//                                         padding: getPadding(top: 28),
//                                         child: Row(
//                                             mainAxisAlignment:
//                                                 MainAxisAlignment.center,
//                                             children: [
//                                               Text("00",
//                                                   overflow:
//                                                       TextOverflow.ellipsis,
//                                                   textAlign: TextAlign.left,
//                                                   style: AppStyle
//                                                       .txtGilroyMedium10
//                                                       .copyWith(
//                                                           color: Colors.black,
//                                                           fontSize: 12)),
//                                               Expanded(
//                                                   child: Padding(
//                                                 padding: getPadding(
//                                                     top: 6, bottom: 5),
//                                                 // child: Divider(
//                                                 //     height: getVerticalSize(1),
//                                                 //     thickness:
//                                                 //         getVerticalSize(1),
//                                                 //     color: ColorConstant
//                                                 //         .blueGray400,
//                                                 //     indent:
//                                                 //         getHorizontalSize(9))
//                                               ))
//                                             ]))
//                                   ]))),
//                       Align(
//                         alignment: Alignment.centerRight,
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.end,
//                           children: [
//                             buildContainer(
//                                 height: 97,
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.028,
//                                 margin: const EdgeInsets.only(top: 45),
//                                 text: "08/21"),
//                             buildContainer(
//                                 height: 138,
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.028,
//                                 margin:
//                                     const EdgeInsets.only(left: 23, top: 19),
//                                 text: "08/22"),
//                             buildContainer(
//                                 height: 160,
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.028,
//                                 margin: const EdgeInsets.only(left: 21, top: 5),
//                                 text: "08/23"),
//                             buildContainer(
//                                 height: 83,
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.028,
//                                 margin:
//                                     const EdgeInsets.only(left: 21, top: 53),
//                                 text: "08/24"),
//                             buildContainer(
//                                 height: 64,
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.028,
//                                 margin:
//                                     const EdgeInsets.only(left: 20, top: 65),
//                                 text: "08/25"),
//                             buildContainer(
//                                 height: 126,
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.028,
//                                 margin:
//                                     const EdgeInsets.only(left: 21, top: 26),
//                                 text: "08/26"),
//                             buildContainer(
//                                 height: 83,
//                                 width:
//                                     MediaQuery.of(context).size.width * 0.028,
//                                 margin:
//                                     const EdgeInsets.only(left: 22, top: 53),
//                                 text: "08/27"),
//                           ],
//                         ),
//                       )
//                     ]))),
//           )),
//         ],
//       ),
//     );
//     // );
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
//               color: const Color.fromARGB(255, 198, 183, 232),
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

// class NotificationItem extends StatelessWidget {
//   final Map<String, dynamic> notification;

//   NotificationItem({required this.notification});
//   ApiServiceProfileManagement api = ApiServiceProfileManagement();

//   @override
//   Widget build(BuildContext context) {
//     String? imageUrl =
//         'http://43.205.154.152:30165/assets/images/profile-icon.png';
//     ;
//     Future<String?> _getImage(Map<String, dynamic> notification) async {
//       final token = await TokenManager.getToken();
//       final String baseUrl = ApiConstants.baseUrl;
//       final String apiUrl = '$baseUrl/api/user-profile';
//       try {
//         final response = await http.get(
//           Uri.parse(apiUrl),
//           headers: {
//             'Authorization': 'Bearer $token',
//           },
//         );
//         if (response.statusCode == 401) {
//           LogoutService.logout();
//         }
//         if (response.statusCode >= 200 && response.statusCode <= 209) {
//           final Map<String, dynamic> jsonData = json.decode(response.body);
//           print('image is ${jsonData['image']}');
//           final trustedImageUrl = Uri.dataFromString(jsonData['image'],
//                   mimeType: 'image/*', encoding: Encoding.getByName('utf-8'))
//               .toString();

//           // print('Url Fetched....... $imageUrl');
//           if (jsonData['image'] == null) {
//             return 'http://43.205.154.152:30165/assets/images/profile-icon.png';
//           } else {
//             imageUrl = trustedImageUrl;
//             return imageUrl;
//           }
//         } else {
//           throw Exception('Failed to load data: ${response.statusCode}');
//         }
//       } catch (e) {
//         throw Exception('Failed to load : $e');
//       }
//     }

//     final notificationText = notification['notification'] as String;
//     final time = notification['time'] as String;
//     final timeDifference = calculateTimeDifference(time);

//     Widget avatar = FutureBuilder<String?>(
//         future: _getImage(notification),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           } else if (snapshot.hasError) {
//             print(snapshot.error);
//             // ScaffoldMessenger.of(context).showSnackBar(
//             //SnackBar(content: Text('Error: ${snapshot.error}')));
//             return CircleAvatar(
//                 radius: 20, backgroundImage: NetworkImage(imageUrl!));
//           } else {
//             imageUrl = snapshot.data;

//             return CircleAvatar(
//               radius: 5,
//               backgroundImage: NetworkImage(imageUrl!),
//             );
//           }
//         });

//     Widget content = Container(
//       height: 40,
//       child: ListTile(
//         leading: avatar,
//         // title: Text(
//         //   notificationText,
//         //   style: TextStyle(fontSize: 12, color: Colors.grey[800]),
//         // ),
//         // subtitle: Text(timeDifference),
//       ),
//     );

//     Widget c = Container(
//       padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.start,
//         children: [
//           avatar,
//           const SizedBox(
//             width: 6,
//           ),
//           Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 notificationText,
//                 style: TextStyle(fontSize: 12, color: Colors.grey[800]),
//               ),
//               const SizedBox(
//                 height: 4,
//               ),
//               Text(
//                 timeDifference,
//                 style: TextStyle(fontSize: 12, color: Colors.grey[800]),
//               ),
//             ],
//           )
//         ],
//       ),
//     );

//     return content;
//   }

//   String calculateTimeDifference(String time) {
//     final currentTime = DateTime.now();
//     final notificationTime = DateTime.parse(time);

//     final difference = currentTime.difference(notificationTime);

//     if (difference.inDays >= 365) {
//       final years = (difference.inDays / 365).floor();
//       return '${years} ${years == 1 ? 'year' : 'years'} ago';
//     } else if (difference.inDays >= 30) {
//       final months = (difference.inDays / 30).floor();
//       return '${months} ${months == 1 ? 'month' : 'months'} ago';
//     } else if (difference.inDays > 0) {
//       return '${difference.inDays} ${difference.inDays == 1 ? 'day' : 'days'} ago';
//     } else if (difference.inHours > 0) {
//       return '${difference.inHours} ${difference.inHours == 1 ? 'hour' : 'hours'} ago';
//     } else {
//       return 'Just now';
//     }
//   }
// }
