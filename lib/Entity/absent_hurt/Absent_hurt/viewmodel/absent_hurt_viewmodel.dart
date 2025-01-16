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
  AbsentHurtEntity get entity => _model.getEntity;
  List<AbsentHurtEntity> get entities => _model.getEntities;
  List<AbsentHurtEntity> get filteredEntities => _model.getFilteredEntities;
  List<AbsentHurtEntity> get searchEntities => _model.getSearchEntities;
  bool get isLoading => _model.getIsLoading;
  bool get showCardView => _model.getShowCardView;
  AbsentHurtApiService apiService =
      AbsentHurtApiService(); // Setters with notifyListeners
  void setActive(bool value) {
    _model.setIsActive = value;
    notifyListeners();
  }

  void initialize(AbsentHurtEntity entity) {
    _model.setIsActive = entity.active ?? false;
    _model.setSelectedPlayerName = entity.playerName;
    _model.setDescription = entity.description;
    _model.setEntity = entity;
    notifyListeners();
  }

  void toggleCardView(bool value) {
    _model.setShowCardView = value;
    notifyListeners();
  }

  Future<void> fetchEntities(
    AbsentHurtApiService apiService,
  ) async {
    _model.setIsLoading = true;
    notifyListeners();

    try {
      final fetchedEntities = await apiService.getAllWithPagination(
          _model.currentPage, _model.pageSize);
      _model.setEntities = List.from(_model.getEntities)
        ..addAll(fetchedEntities);
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
    // _model.setFormData['player_name'] = value;
    _model.setFormData = {..._model.getFormData, 'value': value};
    notifyListeners();
  }

  void saveDescription(String? description) {
    _model.setFormData = {..._model.getFormData, 'description': description};
    notifyListeners();
  }

  Future<void> fetchWithoutPaging(
    AbsentHurtApiService apiService,
  ) async {
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
      final description =
          entity.description?.toString()?.toLowerCase() ?? '';
      final active = entity.active?.toString()?.toLowerCase() ?? '';
      final playerName = entity.playerName?.toString()?.toLowerCase() ?? '';

      return description.contains(keyword.toLowerCase()) ||
          active.contains(keyword.toLowerCase()) ||
          playerName.contains(keyword.toLowerCase());
    }).toList();

    notifyListeners();
  }

  Future<void> deleteEntity(
      AbsentHurtApiService apiService, AbsentHurtEntity entity) async {
    try {
      await apiService.deleteEntity(entity.id);
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
    final updatedEntity = _model.getEntity.toMap();
    updatedEntity['description'] = value;
    _model.setDescription = value;
    // _model.setEntity = {..._model.getEntity, 'description': value};
    _model.setEntity = AbsentHurtEntity.fromMap(updatedEntity);
    notifyListeners();
  }

  Future<void> createEntity(
      BuildContext context, Map<String, dynamic> formData) async {
    try {
      await apiService.createEntity(formData);
      Navigator.pop(context);
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  void _showErrorDialog(BuildContext context, String errorMessage) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text('Failed to create entity: $errorMessage'),
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
