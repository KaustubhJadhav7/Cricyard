import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../repository/LeaderBoard_api_service.dart';

class LeaderboardProvider extends ChangeNotifier {
  final LeaderboardApiService _apiService = LeaderboardApiService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners(); // Notify listeners when the value changes
  }

  String? _errorMessage;
  String? get errorMessage => _errorMessage;

  bool _isActive = false;
  bool get isActive => _isActive;

  void toggleActive(bool value) {
    _isActive = value;
    notifyListeners();
  }

  final Map<String, dynamic> _formData = {};
  Map<String, dynamic> get formData => _formData;

  void updateFormData(String key, dynamic value) {
    _formData[key] = value;
  }

  Future<void> createLeaderboard() async {
    _setLoading(true);

    try {
      final createdEntity = await _apiService.createEntity(_formData);
      _errorMessage = null;
      _resetForm(); // Optionally reset the form after successful creation
    } catch (error) {
      _errorMessage = 'Failed to create LeaderBoard: $error';
    } finally {
      _setLoading(false);
    }
  }

  void _resetForm() {
    _formData.clear();
    _isActive = false;
    notifyListeners();
  }

  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> searchEntities = [];

  bool showCardView = true;
  // bool isLoading = false;
  int currentPage = 0;
  int pageSize = 10;

  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  final LeaderboardApiService apiService = LeaderboardApiService();

  //  final LeaderboardApiService apiService;

  // LeaderboardProvider(this.apiService);

  late stt.SpeechToText speech;

  // LeaderboardProvider.initialize() {
  //   speech = stt.SpeechToText();
  //   scrollController.addListener(scrollListener);
  //   fetchEntities();
  //   fetchWithoutPaging();
  // }

  Future<void> fetchWithoutPaging() async {
    try {
      // final token = await TokenManager.getToken();
      
        final fetchedEntities = await apiService.getEntities();
        searchEntities = fetchedEntities;
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to fetch LeaderBoard data: $e');
    }
  }

  Future<void> fetchEntities() async {
    try {
      isLoading = true;
      notifyListeners();

        final fetchedEntities = await apiService.getAllWithPagination(currentPage, pageSize);
        entities.addAll(fetchedEntities);
        filteredEntities = List.from(entities);
        currentPage++;
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to fetch LeaderBoard data: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      fetchEntities();
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      await apiService.deleteEntity(entity['id']);
      entities.remove(entity);
      filteredEntities = List.from(entities);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  void searchEntitiesByKeyword(String keyword) {
    filteredEntities = searchEntities
        .where((entity) =>
            entity['location'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['format'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['team'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['tournament'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['league'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['name'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['description'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['active'].toString().toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }


  
// void toggleActive(bool value) {
//     isActive = value;
//     notifyListeners();
//   }

  Future<void> updateEntity(int id, Map<String, dynamic> entity) async {
    try {
      await apiService.updateEntity(id, entity);
      notifyListeners(); // Notify listeners if needed (e.g., for refreshing the UI)
    } catch (e) {
      throw Exception('Failed to update LeaderBoard: $e');
    }
  }

  void startListening() async {
    if (!speech.isListening) {
      bool available = await speech.initialize(
        onStatus: (status) {
          print('Speech recognition status: $status');
        },
        onError: (error) {
          print('Speech recognition error: $error');
        },
      );

      if (available) {
        speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              searchController.text = result.recognizedWords;
              searchEntitiesByKeyword(result.recognizedWords);
            }
          },
        );
      }
    }
  }

  void stopListening() {
    if (speech.isListening) {
      speech.stop();
    }
  }

  void disposeProvider() {
    speech.cancel();
    scrollController.dispose();
    searchController.dispose();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
