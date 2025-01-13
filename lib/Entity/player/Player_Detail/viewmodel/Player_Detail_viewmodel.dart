import 'package:cricyard/Entity/player/Player_Detail/model/Player_Detail_model.dart';
import 'package:cricyard/Entity/player/Player_Detail/repository/Player_Detail_api_service.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;


class PlayerDetailProvider extends ChangeNotifier {
  final PlayerDetailApiService _apiService = PlayerDetailApiService();

  List<PlayerDetailModel> _entities = [];
  List<PlayerDetailModel> _filteredEntities = [];
  List<PlayerDetailModel> _searchEntities = [];
  final Map<String, dynamic> formData = {};
  final formKey = GlobalKey<FormState>();


  bool _showCardView = true;
  bool _isLoading = false;
  int _currentPage = 0;
  final int _pageSize = 10;
  final TextEditingController searchController = TextEditingController();
  late stt.SpeechToText _speech;
  final ScrollController _scrollController = ScrollController();

  PlayerDetailProvider() {
    _speech = stt.SpeechToText();
    _scrollController.addListener(_scrollListener);
    fetchEntities();
    fetchWithoutPaging();
  }

  List<PlayerDetailModel> get entities => _entities;
  List<PlayerDetailModel> get filteredEntities => _filteredEntities;
  bool get showCardView => _showCardView;
  bool get isLoading => _isLoading;

  void toggleCardView() {
    _showCardView = !_showCardView;
    notifyListeners();
  }

  Future<void> fetchWithoutPaging() async {
    try {
        final fetchedEntities = await _apiService.getEntities();
        _searchEntities = fetchedEntities;
        notifyListeners();
      
    } catch (e) {
      _showErrorDialog('Failed to fetch Player Detail data: $e');
    }
  }

  Future<dynamic> createEntity(Map<String, dynamic> formData) async {
    
      _isLoading = true;
      notifyListeners();

      final createdEntity = await _apiService.createEntity(formData);

      // _entities.add(createdEntity); // Optionally, update the local state
      _entities.add(PlayerDetailModel.fromJson(createdEntity));
      notifyListeners();
    
  }

Future<void> updateEntity(int id, PlayerDetailModel updatedData) async {
  _isLoading = true;
  notifyListeners();

  await _apiService.updateEntity(id, updatedData);

  final index = _entities.indexWhere((entity) => entity.id == id);
  if (index != -1) {
    _entities[index] = updatedData;
    notifyListeners();
  }
}

  Future<void> fetchEntities() async {
    try {
      _isLoading = true;
      notifyListeners();

        final fetchedEntities =
            await _apiService.getAllWithPagination(_currentPage, _pageSize);
        _entities.addAll(fetchedEntities);
        _filteredEntities = List.from(_entities);
        _currentPage++;
        notifyListeners();
      
    } catch (e) {
      _showErrorDialog('Failed to fetch Player Detail data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      fetchEntities();
    }
  }

  Future<void> deleteEntity(PlayerDetailModel entity) async {
    try {
        await _apiService.deleteEntity(entity.id);
        _entities.remove(entity);
        _filteredEntities.remove(entity);
        notifyListeners();
      
    } catch (e) {
      _showErrorDialog('Failed to delete entity: $e');
    }
  }

  void searchEntities(String keyword) {
    _filteredEntities = _searchEntities
        .where((entity) =>
            // entity['player_name']
            entity.playerName
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            // entity['phone_number']
            entity.phoneNumber
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void startListening() async {
    if (!_speech.isListening) {
      bool available = await _speech.initialize(
        onStatus: (status) => print('Speech recognition status: $status'),
        onError: (error) => print('Speech recognition error: $error'),
      );

      if (available) {
        _speech.listen(onResult: (result) {
          if (result.finalResult) {
            searchController.text = result.recognizedWords;
            searchEntities(result.recognizedWords);
          }
        });
      }
    }
  }

  void stopListening() {
    if (_speech.isListening) {
      _speech.stop();
    }
  }

  void _showErrorDialog(String message) {
    // You can implement an error handling method here for showing a dialog or logging.
    print(message);
  }
}
