import 'package:cricyard/Entity/retired/Retired/model/Retired_model.dart';
import 'package:cricyard/Entity/retired/Retired/repository/Retired_api_service.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RetiredEntitiesProvider with ChangeNotifier {
  final RetiredApiService apiService = RetiredApiService();

  List<RetiredEntity> _entities = [];
  List<RetiredEntity> _filteredEntities = [];
  List<RetiredEntity> _searchEntities = [];

  // final Map<String, dynamic> formData = {};

  RetiredEntity currentEntity = RetiredEntity(
    id: 0, // Placeholder for the form; will be ignored on creation
    description: '',
    active: false,
    playerName: '',
    canBatterBatAgain: '',
  );

  Future<void> createEntity() async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();
    try {
      await apiService.createEntity(currentEntity);
    } catch (e) {
      _errorMessage = e.toString();
      debugPrint('Failed to create entity: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void updateCurrentEntity({
    String? description,
    bool? active,
    String? playerName,
    String? canBatterBatAgain,
  }) {
    currentEntity = currentEntity.copyWith(
      description: description,
      active: active,
      playerName: playerName,
      canBatterBatAgain: canBatterBatAgain,
    );
    notifyListeners();
  }
  


  final ScrollController scrollController = ScrollController();

  bool _isLoading = false;
  bool _showCardView = true;
  int currentPage = 0;
  final int pageSize = 10;
  String _errorMessage = '';

  String get errorMessage => _errorMessage;
  

  late stt.SpeechToText _speech;
  final TextEditingController searchController = TextEditingController();

  RetiredEntitiesProvider() {
    _speech = stt.SpeechToText();
    fetchEntities();
    scrollController.addListener(scrollListener);
    fetchWithoutPaging();
  }

  // Getters for UI
  List<RetiredEntity> get entities => _entities;
  List<RetiredEntity> get filteredEntities => _filteredEntities;
  bool get isLoading => _isLoading;
  bool get showCardView => _showCardView;

  // Fetch entities with pagination
  Future<void> fetchEntities() async {
    try {
      _isLoading = true;
      notifyListeners();
        final fetchedEntities =
            await apiService.getAllWithPagination(currentPage, pageSize);

        _entities.addAll(fetchedEntities);
        _filteredEntities = List.from(_entities); // Create a copy
        currentPage++;
      
    } catch (e) {
      debugPrint('Failed to fetch entities: $e');
      throw Exception('Failed to fetch entities.');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Future<dynamic> createEntity(RetiredEntity formData) async {
  //   _isLoading = true;
  //   _errorMessage = '';
  //   notifyListeners();
  //     try {
  //       await apiService.createEntity(formData);
      
  //   } catch (e) {
  //     _errorMessage = e.toString();
  //     debugPrint('Failed to create entity: $e');
  //   } finally {
  //     _isLoading = false;
  //     notifyListeners();
  //   }
  // }

  Future<dynamic> updateEntity(int entityId, RetiredEntity updatedData) async {

      await apiService.updateEntity(entityId, updatedData);

      notifyListeners();
    
  }

  // Fetch entities without pagination
  Future<void> fetchWithoutPaging() async {
    try {
        final fetchedEntities = await apiService.getEntities();
        _searchEntities = fetchedEntities;
      
    } catch (e) {
      debugPrint('Failed to fetch entities without paging: $e');
      throw Exception('Failed to fetch entities.');
    }
  }

  // Handle deletion of an entity
  Future<void> deleteEntity(RetiredEntity entity) async {
    try {
      await apiService.deleteEntity(entity.id);
      _entities.remove(entity);
      _filteredEntities = List.from(_entities); // Update filtered list
      notifyListeners();
    } catch (e) {
      debugPrint('Failed to delete entity: $e');
      throw Exception('Failed to delete entity.');
    }
  }

  // Search entities
  void searchEntities(String keyword) {
    _filteredEntities = _searchEntities
        .where((entity) =>
            // entity['description']
            entity.description
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            // entity['active']
            entity.active
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            // entity['player_name']
            entity.playerName
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            // entity['can_batter_bat_again']
            entity.canBatterBatAgain
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()))
        .toList();

    notifyListeners();
  }

  // Speech-to-text functionality
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

  // Scroll listener for pagination
  void scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      fetchEntities();
    }
  }

  // Toggle card view state
  void toggleCardView() {
    _showCardView = !_showCardView;
    notifyListeners();
  }

  String? selectedCanBatterBatAgain;

  // Function to handle the dialog logic
  Future<void> showCanBatterBatAgainDialog(BuildContext context) async {
    final result = await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return SimpleDialog(
          title: const Text('Select Can Batter Bat Again'),
          children: [
            RadioListTile<String>(
              title: const Text('Yes'),
              value: 'Yes',
              groupValue: selectedCanBatterBatAgain,
              onChanged: (value) {
                selectedCanBatterBatAgain = value;
                notifyListeners();
                Navigator.pop(context, value);
              },
            ),
            RadioListTile<String>(
              title: const Text('No'),
              value: 'No',
              groupValue: selectedCanBatterBatAgain,
              onChanged: (value) {
                selectedCanBatterBatAgain = value;
                notifyListeners();
                Navigator.pop(context, value);
              },
            ),
          ],
        );
      },
    );

    if (result != null) {
      selectedCanBatterBatAgain = result;
      notifyListeners();
    }
  }

  

  void resetCanBatterBatAgain() {
    selectedCanBatterBatAgain = null;
    notifyListeners();
  }
}
