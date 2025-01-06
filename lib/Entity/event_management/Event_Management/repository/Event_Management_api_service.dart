// import 'package:dio/dio.dart';
// import '/resources/api_constants.dart';

// class event_managementApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();

//   Future<List<Map<String, dynamic>>> getEntities(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response =
//           await dio.get('$baseUrl/Event_Management/Event_Management');
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
//           '$baseUrl/Event_Management/Event_Management/getall/page?page=$page&size=$Size');
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
//           .post('$baseUrl/Event_Management/Event_Management', data: entity);
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
//       await dio.put('$baseUrl/Event_Management/Event_Management/$entityId',
//           data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.delete('$baseUrl/Event_Management/Event_Management/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }
// }

import 'package:cricyard/data/network/network_api_service.dart';
import '/resources/api_constants.dart';
import 'package:cricyard/data/network/base_network_service.dart';


class EventManagementApiService {
  final String baseUrl = ApiConstants.baseUrl;
  BaseNetworkService networkService = NetworkApiService();

  Future<List<Map<String, dynamic>>> getEntities() async {
    try {
      final response = await networkService.getGetApiResponse(ApiConstants.getEntitiesEventManagement);
      final entities = (response as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllWithPagination(int page, int size) async {
    try {
      final response = await networkService.getGetApiResponse(
          ApiConstants.getAllWithPaginationEventManagement);
      final entities =
          (response['content'] as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all with pagination: $e');
    }
  }

  Future<Map<String, dynamic>> createEntity(Map<String, dynamic> entity) async {
    try {
      final response = await networkService.getPostApiResponse(ApiConstants.createEntityEventManagement,
        entity
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  Future<void> updateEntity(int entityId, Map<String, dynamic> entity) async {
    try {
      await networkService.getPutApiResponse(
        ApiConstants.updateEntityEventManagement.replaceFirst('{entityId}', entityId.toString()),
        entity,
      );
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  Future<void> deleteEntity(int entityId) async {
    try {
      await networkService.getDeleteApiResponse(
          ApiConstants.deleteEntityEventManagement.replaceFirst('{entityId}', entityId.toString()));
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }
}
