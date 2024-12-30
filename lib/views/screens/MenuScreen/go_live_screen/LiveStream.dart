// import 'package:cricyard/core/utils/size_utils.dart';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:html';
// import 'dart:ui' as ui;
// import '../../../theme/theme_helper.dart';
// import '../../ReuseableWidgets/BottomAppBarWidget.dart';
// import '../../ReuseableWidgets/CustomDrawer.dart';
// import '../../ReuseableWidgets/headerWidget.dart';

// class MiddleBoxWithIframe extends StatefulWidget {
//   @override
//   _MiddleBoxWithIframeState createState() => _MiddleBoxWithIframeState();
// }

// class _MiddleBoxWithIframeState extends State<MiddleBoxWithIframe> {
//   final IFrameElement _iFrameElement = IFrameElement();

//   @override
//   void initState() {
//     super.initState();
//     // Setting initial properties for iframe
//     _iFrameElement.style.position = 'absolute';
//     _iFrameElement.style.top = '0';
//     _iFrameElement.style.left = '0';
//     _iFrameElement.style.bottom = '0';
//     _iFrameElement.style.right = '0';
//     _iFrameElement.style.height = '100%';
//     _iFrameElement.style.width = '100%';
//     _iFrameElement.src = 'http://52.2.133.246:8000/';
//     _iFrameElement.style.border = 'none';
//     _iFrameElement.allowFullscreen = true;

//     // Registering iframe element with Flutter's platform view registry
//     // ignore: undefined_prefixed_name
//     ui.platformViewRegistry.registerViewFactory(
//       'iframeElement',
//       (int viewId) => _iFrameElement,
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final Widget iframeWidget = HtmlElementView(
//       viewType: 'iframeElement',
//       key: UniqueKey(),
//     );

//     return Scaffold(
//       body: Container(
//         width: double.infinity,
//         height: double.infinity,
//         child: iframeWidget,
//       ),
//     );
//   }
// }

// //   @override
// //   Widget build(BuildContext context) {
// //     final Widget iframeWidget = HtmlElementView(
// //       viewType: 'iframeElement',
// //       key: UniqueKey(),
// //     );

// //     // Calculating box width and height based on screen size
// //     final double boxWidth = MediaQuery.of(context).size.width * 0.8;
// //     final double boxHeight = MediaQuery.of(context).size.height * 0.6;

// //     return Center(
// //       child: Container(
// //         width: boxWidth,
// //         height: boxHeight,
// //         padding: const EdgeInsets.all(10.0), // Adjusted padding
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Expanded(
// //               child: AspectRatio(
// //                 aspectRatio: 4 / 3, // Adjust aspect ratio as needed
// //                 child: Container(
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(20),
// //                     border: Border.all(
// //                       color: Colors.grey,
// //                       width: 1,
// //                     ),
// //                   ),
// //                   child: ClipRRect(
// //                     borderRadius: BorderRadius.circular(20),
// //                     child: iframeWidget,
// //                   ),
// //                 ),
// //               ),
// //             ),
// //             const SizedBox(height: 20),
// //             // ElevatedButton(
// //             //   onPressed: () {
// //             //     // Implement your logic here for the Go Live button
// //             //   },
// //             //   child: Text('Go Live'),
// //             // ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // DashboardScreen widget
// class LiveStream extends StatefulWidget {
//   LiveStream(this.userData, {Key? key}) : super(key: key);
//   final Map<String, dynamic> userData;

//   @override
//   _DashboardScreenState createState() => _DashboardScreenState();
// }

// class _DashboardScreenState extends State<LiveStream> {
//   int _currentTab = 0;
//   final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

//   @override
//   void initState() {
//     super.initState();
//     getUserData();
//     print('user data is ..$userData');
//   }

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

//   void setTab(int index) {
//     setState(() {
//       _currentTab = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return PopScope(
//       child: Scaffold(
//         key: _scaffoldKey,
//         drawer: CustomDrawer(context: context),
//         bottomNavigationBar: BottomAppBarWidget(),
//         floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
//         backgroundColor: const Color(0xfffefefe),
//         extendBodyBehindAppBar: true,
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
//                     SizedBox(height: 21.v),
//                     Divider(
//                       color: theme.colorScheme.primaryContainer,
//                       indent: 37.h,
//                       endIndent: 28.h,
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 8.v),
//               Expanded(
//                 child: MiddleBoxWithIframe(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
