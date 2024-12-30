import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class UserManager {
  static const String _userKey = 'user';
  static UserManager? _instance;
  static Map<String, dynamic>? _cachedUser;

  // Private constructor for singleton
  UserManager._privateConstructor();

  // Factory constructor to get the singleton instance
  factory UserManager() {
    _instance ??= UserManager._privateConstructor();
    return _instance!;
  }

  // Initialize and load user data
  Future<void> initialize() async {
    if (_cachedUser == null) {
      final prefs = await SharedPreferences.getInstance();
      final userData = prefs.getString(_userKey);
      if (userData != null) {
        _cachedUser = jsonDecode(userData) as Map<String, dynamic>;
      }
    }
  }

  // Accessor for user token
  String? get token {
    return _cachedUser?['token'];
  }

  // Accessor for user name
  String? get userName {
    return _cachedUser?['fullname'];
  }

  // Accessor for user email
  String? get email {
    return _cachedUser?['email'];
  }

  // Accessor for user id
  int? get userId {
    return _cachedUser?['userId'];
  }

  // Accessor for user roles (Assuming it's a list of roles in the user data)
  List<String>? get roles {
    if (_cachedUser?['roles'] != null) {
      return List<String>.from(_cachedUser!['roles']);
    }
    return null;
  }

  // Save user data and cache it
  Future<void> setUser(Map<String, dynamic> user) async {
    final prefs = await SharedPreferences.getInstance();
    final userData = jsonEncode(user);
    await prefs.setString(_userKey, userData);
    _cachedUser = user; // Update cache
  }

  // Clear user data and cache
  Future<void> clearUser() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_userKey);
    await prefs.remove('isLoggedIn');
    await prefs.clear();
    _cachedUser = null; // Clear cache
  }
}
