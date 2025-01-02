import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'core/utils/size_utils.dart';
import 'routes/app_routes.dart';
import 'views/screens/MenuScreen/merch/provider/product_data_provider.dart';
import 'theme/theme_helper.dart';
import 'package:cricyard/Entity/absent_hurt/Absent_hurt/viewmodel/absent_hurt_viewmodel.dart';
import 'package:cricyard/Entity/add_tournament/My_Tournament/viewmodel/My_Tournament_viewmodel.dart';
import 'package:cricyard/views/screens/practice_match/viewmodel/practice_matchview_model.dart';
// lib\views\screens\practice_match\viewmodel\practice_matchview_model.dart

//const simplePeriodicTask = "simplePeriodicTask";

// void showNotification(String v, FlutterLocalNotificationsPlugin flp) async {
//   var android = const AndroidNotificationDetails(
//     'channel id',
//     'channel NAME',
//     priority: Priority.high,
//     importance: Importance.max,
//   );
//   var iOS = const IOSNotificationDetails();
//   var platform = NotificationDetails(android: android, iOS: iOS);
//   await flp.show(0, 'CloudnSure', '$v', platform, payload: 'VIS \n $v');
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  ThemeHelper().changeTheme('primary');

  //Request notification permissions
  // await _requestNotificationPermissions();

  // await Workmanager().initialize(callbackDispatcher);
  // await Workmanager().registerPeriodicTask(
  //   "5",
  //   simplePeriodicTask,
  //   existingWorkPolicy: ExistingWorkPolicy.replace,
  //   frequency: const Duration(minutes: 15),
  //   initialDelay: const Duration(seconds: 5),
  //   constraints: Constraints(networkType: NetworkType.connected),
  // );
  // runApp(MyApp());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ProductProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => PracticeMatchviewModel(),
      ),
      ChangeNotifierProvider(
        create: (_) => AbsentHurtProvider(),
      ),
      ChangeNotifierProvider(
        create: (_) => MyTournamentProvider(),
      )
    ],
    child: MyApp(),
  ));
}

// Future<void> _requestNotificationPermissions() async {
//   final status = await Permission.notification.request();
//   if (status.isGranted) {
//     print('Notification permissions granted');
//   } else {
//     print('Notification permissions denied');
//   }
// }

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     FlutterLocalNotificationsPlugin flp = FlutterLocalNotificationsPlugin();
//     var android = const AndroidInitializationSettings('@mipmap/ic_launcher');
//     var iOS = const IOSInitializationSettings();
//     var initSettings = InitializationSettings(android: android, iOS: iOS);
//     flp.initialize(initSettings);
//     String baseUrl = ApiConstants.baseUrl;
//     final apiUrl = '$baseUrl/user_notifications/get_unseen';
//     final token = await TokenManager.getToken();
//     final response = await http.get(
//       Uri.parse(apiUrl),
//       headers: {
//         'Authorization': 'Bearer $token',
//         'Content-Type': 'application/json',
//       },
//     );
//     if (response.statusCode <= 209) {
//       final List<dynamic> data = jsonDecode(response.body);
//       List<Map<String, dynamic>> notifications =
//           data.cast<Map<String, dynamic>>();
//       notifications.forEach((element) async {
//         showNotification(element['notification'], flp);
//         int id = element['id'];
//         final apiUrl2 = '$baseUrl/user_notifications/seen_success/$id';
//         final response2 = await http.get(
//           Uri.parse(apiUrl2),
//           headers: {
//             'Authorization': 'Bearer $token',
//             'Content-Type': 'application/json',
//           },
//         );
//         if (response2.statusCode <= 209) {
//           print("seen request to web success");
//         }
//       });
//     } else {
//       print('Failed to fetch data');
//     }
//     return Future.value(true);
//   });
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Welcome to cloudNsure',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: const LoginScreen(),
//       routes: {
//         // '/load': (context) => const ProjectListScreen(),
//
//
//       },
//     );
//   }
// }
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//
//
//   double getMargin(BuildContext context) {
//     // Calculate the margin based on a percentage of screen width
//     double screenWidth = MediaQuery.of(context).size.width;
//     double marginPercentage = 0.2; // Adjust the percentage as needed
//     return screenWidth * marginPercentage;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return kIsWeb
//         ? Container(
//             margin: EdgeInsets.symmetric(
//               horizontal: getMargin(context),
//             ),
//             child: MaterialApp(
//               navigatorKey: navigatorKey,
//               debugShowCheckedModeBanner: false,
//               title: 'Welcome to cloudNsure',
//               theme: ThemeData(
//                 primarySwatch: Colors.blue,
//                 visualDensity: VisualDensity.adaptivePlatformDensity,
//               ),
//               home:SplashScreen(),
//               routes: {
//
//                 '/regi': (context) =>
//                     RegistrationDetailsScreen(email: 'gaurav@dekatc.com'),
//                 '/user': (context) => CreateUserScreen(),
//
//               },
//             ),
//           )
//         : MaterialApp(
//             debugShowCheckedModeBanner: false,
//             title: 'Welcome to cloudNsure',
//             theme: ThemeData(
//               primarySwatch: Colors.blue,
//               visualDensity: VisualDensity.adaptivePlatformDensity,
//             ),
//             home: SplashScreen(),
//             routes: {
//               // '/load': (context) => const ProjectListScreen(),
//

//             },
//           );
//   }
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       // home: LoginOneScreen(),
//       initialRoute: AppRoutes.loginOneScreen,

//       routes: AppRoutes.routes,
//       theme: ThemeData(
//         primaryColor: Colors.blue,
//         appBarTheme: const AppBarTheme(
//           color: Colors.blue,
//         ),
//       ),
//     );
//   }
// }
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp(
          theme: theme,
          title: 'CricYard',
          debugShowCheckedModeBanner: false,
          initialRoute: AppRoutes.spalshscreen,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}