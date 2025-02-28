// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:cricyard/data/network/network_api_service.dart';
import 'package:cricyard/resources/api_constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SportSelectionProvider with ChangeNotifier {
  String userId = "";
  String? selectedSport;
  final NetworkApiService networkApiService = NetworkApiService();
  final String baseUrl = ApiConstants.baseUrl;

  SportSelectionProvider() {
    fetchUserId();
    fetchPreferredSport();

  }
  /// Fetch the preferred sport from SharedPreferences
  Future<void> fetchPreferredSport() async {
    final prefs = await SharedPreferences.getInstance();
    selectedSport = prefs.getString('preferred_sport') ?? "None";
    print("🎯 Fetched preferred sport: $selectedSport");
    notifyListeners();
  }

  Future<void> fetchUserId() async {
    final prefs = await SharedPreferences.getInstance();
    String? userDataStr = prefs.getString('userData');

    if (userDataStr != null) {
      try {
        Map<String, dynamic> userData = json.decode(userDataStr);
        if (userData.containsKey('userId')) {
          userId = userData['userId'].toString();
          notifyListeners();
        } else {
          print("User ID not found in stored user data.");
          userId = "";
        }
      } catch (e) {
        print("Error fetching userId: $e");
      }
    }
  }

  Future<void> savePreferredSport(String sport) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (sport == 'None') {
      await prefs.remove('preferred_sport');
    } else {
      await prefs.setString('preferred_sport', sport);
    }
    selectedSport = sport;
    notifyListeners(); // 🔄 Ensure UI updates

    if (userId.isNotEmpty) {
      await _updateSportOnBackend(sport);
    } else {
      print("User not logged in, skipping sport update on backend.");
    }

    String? savedSport = prefs.getString('preferred_sport');
    print('Saved sport in shared preference: $savedSport');
  }

  Future<void> _updateSportOnBackend(String sport) async {
    if (userId.isEmpty) {
      print("🚫 User ID is empty. Skipping sport update.");
      return;
    }
    final String endpoint = "/api/setSport";
    final String encodedSport = Uri.encodeComponent(sport);
    final String url = "$baseUrl$endpoint?userId=$userId&sport=$encodedSport";
    print("Sending Sport Selection API request: $url");
    try {
      final response = await networkApiService.getPostApiResponse(url, {});
      if (response is Map<String, dynamic> &&
          response.containsKey('preferred_sport')) {
        if (response['preferred_sport'] == sport) {
          print("✅ Sport updated successfully on the backend.");
        } else {
          print(
              "⚠️ Sport update did not reflect correctly. Received: ${response['preferred_sport']}");
        }
      } else {
        print("❌ Failed to update sport in Backend. Response: $response");
      }
    } catch (e) {
      print("⚠️ Error updating sport on backend: $e");
    }
  }
}
