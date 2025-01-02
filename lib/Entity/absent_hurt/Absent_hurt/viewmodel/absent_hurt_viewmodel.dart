// import 'package:flutter/material.dart';
// import 'package:cricyard/Entity/absent_hurt/Absent_hurt/repository/Absent_hurt_api_service.dart';
// import '../model/Absent_hurt_model.dart';

// class AbsentHurtProvider with ChangeNotifier {
//   AbsentHurtModel _model = AbsentHurtModel();

//   // Getters
//   bool get isActive => _model.getIsActive;
//   String? get selectedPlayerName => _model.getSelectedPlayerName;
//   Map<String, dynamic> get formData => _model.getFormData;
//   String? get description => _model.getDescription;
//   Map<String, dynamic> get entity => _model.getEntity;
//   List<Map<String, dynamic>> get entities => _model.getEntities;
//   List<Map<String, dynamic>> get filteredEntities => _model.getFilteredEntities;
//   List<Map<String, dynamic>> get searchEntities => _model.getSearchEntities;
//   bool get isLoading => _model.getIsLoading;
//   bool get showCardView => _model.getShowCardView;

//   // Setters with notifyListeners
//   void setActive(bool value) {
//     _isActive = value;
//     notifyListeners();
//   }

//   void initialize(Map<String, dynamic> entity) {
//     _isActive = entity['active'] ?? false;
//     _selectedPlayerName = entity['player_name'];
//     _description = entity['description'];
//     _entity.clear();
//     _entity.addAll(entity);
//     notifyListeners();
//   }

//   void toggleCardView(bool value) {
//     _showCardView = value;
//     notifyListeners();
//   }

//   Future<void> fetch_Entities(
//       AbsentHurtApiService apiService, String token) async {
//     _isLoading = true;
//     notifyListeners();

//     try {
//       final fetchedEntities =
//           await apiService.getAllWithPagination(token, _currentPage, _pageSize);
//       _entities.addAll(fetchedEntities);
//       _filteredEntities = List.from(_entities);
//       _currentPage++;
//     } catch (e) {
//       // Handle the error appropriately
//       print('Error fetching entities: $e');
//     } finally {
//       _isLoading = false;
//       notifyListeners();
//     }
//   }

//   void setSelectedPlayerName(String? value) {
//     _selectedPlayerName = value;
//     _formData['player_name'] = value;
//     notifyListeners();
//   }

//   void saveDescription(String? description) {
//     _formData['description'] = description;
//     notifyListeners();
//   }

//   Future<void> fetchWithoutPaging(
//       AbsentHurtApiService apiService, String token) async {
//     try {
//       final fetchedEntities = await apiService.getEntities(token);
//       _searchEntities = fetchedEntities;
//       notifyListeners();
//     } catch (e) {
//       // Handle the error appropriately
//       print('Error fetching entities without paging: $e');
//     }
//   }

//   void search_Entities(String keyword) {
//     _filteredEntities = _searchEntities.where((entity) {
//       final description =
//           entity['description']?.toString()?.toLowerCase() ?? '';
//       final active = entity['active']?.toString()?.toLowerCase() ?? '';
//       final playerName = entity['player_name']?.toString()?.toLowerCase() ?? '';

//       return description.contains(keyword.toLowerCase()) ||
//           active.contains(keyword.toLowerCase()) ||
//           playerName.contains(keyword.toLowerCase());
//     }).toList();

//     notifyListeners();
//   }

//   Future<void> deleteEntity(AbsentHurtApiService apiService, String token,
//       Map<String, dynamic> entity) async {
//     try {
//       await apiService.deleteEntity(token, entity['id']);
//       _entities.remove(entity);
//       notifyListeners();
//     } catch (e) {
//       // Handle the error appropriately
//       print('Error deleting entity: $e');
//     }
//   }

//   void resetPagination() {
//     _currentPage = 0;
//     _entities.clear();
//     notifyListeners();
//   }

