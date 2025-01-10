import 'dart:convert';

class MatchModel {
  final int? id;
  final String? team1;
  final String? team2;
  final String? location;
  final String? dateField;
  final String? dateTimeField;
  final String? name;
  final String? description;
  final bool? active;
  final int? userId;

  MatchModel({
    this.id,
    this.team1,
    this.team2,
    this.location,
    this.dateField,
    this.dateTimeField,
    this.name,
    this.description,
    this.active,
    this.userId,
  });

  /// Factory constructor for creating an instance from JSON.
  factory MatchModel.fromJson(Map<String, dynamic> json) => MatchModel(
        id: json['id'],
        team1: json['team_1'],
        team2: json['team_2'],
        location: json['location'],
        dateField: json['date_field'],
        dateTimeField: json['datetime_field'],
        name: json['name'],
        description: json['description'],
        active: json['active'],
        userId: json['user_id'],
      );

  /// Converts the instance to a JSON-compatible map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'team_1': team1,
        'team_2': team2,
        'location': location,
        'date_field': dateField,
        'datetime_field': dateTimeField,
        'name': name,
        'description': description,
        'active': active,
        'user_id': userId,
      };

  /// Creates a `MatchModel` instance from a raw JSON string.
  factory MatchModel.fromRawJson(String str) =>
      MatchModel.fromJson(json.decode(str));

  /// Converts the `MatchModel` instance to a raw JSON string.
  String toRawJson() => json.encode(toJson());
}
