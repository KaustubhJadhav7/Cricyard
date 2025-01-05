import 'package:flutter/foundation.dart';
import '../repository/Event_Management_api_service.dart';
import '/providers/token_manager.dart';
import 'package:flutter/material.dart';


class EventManagementProvider with ChangeNotifier {
  final EventManagementApiService _apiService = EventManagementApiService();
  
  List<Map<String, dynamic>> _entities = [];
  List<Map<String, dynamic>> _filteredEntities = [];
  List<Map<String, dynamic>> _searchEntities = [];
  final Map<String, dynamic> formData = {};
  final formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  int _currentPage = 0;
  int _pageSize = 10;

  List<Map<String, dynamic>> get entities => _entities;
  List<Map<String, dynamic>> get filteredEntities => _filteredEntities;
  bool get isLoading => _isLoading;

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isActive = false;

  // bool get isActive => isActive;

  void toggleActive(bool newValue) {
    isActive = newValue;
    notifyListeners();
  }




  Future<void> fetchEntities() async {
  if (_isLoading) return; // Prevent simultaneous fetches
  
  _setLoading(true); // Set loading state
  try {
    final token = await TokenManager.getToken();
    if (token != null) {
      // Fetch paginated data from the API
      final fetchedEntities = await _apiService.getAllWithPagination(
        // token, // Ensure token is passed
        _currentPage,
        _pageSize,
      );

      if (fetchedEntities.isNotEmpty) {
        _entities.addAll(fetchedEntities); // Append fetched data
        _filteredEntities = List.from(_entities); // Sync filtered list
        _currentPage++; // Increment for next fetch
      }
      notifyListeners(); // Notify UI about the changes
    }
  } catch (e) {
    debugPrint('Failed to fetch entities: $e');
    throw Exception('Failed to fetch entities: $e'); // Retain error for visibility
  } finally {
    _setLoading(false); // Reset loading state
  }
}


  Future<void> fetchWithoutPaging() async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        final fetchedEntities = await _apiService.getEntities();
        _searchEntities = fetchedEntities;
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
      _entities.removeWhere((e) => e['id'] == entity['id']); // Use 'entity['id']' here
      _filteredEntities = List.from(_entities);
      notifyListeners();
    }
  } catch (e) {
    debugPrint('Failed to delete entity: $e');
    rethrow;
  }
}


  void searchEntities(String keyword) {
    _filteredEntities = _searchEntities
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
    _currentPage = 0;
    _entities.clear();
    _filteredEntities.clear();
    notifyListeners();
  }
}
