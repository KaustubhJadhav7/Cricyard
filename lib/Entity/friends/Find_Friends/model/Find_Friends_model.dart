import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class FindFriendsModel {
  final ScrollController scrollController = ScrollController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> searchEntities = [];
  Map<String, dynamic> formData = {};

  bool isLoading = false;
  int currentPage = 0;
  int pageSize = 10;

  bool isActive = false;

  stt.SpeechToText speech = stt.SpeechToText();
}
