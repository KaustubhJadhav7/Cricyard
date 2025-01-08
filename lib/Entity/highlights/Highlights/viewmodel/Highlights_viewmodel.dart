import 'package:flutter/material.dart';
import '../repository/Highlights_api_service.dart';
import '../model/Highlights_model.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HighlightsProvider extends ChangeNotifier {
  final HighlightsApiService _apiService = HighlightsApiService();
  final formKey = GlobalKey<FormState>();
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();
  late stt.SpeechToText speech;

  final HighlightModel _highlightModel = HighlightModel();

  HighlightModel get highlightModel => _highlightModel;

  void toggleActive(bool value) {
    _highlightModel.isActive = value;
    notifyListeners();
  }

  void toggleViewMode() {
    _highlightModel.showCardView = !_highlightModel.showCardView;
    notifyListeners();
  }

  Future<void> updateEntity(int id, Map<String, dynamic> entity) async {
    _setLoading(true);

    try {
      await _apiService.updateEntity(id, entity);
      _highlightModel.errorMessage = null;
    } catch (error) {
      _highlightModel.errorMessage = error.toString();
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchHighlightsWithoutPaging() async {
    _setLoading(true);
    try {
      final fetchedEntities = await _apiService.getEntities();
      _highlightModel.filteredEntities = fetchedEntities;
      notifyListeners(); // Notify listeners to update UI
    } catch (e) {
      throw Exception('Failed to fetch highlights without paging: $e');
    } finally {
      _setLoading(false);
    }
  }

  Future<void> fetchHighlightsWithPaging() async {
    _setLoading(true);
    try {
      final fetchedEntities = await _apiService.getAllWithPagination(
        _highlightModel.currentPage,
        _highlightModel.pageSize,
      );
      _highlightModel.entities.addAll(fetchedEntities);
      _highlightModel.filteredEntities = _highlightModel.entities.toList();
      _highlightModel.currentPage++;
      notifyListeners(); // Notify listeners to update UI
    } catch (e) {
      throw Exception('Failed to fetch highlights with paging: $e');
    } finally {
      _setLoading(false);
    }
  }

  void initializeSpeech() {
    speech = stt.SpeechToText();
  }

  Future<void> startListening() async {
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
              searchHighlights(result.recognizedWords);
            }
          },
        );
      }
    }
  }

  Future<void> createHighlight(Map<String, dynamic> formData) async {
    _setLoading(true);
    try {
      await _apiService.createEntity(formData);
      // Additional logic (if any) after successful creation
    } catch (e) {
      throw Exception('Failed to create highlight: $e');
    } finally {
      _setLoading(false);
    }
  }

  void stopListening() {
    if (speech.isListening) {
      speech.stop();
    }
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchHighlightsWithPaging();
    }
  }

  Future<void> deleteHighlight(Map<String, dynamic> entity) async {
    _setLoading(true);
    try {
      await _apiService.deleteEntity(entity['id']);
      _highlightModel.entities.remove(entity);
      notifyListeners(); // Notify listeners to update UI
    } catch (e) {
      throw Exception('Failed to delete highlight: $e');
    } finally {
      _setLoading(false);
    }
  }

  void searchHighlights(String keyword) {
    _highlightModel.filteredEntities = _highlightModel.entities.where((entity) {
      return entity['highlight_name']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          entity['description']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          entity['duration']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase()) ||
          entity['active']
              .toString()
              .toLowerCase()
              .contains(keyword.toLowerCase());
    }).toList();
    notifyListeners(); // Notify listeners after updating filtered entities
  }

  void _setLoading(bool value) {
    _highlightModel.isLoading = value;
    notifyListeners();
  }
}
