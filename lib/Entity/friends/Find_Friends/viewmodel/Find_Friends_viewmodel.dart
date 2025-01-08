import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../repository/Find_Friends_api_service.dart';
import '/providers/token_manager.dart';
import '../model/Find_Friends_model.dart';

class FindFriendsProvider with ChangeNotifier {
  final FindFriendsApiService apiService = FindFriendsApiService();
  final FindFriendsModel model = FindFriendsModel();

//   List<Map<String, dynamic>> entities = [];
//   List<Map<String, dynamic>> filteredEntities = [];
//   List<Map<String, dynamic>> searchEntities = [];
//   stt.SpeechToText speech = stt.SpeechToText();
//   final ScrollController scrollController = ScrollController();
//     final Map<String, dynamic> formData = {};
//   final formKey = GlobalKey<FormState>();
//   bool isLoading = false;
//   int currentPage = 0;
//   int pageSize = 10;

  bool _isActive = false;

  bool get isActive => _isActive;

  void toggleIsActive(bool value) {
    _isActive = value;
    notifyListeners();
  }

  TextEditingController searchController = TextEditingController();

  FindFriendsProvider() {
    fetchEntities();
    fetchWithoutPaging();
  }

  Future<void> fetchWithoutPaging() async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        final fetchedEntities = await apiService.getEntities();
        model.searchEntities = fetchedEntities;
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to fetch Find_Friends data: $e');
    }
  }

  Future<void> fetchEntities() async {
    try {
      model.isLoading = true;
      notifyListeners();

      final token = await TokenManager.getToken();
      if (token != null) {
        final fetchedEntities =
            await apiService.getAllWithPagination(token, model.currentPage, model.pageSize);
        model.entities.addAll(fetchedEntities);
        model.filteredEntities = List.from(model.entities);
        model.currentPage++;
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to fetch Find_Friends data: $e');
    } finally {
      model.isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        await apiService.deleteEntity(token, entity['id']);
        model.entities.remove(entity);
        model.filteredEntities = List.from(model.entities);
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  void searchEntitiesByKeyword(String keyword) {
    model.filteredEntities = model.searchEntities
        .where((entity) =>
            entity['find_friends']
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

  Future<void> startListening() async {
    if (!model.speech.isListening) {
      bool available = await model.speech.initialize(
        onStatus: (status) {
          debugPrint('Speech recognition status: $status');
        },
        onError: (error) {
          debugPrint('Speech recognition error: $error');
        },
      );

      if (available) {
        model.speech.listen(
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
    if (model.speech.isListening) {
      model.speech.stop();
    }
  }
}
