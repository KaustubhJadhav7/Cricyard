// import 'package:dio/dio.dart';
// import '/resources/api_constants.dart';

// class live_score_updateApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();

//   Future<List<Map<String, dynamic>>> getEntities(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response =
//           await dio.get('$baseUrl/Live_Score_Update/Live_Score_Update');
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
//           '$baseUrl/Live_Score_Update/Live_Score_Update/getall/page?page=$page&size=$Size');
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
//       final response = await dio
//           .post('$baseUrl/Live_Score_Update/Live_Score_Update', data: entity);

//       print(entity);

//       // Assuming the response is a Map<String, dynamic>
//       Map<String, dynamic> responseData = response.data;

//       return responseData;
//     } catch (e) {
//       throw Exception('Failed to create entity: $e');
//     }
//   }

//   Future<void> updateEntity(
//       String token, int entityId, Map<String, dynamic> entity) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.put('$baseUrl/Live_Score_Update/Live_Score_Update/$entityId',
//           data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio
//           .delete('$baseUrl/Live_Score_Update/Live_Score_Update/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }
// }

import 'package:cricyard/providers/token_manager.dart';
import 'package:cricyard/data/network/network_api_service.dart';
import '/resources/api_constants.dart';

class LiveScoreUpdateApiService {
  final String baseUrl = ApiConstants.baseUrl;
  final NetworkApiService networkApiService = NetworkApiService();

  // Fetch all entities
  Future<List<Map<String, dynamic>>> getEntities() async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        final response = await networkApiService.getGetApiResponse(
            '$baseUrl/Live_Score_Update/Live_Score_Update', 
            // token
            );
        final entities = (response as List).cast<Map<String, dynamic>>();
        return entities;
      } else {
        throw Exception('Token is null');
      }
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  // Fetch all entities with pagination
  Future<List<Map<String, dynamic>>> getAllWithPagination(
      String token, int page, int size) async {
    try {
      final response = await networkApiService.getGetApiResponse(
          '$baseUrl/Live_Score_Update/Live_Score_Update/getall/page?page=$page&size=$size', 
          // token
          );
      final entities = (response['content'] as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all without pagination: $e');
    }
  }

  // Create a new live score update entity
  Future<Map<String, dynamic>> createEntity(
      String token, Map<String, dynamic> entity) async {
    try {
      final response = await networkApiService.getPostApiResponse(
          '$baseUrl/Live_Score_Update/Live_Score_Update', entity, 
          // token
          );
      return response;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  // Update a live score update entity
  Future<void> updateEntity(
      String token, int entityId, Map<String, dynamic> entity) async {
    try {
      await networkApiService.getPutApiResponse(
          '$baseUrl/Live_Score_Update/Live_Score_Update/$entityId', entity,
          //  token
           );
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  // Delete a live score update entity
  Future<void> deleteEntity(String token, int entityId) async {
    try {
      await networkApiService.getDeleteApiResponse(
          '$baseUrl/Live_Score_Update/Live_Score_Update/$entityId', 
          // token
          );
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }
}
