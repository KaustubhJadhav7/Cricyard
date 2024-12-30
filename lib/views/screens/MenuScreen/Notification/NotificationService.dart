import 'package:cricyard/providers/token_manager.dart';
import 'package:dio/dio.dart';
import '/resources/api_constants.dart';

class NotificationService {
  final String baseUrl = ApiConstants.baseUrl;
  final Dio dio = Dio();

// /get by userid
  Future<List<Map<String, dynamic>>> getByUserId() async {
    try {
      final token = await TokenManager.getToken();

      dio.options.headers['Authorization'] = 'Bearer $token';
      final response =
          await dio.get('$baseUrl/notification/get_notification/userId');
      final entities = (response.data as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all Notification: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllWithPagination(
      String token, int page, int Size) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get(
          '$baseUrl/notification/get_notification/getall/page?page=$page&size=$Size');
      final entities =
          (response.data['content'] as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all without pagination: $e');
    }
  }

  Future<void> Accept(int entityId) async {
    try {
      final token = await TokenManager.getToken();

      Map<String, dynamic> entity = {};
      dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.put('$baseUrl/notification/get_notification/accept/$entityId',
          data: entity);
      print(entity);
    } catch (e) {
      throw Exception('Failed to Accept: $e');
    }
  }

  Future<void> ignored(int entityId) async {
    try {
      final token = await TokenManager.getToken();

      Map<String, dynamic> entity = {};
      dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.put('$baseUrl/notification/get_notification/ignored/$entityId',
          data: entity);
      print(entity);
    } catch (e) {
      throw Exception('Failed to ignored: $e');
    }
  }

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

// // my team
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

//       // Assuming the response is a Map<String, dynamic>
//       // Map<String, dynamic> responseData = response.data;

//       return Future.delayed(Duration(seconds: 2), () => true);
//     } catch (e) {
//       throw Exception('Failed to Invite Player : $e');
//     }
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
}
