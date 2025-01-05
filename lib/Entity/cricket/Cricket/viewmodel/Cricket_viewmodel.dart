import 'package:flutter/material.dart';
import '../repository/Cricket_api_service.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '/providers/token_manager.dart';
import 'package:cricyard/data/network/network_api_service.dart';
import '/resources/api_constants.dart';

class CricketProvider with ChangeNotifier {
  final CricketApiService apiService = CricketApiService();
  bool isActive = false;
  String? selectedAudioLanguage;
  Map<String, dynamic> formData = {};

  List<Map<String, dynamic>> _entities = [];
  List<Map<String, dynamic>> _filteredEntities = [];
  List<Map<String, dynamic>> _searchEntities = [];
  bool _isLoading = false;

  final NetworkApiService networkService = NetworkApiService();

  final String baseUrl = ApiConstants.baseUrl;

  int _currentPage = 0;
  final int _pageSize = 10;

  List<Map<String, dynamic>> get entities => _entities;
  List<Map<String, dynamic>> get filteredEntities => _filteredEntities;
  bool get isLoading => _isLoading;

  CricketEntityProvider() {
    fetchEntities();
    fetchWithoutPaging();
  }

  TextEditingController searchController = TextEditingController();
  Future<void> startListening() async {
    if (!_speech.isListening) {
      try {
        bool available = await _speech.initialize(
          onStatus: (status) {
            print('Speech recognition status: $status');
          },
          onError: (error) {
            print('Speech recognition error: $error');
          },
        );

        if (available) {
          // isListening = true;
          notifyListeners(); // Notify listeners that the provider is now listening.

          _speech.listen(
            onResult: (result) {
              if (result.finalResult) {
                searchController.text = result.recognizedWords;
                searchEntities(result.recognizedWords); // Call search logic.
                stopListening(); // Automatically stop listening after processing result.
              }
            },
          );
        }
      } catch (e) {
        print('Error initializing speech recognition: $e');
      }
    }
  }

  late stt.SpeechToText _speech;
  void stopListening() {
    if (_speech.isListening) {
      _speech.stop();
      // isListening = false;
      notifyListeners(); // Notify listeners that the provider stopped listening.
    }
  }

  Future<void> fetchEntities() async {
    try {
      _isLoading = true;
      notifyListeners();

      final token = await TokenManager.getToken();
      if (token != null) {
        final fetchedEntities = await apiService.getAllWithPagination(
            token, _currentPage, _pageSize);

        _entities.addAll(fetchedEntities);
        _filteredEntities = List.from(_entities);
        _currentPage++;

        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to fetch entities: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> fetchWithoutPaging() async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        final fetchedEntities = await apiService.getEntities(token);
        _searchEntities = fetchedEntities;

        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to fetch entities without paging: $e');
    }
  }

  void searchEntities(String keyword) {
    _filteredEntities = _searchEntities
        .where((entity) =>
            entity['audio_language']
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

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        await apiService.deleteEntity(token, entity['id']);
        _entities.remove(entity);
        _filteredEntities = List.from(_entities);

        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  void reset() {
    _currentPage = 0;
    _entities.clear();
    fetchEntities();
  }

  List<String> audioLanguageList = [
    'bar_code',
    'qr_code',
  ];

  Future<void> submitForm(GlobalKey<FormState> formKey, BuildContext context) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      formData['active'] = isActive;

      try {
        await apiService.createEntity(formData);
        Navigator.pop(context);
        notifyListeners();
      } catch (e) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text('Failed to create Cricket: $e'),
              actions: [
                TextButton(
                  child: const Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    }
  }

  void updateIsActive(bool value) {
    isActive = value;
    notifyListeners();
  }

  void updateAudioLanguage(String? value) {
    selectedAudioLanguage = value;
    formData['audio_language'] = value;
    notifyListeners();
  }

  void updateFormData(String key, dynamic value) {
    formData[key] = value;
    notifyListeners();
  }

  Map<String, dynamic> currentEntity = {};
  Future<void> updateEntity(BuildContext context) async {
    try {
      final entityId = currentEntity['id']; // Retrieve the entity ID
      if (entityId != null) {
        await networkService.getPutApiResponse(
          '$baseUrl/Cricket/Cricket/$entityId',
          currentEntity,
        );

        // Update local state if necessary
        notifyListeners();

        // Optionally show a success message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Entity updated successfully!')),
        );
      } else {
        throw Exception('Entity ID is missing.');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update entity: $e')),
      );
      throw Exception('Failed to update entity: $e');
    }

    Future<void> submitForm(
        GlobalKey<FormState> formKey, BuildContext context) async {
      if (formKey.currentState!.validate()) {
        formKey.currentState!.save();
        formData['active'] = isActive;

        // final token = await TokenManager.getToken();
        try {
          await apiService.createEntity(formData);
          Navigator.pop(context);
        } catch (e) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Error'),
                content: Text('Failed to create Cricket: $e'),
                actions: [
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            },
          );
        }
      }
    }
  }
}
