import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../repository/FeedBack_Form_api_service.dart';

class FeedbackModel {
  final String id;
  final String name;
  final String phoneNumber;
  final String email;
  final String experience;

  FeedbackModel({
    required this.id,
    required this.name,
    required this.phoneNumber,
    required this.email,
    required this.experience,
  });

  // Factory method to create a FeedbackModel from a Map
  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      phoneNumber: json['phone_number'] ?? '',
      email: json['email_field'] ?? '',
      experience: json['share_your_experience'] ?? '',
    );
  }

  // Convert FeedbackModel to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'phone_number': phoneNumber,
      'email_field': email,
      'share_your_experience': experience,
    };
  }
}

class FeedbackFormData {
  final Map<String, dynamic> formData;
  final GlobalKey<FormState> formKey;

  FeedbackFormData({required this.formData, required this.formKey});
}

class PaginationSettings {
  int currentPage;
  final int pageSize;

  PaginationSettings({this.currentPage = 0, this.pageSize = 10});
}

class SearchSettings {
  TextEditingController searchController = TextEditingController();
  List<FeedbackModel> searchResults = [];
}

class FeedbackProviderState {
  final List<Map<String, dynamic>> entities;
  final List<Map<String, dynamic>> filteredEntities;
  final List<Map<String, dynamic>> searchEntities;
  final bool showCardView;
  final bool isLoading;
  final int currentPage;
  final int pageSize;
  final TextEditingController searchController;
  final ScrollController scrollController;
  final stt.SpeechToText speech;
  final FeedbackFormApiService apiService;

  FeedbackProviderState({
    required this.entities,
    required this.filteredEntities,
    required this.searchEntities,
    required this.showCardView,
    required this.isLoading,
    required this.currentPage,
    required this.pageSize,
    required this.searchController,
    required this.scrollController,
    required this.speech,
    required this.apiService,
  });
}
