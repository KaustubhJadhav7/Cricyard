import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../repository/live_score_update_api_service.dart';
import '../model/Live_Score_model.dart';
// import '../repository/token_manager.dart';

class LiveScoreUpdateProvider extends ChangeNotifier {
  final LiveScoreUpdateApiService _apiService = LiveScoreUpdateApiService();
  late stt.SpeechToText _speech;

  List<LiveScoreUpdate> _entities = [];
  List<LiveScoreUpdate> _filteredEntities = [];
  List<LiveScoreUpdate> _searchEntities = [];

  List<LiveScoreUpdate> get entities => _entities;
  List<LiveScoreUpdate> get filteredEntities => _filteredEntities;

  bool _isLoading = false;
  bool _isListening = false;
  int _currentPage = 0;
  final int _pageSize = 10;

  bool get isLoading => _isLoading;
  bool get isListening => _isListening;

  TextEditingController searchController = TextEditingController();

  Future<void> fetchEntities() async {
    try {
      _setLoading(true);
      // final token = await TokenManager.getToken();

      final fetchedEntities = await _apiService.getAllWithPagination(
        _currentPage,
        _pageSize,
      );

      _entities.addAll(fetchedEntities.map((e) => LiveScoreUpdate.fromJson(e)));
      _filteredEntities = _entities.toList();
      _currentPage++;
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch entities: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchWithoutPaging() async {
    try {
      // final token = await TokenManager.getToken();

      final fetchedEntities = await _apiService.getEntities();
      _searchEntities =
          fetchedEntities.map((e) => LiveScoreUpdate.fromJson(e)).toList();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to fetch entities without paging: $e');
    }
  }

  Future<void> deleteEntity(dynamic entity) async {
    try {
      await _apiService.deleteEntity(entity.id);
      _entities.remove(entity);
      _filteredEntities = _entities.toList();
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  void searchEntities(String keyword) {
    _filteredEntities = _searchEntities
        .where((entity) =>
            entity.liveCommentary
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity.boundary
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity.wickets
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity.name.toLowerCase().contains(keyword.toLowerCase()) ||
            entity.description.toLowerCase().contains(keyword.toLowerCase()) ||
            entity.active
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> startListening() async {
    if (!_isListening) {
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
              searchEntities(result.recognizedWords);
            }
          },
        );
        _isListening = true;
        notifyListeners();
      }
    }
  }

  Future<dynamic> createEntity(Map<String, dynamic> formData) async {
    _setLoading(true);
    try {
      await _apiService.createEntity(formData);
      // Optionally: Add the new entity to the list and notify listeners
      // _entities.add(LiveScoreUpdate.fromJson(response));
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> updateEntity(int id, Map<String, dynamic> updatedEntity) async {
    _setLoading(true);
    try {
      await _apiService.updateEntity(id, updatedEntity); 
      // Optionally: Update the entity in the local list if needed
      // final index = _entities.indexWhere((e) => e.id == id);
      // if (index != -1) {
      //   _entities[index] = LiveScoreUpdate.fromJson(updatedEntity);
      //   notifyListeners();
      // }
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    } finally {
      _setLoading(false);
    }
  }

  void stopListening() {
    if (_isListening) {
      _speech.stop();
      _isListening = false;
      notifyListeners();
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
