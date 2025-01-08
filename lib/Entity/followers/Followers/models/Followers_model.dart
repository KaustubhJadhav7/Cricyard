import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '/providers/token_manager.dart';
import '../repository/Followers_api_service.dart';

class FollowersModel {
  final FollowersApiService apiService = FollowersApiService();
  final stt.SpeechToText speech = stt.SpeechToText();
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> searchEntities = [];

  bool showCardView = true;
  bool isLoading = false;
  int currentPage = 0;
  int pageSize = 10;

  FollowersModel();
}