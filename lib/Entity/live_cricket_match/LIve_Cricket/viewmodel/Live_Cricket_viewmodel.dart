import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import '../repository/LIve_Cricket_api_service.dart';
import '/providers/token_manager.dart';

class LiveCricketProvider extends ChangeNotifier {
  final LiveCricketApiService apiService = LiveCricketApiService();
  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> searchEntities = [];

  bool isLoading = false;
  int currentPage = 0;
  int pageSize = 10;

  LiveCricketProvider() {
    fetchEntities(); // Automatically fetch entities on initialization
    fetchWithoutPaging();
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
      debugPrint('Failed to fetch entities without paging: $e');
    }
  }

  Future<void> fetchEntities() async {
    try {
      isLoading = true;
      notifyListeners();

      final token = await TokenManager.getToken();
      if (token != null) {
        final fetchedEntities =
            await apiService.getAllWithPagination(token, currentPage, pageSize);
        entities.addAll(fetchedEntities);
        filteredEntities = List.from(entities);
        currentPage++;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to fetch entities: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        await apiService.deleteEntity(token, entity['id']);
        entities.remove(entity);
        filteredEntities = List.from(entities);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to delete entity: $e');
    }
  }

  void searchEntitiesByKeyword(String keyword) {
    filteredEntities = searchEntities
        .where((entity) =>
            entity['overs']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['team_run_rate']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['name']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['description']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['active']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  bool isActive = false; // Tracks the `isactive` state

  // Updates the `isactive` value
  void updateActiveStatus(bool newValue) {
    isActive = newValue;
    notifyListeners();
  }

  Future<void> createEntity(Map<String, dynamic> formData) async {
    try {
      formData['active'] = isActive; // Add `isActive` to the form data
      Map<String, dynamic> createdEntity =
          await apiService.createEntity(formData);

      debugPrint('Entity created successfully: $createdEntity');
      // Notify listeners if additional actions are required after creation
    } catch (e) {
      debugPrint('Failed to create entity: $e');
      rethrow; // Rethrow the error so the UI can handle it (e.g., show a dialog)
    }
  }

  final ScrollController scrollController = ScrollController();
  late SpeechToText speech;
  bool isListening = false; // Track if the speech recognizer is listening
  String recognizedText = ''; // Track the recognized speech text

  Future<void> startListening(TextEditingController searchController) async {
    if (!speech.isListening) {
      bool available = await speech.initialize(
        onStatus: (status) {
          debugPrint('Speech recognition status: $status');
        },
        onError: (error) {
          debugPrint('Speech recognition error: $error');
        },
      );

      if (available) {
        isListening = true;
        notifyListeners();

        speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              recognizedText = result.recognizedWords;
              searchController.text = recognizedText;
              searchEntitiesByKeyword(recognizedText);
              notifyListeners();
            }
          },
        );
      }
    }
  }

  void stopListening() {
    if (speech.isListening) {
      speech.stop();
      isListening = false;
      notifyListeners();
    }
  }
}
