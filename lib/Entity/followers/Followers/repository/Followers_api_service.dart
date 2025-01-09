// import 'package:dio/dio.dart';
// import '/resources/api_constants.dart';

// class followersApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();

//   Future<List<Map<String, dynamic>>> getEntities(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get('$baseUrl/Followers/Followers');
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
//           '$baseUrl/Followers/Followers/getall/page?page=$page&size=$Size');
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
//           await dio.post('$baseUrl/Followers/Followers', data: entity);

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
//       await dio.put('$baseUrl/Followers/Followers/$entityId', data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.delete('$baseUrl/Followers/Followers/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }
// }
import 'package:cricyard/providers/token_manager.dart';
import '/resources/api_constants.dart';
import 'package:cricyard/data/network/network_api_service.dart';

class FollowersApiService {
  final String baseUrl = ApiConstants.baseUrl;
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<List<Map<String, dynamic>>> getEntities() async {
    try {
      final response = await _networkApiService
          .getGetApiResponse(ApiConstants.getEntitiesFollowers);
      final entities = (response as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllWithPagination(
      int page, int size) async {
    try {
      final response = await _networkApiService.getGetApiResponse(
          '${ApiConstants.getAllWithPaginationFollowers}?page=$page&size=$size');
      final entities =
          (response['content'] as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all with pagination: $e');
    }
  }

  Future<Map<String, dynamic>> createEntity(Map<String, dynamic> entity) async {
    try {
      print("in post api $entity");
      final response = await _networkApiService.getPostApiResponse(
          ApiConstants.createEntityFollowers, entity);
      print(entity);

      Map<String, dynamic> responseData = response;
      return responseData;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  Future<void> updateEntity(int entityId, Map<String, dynamic> entity) async {
    try {
      await _networkApiService.getPutApiResponse(
          '${ApiConstants.updateEntityFollowers}/$entityId', entity);
      print(entity);
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  Future<void> deleteEntity(int entityId) async {
    try {
      await _networkApiService.getDeleteApiResponse(
          '${ApiConstants.deleteEntityFollowers}/$entityId');
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }
}
