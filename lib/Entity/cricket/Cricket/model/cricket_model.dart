// models.dart
import 'package:speech_to_text/speech_to_text.dart' as stt;
class CricketListModel {
  List<Map<String, dynamic>> entities;
  List<Map<String, dynamic>> filteredEntities;
  List<Map<String, dynamic>> searchEntities;
  bool showCardView;
  late stt.SpeechToText speech;
  bool isLoading;
  int currentPage;
  int pageSize;

  CricketListModel({
    this.entities = const [],
    this.filteredEntities = const [],
    this.searchEntities = const [],
    this.showCardView = true,
    stt.SpeechToText? speechInstance,
    this.isLoading = false,
    this.currentPage = 0,
    this.pageSize = 10,
  }) : speech = speechInstance ?? stt.SpeechToText();
}

class CricketEntity {
  int? id;
  String? audioLanguage;
  String? name;
  String? description;
  bool? isActive;

  CricketEntity({
    this.id,
    this.audioLanguage,
    this.name,
    this.description,
    this.isActive,
  });

  // Create CricketEntity from a JSON object
  factory CricketEntity.fromJson(Map<String, dynamic> json) {
    return CricketEntity(
      id: json['id'],
      audioLanguage: json['audio_language'],
      name: json['name'],
      description: json['description'],
      isActive: json['active'] ?? false,
    );
  }

  // Convert CricketEntity to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'audio_language': audioLanguage,
      'name': name,
      'description': description,
      'active': isActive,
    };
  }
}
