import 'package:cricyard/views/screens/Login%20Screen/view/login_screen_f.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../main.dart';

class LogoutService {
  static Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('userData');
    await prefs.remove('isLoggedIn');
    // await prefs.clear();
    const storage = FlutterSecureStorage();
    await storage.delete(key: 'token');
    navigatorKey.currentState!.pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => LoginScreenF(true)),
      (route) => false, // Remove all routes from the stack
    );
    // prefs.clear();
  }
}
