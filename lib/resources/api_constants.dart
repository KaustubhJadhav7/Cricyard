class ApiConstants {
  // static const baseUrl = 'http://localhost:9292';
  static const baseUrl = 'http://3.6.250.12:30198';

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







    // for api contants =>  static const getEntitiesAbsenthurt = '$baseUrl/Absent_hurt/Absent_hurt';
    // for repo => final response = await _networkApiService.getGetApiResponse(AppUrls.getEntitiesAbsenthurt)

}
