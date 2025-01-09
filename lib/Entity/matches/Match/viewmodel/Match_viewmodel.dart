import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../repository/Match_api_service.dart'; // Replace with the correct import for your MatchApiService

class MatchProvider with ChangeNotifier {
  final MatchApiService _apiService = MatchApiService();
  final TextEditingController searchController = TextEditingController();
  final ScrollController scrollController = ScrollController();

  stt.SpeechToText _speech = stt.SpeechToText();

  List<Map<String, dynamic>> _entities = [];
  List<Map<String, dynamic>> _filteredEntities = [];
  List<Map<String, dynamic>> _searchEntities = [];

  bool _showCardView = true;
  bool _isLoading = false;

  int _currentPage = 0;
  int _pageSize = 10;

  List<Map<String, dynamic>> get entities => _filteredEntities;
  bool get isLoading => _isLoading;
  bool get showCardView => _showCardView;

  MatchProvider() {
    scrollController.addListener(_scrollListener);
    fetchEntities();
    fetchWithoutPaging();
  }

  Future<void> fetchWithoutPaging() async {
    try {
      final fetchedEntities = await _apiService.getEntities();
      _searchEntities = fetchedEntities;
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to fetch entities: $e");
    }
  }

  Future<void> fetchEntities() async {
    try {
      _isLoading = true;
      notifyListeners();

        final fetchedEntities =
            await _apiService.getAllWithPagination(_currentPage, _pageSize);
        _entities.addAll(fetchedEntities);
        _filteredEntities = _entities.toList();
        _currentPage++;
        notifyListeners();
      
    } catch (e) {
      throw Exception("Failed to fetch entities: $e");
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      await _apiService.deleteEntity(entity['id']);
      _entities.remove(entity);
      _filteredEntities = _entities.toList();
      notifyListeners();
    } catch (e) {
      throw Exception("Failed to delete entity: $e");
    }
  }

  void searchEntities(String keyword) {
    _filteredEntities = _searchEntities
        .where((entity) =>
            entity['team_1']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['team_2']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['location']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['date_field']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['datetime_field']
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
                .contains(keyword.toLowerCase()) ||
            entity['user_id']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void startListening() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) {},
        onError: (error) {},
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

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchEntities();
    }
  }
}
