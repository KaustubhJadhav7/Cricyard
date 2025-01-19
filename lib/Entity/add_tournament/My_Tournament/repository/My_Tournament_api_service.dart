// import 'package:cricyard/providers/token_manager.dart';
// import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
// import 'dart:typed_data';
// import '/resources/api_constants.dart';
// import 'dart:typed_data';

// class my_tournamentApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();

//   Future<List<Map<String, dynamic>>> getEntities(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get('$baseUrl/My_Tournament/My_Tournament');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all entities: $e');
//     }
//   }

//   Future<List<Map<String, dynamic>>> getAllWithPagination(
//       String token, int page, int Size) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get(
//           '$baseUrl/My_Tournament/My_Tournament/getall/page?page=$page&size=$Size');
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
//       final response =
//           await dio.post('$baseUrl/My_Tournament/My_Tournament', data: entity);

//       print(entity);

//       // Assuming the response is a Map<String, dynamic>
//       Map<String, dynamic> responseData = response.data;

//       return responseData;
//     } catch (e) {
//       throw Exception('Failed to create entity: $e');
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
//       await dio.put('$baseUrl/My_Tournament/My_Tournament/$entityId',
//           data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.delete('$baseUrl/My_Tournament/My_Tournament/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }

//   Future<List<Map<String, dynamic>>> gettournament_name(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get(
//           '$baseUrl/Tournament_List_ListFilter1/Tournament_List_ListFilter1');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all entities: $e');
//     }
//   }

//   // register tournament apis

