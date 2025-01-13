import 'package:cricyard/Entity/runs/Runs/model/Runs_model.dart';
import 'package:cricyard/Entity/runs/Runs/repository/Runs_api_service.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class RunsEntitiesProvider extends ChangeNotifier {
  final runsApiService apiService = runsApiService();

  final stt.SpeechToText _speech = stt.SpeechToText();
  TextEditingController searchController = TextEditingController();

  List<RunsEntity> _entities = [];
  List<RunsEntity> _filteredEntities = [];
  List<RunsEntity> _searchEntities = [];
  bool _isLoading = false;
  int _currentPage = 0;
  int _pageSize = 10;

  List<RunsEntity> get entities => _entities;
  List<RunsEntity> get filteredEntities => _filteredEntities;
  bool get isLoading => _isLoading;

  Future<void> fetchEntities() async {
    try {
      _isLoading = true;
      notifyListeners();

        final fetchedEntities =
            await apiService.getAllWithPagination(_currentPage, _pageSize);

        _entities.addAll(fetchedEntities);
        _filteredEntities = _entities.toList();
        _currentPage++;

        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to fetch Runs data: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<dynamic> updateEntity(int id, RunsEntity updatedData) async {
    try {
      _isLoading = true;
      notifyListeners();

        final updatedEntity = await apiService.updateEntity(id, updatedData);

        final index = _entities.indexWhere((entity) => entity.id == id);
        if (index != -1) {
          _entities[index] = updatedEntity; // Update the entity in the list
          _filteredEntities = _entities.toList();
        }
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  List<Map<String, dynamic>> _selectFieldItems = [];
  Map<String, dynamic>? _selectedSelectFieldValue;
  bool _isFetching = false;

  List<Map<String, dynamic>> get selectFieldItems => _selectFieldItems;
  Map<String, dynamic>? get selectedSelectFieldValue => _selectedSelectFieldValue;
  bool get isFetching => _isFetching;

  // Fetch select_field items
  Future<void> fetchSelectFieldItems(String? initialValue) async {
    _isFetching = true;
    notifyListeners();

    try {
        final fetchedData = await apiService.getselectField();
        if (fetchedData != null && fetchedData.isNotEmpty) {
          _selectFieldItems = fetchedData;
          // Set initial selected value
          _selectedSelectFieldValue = fetchedData.firstWhere(
            (item) => item['value'] == initialValue,
            // orElse: () => null,
          );
          notifyListeners();
        
      }
    } catch (e) {
      throw Exception('Failed to load select_field items: $e');
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  // Update the selected value
  void setSelectedSelectFieldValue(Map<String, dynamic>? value) {
    _selectedSelectFieldValue = value;
    notifyListeners();
  }

  Future<void> fetchWithoutPaging() async {
    try {
        final fetchedEntities = await apiService.getEntities();

        _searchEntities = fetchedEntities;
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to fetch Runs: $e');
    }
  }

  // Create a new entity
  Future<void> createEntity(RunsEntity formData) async {
    try {
      _isLoading = true;
      notifyListeners();

        final createdEntity = await apiService.createEntity(formData);

        _entities.insert(0, createdEntity); // Add the new entity to the list
        _filteredEntities = _entities.toList();
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteEntity(dynamic entityId) async {
    try {
        await apiService.deleteEntity( entityId);
        _entities.removeWhere((entity) => entity.id == entityId);
        _filteredEntities = _entities.toList();
        notifyListeners();
      
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

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
            entity.numberOfRuns
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity.selectField
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()))
        .toList();

    notifyListeners();
  }

  // Speech-to-Text: Start Listening
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
              searchEntities(result.recognizedWords);
            }
          },
        );
      }
    }
  }

  // Speech-to-Text: Stop Listening
  void stopListening() {
    if (_speech.isListening) {
      _speech.stop();
    }
  }

  void resetPagination() {
    _currentPage = 0;
    _entities = [];
    _filteredEntities = [];
    notifyListeners();
  }
}
