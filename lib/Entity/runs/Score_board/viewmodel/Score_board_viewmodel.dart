import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../repository/Score_board_api_service.dart';

class ScoreBoardProvider extends ChangeNotifier {
  final score_boardApiService _apiService = score_boardApiService();
  final stt.SpeechToText _speech = stt.SpeechToText();

  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> searchEntities = [];
  
  bool showCardView = true;
  bool isLoading = false;
  bool isListening = false;

  int currentPage = 0;
  int pageSize = 10;

  TextEditingController searchController = TextEditingController();

  ScoreBoardProvider() {
    fetchEntities();
    fetchWithoutPaging();
  }

  Future<void> fetchWithoutPaging() async {
    try {
        final fetchedEntities = await _apiService.getEntities();
        searchEntities = fetchedEntities;
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to fetch data: $e');
    }
  }

  Future<void> fetchEntities() async {
    try {
      isLoading = true;
      notifyListeners();
        final fetchedEntities = await _apiService.getAllWithPagination(currentPage, pageSize);
        entities.addAll(fetchedEntities);
        filteredEntities = List.from(entities);
        currentPage++;
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to fetch entities: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      await _apiService.deleteEntity(entity['id']);
      entities.remove(entity);
      filteredEntities.remove(entity);
      notifyListeners();
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  void searchEntitiesByKeyword(String keyword) {
    filteredEntities = searchEntities.where((entity) {
      return entity.values.any((value) =>
          value.toString().toLowerCase().contains(keyword.toLowerCase()));
    }).toList();
    notifyListeners();
  }

  Future<void> startListening() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => debugPrint('Speech status: $status'),
        onError: (error) => debugPrint('Speech error: $error'),
      );

      if (available) {
        _speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              searchController.text = result.recognizedWords;
              searchEntitiesByKeyword(result.recognizedWords);
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
}
