import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class EventManagementModel {
  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> searchEntities = [];
  bool showCardView = true;
  bool isLoading = false;
  int currentPage = 0;
  int pageSize = 10;

  EventManagementModel();
}

class EventManagementControllers {
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  late stt.SpeechToText speech;

  EventManagementControllers() {
    speech = stt.SpeechToText();
  }

  void dispose() {
    searchController.dispose();
    scrollController.dispose();
  }
}