//   Future<Map<String, dynamic>> registerTournament(
//       Map<String, dynamic> entity) async {
//     try {
//       final token = await TokenManager.getToken();
//       print("in post api$entity");
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.post('$baseUrl/tournament/Register_tournament',
//           data: entity);

//       // Assuming the response is a Map<String, dynamic>
//       Map<String, dynamic> responseData = response.data;

//       print('after register tournament: $responseData');
//       return responseData;
//     } catch (e) {
//       throw Exception('Failed to Register Tournament: $e');
//     }
//   }

// // enrolled tournament
//   Future<List<Map<String, dynamic>>> getenrolledTournament(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response =
//           await dio.get('$baseUrl/My_Tournament/My_Tournament/myTour');

//       // Assuming the response is a List<Map<String, dynamic>>
//       List<Map<String, dynamic>> responseData =
//           List<Map<String, dynamic>>.from(response.data);

//       return responseData;
//     } catch (e) {
//       throw Exception('Failed to get enrolled tournament: $e');
//     }
//   }

// // created tournament
//   Future<List<Map<String, dynamic>>> getMyTournament(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response =
//           await dio.get('$baseUrl/My_Tournament/My_Tournament/creted/myTour');

//       // Assuming the response is a List<Map<String, dynamic>>
//       List<Map<String, dynamic>> responseData =
//           List<Map<String, dynamic>>.from(response.data);

//       return responseData;
//     } catch (e) {
//       throw Exception('Failed to get my tournament: $e');
//     }
//   }

//   Future<List<Map<String, dynamic>>> getAllByUserId(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response =
//           await dio.get('$baseUrl/tournament/Register_tournament/userid');
//       // Assuming the response is a List<Map<String, dynamic>>
//       List<Map<String, dynamic>> responseData =
//           List<Map<String, dynamic>>.from(response.data);
//       return responseData;
//     } catch (e) {
//       throw Exception('Failed to get all by user ID: $e');
//     }
//   }
// }

import 'package:cricyard/data/network/network_api_service.dart';
import 'package:cricyard/providers/token_manager.dart';
import 'package:cricyard/data/network/base_network_service.dart';

import '/resources/api_constants.dart';
import 'package:dio/dio.dart';
import 'dart:typed_data';

class MyTournamentApiService {
  final String baseUrl = ApiConstants.baseUrl;
  BaseNetworkService networkService = NetworkApiService();

  Future<List<Map<String, dynamic>>> getEntities(String token) async {
    try {
      // final response = await networkService.getGetApiResponse('$baseUrl/My_Tournament/My_Tournament');
      final response = await networkService
          .getGetApiResponse(ApiConstants.getEntitiesMyTournament);

      final entities = (response as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllWithPagination(
      String token, int page, int size) async {
    try {
      // final response = await networkService.getGetApiResponse(
      //     '$baseUrl/My_Tournament/My_Tournament/getall/page?page=$page&size=$size');
      final response = await networkService.getGetApiResponse(
          '${ApiConstants.getAllWithPaginationMyTournament}?page=$page&size=$size');

      final entities =
          (response['content'] as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all with pagination: $e');
    }
  }

  Future<Map<String, dynamic>> createEntity(
      String token, Map<String, dynamic> entity) async {
    try {
      // final response = await networkService.getPostApiResponse(
      //   '$baseUrl/My_Tournament/My_Tournament',
      //   entity,
      // );
      final response = await networkService.getPostApiResponse(
          ApiConstants.createEntityMyTournament, entity);

      return response;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  // Modify the uploadlogoimage function
  Future<void> uploadlogoimage(String token, String ref, String refTableNmae,
      String selectedFilePath, Uint8List image_timageBytes) async {
    try {
      // String apiUrl = "$baseUrl/FileUpload/Uploadeddocs/$ref/$refTableNmae";
      String apiUrl = '${ApiConstants.uploadLogoImage}/$ref/$refTableNmae';

      final Uint8List fileBytes = image_timageBytes!;
      final mimeType = logolookupMimeType(selectedFilePath);

      FormData formData = FormData.fromMap({
        'file': MultipartFile.fromBytes(
          fileBytes,
          filename: selectedFilePath
              .split('/')
              .last, // Get the file name from the path
          contentType: MediaType.parse(mimeType!),
        ),
      });

      Dio dio = Dio(); // Create a new Dio instance
      dio.options.headers['Authorization'] = 'Bearer $token';

      final response = await dio.post(apiUrl, data: formData);

      if (response.statusCode == 200) {
        // Handle successful response
        print('File uploaded successfully');
      } else {
        print('Failed to upload file with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error occurred during form submission: $error');
    }
  }

// Modify the lookupMimeType function if needed
  String logolookupMimeType(String filePath) {
    final ext = filePath.split('.').last;
    switch (ext) {
      case 'jpg':
      case 'jpeg':
        return 'image/jpeg';
      case 'png':
        return 'image/png';
      case 'pdf':
        return 'application/pdf';
      // Add more cases for other file types as needed
      default:
        return 'application/octet-stream'; // Default MIME type
    }
  }

  Future<void> updateEntity(int entityId, Map<String, dynamic> entity) async {
    try {
      // await networkService.getPutApiResponse(
      //   '$baseUrl/My_Tournament/My_Tournament/$entityId',
      //   entity,
      // );
      await networkService.getPutApiResponse(
          ApiConstants.updateEntityMyTournament
              .replaceFirst('{entityId}', entityId.toString()),
          entity);
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  Future<void> deleteEntity(String token, int entityId) async {
    try {
      // await networkService.getDeleteApiResponse('$baseUrl/My_Tournament/My_Tournament/$entityId');
      await networkService.getDeleteApiResponse(ApiConstants
          .deleteEntityMyTournament
          .replaceFirst('{entityId}', entityId.toString()));
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getTournamentName() async {
    try {
      // final response = await networkService.getGetApiResponse(
      //     '$baseUrl/Tournament_List_ListFilter1/Tournament_List_ListFilter1');
      final response = await networkService
          .getGetApiResponse(ApiConstants.getTournamentName);

      final entities = (response as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get tournament names: $e');
    }
  }

  Future<Map<String, dynamic>> registerTournament(
      Map<String, dynamic> entity) async {
    try {
      // final response = await networkService.getPostApiResponse(
      //   '$baseUrl/tournament/Register_tournament',
      //   entity,
      // token: token,
      // );
      final response = await networkService.getPostApiResponse(
          ApiConstants.registerTournament, entity);
      print("Registration Response: ====> $response");
      return response;
    } catch (e) {
      throw Exception('Failed to register tournament: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getEnrolledTournament(String token) async {
    try {
      // final response = await networkService.getGetApiResponse(
      //     '$baseUrl/My_Tournament/My_Tournament/myTour');
      final response = await networkService
          .getGetApiResponse(ApiConstants.getEnrolledTournament);

      final entities = (response as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get enrolled tournaments: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getMyTournament() async {
    try {
      // final response = await networkService.getGetApiResponse(
      //     '$baseUrl/My_Tournament/My_Tournament/creted/myTour');
      final response =
          await networkService.getGetApiResponse(ApiConstants.getMyTournament);

      final entities = (response as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get my tournaments: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllByUserId() async {
    try {
      // final response = await networkService.getGetApiResponse(
      //     '$baseUrl/tournament/Register_tournament/userid');
      final response =
          await networkService.getGetApiResponse(ApiConstants.getAllByUserId);

      final entities = (response as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all tournaments by user ID: $e');
    }
  }
}