//   void setDescription(String value) {
//     _description = value;
//     _entity['description'] = value;
//     notifyListeners();
//   }
// }
import 'package:flutter/material.dart';
import 'package:cricyard/Entity/absent_hurt/Absent_hurt/repository/Absent_hurt_api_service.dart';
import '../model/Absent_hurt_model.dart';

class AbsentHurtProvider with ChangeNotifier {
  AbsentHurtModel _model = AbsentHurtModel();

  // Getters
  bool get isActive => _model.getIsActive;
  String? get selectedPlayerName => _model.getSelectedPlayerName;
  Map<String, dynamic> get formData => _model.getFormData;
  String? get description => _model.getDescription;
  Map<String, dynamic> get entity => _model.getEntity;
  List<Map<String, dynamic>> get entities => _model.getEntities;
  List<Map<String, dynamic>> get filteredEntities => _model.getFilteredEntities;
  List<Map<String, dynamic>> get searchEntities => _model.getSearchEntities;
  bool get isLoading => _model.getIsLoading;
  bool get showCardView => _model.getShowCardView;

  // Setters with notifyListeners
  void setActive(bool value) {
    _model.setIsActive = value;
    notifyListeners();
  }

  void initialize(Map<String, dynamic> entity) {
    _model.setIsActive = entity['active'] ?? false;
    _model.setSelectedPlayerName = entity['player_name'];
    _model.setDescription = entity['description'];
    _model.setEntity = entity;
    notifyListeners();
  }

  void toggleCardView(bool value) {
    _model.setShowCardView = value;
    notifyListeners();
  }

  Future<void> fetchEntities(AbsentHurtApiService apiService, ) async {
    _model.setIsLoading = true;
    notifyListeners();

    try {
      final fetchedEntities =
          await apiService.getAllWithPagination(_model.currentPage, _model.pageSize);
      _model.setEntities = List.from(_model.getEntities)..addAll(fetchedEntities);
      _model.setFilteredEntities = List.from(_model.getEntities);
      _model.setCurrentPage = _model.currentPage + 1;
    } catch (e) {
      print('Error fetching entities: $e');
    } finally {
      _model.setIsLoading = false;
      notifyListeners();
    }
  }

  void setSelectedPlayerName(String? value) {
    _model.setSelectedPlayerName = value;
    _model.formData['player_name'] = value;
    notifyListeners();
  }

  void saveDescription(String? description) {
    _model.formData['description'] = description;
    notifyListeners();
  }

  Future<void> fetchWithoutPaging(
      AbsentHurtApiService apiService, ) async {
    try {
      final fetchedEntities = await apiService.getEntities();
      _model.setSearchEntities = fetchedEntities;
      notifyListeners();
    } catch (e) {
      print('Error fetching entities without paging: $e');
    }
  }

  void search_Entities(String keyword) {
    _model.setFilteredEntities = _model.getSearchEntities.where((entity) {
      final description = entity['description']?.toString()?.toLowerCase() ?? '';
      final active = entity['active']?.toString()?.toLowerCase() ?? '';
      final playerName = entity['player_name']?.toString()?.toLowerCase() ?? '';

      return description.contains(keyword.toLowerCase()) ||
          active.contains(keyword.toLowerCase()) ||
          playerName.contains(keyword.toLowerCase());
    }).toList();

    notifyListeners();
  }

  Future<void> deleteEntity(AbsentHurtApiService apiService, Map<String, dynamic> entity) async {
    try {
      await apiService.deleteEntity( entity['id']);
      _model.setEntities = _model.getEntities..remove(entity);
      notifyListeners();
    } catch (e) {
      print('Error deleting entity: $e');
    }
  }

  void resetPagination() {
    _model.setCurrentPage = 0;
    _model.setEntities = [];
    notifyListeners();
  }

  void setDescription(String value) {
    _model.setDescription = value;
    _model.setEntity = {..._model.getEntity, 'description': value};
    notifyListeners();
  }
}
