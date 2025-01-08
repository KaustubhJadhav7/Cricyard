import 'package:cricyard/Entity/followers/Followers/models/Followers_model.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '/providers/token_manager.dart';
import '../repository/Followers_api_service.dart';

class FollowersProvider extends ChangeNotifier {
  final FollowersModel model = FollowersModel();
  final FollowersApiService apiService = FollowersApiService();
  final stt.SpeechToText speech = stt.SpeechToText();
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> entities = [];
  List<Map<String, dynamic>> filteredEntities = [];
  List<Map<String, dynamic>> searchEntities = [];
  final formKey = GlobalKey<FormState>();
  bool showCardView = true;
  bool isLoading = false;
  int currentPage = 0;
  int pageSize = 10;

  FollowersProvider() {
    _initialize();
  }

  void _initialize() {
    scrollController.addListener(_scrollListener);
    fetchEntities();
    fetchWithoutPaging();
  }

  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchEntities();
    }
  }

  bool _isActive = false;

  bool get isActive => _isActive;

  void toggleIsActive(bool value) {
    _isActive = value;
    notifyListeners();
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
      _showErrorDialog('Failed to fetch followers: $e');
    }
  }

  Future<void> fetchEntities() async {
    try {
      _setLoading(true);
      final token = await TokenManager.getToken();
      if (token != null) {
        final fetchedEntities = await apiService.getAllWithPagination(currentPage, pageSize);
        entities.addAll(fetchedEntities);
        filteredEntities = entities.toList();
        currentPage++;
        notifyListeners();
      }
    } catch (e) {
      _showErrorDialog('Failed to fetch followers data: $e');
    } finally {
      _setLoading(false);
    }
  }

  void _scrollListener() {
    if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
      fetchEntities();
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      await apiService.deleteEntity(entity['id']);
      entities.remove(entity);
      filteredEntities = entities.toList();
      notifyListeners();
    } catch (e) {
      _showErrorDialog('Failed to delete entity: $e');
    }
  }

  void searchEntitiesByKeyword(String keyword) {
    filteredEntities = searchEntities
        .where((entity) =>
            entity['user_id'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['follower_id'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['name'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['description'].toString().toLowerCase().contains(keyword.toLowerCase()) ||
            entity['active'].toString().toLowerCase().contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void startListening() async {
    if (!speech.isListening) {
      bool available = await speech.initialize(
        onStatus: (status) => print('Speech recognition status: $status'),
        onError: (error) => print('Speech recognition error: $error'),
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

  void _setLoading(bool value) {
    isLoading = value;
    notifyListeners();
  }

  void _showErrorDialog(String message) {
    // You can use a custom notification system for this
    print(message);
  }
}
