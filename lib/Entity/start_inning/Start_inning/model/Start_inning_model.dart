import 'dart:convert';

class StartInningModel {
   int id;
   String selectMatch;
   String selectTeam;
   String selectPlayer;
   String datetimeField;

  // Constructor
  StartInningModel({
    required this.id,
    required this.selectMatch,
    required this.selectTeam,
    required this.selectPlayer,
    required this.datetimeField,
  });

  // Factory method to create an instance from JSON
  factory StartInningModel.fromJson(Map<String, dynamic> json) {
    return StartInningModel(
      id: json['id'],
      selectMatch: json['select_match'] ?? '',
      selectTeam: json['select_team'] ?? '',
      selectPlayer: json['select_player'] ?? '',
      datetimeField: json['datetime_field'] ?? '',
    );
  }

  // Convert the model to JSON (useful for API calls)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'select_match': selectMatch,
      'select_team': selectTeam,
      'select_player': selectPlayer,
      'datetime_field': datetimeField,
    };
  }

  // Factory method to create an instance from a Map (this could be used for data that is not in JSON format)
  factory StartInningModel.fromMap(Map<String, dynamic> map) {
    return StartInningModel(
      id: map['id'],
      selectMatch: map['select_match'] ?? '',
      selectTeam: map['select_team'] ?? '',
      selectPlayer: map['select_player'] ?? '',
      datetimeField: map['datetime_field'] ?? '',
    );
  }

  // Convert to Map (useful for when data needs to be passed in a Map format)
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'select_match': selectMatch,
      'select_team': selectTeam,
      'select_player': selectPlayer,
      'datetime_field': datetimeField,
    };
  }

  // Optional: Add methods for business logic (e.g., formatting datetimeField or updating select_team)
  StartInningModel copyWith({
    int? id,
    String? selectMatch,
    String? selectTeam,
    String? selectPlayer,
    String? datetimeField,
  }) {
    return StartInningModel(
      id: id ?? this.id,
      selectMatch: selectMatch ?? this.selectMatch,
      selectTeam: selectTeam ?? this.selectTeam,
      selectPlayer: selectPlayer ?? this.selectPlayer,
      datetimeField: datetimeField ?? this.datetimeField,
    );
  }

  @override
  String toString() {
    return 'StartInningModel(id: $id, selectMatch: $selectMatch, selectTeam: $selectTeam, selectPlayer: $selectPlayer, datetimeField: $datetimeField)';
  }
}
