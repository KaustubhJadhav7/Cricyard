import 'package:flutter/foundation.dart';
import '../repository/Event_Management_api_service.dart';
import '/providers/token_manager.dart';
import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../model/Event_management_model.dart';

class EventManagementProvider with ChangeNotifier {
  final EventManagementApiService _apiService = EventManagementApiService();
  late EventManagementModel eventModel;
  late EventManagementControllers eventControllers;

  // List<Map<String, dynamic>> _entities = [];
  // List<Map<String, dynamic>> _filteredEntities = [];
  // List<Map<String, dynamic>> _searchEntities = [];
  final Map<String, dynamic> formData = {};
  final formKey = GlobalKey<FormState>();
  // bool _isLoading = false;
  // int _currentPage = 0;
  // int _pageSize = 10;
  // late stt.SpeechToText speech;
  // final ScrollController scrollController = ScrollController();
  // List<Map<String, dynamic>> get entities => _entities;
  // List<Map<String, dynamic>> get filteredEntities => _filteredEntities;
  // bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    eventModel.isLoading = value;
    notifyListeners();
  }

  // final ScrollController scrollController = ScrollController();

  EventManagementProvider() {
    eventControllers.scrollController.addListener(scrollListener);
  }

  void scrollListener() {
    if (eventControllers.scrollController.position.pixels ==
        eventControllers.scrollController.position.maxScrollExtent) {
      fetchEntities(); // Call your fetchEntities logic here
    }
  }

  void stopListening() {
    if (eventControllers.speech.isListening) {
      eventControllers.speech.stop();
      notifyListeners();
    }
  }

  bool isActive = false;

  // bool get isActive => isActive;

  void toggleActive(bool newValue) {
    isActive = newValue;
    notifyListeners();
  }

  Future<void> fetchEntities() async {
    if (eventModel.isLoading) return; // Prevent simultaneous fetches
    _setLoading(true); // Set loading state
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        // Fetch paginated data from the API
        final fetchedEntities = await _apiService.getAllWithPagination(
          // token, // Ensure token is passed
          eventModel.currentPage,
          eventModel.pageSize,
        );
        if (fetchedEntities.isNotEmpty) {
          eventModel.entities.addAll(fetchedEntities); // Append fetched data
          eventModel.filteredEntities =
              List.from(eventModel.entities); // Sync filtered list
          eventModel.currentPage++; // Increment for next fetch
        }
        notifyListeners(); // Notify UI about the changes
      }
    } catch (e) {
      debugPrint('Failed to fetch entities: $e');
      throw Exception(
          'Failed to fetch entities: $e'); // Retain error for visibility
    } finally {
      _setLoading(false); // Reset loading state
    }
  }

  Future<void> fetchWithoutPaging() async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        final fetchedEntities = await _apiService.getEntities();
        eventModel.searchEntities = fetchedEntities;
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to fetch without paging: $e');
      rethrow;
    }
  }

  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        await _apiService.deleteEntity(
          entity['id'], // Use the 'id' field from the entity map
        );
        eventModel.entities.removeWhere(
            (e) => e['id'] == entity['id']); // Use 'entity['id']' here
        eventModel.filteredEntities = List.from(eventModel.entities);
        notifyListeners();
      }
    } catch (e) {
      debugPrint('Failed to delete entity: $e');
      rethrow;
    }
  }

  Future<void> startListening({
    required TextEditingController searchController,
    required BuildContext context,
  }) async {
    if (!eventControllers.speech.isListening) {
      bool available = await eventControllers.speech.initialize(
        onStatus: (status) {
          debugPrint('Speech recognition status: $status');
        },
        onError: (error) {
          debugPrint('Speech recognition error: $error');
        },
      );

      if (available) {
        eventControllers.speech.listen(
          onResult: (result) {
            if (result.finalResult) {
              searchController.text = result.recognizedWords;

              // Trigger the search operation
              WidgetsBinding.instance.addPostFrameCallback((_) {
                searchEntities(result.recognizedWords);
              });
            }
          },
        );
      }
    }
  }

  void searchEntities(String keyword) {
    eventModel.filteredEntities = eventModel.searchEntities
        .where((entity) =>
            entity['practice_match']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['admin_name']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['ground']
                .toString()
                .toLowerCase()
                .contains(keyword.toLowerCase()) ||
            entity['datetime']
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

  DateTime _selectedDateTime = DateTime.now();

  DateTime get selectedDateTime => _selectedDateTime;

  bool isSubmitting = false;
  String? errorMessage;

  Future<void> submitForm(
    BuildContext context,
    GlobalKey<FormState> formKey,
    Map<String, dynamic> formData,
    bool isActive,
    Future<Map<String, dynamic>> Function(Map<String, dynamic>) createEntity,
  ) async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      formData['active'] = isActive;

      isSubmitting = true;
      notifyListeners(); // Notify listeners about the state change.

      try {
        // Call the API to create the entity.
        Map<String, dynamic> createdEntity = await createEntity(formData);

        // Handle success (navigate back or show a success message).
        Navigator.pop(context);
      } catch (e) {
        // Handle error by setting the error message.
        errorMessage = 'Failed to create Event_Management: $e';
        notifyListeners();

        // Show a dialog with the error.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Error'),
              content: Text(errorMessage!),
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
      } finally {
        // Reset the submitting state.
        isSubmitting = false;
        notifyListeners();
      }
    }
  }

  Future<void> selectDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );
      if (pickedTime != null) {
        _selectedDateTime = DateTime(
          pickedDate.year,
          pickedDate.month,
          pickedDate.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        notifyListeners();
      }
    }
  }

  void resetPagination() {
    eventModel.currentPage = 0;
    eventModel.entities.clear();
    eventModel.filteredEntities.clear();
    notifyListeners();
  }
}
