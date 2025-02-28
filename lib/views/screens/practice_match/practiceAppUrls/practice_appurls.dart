import 'package:shared_preferences/shared_preferences.dart';

import '../../../../resources/api_constants.dart';

class PracticeAppurls {
  static const baseUrl = ApiConstants.baseUrl;

// Match Urls
  static const createPracticeMatch =
      '$baseUrl/token/Practice/score/Score_board';

  static const getAllmatches =
      '$baseUrl/token/Practice/score/Score_board/myMatches';

  static const getAllWithPagination =
      '$baseUrl/token/Practice/score/Score_board/getall/page';

  static Future<String?> getPreferredSport() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('preferred_sport');
  }
// Teams Uurls
  static const getAllTeams =
      '$baseUrl/token/Practice/Teams/PracticeTeam/myTeam';

  static const getAllPlayersInTeam =
      '$baseUrl/token/Practice/Player/PracticeTeamPlayer/myTeam';
  static const newPlayerEntryInningend =
      '$baseUrl/token/Practice/score/inningEnd/entry';

  static const deleteEntity = '$baseUrl/token/Practice/score/Match';
  static const createNewTeam = '$baseUrl/token/Practice/Teams/Teams';

// Archived urls
  static const getAllArchivedMatches = '$baseUrl/token/Practice/score/Archived';

  static const unArchiveMatch = '$baseUrl/token/Practice/score/unArchived';
  static const archiveMatch = '$baseUrl/token/Practice/score/Archived';

  static const getlastrecord = '$baseUrl/token/Practice/score/lastRecord';
}
