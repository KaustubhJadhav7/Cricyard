class ApiConstants {
  // static const baseUrl = 'http://localhost:9292';
  // static const baseUrl = 'http://3.6.250.12:30198';
  static const baseUrl = 'http://43.205.171.168:30198';

  // AbsentHurt
  static const getEntitiesAbsenthurt = '$baseUrl/Absent_hurt/Absent_hurt';
  static const String getAllWithPaginationAbsenthurt = '$baseUrl/Absent_hurt/Absent_hurt/getall/page';
  static const String createEntityAbsenthurt = '$baseUrl/Absent_hurt/Absent_hurt';
  static const String updateEntityAbsenthurt = '$baseUrl/Absent_hurt/Absent_hurt/{entityId}';
  static const String deleteEntityAbsenthurt = '$baseUrl/Absent_hurt/Absent_hurt/{entityId}';
  // AddTournament
  static const String getEntitiesMyTournament = '$baseUrl/My_Tournament/My_Tournament';
  static const String getAllWithPaginationMyTournament = '$baseUrl/My_Tournament/My_Tournament/getall/page';
  static const String createEntityMyTournament = '$baseUrl/My_Tournament/My_Tournament';
  static const String uploadLogoImage = '$baseUrl/FileUpload/Uploadeddocs';
  static const String updateEntityMyTournament = '$baseUrl/My_Tournament/My_Tournament/{entityId}';
  static const String deleteEntityMyTournament = '$baseUrl/My_Tournament/My_Tournament/{entityId}';
  static const String getTournamentName = '$baseUrl/Tournament_List_ListFilter1/Tournament_List_ListFilter1';
  static const String registerTournament = '$baseUrl/tournament/Register_tournament';
  static const String getEnrolledTournament = '$baseUrl/My_Tournament/My_Tournament/myTour';
  static const String getMyTournament = '$baseUrl/My_Tournament/My_Tournament/creted/myTour';
  static const String getAllByUserId = '$baseUrl/tournament/Register_tournament/userid';
  // EventManagement 
  static const String getEntitiesEventManagement = '$baseUrl/Event_Management/Event_Management';
  static const String getAllWithPaginationEventManagement = '$baseUrl/Event_Management/Event_Management/getall/page';
  static const String createEntityEventManagement = '$baseUrl/Event_Management/Event_Management';
  static const String updateEntityEventManagement = '$baseUrl/Event_Management/Event_Management/{entityId}';
  static const String deleteEntityEventManagement = '$baseUrl/Event_Management/Event_Management/{entityId}';
  // FindFriends
  static const String findFriendsBase = '$baseUrl/Find_Friends/Find_Friends';
  static const String findFriends = '$findFriendsBase';
  static const String myFriends = '$findFriendsBase/myFriends';
  static const String addFriend = '$findFriendsBase/Add';
  static const String deleteFriend = '$findFriendsBase';
  static const String users = '$baseUrl/api/getuser/accountid';
  static const String pagination = '$findFriendsBase/getall/page';
 // LiveCricket
  static const String getEntitiesLiveCricket = '$baseUrl/LIve_Cricket/LIve_Cricket';
  static const String getAllWithPaginationLiveCricket = '$baseUrl/LIve_Cricket/LIve_Cricket/getall/page';
  static const String createEntityLiveCricket = '$baseUrl/LIve_Cricket/LIve_Cricket';
  static const String updateEntityLiveCricket = '$baseUrl/LIve_Cricket/LIve_Cricket';
  static const String deleteEntityLiveCricket = '$baseUrl/LIve_Cricket/LIve_Cricket';
// Leaderboard
  static const String getEntitiesLeaderboard = '$baseUrl/LeaderBoard/LeaderBoard';
  static const String getAllWithPaginationLeaderboard = '$baseUrl/LeaderBoard/LeaderBoard/getall/page';
  static const String createEntityLeaderboard = '$baseUrl/LeaderBoard/LeaderBoard';
  static const String updateEntityLeaderboard = '$baseUrl/LeaderBoard/LeaderBoard';
  static const String deleteEntityLeaderboard = '$baseUrl/LeaderBoard/LeaderBoard';
// Highlights
  static const String getEntitiesHighlights = '$baseUrl/Highlights/Highlights';
  static const String getAllWithPaginationHighlights = '$baseUrl/Highlights/Highlights/getall/page';
  static const String createEntityHighlights = '$baseUrl/Highlights/Highlights';
  static const String updateEntityHighlights = '$baseUrl/Highlights/Highlights';
  static const String deleteEntityHighlights = '$baseUrl/Highlights/Highlights';
// Followers
  static const String getEntitiesFollowers = '$baseUrl/Followers/Followers';
  static const String getAllWithPaginationFollowers = '$baseUrl/Followers/Followers/getall/page';
  static const String createEntityFollowers = '$baseUrl/Followers/Followers';
  static const String updateEntityFollowers = '$baseUrl/Followers/Followers';
  static const String deleteEntityFollowers = '$baseUrl/Followers/Followers';
// Feedback Form
  static const String getEntitiesFeedbackForm = '$baseUrl/FeedBack_Form/FeedBack_Form';
  static const String getAllWithPaginationFeedbackForm = '$baseUrl/FeedBack_Form/FeedBack_Form/getall/page';
  static const String createEntityFeedbackForm = '$baseUrl/FeedBack_Form/FeedBack_Form';
  static const String updateEntityFeedbackForm = '$baseUrl/FeedBack_Form/FeedBack_Form';
  static const String deleteEntityFeedbackForm = '$baseUrl/FeedBack_Form/FeedBack_Form';
// Cricket
  static const String getEntitiesCricket = '$baseUrl/Cricket/Cricket';
  static const String getAllWithPaginationCricket = '$baseUrl/Cricket/Cricket/getall/page';
  static const String createEntityCricket = '$baseUrl/Cricket/Cricket';
  static const String updateEntityCricket = '$baseUrl/Cricket/Cricket';
  static const String deleteEntityCricket = '$baseUrl/Cricket/Cricket';
  // Contact Us
  static const String getEntitiesContactUs = '$baseUrl/Contact_us/Contact_us';
  static const String getAllWithPaginationContactUs = '$baseUrl/Contact_us/Contact_us/getall/page';
  static const String createEntityContactUs = '$baseUrl/Contact_us/Contact_us';
  static const String updateEntityContactUs = '$baseUrl/Contact_us/Contact_us';
  static const String deleteEntityContactUs = '$baseUrl/Contact_us/Contact_us';
  // Live Score Update
  static const String getEntitiesLiveScoreUpdate = '$baseUrl/Live_Score_Update/Live_Score_Update';
  static const String getAllWithPaginationLiveScoreUpdate = '$baseUrl/Live_Score_Update/Live_Score_Update/getall/page';
  static const String createEntityLiveScoreUpdate = '$baseUrl/Live_Score_Update/Live_Score_Update';
  static const String updateEntityLiveScoreUpdate = '$baseUrl/Live_Score_Update/Live_Score_Update';
  static const String deleteEntityLiveScoreUpdate = '$baseUrl/Live_Score_Update/Live_Score_Update';
// Match Endpoints
  static const String getEntitiesMatch = '$baseUrl/Match/Match';
  static const String getAllWithPaginationMatch = '$baseUrl/Match/Match/getall/page';
  static const String createEntityMatch = '$baseUrl/Match/Match';
  static const String updateEntityMatch = '$baseUrl/Match/Match';
  static const String cancelMatch = '$baseUrl/Match/Match/cancel';
  static const String deleteEntityMatch = '$baseUrl/Match/Match';
  static const String myMatches = '$baseUrl/Match/Match/myMatches';
  static const String allMatchesByTourId = '$baseUrl/Match/Match/tournament';
  static const String liveMatches = '$baseUrl/Match/Match/status?status=Started';
  static const String liveMatchesByTourId = '$baseUrl/Match/Match/status/tour?status=Started';


    // for api contants =>  static const getEntitiesAbsenthurt = '$baseUrl/Absent_hurt/Absent_hurt';
    // for repo => final response = await _networkApiService.getGetApiResponse(AppUrls.getEntitiesAbsenthurt)

}
