// import 'package:dio/dio.dart';
// import '/resources/api_constants.dart';

// class start_inningApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();

//   Future<List<Map<String, dynamic>>> getEntities(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get('$baseUrl/Start_inning/Start_inning');
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
//           '$baseUrl/Start_inning/Start_inning/getall/page?page=$page&size=$Size');
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
//           await dio.post('$baseUrl/Start_inning/Start_inning', data: entity);

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
//       await dio.put('$baseUrl/Start_inning/Start_inning/$entityId',
//           data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.delete('$baseUrl/Start_inning/Start_inning/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }
// }
import 'package:cricyard/Entity/start_inning/Start_inning/model/Start_inning_model.dart';

import '/resources/api_constants.dart';
import 'package:cricyard/data/network/network_api_service.dart'; // Import NetworkApiService

class start_inningApiService {
  final String baseUrl = ApiConstants.baseUrl;
  final NetworkApiService networkApiService = NetworkApiService();

  Future<List<StartInningModel>> getEntities() async {
    try {
      final response = await networkApiService.getGetApiResponse(ApiConstants.getEntitiesStartInning);
      // Assuming the response is a List of entities
      final entities = (response as List).cast<StartInningModel>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all entities: $e');
    }
  }

  Future<List<StartInningModel>> getAllWithPagination(int page, int size) async {
    try {
      final response = await networkApiService.getGetApiResponse(
          '${ApiConstants.getAllWithPaginationStartInning}?page=$page&size=$size');
      final entities = (response['content'] as List).cast<StartInningModel>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all with pagination: $e');
    }
  }

  Future<StartInningModel> createEntity(StartInningModel entity) async {
    try {
      final response = await networkApiService.getPostApiResponse(
          ApiConstants.createEntityStartInning, entity);
      // Assuming the response is a Map<String, dynamic>
      return response;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  Future<void> updateEntity(int entityId, StartInningModel entity) async {
    try {
      // await networkApiService.getPutApiResponse(
      //     '$baseUrl/Start_inning/Start_inning/$entityId', entity);
      final url = ApiConstants.updateEntityStartInning.replaceFirst(
        '{entityId}',
        entityId.toString(),
      );
      await networkApiService.getPutApiResponse(url, entity);
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  Future<void> deleteEntity(int entityId) async {
    try {
      // await networkApiService.getDeleteApiResponse(
      //     '$baseUrl/Start_inning/Start_inning/$entityId');
      final url = ApiConstants.deleteEntityStartInning.replaceFirst(
        '{entityId}',
        entityId.toString(),
      );
      await networkApiService.getDeleteApiResponse(url);
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }
}
