// import 'dart:convert';

// class TeamsModel {
//    int id;
//    String? teamName;
//    String? description;
//    int members;
//    int matches;
//    bool active;
//    bool? addMyself;
//    bool invited;

//   TeamsModel({
//     required this.id,
//     required this.teamName,
//     required this.description,
//     required this.members,
//     required this.matches,
//     required this.active,
//     required this.addMyself,
//     this.invited = false,
//   });

//   /// Factory method to create an instance from JSON
//   factory TeamsModel.fromJson(Map<String, dynamic> json) {
//     return TeamsModel(
//       id: json['id'] ?? 0,
//       teamName: json['team_name'] ?? '',
//       description: json['description'] ?? '',
//       members: json['members'] ?? 0,
//       matches: json['matches'] ?? 0,
//       active: json['active'] ?? false,
//       addMyself: json['add_myself'] ?? false,
//     );
//   }

//   /// Convert the model to JSON (useful for API calls)
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'team_name': teamName,
//       'description': description,
//       'members': members,
//       'matches': matches,
//       'active': active,
//       'add_myself': addMyself,
//     };
//   }

//   /// Factory method to create an instance from a Map
//   factory TeamsModel.fromMap(Map<String, dynamic> map) {
//     return TeamsModel(
//       id: map['id'] ?? 0,
//       teamName: map['team_name'] ?? '',
//       description: map['description'] ?? '',
//       members: map['members'] ?? 0,
//       matches: map['matches'] ?? 0,
//       active: map['active'] ?? false,
//       addMyself: map['add_myself'] ?? false,
//       invited: map['invited'] ?? false,
//     );
//   }

//   /// Convert to Map for use in APIs or local storage
//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'team_name': teamName,
//       'description': description,
//       'members': members,
//       'matches': matches,
//       'active': active,
//       'add_myself': addMyself,
//       'invited': invited,
//     };
//   }

//   /// Method to copy the current instance with updated fields
//   TeamsModel copyWith({
//     int? id,
//     String? teamName,
//     String? description,
//     int? members,
//     int? matches,
//     bool? active,
//     bool? addMyself,
//     bool? invited,

//   }) {
//     return TeamsModel(
//       id: id ?? this.id,
//       teamName: teamName ?? this.teamName,
//       description: description ?? this.description,
//       members: members ?? this.members,
//       matches: matches ?? this.matches,
//       active: active ?? this.active,
//       addMyself: addMyself ?? this.addMyself,
//       invited: invited ?? this.invited
//     );
//   }

//   @override
//   String toString() {
//     return 'TeamsModel(id: $id, teamName: $teamName, description: $description, members: $members, matches: $matches, active: $active, addMyself: $addMyself)';
//   }
// }
import 'dart:convert';

class TeamsModel {
  int id;
  String? teamName;
  String? description;
  String? preferredSport;
  int? members;
  int? matches;
  bool active;
  bool? addMyself;
  bool invited;

  TeamsModel({
    required this.id,
    required this.teamName,
    required this.description,
    this.preferredSport,
    required this.members,
    required this.matches,
    required this.active,
    required this.addMyself,
    this.invited = false,
  });

  /// Factory method to create an instance from JSON
  factory TeamsModel.fromJson(Map<String, dynamic> json) {
    return TeamsModel(
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      teamName: json['team_name'] ?? '', // Adjusted to match API field
      description: json['description'] ?? '',
      preferredSport: json['preferred_sport'] ?? '',
      members: json['members'] is int
          ? json['members']
          : json['members'] != null
              ? int.tryParse(json['members'].toString()) ?? 0
              : 0,
      matches: json['matches'] is int
          ? json['matches']
          : json['matches'] != null
              ? int.tryParse(json['matches'].toString()) ?? 0
              : 0,
      active: json['active'] ?? false,
      addMyself: json['add_myself'] ?? false,
      invited: json['invited'] ?? false, // Ensure this field is populated
    );
  }

  /// Convert the model to JSON (useful for API calls)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'team_name': teamName,
      'description': description,
      'preferred_sport': preferredSport,
      'members': members,
      'matches': matches,
      'active': active,
      'add_myself': addMyself,
      // 'invited': invited, // Include the invited field
    };
  }

  /// Factory method to create an instance from a Map
  factory TeamsModel.fromMap(Map<String, dynamic> map) {
    return TeamsModel(
      id: map['id'] ?? 0,
      teamName: map['team_name'] ?? '',
      description: map['description'] ?? '',
      preferredSport: map['preferred_sport'] ?? '',
      members: map['members'] ?? 0,
      matches: map['matches'] ?? 0,
      active: map['active'] ?? false,
      addMyself: map['add_myself'] ?? false,
      invited: map['invited'] ?? false, // Ensure the invited field is populated
    );
  }

  /// Convert to Map for use in APIs or local storage
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'team_name': teamName,
      'description': description,
      'preferred_sport': preferredSport,
      'members': members,
      'matches': matches,
      'active': active,
      'add_myself': addMyself,
      // 'invited': invited, // Include the invited field
    };
  }

  /// Method to copy the current instance with updated fields
  TeamsModel copyWith({
    int? id,
    String? teamName,
    String? description,
    String? preferredSport,
    int? members,
    int? matches,
    bool? active,
    bool? addMyself,
    bool? invited,
  }) {
    return TeamsModel(
      id: id ?? this.id,
      teamName: teamName ?? this.teamName,
      description: description ?? this.description,
      preferredSport: preferredSport ?? this.preferredSport,
      members: members ?? this.members,
      matches: matches ?? this.matches,
      active: active ?? this.active,
      addMyself: addMyself ?? this.addMyself,
      invited: invited ?? this.invited,
    );
  }

  @override
  String toString() {
    return 'TeamsModel(id: $id, teamName: $teamName, description: $description,preferredSport: $preferredSport, members: $members, matches: $matches, active: $active, addMyself: $addMyself, invited: $invited)';
  }
}
