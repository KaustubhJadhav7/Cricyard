// import 'package:dio/dio.dart';
// import 'package:http_parser/http_parser.dart';
// import 'dart:typed_data';
// import '/resources/api_constants.dart';
// import 'dart:convert';

// import '../LogoutService/Logoutservice.dart';

// class ApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();

//   Future<List<Map<String, dynamic>>> getEntities(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get('$baseUrl/Bookmarks/Bookmarks');

//       if (response.statusCode == 401) {
//         LogoutService.logout();
//       }
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all entities: $e');
//     }
//   }

//   Future<void> createEntity(
//       String token, Map<String, dynamic> fData, dynamic selectedFile) async {
//     try {
//       String apiUrl = "$baseUrl/Bookmarks/Bookmarks";

//       final Uint8List fileBytes = selectedFile.bytes!;
//       final mimeType = lookupMimeType(selectedFile.name!);

//       FormData formData = FormData.fromMap({
//         'file': MultipartFile.fromBytes(
//           fileBytes,
//           filename: selectedFile.name!,
//           contentType: MediaType.parse(mimeType!),
//         ),
//         'data': jsonEncode(
//             fData), // Convert the map to JSON and include it as a parameter
//       });

//       Dio dio = Dio(); // Create a new Dio instance
//       dio.options.headers['Authorization'] = 'Bearer $token';

//       final response = await dio.post(apiUrl, data: formData);
//       if (response.statusCode == 401) {
//         LogoutService.logout();
//       }
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

//   String lookupMimeType(String filePath) {
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
//       var response =
//           await dio.put('$baseUrl/Bookmarks/Bookmarks/$entityId', data: entity);
//       if (response.statusCode == 401) {
//         LogoutService.logout();
//       }
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       var response = await dio.delete('$baseUrl/Bookmarks/Bookmarks/$entityId');
//       if (response.statusCode == 401) {
//         LogoutService.logout();
//       }
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }
// }
import 'dart:convert';
import 'dart:typed_data';
import 'package:cricyard/views/screens/Bookmarks/model/Bookmarks_model.dart';
import 'package:dio/dio.dart';
import 'package:cricyard/providers/token_manager.dart'; // Assuming TokenManager is used for token
import 'package:http_parser/http_parser.dart'; // For mime type lookup
import 'package:cricyard/data/network/network_api_service.dart'; // Importing NetworkApiService

import '../../LogoutService/Logoutservice.dart';

class ApiService {
  final NetworkApiService _networkService = NetworkApiService();


  // Fetch all entities
  Future<List<BookmarkEntity>> getEntities() async {
    try {
      final response = await _networkService.getGetApiResponse('/Bookmarks/Bookmarks');
      return List<BookmarkEntity>.from(response);
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  // Create a new entity with file upload
  Future<void> createEntity(BookmarkEntity fData, dynamic selectedFile) async {
    try {
      String apiUrl = '/Bookmarks/Bookmarks'; // Assuming the path

      // Prepare file data
      final Uint8List fileBytes = selectedFile.bytes!;
      final mimeType = lookupMimeType(selectedFile.name!);

      final formData = {
        'file': MultipartFile.fromBytes(
          fileBytes,
          filename: selectedFile.name!,
          contentType: MediaType.parse(mimeType!),
        ),
        'data': jsonEncode(fData), // Convert the map to JSON
      };

      // final token = await TokenManager.getToken();

      // Using the NetworkApiService for POST request
      await _networkService.getPostApiResponse(apiUrl, formData);
    } catch (e) {
      print('Error occurred during form submission: $e');
      throw Exception('Failed to create entity: $e');
    }
  }

  // Update an existing entity
  Future<void> updateEntity(int entityId, BookmarkEntity entity) async {
    try {
      String apiUrl = '/Bookmarks/Bookmarks/$entityId';

      // final token = await TokenManager.getToken();

      // Using the NetworkApiService for PUT request
      await _networkService.getPutApiResponse(apiUrl, entity);
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  // Delete an entity
  Future<void> deleteEntity(int entityId) async {
    try {
      String apiUrl = '/Bookmarks/Bookmarks/$entityId';

      // final token = await TokenManager.getToken();

      // Using the NetworkApiService for DELETE request
      await _networkService.getDeleteApiResponse(apiUrl);
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  // Function to determine mime type from file extension
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
      // Add more cases for other file types as needed
      default:
        return 'application/octet-stream'; // Default MIME type
    }
  }
}
