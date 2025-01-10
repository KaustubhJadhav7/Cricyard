class MatchModel {
  final int id;
  final String matchName;
  final String score;
  final String result;
  final String dateField;
  final String description;
  final bool active;

  MatchModel({
    required this.id,
    required this.matchName,
    required this.score,
    required this.result,
    required this.dateField,
    required this.description,
    required this.active,
  });

  factory MatchModel.fromJson(dynamic json) {
    return MatchModel(
      id: json['id'],
      matchName: json['match_name'],
      score: json['score'],
      result: json['result'],
      dateField: json['date_field'],
      description: json['description'],
      active: json['active'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'match_name': matchName,
      'score': score,
      'result': result,
      'date_field': dateField,
      'description': description,
      'active': active,
    };
  }
}
