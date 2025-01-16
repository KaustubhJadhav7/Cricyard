import 'package:cricyard/views/screens/Bookmarks/model/Bookmarks_model.dart';
import 'package:flutter/material.dart';
import '../repository/Bookmarks_api_service.dart'; // Replace with actual API service import
// import 'bookmark_model.dart'; // Replace with your actual model file

class BookmarksProvider with ChangeNotifier {
  List<BookmarkEntity> _entities = [];
  bool _isLoading = false;

  List<BookmarkEntity> get entities => _entities;
  bool get isLoading => _isLoading;

  final ApiService apiService = ApiService(); // Replace with actual API service

  // Fetch entities
  Future<void> fetchEntities() async {
    _isLoading = true;
    notifyListeners();

    try {
      final fetchedEntities = await apiService.getEntities();
      _entities = fetchedEntities;
    } catch (e) {
      print('Failed to fetch entities: $e');
      // Handle error, if needed
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Delete an entity
  Future<void> deleteEntity(Map<String, dynamic> entity) async {
    try {
      await apiService.deleteEntity(entity['id']);
      _entities.remove(entity);
      notifyListeners();
    } catch (e) {
      print('Failed to delete entity: $e');
      // Handle error, if needed
    }
  }
// Replace with your actual API service

  // Method to update an entity
  Future<void> updateEntity(BuildContext context, BookmarkEntity entity) async {
    try {
      await apiService.updateEntity(entity.id, entity);
      
      // Update the entity in the list if necessary (this depends on how you structure your data)
      int index = _entities.indexWhere((e) => e.id == entity.id);
      if (index != -1) {
        _entities[index] = entity;
        notifyListeners();
      }

      // Optionally handle post-update navigation logic here
      Navigator.pop(context);  // Navigating back after successful update
      
    } catch (e) {
      // Handle the error (UI-related handling will be in the widget layer)
      print('Failed to update entity: $e');
      // You can still throw the error to show it in the UI layer if needed.
      throw e;
    }
  }

  Future<void> createEntity(
      BuildContext context, BookmarkEntity formData, dynamic selectedFileupload_Field) async {
    try {
      _isLoading = true;
      notifyListeners();

      await apiService.createEntity(formData, selectedFileupload_Field);
      
      // Optionally, you can update internal state if the created entity needs to be added to the list.
      // Example: _entities.add(newEntity);
      // notifyListeners();

      Navigator.pop(context); // Navigating back after successful creation
    } catch (e) {
      _isLoading = false;
      notifyListeners();
      
      // Rethrow the error so it can be handled in the UI layer (e.g., show a dialog)
      throw e;
    }
  }
}
