// import 'package:dio/dio.dart';

// import '../../../resources/api_constants.dart';

// class absent_hurtApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();

//   Future<List<Map<String, dynamic>>> getEntities(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get('$baseUrl/Absent_hurt/Absent_hurt');
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
//           '$baseUrl/Absent_hurt/Absent_hurt/getall/page?page=$page&size=$Size');
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
//           await dio.post('$baseUrl/Absent_hurt/Absent_hurt', data: entity);

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
//       await dio.put('$baseUrl/Absent_hurt/Absent_hurt/$entityId', data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.delete('$baseUrl/Absent_hurt/Absent_hurt/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }
// }
import 'package:cricyard/Entity/absent_hurt/Absent_hurt/model/Absent_hurt_model.dart';

import '../../../../resources/api_constants.dart';
import 'package:cricyard/data/network/network_api_service.dart';
import 'package:cricyard/data/network/base_network_service.dart';

class AbsentHurtApiService {
  // final String baseUrl = ApiConstants.baseUrl;
  // final NetworkApiService _networkApiService = NetworkApiService();
  BaseNetworkService _networkApiService = NetworkApiService();

  // Constructor to inject NetworkApiService
  // AbsentHurtApiService(this._networkApiService);

  Future<List<AbsentHurtEntity>> getEntities() async {
    try {
      // final response = await _networkApiService.getGetApiResponse(
      //     '$baseUrl/Absent_hurt/Absent_hurt');
      final response = await _networkApiService.getGetApiResponse(ApiConstants.getEntitiesAbsenthurt);

      // Assuming the response is a List of maps
      return (response as List).cast<AbsentHurtEntity>();
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<AbsentHurtEntity>> getAllWithPagination(int page, int size) async {
    try {
      // final response = await _networkApiService.getGetApiResponse(
      //     '$baseUrl/Absent_hurt/Absent_hurt/getall/page?page=$page&size=$size');
      final response = await _networkApiService.getGetApiResponse(
          '${ApiConstants.getAllWithPaginationAbsenthurt}?page=$page&size=$size');

      // Assuming the response has 'content' key with the data
      return (response['content'] as List).cast<AbsentHurtEntity>();
    } catch (e) {
      throw Exception('Failed to get all with pagination: $e');
    }
  }

  Future<Map<String, dynamic>> createEntity(Map<String, dynamic> entity) async {
    try {
      final response = await _networkApiService.getPostApiResponse(ApiConstants.createEntityAbsenthurt, entity);

      // Assuming the response is a Map<String, dynamic>
      return response as Map<String, dynamic>;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  Future<void> updateEntity(
      String token, int entityId, AbsentHurtEntity entity) async {
    try {
      await _networkApiService.getPutApiResponse(
  ApiConstants.updateEntityAbsenthurt.replaceFirst('{entityId}', entityId.toString()), entity);
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  Future<void> deleteEntity(int entityId) async {
    try {
      await _networkApiService.getDeleteApiResponse(
  ApiConstants.deleteEntityAbsenthurt.replaceFirst('{entityId}', entityId.toString()));

    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }
}
