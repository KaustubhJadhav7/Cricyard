// import 'package:cricyard/providers/token_manager.dart';
// import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';
// import 'dart:typed_data';
// import '/resources/api_constants.dart';

// class teamsApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();

//   Future<List<Map<String, dynamic>>> getEntities() async {
//     try {
//       final token = await TokenManager.getToken();

//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get('$baseUrl/Teams/Teams');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all Team: $e');
//     }
//   }

//   Future<List<Map<String, dynamic>>> getAllWithPagination(
//       String token, int page, int Size) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio
//           .get('$baseUrl/Teams/Teams/getall/page?page=$page&size=$Size');
//       final entities =
//           (response.data['content'] as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all without pagination: $e');
//     }
//   }

//   Future<Map<String, dynamic>> createEntity(
//       String token, Map<String, dynamic> entity) async {
//     try {
//       print("in post api$entity");
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.post('$baseUrl/Teams/Teams', data: entity);

//       print(entity);

//       // Assuming the response is a Map<String, dynamic>
//       Map<String, dynamic> responseData = response.data;

//       return responseData;
//     } catch (e) {
//       throw Exception('Failed to create Team: $e');
//     }
//   }

// // Modify the uploadlogoimage function
//   Future<void> uploadlogoimage(String token, String ref, String refTableNmae,
//       String selectedFilePath, Uint8List image_timageBytes) async {
//     try {
//       String apiUrl = "$baseUrl/FileUpload/Uploadeddocs/$ref/$refTableNmae";

//       final Uint8List fileBytes = image_timageBytes!;
//       final mimeType = logolookupMimeType(selectedFilePath);

//       FormData formData = FormData.fromMap({
//         'file': MultipartFile.fromBytes(
//           fileBytes,
//           filename: selectedFilePath
//               .split('/')
//               .last, // Get the file name from the path
//           contentType: MediaType.parse(mimeType!),
//         ),
//       });

//       Dio dio = Dio(); // Create a new Dio instance
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.post(apiUrl, data: formData);

//       if (response.statusCode == 200) {
//         // Handle successful response
//         print('File uploaded successfully');
//       } else {
//         print('Failed to upload file with status: ${response.statusCode}');
//       }
//     } catch (error) {
//       print('Error occurred during form submission: $error');
//     }
//   }

// // Modify the lookupMimeType function if needed
//   String logolookupMimeType(String filePath) {
//     final ext = filePath.split('.').last;
//     switch (ext) {
//       case 'jpg':
//       case 'jpeg':
//         return 'image/jpeg';
//       case 'png':
//         return 'image/png';
//       case 'pdf':
//         return 'application/pdf';
//       // Add more cases for other file types as needed
//       default:
//         return 'application/octet-stream'; // Default MIME type
//     }
//   }

//   Future<void> updateEntity(
//       String token, int entityId, Map<String, dynamic> entity) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.put('$baseUrl/Teams/Teams/$entityId', data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.delete('$baseUrl/Teams/Teams/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }

// // my team creted by self
//   Future<List<Map<String, dynamic>>> getMyTeam() async {
//     try {
//       final token = await TokenManager.getToken();
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get('$baseUrl/Teams/Teams/myTeam');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all Team: $e');
//     }
//   }

//   // my team enrolled in which team
//   Future<List<Map<String, dynamic>>> getenrolledTeam() async {
//     try {
//       final token = await TokenManager.getToken();
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response =
//           await dio.get('$baseUrl/team/Register_team/enrolled/getAll');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get enrolled Team: $e');
//     }
//   }

// // get all team by tournament id
//   Future<List<Map<String, dynamic>>> getMyTeamBytourId(int tourId) async {
//     try {
//       final token = await TokenManager.getToken();
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio
//           .get('$baseUrl/tournament/Register_tournament/teams/$tourId');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all Teams: $e');
//     }
//   }

// // get all member by team id
//   Future<List<Map<String, dynamic>>> getallmember(int teamId) async {
//     try {
//       final token = await TokenManager.getToken();
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response =
//           await dio.get('$baseUrl/team/Register_team/member/$teamId');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all Member: $e');
//     }
//   }

// // enroll in team
//   Future<Map<String, dynamic>> enrollInTeam(Map<String, dynamic> entity) async {
//     final token = await TokenManager.getToken();
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response =
//           await dio.post('$baseUrl/team/Register_team', data: entity);

