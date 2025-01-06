import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../repository/FeedBack_Form_api_service.dart';
// import '../model/FeedBack_Form_model.dart';
import '/providers/token_manager.dart';

class FeedbackProvider extends ChangeNotifier {
  final FeedbackFormApiService apiService = FeedbackFormApiService();
  final stt.SpeechToText speech = stt.SpeechToText();
  // List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> searchEntities = [];
  final ScrollController scrollController = ScrollController();

  bool showCardView = true;
  bool isLoading = false;
  
  int currentPage = 0;
  int pageSize = 10;

  TextEditingController searchController = TextEditingController();

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchEntities();
    }
  }
  
  FeedbackProvider() {
    fetchWithoutPaging();
    fetchEntities();
  }

  Future<void> fetchWithoutPaging() async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        final fetchedEntities = await apiService.getEntities();
        searchEntities = fetchedEntities;
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }
  // final Map<String, dynamic> entity;
  final Map<String, dynamic> formData = {};
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _isEmailFieldEmailValid = true;

  // Getter for email validation state
  bool get isEmailFieldEmailValid => _isEmailFieldEmailValid;

  // Method to validate email
  void validateEmailFieldEmail(String email) {
    _isEmailFieldEmailValid =
        RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+\$').hasMatch(email);
    notifyListeners();
  }

  Future<void> fetchEntities() async {
    try {
      isLoading = true;
      notifyListeners();

      final token = await TokenManager.getToken();
      if (token != null) {
        final fetchedEntities = await apiService.getAllWithPagination(currentPage, pageSize);
        entities.addAll(fetchedEntities);
        filteredEntities = entities.toList();
        currentPage++;
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      await apiService.deleteEntity(entity['id']);
      entities.remove(entity);
      filteredEntities = entities.toList();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  void search_Entities(String keyword) {
    filteredEntities = searchEntities
        .where((entity) =>
            entity['name'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['phone_number'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['email_field'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['share_your_experience'].toString().toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> startListening() async {
    if (!speech.isListening) {
      bool available = await speech.initialize();
      if (available) {
        speech.listen(onResult: (result) {
          if (result.finalResult) {
            searchController.text = result.recognizedWords;
            search_Entities(result.recognizedWords);
          }
        });
      }
    }
  }

  void stopListening() {
    if (speech.isListening) {
      speech.stop();
    }
  }
}
