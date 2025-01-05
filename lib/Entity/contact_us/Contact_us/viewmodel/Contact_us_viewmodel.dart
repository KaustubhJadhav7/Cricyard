import 'package:flutter/material.dart';
import '../repository/contact_us_api_service.dart';

class ContactUsProvider with ChangeNotifier {
  final ContactUsApiService _apiService = ContactUsApiService();
  // Form data
  final Map<String, dynamic> _formData = {};
  bool _isActive = false;
  bool _isLoading = false;
  // Getters
  Map<String, dynamic> get formData => _formData;
  bool get isActive => _isActive;
  bool get isLoading => _isLoading;
  // Setters
  void setName(String name) {
    _formData['name'] = name;
    notifyListeners();
  }
  void setPhoneNumber(String phoneNumber) {
    _formData['phone_number'] = phoneNumber;
    notifyListeners();
  }
  void setComment(String comment) {
    _formData['comment'] = comment;
    notifyListeners();
  }
  void setDescription(String description) {
    _formData['description'] = description;
    notifyListeners();
  }
  void toggleActive(bool isActive) {
    _isActive = isActive;
    notifyListeners();
  }
  // Method to submit the form
  Future<void> submitForm() async {
    if (_formData.isEmpty) {
      throw Exception("Form data is empty!");
    }
    _formData['active'] = _isActive;
    _isLoading = true;
    notifyListeners();
    try {
      await _apiService.createEntity(_formData);
    } catch (error) {
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Reset form data
  void resetForm() {
    _formData.clear();
    _isActive = false;
    notifyListeners();
  }
}
