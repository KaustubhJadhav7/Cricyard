import 'package:cricyard/Entity/retired_out/Retired_out/model/Retired_out_model.dart';
import 'package:cricyard/Entity/retired_out/Retired_out/repository/Retired_out_api_service.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RetiredOutProvider extends ChangeNotifier {
  final RetiredOutApiService _apiService = RetiredOutApiService();
  final TextEditingController searchController = TextEditingController();
  late stt.SpeechToText _speech;

  List<RetiredOutEntity> _entities = [];
  List<RetiredOutEntity> _filteredEntities = [];
  List<RetiredOutEntity> _searchEntities = [];

  bool _isLoading = false;
  bool _showCardView = true;
  int _currentPage = 0;
  final int _pageSize = 10;

  ScrollController _scrollController = ScrollController();

  // Getters
  List<RetiredOutEntity> get entities => _entities;
  List<RetiredOutEntity> get filteredEntities => _filteredEntities;
  bool get isLoading => _isLoading;
  bool get showCardView => _showCardView;
  ScrollController get scrollController => _scrollController;

  RetiredOutProvider() {
    _speech = stt.SpeechToText();
    _scrollController.addListener(_scrollListener);
    fetchEntities();
    fetchWithoutPaging();
  }
  void _scrollListener() {
    if (_scrollController.position.pixels == _scrollController.position.maxScrollExtent) {
      fetchEntities();
    }
  }
  Future<dynamic> createEntity(RetiredOutEntity entity) async {
    try {
      final createdEntity = await _apiService.createEntity(entity.toJson());
      _entities.add(RetiredOutEntity.fromJson(createdEntity));
      _filteredEntities = _entities.toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to create entity: $e');
      rethrow;
    }
  }

  Future<dynamic> updateEntity(int id, RetiredOutEntity updatedEntity) async {
    try {
      await _apiService.updateEntity(id, updatedEntity.toJson());
      final index = _entities.indexWhere((entity) => entity.id == id);
      if (index != -1) {
        _entities[index] = updatedEntity;
        _filteredEntities = _entities.toList();
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to update entity: $e');
      rethrow;
    }
  }

  Future<void> fetchWithoutPaging() async {
    try {
      final fetchedEntities = await _apiService.getEntities();
      _searchEntities = fetchedEntities
          .map<RetiredOutEntity>((json) => RetiredOutEntity.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to fetch data: $e');
    }
  }

  Future<void> fetchEntities() async {
    try {
      _isLoading = true;
      notifyListeners();

      final fetchedEntities =
          await _apiService.getAllWithPagination(_currentPage, _pageSize);
      _entities.addAll(fetchedEntities
          .map<RetiredOutEntity>((json) => RetiredOutEntity.fromJson(json))
          .toList());
      _filteredEntities = _entities.toList();
      _currentPage++;
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to fetch paginated data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEntity(dynamic id) async {
    try {
      await _apiService.deleteEntity(id);
      _entities.removeWhere((entity) => entity.id == id);
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to delete entity: $e');
    }
  }

  void searchEntities(String keyword) {
    _filteredEntities = _searchEntities
        .where((entity) =>
            entity.description.toLowerCase().contains(keyword.toLowerCase()) ||
            entity.playerName.toLowerCase().contains(keyword.toLowerCase()) ||
            entity.active.toString().toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  Future<void> startListening() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => debugPrint('Speech recognition status: $status'),
        onError: (error) => debugPrint('Speech recognition error: $error'),
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
      }
    }
  }

  void stopListening() {
    if (_speech.isListening) {
      _speech.stop();
    }
  }

  void toggleViewMode() {
    _showCardView = !_showCardView;
    notifyListeners();
  }
}
