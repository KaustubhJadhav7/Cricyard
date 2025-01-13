// import 'package:dio/dio.dart';
// import '/resources/api_constants.dart';

// class obstructing_the_fieldApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();

//   Future<List<Map<String, dynamic>>> getEntities(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response =
//           await dio.get('$baseUrl/Obstructing_The_Field/Obstructing_The_Field');
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
//           '$baseUrl/Obstructing_The_Field/Obstructing_The_Field/getall/page?page=$page&size=$Size');
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
//       final response = await dio.post(
//           '$baseUrl/Obstructing_The_Field/Obstructing_The_Field',
//           data: entity);

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
//       await dio.put(
//           '$baseUrl/Obstructing_The_Field/Obstructing_The_Field/$entityId',
//           data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.delete(
//           '$baseUrl/Obstructing_The_Field/Obstructing_The_Field/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }
// }

import 'package:cricyard/Entity/obstructing_the_field/Obstructing_The_Field/model/Obstructing_The_Field_model.dart';

import '/resources/api_constants.dart';
import 'package:cricyard/data/network/network_api_service.dart'; // Import NetworkApiService

class ObstructingTheFieldApiService {
  final String baseUrl = ApiConstants.baseUrl;
  final NetworkApiService networkApiService = NetworkApiService();

  // Fetch all entities
  Future<List<ObstructingTheField>> getEntities() async {
    try {
      final response = await networkApiService
          .getGetApiResponse(ApiConstants.getEntitiesObstructingTheField);
      final entities = (response as List).cast<ObstructingTheField>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  // Fetch all entities with pagination
  Future<List<ObstructingTheField>> getAllWithPagination(int page, int size) async {
    try {
      final response = await networkApiService.getGetApiResponse(
          '${ApiConstants.getAllWithPaginationObstructingTheField}?page=$page&size=$size');
      final entities =
          (response['content'] as List).cast<ObstructingTheField>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all with pagination: $e');
    }
  }

  // Create a new entity
  Future<Map<String, dynamic>> createEntity(Map<String, dynamic> entity) async {
    try {
      final response = await networkApiService.getPostApiResponse(
          ApiConstants.createEntityObstructingTheField, entity);
      return response;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  // Update an existing entity
  Future<void> updateEntity(int entityId, Map<String, dynamic> entity) async {
    try {
      await networkApiService.getPutApiResponse(
          '${ApiConstants.updateEntityObstructingTheField}/$entityId', entity);
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  // Delete an entity
  Future<void> deleteEntity(int entityId) async {
    try {
      await networkApiService.getDeleteApiResponse(
          '${ApiConstants.deleteEntityObstructingTheField}/$entityId');
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }
}
