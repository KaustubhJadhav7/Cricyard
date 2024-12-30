import '../../../../../resources/api_constants.dart';

class TeamAppUrl {
  static const baseUrl = ApiConstants.baseUrl;

  static const getEntities = '$baseUrl/Teams/Teams';
  static const getMyTeam = '$baseUrl/Teams/Teams/myTeam';
  static const enrollInTeam = '$baseUrl/team/Register_team';

  static const getAllInvitedPlayers =
      '$baseUrl/Invitation_member/Invitation_member/myplayer';

  static const invitePlayer = '$baseUrl/Teams/Teams/invite';
}
