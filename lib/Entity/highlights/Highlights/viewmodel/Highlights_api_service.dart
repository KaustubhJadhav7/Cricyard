// import 'package:dio/dio.dart';
// import '/resources/api_constants.dart';

// class highlightsApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();

//   Future<List<Map<String, dynamic>>> getEntities(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get('$baseUrl/Highlights/Highlights');
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
//           '$baseUrl/Highlights/Highlights/getall/page?page=$page&size=$Size');
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
//           await dio.post('$baseUrl/Highlights/Highlights', data: entity);

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
//       await dio.put('$baseUrl/Highlights/Highlights/$entityId', data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.delete('$baseUrl/Highlights/Highlights/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }
// }

import '/resources/api_constants.dart';
import 'package:cricyard/data/network/network_api_service.dart';

class HighlightsApiService {
  final String baseUrl = ApiConstants.baseUrl;
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<List<Map<String, dynamic>>> getEntities(String token) async {
    try {
      final response = await _networkApiService.getGetApiResponse(
          '$baseUrl/Highlights/Highlights');
      final entities = (response as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllWithPagination(
      String token, int page, int size) async {
    try {
      final response = await _networkApiService.getGetApiResponse(
          '$baseUrl/Highlights/Highlights/getall/page?page=$page&size=$size');
      final entities = (response['content'] as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all with pagination: $e');
    }
  }

  Future<Map<String, dynamic>> createEntity(
      String token, Map<String, dynamic> entity) async {
    try {
      final response = await _networkApiService.getPostApiResponse(
          '$baseUrl/Highlights/Highlights', entity);
      return response;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  Future<void> updateEntity(
      String token, int entityId, Map<String, dynamic> entity) async {
    try {
      await _networkApiService.getPutApiResponse(
          '$baseUrl/Highlights/Highlights/$entityId', entity);
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  Future<void> deleteEntity(String token, int entityId) async {
    try {
      await _networkApiService.getDeleteApiResponse(
          '$baseUrl/Highlights/Highlights/$entityId');
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }
}