//       print(entity);

//       // Assuming the response is a Map<String, dynamic>
//       Map<String, dynamic> responseData = response.data;

//       return responseData;
//     } catch (e) {
//       throw Exception('Failed to Enroll Team: $e');
//     }
//   }

// // send invitation to player
//   // Future<dynamic> invitePlayer(String mobNo, int teamId) async {
//   //   final token = await TokenManager.getToken();

//   //   Map<String, dynamic> entity = {};
//   //   try {
//   //     print("in post api$entity");
//   //     dio.options.headers['Authorization'] = 'Bearer $token';
//   //     final response = await dio.post(
//   //         '$baseUrl/Teams/Teams/invite?Mob_number=$mobNo&TeamId=$teamId',
//   //         data: entity);

//   //     print(entity);

//   //     // Assuming the response is a Map<String, dynamic>
//   //     // Map<String, dynamic> responseData = response.data;

//   //     return Future.delayed(Duration(seconds: 2), () => true);
//   //   } catch (e) {
//   //     throw Exception('Failed to Invite Player : $e');
//   //   }
//   // }

// // send invitation to player
//   Future<dynamic> invitePlayer(String mobNo, int teamId) async {
//     final token = await TokenManager.getToken();

//     Map<String, dynamic> entity = {};
//     try {
//       print("in post api$entity");
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.post(
//           '$baseUrl/Teams/Teams/invite?Mob_number=$mobNo&TeamId=$teamId',
//           data: entity);

//       print(entity);

//       print('Response status: ${response.statusCode}');
//       print('Response data: ${response.data}');

//       // Assuming the response data is a string indicating the invitation status
//       if (response.statusCode == 200) {
//         return response.data; // Return the actual response data
//       } else {
//         throw Exception('Failed to invite team: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Exception: $e');
//       return 'An error occurred'; // Return an error message or handle as needed
//     }
//   }

// // send invitation to team
//   // Future<dynamic> inviteteam(int tournamentId, int teamId) async {
//   //   print("invite service method is calling");
//   //   final token = await TokenManager.getToken();

//   //   Map<String, dynamic> entity = {};
//   //   try {
//   //     print("in post API $entity");
//   //     dio.options.headers['Authorization'] = 'Bearer $token';
//   //     final response = await dio.post(
//   //       '$baseUrl/My_Tournament/My_Tournament/invite?tournamentId=$tournamentId&TeamId=$teamId',
//   //       data: entity,
//   //     );

//   //     print('Response status: ${response.statusCode}');
//   //     print('Response data: ${response.data}');

//   //     // Assuming the response data is a string indicating the invitation status
//   //     if (response.statusCode == 200) {
//   //       return response.data; // Return the actual response data
//   //     } else {
//   //       throw Exception('Failed to invite team: ${response.statusCode}');
//   //     }
//   //   } catch (e) {
//   //     print('Exception: $e');
//   //     return 'An error occurred'; // Return an error message or handle as needed
//   //   }
//   // }

//   // update player tag (C,VC,Wk)
//   Future<void> updateTag({required String playerTag, required int id}) async {
//     final token = await TokenManager.getToken();

//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.put(
//         '$baseUrl/team/Register_team/updatetag?data=$playerTag&id=$id',
//       );

//       if (response.statusCode == 200) {
//         print("Player tag updated successfully");
//       } else {
//         print(
//             "Failed to update player tag: ${response.statusCode} - ${response.data}");
//       }
//     } catch (e) {
//       print("Error updating player tag: $e");
//     }
//   }

//   Future<List<Map<String, dynamic>>?> getAllInvitedPlayers(
//       {required String teamId}) async {
//     final token = await TokenManager.getToken();
//     dio.options.headers['Authorization'] = 'Bearer $token';
//     try {
//       final res = await dio
//           .get('$baseUrl/Invitation_member/Invitation_member/myplayer/$teamId');
//       if (res.statusCode == 200) {
//         print("TeamId-$teamId");
//         List<dynamic> data =
//             res.data; // Access the 'data' property of the response
//         print("DATA-$data");
//         List<Map<String, dynamic>> mappedData =
//             List<Map<String, dynamic>>.from(data);
//         return mappedData;
//       }
//     } catch (e) {
//       print("Error fetching invited user list");
//     }
//     return null;
//   }
// // send invitation to team
//   Future<dynamic> inviteteam(String tournamentId, int teamId) async {
//     final token = await TokenManager.getToken();

//     Map<String, dynamic> entity = {};
//     try {
//       print("in post api$entity");
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.post(
//           '$baseUrl/My_Tournament/My_Tournament/invite?tournamentId=$tournamentId&TeamId=$teamId',
//           data: entity);

//       // print(entity);

//       // // Assuming the response is a Map<String, dynamic>
//       // Map<String, dynamic> responseData = response.data;

//       return Future.delayed(Duration(seconds: 2), () => true);
//     } catch (e) {
//       throw Exception('Failed to Invite Team : $e');
//     }
//   }
// }
import 'package:cricyard/Entity/team/Teams/model/Teams_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_parser/http_parser.dart'; // For MediaType
// import 'package:cricyard/providers/token_manager.dart';
import 'dart:typed_data';
import '/resources/api_constants.dart';
import 'package:cricyard/data/network/network_api_service.dart';


class teamsApiService {
  final String baseUrl = ApiConstants.baseUrl;
  final NetworkApiService networkApiService = NetworkApiService();

  Future<List<TeamsModel>> getEntities() async {
    try {
      final response = await networkApiService.getGetApiResponse(
        ApiConstants.getEntitiesTeams,
      );
      print("Raw API Response: $response");
      // return (response as List).cast<TeamsModel>();
      return (response as List).map((json) {
      return TeamsModel.fromJson(json as Map<String, dynamic>);
    }).toList();
    } catch (e) {
      throw Exception('Failed to get all Teams: $e');
    }
  }
  Future<List<Map<String, dynamic>>> getEntitiess() async {
    try {
      final response = await networkApiService.getGetApiResponse(
        ApiConstants.getEntitiesTeams,
      );
      // Ensure the response is a list of maps
      // print("Raw API Response: $response");
      // print("API Response Type===>> ${response.runtimeType}");

    if (response is List) {
      return response.cast<Map<String, dynamic>>();
    } else {
      throw Exception("Invalid API Response: Expected List, got ${response.runtimeType}");
    }
      // return TeamsModel.fromJson(json as Map<String, dynamic>);
    }
     catch (e) {
      throw Exception('Failed to get all Teams: $e');
    }
  }

  Future<List<TeamsModel>> getAllWithPagination(int page, int size) async {
    try {
      final response = await networkApiService.getGetApiResponse(
        '${ApiConstants.getAllWithPaginationTeams}?page=$page&size=$size',
        // token: token,
      );
      return (response['content'] as List).cast<TeamsModel>();
    } catch (e) {
      throw Exception('Failed to get Teams with pagination: $e');
    }
  }

  Future<TeamsModel> createEntity(Map<String, dynamic> entity) async {
    try {
      final response = await networkApiService.getPostApiResponse(
        ApiConstants.createEntityTeams,
        entity,
      );
      debugPrint("API Response---->: ${response}");

      return TeamsModel.fromJson(response);
    } catch (e) {
      throw Exception('Failed to create Team: $e');
    }
  }

  Future<void> uploadLogoImage(String ref, String refTableName,
      String selectedFilePath, Uint8List imageBytes) async {
    try {
      String apiUrl = ApiConstants.uploadLogoImage.replaceFirst('{ref}', ref).replaceFirst('{refTableName}', refTableName);

      final mimeType = lookupMimeType(selectedFilePath);
      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          imageBytes,
          filename: selectedFilePath.split('/').last,
          contentType: MediaType.parse(mimeType),
        ),
      });

      await networkApiService.getPostApiResponse(apiUrl, formData, 
      // token: token
      );
    } catch (error) {
      throw Exception('Error occurred during file upload: $error');
    }
  }

  String lookupMimeType(String filePath) {
    final ext = filePath.split('.').last;
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'pdf':
        return 'application/pdf';
      default:
        return 'application/octet-stream';
    }
  }

  Future<void> updateEntity(int entityId, TeamsModel entity) async {
    // try {
    //   await networkApiService.getPutApiResponse(
    //     '$baseUrl/Teams/Teams/$entityId',
    //     entity,
    //   );
    // } 
    try {
      final url = ApiConstants.updateEntityTeams.replaceFirst('{entityId}', entityId.toString());
      await networkApiService.getPutApiResponse(url, entity);
    }
    catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  Future<void> deleteEntity(int entityId) async {
    try {
      // await networkApiService.getDeleteApiResponse(
      //   '$baseUrl/Teams/Teams/$entityId'
      // );
      final url = ApiConstants.deleteEntityTeams.replaceFirst('{entityId}', entityId.toString());
      await networkApiService.getDeleteApiResponse(url);
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getMyTeam() async {
    try {
      final response = await networkApiService.getGetApiResponse(
        ApiConstants.getMyTeam,
      );
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to get My Team: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getEnrolledTeam() async {
    try {
      final response = await networkApiService.getGetApiResponse(
        ApiConstants.getEnrolledTeam,
      );
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to get enrolled Teams: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getMyTeamByTourId(int tourId) async {
    try {
      // final response = await networkApiService.getGetApiResponse(
      //   '$baseUrl/tournament/Register_tournament/teams/$tourId',
      // );
       final url = ApiConstants.getMyTeamByTourId.replaceFirst('{tourId}', tourId.toString());
      final response = await networkApiService.getGetApiResponse(url);
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to get Teams by tournament ID: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllMembers(int teamId) async {
    try {
      // final response = await networkApiService.getGetApiResponse(
      //   '$baseUrl/team/Register_team/member/$teamId',
      // );
      final url = ApiConstants.getAllMembers.replaceFirst('{teamId}', teamId.toString());
      final response = await networkApiService.getGetApiResponse(url);
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to get all Members: $e');
    }
  }

  Future<Map<String, dynamic>> enrollInTeam(Map<String, dynamic> entity) async {
    try {
      final response = await networkApiService.getPostApiResponse(
        ApiConstants.enrollInTeam,
        entity,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to enroll in Team: $e');
    }
  }

  Future<dynamic> invitePlayer(String mobNo, int teamId) async {
    try {
      // final response = await networkApiService.getPostApiResponse(
      //   '$baseUrl/Teams/Teams/invite?Mob_number=$mobNo&TeamId=$teamId',
      //   {},
      // );
      final url = ApiConstants.invitePlayer.replaceFirst('{mobNo}', mobNo).replaceFirst('{teamId}', teamId.toString());
      final response = await networkApiService.getPostApiResponse(url, {});
      return response;
    } catch (e) {
      throw Exception('Failed to invite Player: $e');
    }
  }

  Future<dynamic> inviteTeam(int tournamentId, int teamId) async {
    try {
      // final response = await networkApiService.getPostApiResponse(
      //   '$baseUrl/My_Tournament/My_Tournament/invite?tournamentId=$tournamentId&TeamId=$teamId',
      //   {},
      // );
      final url = ApiConstants.inviteTeam.replaceFirst('{tournamentId}', tournamentId.toString()).replaceFirst('{teamId}', teamId.toString());
      final response = await networkApiService.getPostApiResponse(url, {});
      return response;
    } catch (e) {
      throw Exception('Failed to invite Team: $e');
    }
  }

  Future<void> updateTag({required String playerTag, required int id}) async {
    try {
      // await networkApiService.getPutApiResponse(
      //   '$baseUrl/team/Register_team/updatetag?data=$playerTag&id=$id',
      //   {},
      // );
      final url = ApiConstants.updateTag.replaceFirst('{playerTag}', playerTag).replaceFirst('{id}', id.toString());
      await networkApiService.getPutApiResponse(url, {});
    } catch (e) {
      throw Exception('Failed to update player tag: $e');
    }
  }

  Future<List<Map<String, dynamic>>?> getAllInvitedPlayers(
      {required String teamId}) async {
    try {
      // final response = await networkApiService.getGetApiResponse(
      //   '$baseUrl/Invitation_member/Invitation_member/myplayer/$teamId',
      // );
       final url = ApiConstants.getAllInvitedPlayers.replaceFirst('{teamId}', teamId);
      final response = await networkApiService.getGetApiResponse(url);
      return (response as List).cast<Map<String, dynamic>>();
    } catch (e) {
      throw Exception('Failed to fetch invited players: $e');
    }
  }
}
