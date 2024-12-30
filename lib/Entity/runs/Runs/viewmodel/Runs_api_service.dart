// import 'package:dio/dio.dart';
// import '/resources/api_constants.dart';

// class runsApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();

//   Future<List<Map<String, dynamic>>> getEntities(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get('$baseUrl/Runs/Runs');
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
//       final response =
//           await dio.get('$baseUrl/Runs/Runs/getall/page?page=$page&size=$Size');
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
//       final response = await dio.post('$baseUrl/Runs/Runs', data: entity);

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
//       await dio.put('$baseUrl/Runs/Runs/$entityId', data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.delete('$baseUrl/Runs/Runs/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }

//   Future<List<Map<String, dynamic>>> getselect_field(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio
//           .get('$baseUrl/PlayerList_ListFilter1/PlayerList_ListFilter1');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all entities: $e');
//     }
//   }
// }

import '/resources/api_constants.dart';
import 'package:cricyard/data/network/network_api_service.dart'; // Import NetworkApiService

class runsApiService {
  final String baseUrl = ApiConstants.baseUrl;
  final NetworkApiService networkApiService = NetworkApiService();

  // Fetch all entities
  Future<List<Map<String, dynamic>>> getEntities(String token) async {
    try {
      final response = await networkApiService.getGetApiResponse('$baseUrl/Runs/Runs');
      // Assuming the response is a List of entities
      final entities = (response as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  // Fetch all entities with pagination
  Future<List<Map<String, dynamic>>> getAllWithPagination(
      String token, int page, int size) async {
    try {
      final response = await networkApiService.getGetApiResponse(
          '$baseUrl/Runs/Runs/getall/page?page=$page&size=$size');
      final entities = (response['content'] as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all with pagination: $e');
    }
  }

  // Create a new entity
  Future<Map<String, dynamic>> createEntity(
      String token, Map<String, dynamic> entity) async {
    try {
      final response = await networkApiService.getPostApiResponse(
          '$baseUrl/Runs/Runs', entity);
      // Assuming the response is a Map<String, dynamic>
      return response;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  // Update an existing entity
  Future<void> updateEntity(
      String token, int entityId, Map<String, dynamic> entity) async {
    try {
      await networkApiService.getPutApiResponse(
          '$baseUrl/Runs/Runs/$entityId', entity);
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  // Delete an entity
  Future<void> deleteEntity(String token, int entityId) async {
    try {
      await networkApiService.getDeleteApiResponse(
          '$baseUrl/Runs/Runs/$entityId');
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  // Fetch select fields (e.g., player list)
  Future<List<Map<String, dynamic>>> getselectField(String token) async {
    try {
      final response = await networkApiService.getGetApiResponse(
          '$baseUrl/PlayerList_ListFilter1/PlayerList_ListFilter1');
      final entities = (response as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get select fields: $e');
    }
  }
}
