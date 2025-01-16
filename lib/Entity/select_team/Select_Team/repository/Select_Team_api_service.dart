// import 'package:dio/dio.dart';
// import '/resources/api_constants.dart';

// class select_teamApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();

//   Future<List<Map<String, dynamic>>> getEntities(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get('$baseUrl/Select_Team/Select_Team');
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
//           '$baseUrl/Select_Team/Select_Team/getall/page?page=$page&size=$Size');
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
//           await dio.post('$baseUrl/Select_Team/Select_Team', data: entity);

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
//       await dio.put('$baseUrl/Select_Team/Select_Team/$entityId', data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.delete('$baseUrl/Select_Team/Select_Team/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }

//   Future<List<Map<String, dynamic>>> getteam_name(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response =
//           await dio.get('$baseUrl/TeamList_ListFilter1/TeamList_ListFilter1');
//       final entities = (response.data as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all entities: $e');
//     }
//   }
// }

import 'package:cricyard/Entity/select_team/Select_Team/model/Select_Team_model.dart';

import '/resources/api_constants.dart';
import 'package:cricyard/data/network/network_api_service.dart'; // Import NetworkApiService

class SelectTeamApiService {
  final String baseUrl = ApiConstants.baseUrl;
  final NetworkApiService networkApiService = NetworkApiService();

  // Fetch all entities
  Future<List<SelectTeamEntity>> getEntities() async {
    try {
      final response = await networkApiService.getGetApiResponse(ApiConstants.getEntitiesSelectTeam);
      // Assuming the response is a List of entities
      final entities = (response as List).cast<SelectTeamEntity>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  // Fetch all entities with pagination
  Future<List<SelectTeamEntity>> getAllWithPagination(int page, int size) async {
    try {
      final response = await networkApiService.getGetApiResponse(
          '${ApiConstants.getAllWithPaginationSelectTeam}?page=$page&size=$size');
      final entities = (response['content'] as List).cast<SelectTeamEntity>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all with pagination: $e');
    }
  }

  // Create a new entity
  Future<SelectTeamEntity> createEntity(SelectTeamEntity entity) async {
    try {
      final response = await networkApiService.getPostApiResponse(
          ApiConstants.createEntitySelectTeam, entity);
      // Assuming the response is a Map<String, dynamic>
      return response;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  // Update an existing entity
  Future<void> updateEntity(int entityId, Map<String, dynamic> entity) async {
    try {
      await networkApiService.getPutApiResponse(
          '${ApiConstants.updateEntitySelectTeam}/$entityId', entity);
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  // Delete an entity
  Future<void> deleteEntity(int entityId) async {
    try {
      await networkApiService.getDeleteApiResponse(
          '${ApiConstants.deleteEntitySelectTeam}/$entityId');
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  // Fetch team names
  Future<List<Map<String, dynamic>>> getTeamName() async {
    try {
      final response = await networkApiService.getGetApiResponse(
          ApiConstants.getTeamNameSelectTeam);
      final entities = (response as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get team names: $e');
    }
  }
}
