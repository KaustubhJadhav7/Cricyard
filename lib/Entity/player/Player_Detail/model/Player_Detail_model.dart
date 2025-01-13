class PlayerDetailModel {
   int id;
   String playerName;
   String phoneNumber;
   String email;
   String teamName;

  PlayerDetailModel({
    required this.id,
    required this.playerName,
    required this.phoneNumber,
    required this.email,
    required this.teamName,
  });

  /// Factory constructor to create a `PlayerDetailModel` from a JSON map
  factory PlayerDetailModel.fromJson(Map<String, dynamic> json) {
    return PlayerDetailModel(
      id: json['id'] as int,
      playerName: json['player_name'] as String,
      phoneNumber: json['phone_number'] as String,
      email: json['email'] as String,
      teamName: json['team_name'] as String,
    );
  }

  /// Converts a `PlayerDetailModel` instance to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'player_name': playerName,
      'phone_number': phoneNumber,
      'email': email,
      'team_name': teamName,
    };
  }

  void updateField(String key, dynamic value) {
    switch (key) {
      case 'player_name':
        playerName = value;
        break;
      case 'phone_number':
        phoneNumber = value;
        break;
      // Add more cases if needed
    }
  }
  List<dynamic> get values => [id, playerName, phoneNumber, email, teamName];
}
