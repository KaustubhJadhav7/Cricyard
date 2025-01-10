import 'dart:convert';
import 'package:flutter/material.dart';

class StartMatchModel {
  final int? id;
  final String? nameOfMatch;
  final String? format;
  final String? rules;
  final String? venue;
  final String? dateField;
  final String? description;
  bool? isActive;
  
  StartMatchModel({
    this.id,
    this.nameOfMatch,
    this.format,
    this.rules,
    this.venue,
    this.dateField,
    this.description,
    this.isActive,
  });

  // Factory constructor to create the model from JSON
  factory StartMatchModel.fromJson(Map<String, dynamic> json) => StartMatchModel(
    id: json['id'],
    nameOfMatch: json['name_of_match'],
    format: json['format'],
    rules: json['rules'],
    venue: json['venue'],
    dateField: json['date_field'],
    description: json['description'],
    isActive: json['active'],
  );

  // Method to convert the model into a JSON map
  Map<String, dynamic> toJson() => {
    'id': id,
    'name_of_match': nameOfMatch,
    'format': format,
    'rules': rules,
    'venue': venue,
    'date_field': dateField,
    'description': description,
    'active': isActive,
  };

  // Method to toggle the 'isActive' property
  void toggleActive() {
    isActive = !(isActive ?? false);
  }

  // Additional methods as needed
  void searchEntitiesByKeyword(String keyword, List<StartMatchModel> entities) {
    entities.where((entity) =>
        entity.nameOfMatch!.toLowerCase().contains(keyword.toLowerCase()) ||
        entity.format!.toLowerCase().contains(keyword.toLowerCase()) ||
        entity.rules!.toLowerCase().contains(keyword.toLowerCase()) ||
        entity.venue!.toLowerCase().contains(keyword.toLowerCase()) ||
        entity.dateField!.toLowerCase().contains(keyword.toLowerCase()) ||
        entity.description!.toLowerCase().contains(keyword.toLowerCase()) ||
        entity.isActive.toString().toLowerCase().contains(keyword.toLowerCase())
    ).toList();
  }
}
