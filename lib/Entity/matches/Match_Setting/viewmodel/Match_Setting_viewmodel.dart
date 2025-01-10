import 'package:cricyard/Entity/matches/Match_Setting/model/Match_Setting_model.dart';
import 'package:cricyard/Entity/matches/Match_Setting/repository/Match_Setting_api_service.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class MatchSettingProvider with ChangeNotifier {
  final MatchSettingApiService apiService = MatchSettingApiService();
  MatchSetting _matchSetting = MatchSetting();

  // Getter for the model
  MatchSetting get matchSetting => _matchSetting;

  // Methods to update the model
  void updateName(dynamic value) {
    _matchSetting.name = value;
    notifyListeners();
  }

  Future<void> updateMatchSetting(dynamic id, Map<String, dynamic> updatedData) async {
    try {
      await apiService.updateEntity(id, updatedData);
      notifyListeners(); // Notify listeners in case of state change
    } catch (e) {
      throw Exception('Failed to update match setting: $e');
    }
  }

  void updateDescription(dynamic value) {
    _matchSetting.description = value;
    notifyListeners();
  }

  void updateForOvers(dynamic value) {
    _matchSetting.forOvers = value;
    notifyListeners();
  }

  void toggleActive(bool value) {
    _matchSetting.isActive = value;
    notifyListeners();
  }

  void toggleDisableWagonWheelForDotBall(bool value) {
    _matchSetting.isDisableWagonWheelForDotBall = value;
    notifyListeners();
  }

  void toggleDisableWagonWheelFor1s2sAnd3s(bool value) {
    _matchSetting.isDisableWagonWheelFor1s2sAnd3s = value;
    notifyListeners();
  }

  void toggleDisableShotSelection(bool value) {
    _matchSetting.isDisableShotSelection = value;
    notifyListeners();
  }

  void toggleCountWideAsLegalDelivery(bool value) {
    _matchSetting.isCountWideAsLegalDelivery = value;
    notifyListeners();
  }

  void toggleCountNoBallAsLegalDelivery(bool value) {
    _matchSetting.isCountNoBallAsLegalDelivery = value;
    notifyListeners();
  }

  // Method to reset the form
  void resetForm() {
    _matchSetting = MatchSetting();
    notifyListeners();
  }

  Future<void> submitForm() async {
    try {
      final formData = _matchSetting.toMap();
      final response = await apiService.createEntity(formData); // Replace with your API call
      print('Entity created successfully: $response');
    } catch (error) {
      print('Error creating entity: $error');
      throw error;
    }
  }
  final stt.SpeechToText _speech = stt.SpeechToText();
  bool isListening = false;
  final TextEditingController searchController = TextEditingController();

  void startListening() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {
          print('Speech recognition status: $status');
        },
        onError: (error) {
          print('Speech recognition error: $error');
        },
      );

      if (available) {
        _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              searchController.text = result.recognizedWords;
              searchEntities(result.recognizedWords); // Use the provider's search method
              notifyListeners(); // Notify listeners about changes
            }
          },
        );
        isListening = true;
        notifyListeners();
      }
    }
  }

  void stopListening() {
    if (_speech.isListening) {
      _speech.stop();
      isListening = false;
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> _entities = [];
  List<Map<String, dynamic>> _filteredEntities = [];
  List<Map<String, dynamic>> _searchEntities = [];
  bool _isLoading = false;
  int _currentPage = 0;
  final int _pageSize = 10;

  List<Map<String, dynamic>> get entities => _filteredEntities;
  bool get isLoading => _isLoading;

  Future<void> fetchEntities() async {
    _setLoading(true);
    try {
        final fetchedEntities = await apiService.getAllWithPagination(_currentPage, _pageSize);
        _entities.addAll(fetchedEntities);
        _filteredEntities = List.from(_entities);
        _currentPage++;
      
    } catch (e) {
      debugPrint('Error fetching entities: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchWithoutPaging() async {
    try {
        _searchEntities = await apiService.getEntities();
        notifyListeners();
      
    } catch (e) {
      debugPrint('Error fetching entities without paging: $e');
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
        await apiService.deleteEntity(entity['id']);
        _entities.remove(entity);
        _filteredEntities.remove(entity);
        notifyListeners();
      
    } catch (e) {
      debugPrint('Error deleting entity: $e');
    }
  }

  void searchEntities(String keyword) {
  _filteredEntities = _searchEntities
      .where((entity) =>
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
              .contains(keyword.toLowerCase()) ||
          entity['disable_wagon_wheel_for_dot_ball']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          entity['disable_wagon_wheel_for_1s_2s_and_3s']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          entity['disable_shot_selection']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          entity['count_wide_as_a_legal_delivery']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          entity['count_no_ball_as_a_legal_delivery']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          entity['for_overs']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()))
      .toList();
  notifyListeners();
}


  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
