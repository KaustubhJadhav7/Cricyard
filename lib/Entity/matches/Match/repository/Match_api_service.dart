// import 'package:cricyard/providers/token_manager.dart';
// import 'package:dio/dio.dart';
// import '/resources/api_constants.dart';

// class matchApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();

//   final token = TokenManager.getToken();

//   Future<List<Map<String, dynamic>>> getEntities() async {
//     try {
//       final token = await TokenManager.getToken();
//       print('token is $token');
//       if (token != null) {
//         dio.options.headers['Authorization'] = 'Bearer $token';
//         final response = await dio.get('$baseUrl/Match/Match');
//         final entities = (response.data as List).cast<Map<String, dynamic>>();
//         return entities;
//       } else {
//         throw Exception('Token is null');
//       }
//     } catch (e) {
//       throw Exception('Failed to get all entities: $e');
//     }
//   }

//   Future<List<Map<String, dynamic>>> getAllWithPagination(
//       String token, int page, int Size) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio
//           .get('$baseUrl/Match/Match/getall/page?page=$page&size=$Size');
//       final entities =
//           (response.data['content'] as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all without pagination: $e');
//     }
//   }

//   Future<Map<String, dynamic>> createEntity(Map<String, dynamic> entity) async {
//     try {
//       final token = await TokenManager.getToken();

//       print("in post api$entity");
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.post('$baseUrl/Match/Match', data: entity);

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
//       await dio.put('$baseUrl/Match/Match/$entityId', data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> cancel(int entityId) async {
//     final token = await TokenManager.getToken();
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.put('$baseUrl/Match/Match/cancel/$entityId', data: {});
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.delete('$baseUrl/Match/Match/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }

// // my matches by tournment id
//   Future<List<Map<String, dynamic>>> mymatches(int tourId) async {
//     try {
//       final token = await TokenManager.getToken();
//       print('token is $token');
//       if (token != null) {
//         dio.options.headers['Authorization'] = 'Bearer $token';
//         final response =
//             await dio.get('$baseUrl/Match/Match/myMatches/$tourId');
//         final entities = (response.data as List).cast<Map<String, dynamic>>();
//         return entities;
//       } else {
//         throw Exception('Token is null');
//       }
//     } catch (e) {
//       throw Exception('Failed to get all Matches: $e');
//     }
//   }

// // all matches by tournament id
//   Future<List<Map<String, dynamic>>> allmatches(int tourId) async {
//     try {
//       final token = await TokenManager.getToken();
//       print('token is $token');
//       if (token != null) {
//         dio.options.headers['Authorization'] = 'Bearer $token';
//         final response =
//             await dio.get('$baseUrl/Match/Match/tournament/$tourId');
//         final entities = (response.data as List).cast<Map<String, dynamic>>();
//         return entities;
//       } else {
//         throw Exception('Token is null');
//       }
//     } catch (e) {
//       throw Exception('Failed to get all Matches: $e');
//     }
//   }

//   Future<List<Map<String, dynamic>>> liveMatches() async {
//     try {
//       final token = await TokenManager.getToken();
//       print('token is $token');
//       if (token != null) {
//         dio.options.headers['Authorization'] = 'Bearer $token';
//         final response =
//             await dio.get('$baseUrl/Match/Match/status?status=Started');
//         final entities = (response.data as List).cast<Map<String, dynamic>>();
//         return entities;
//       } else {
//         throw Exception('Token is null');
//       }
//     } catch (e) {
//       throw Exception('Failed to get all Matches: $e');
//     }
//   }

// // fetch live match By tourid
//   Future<List<Map<String, dynamic>>> liveMatchesBytourId(int tourId) async {
//     try {
//       final token = await TokenManager.getToken();
//       print('token is $token');
//       if (token != null) {
//         dio.options.headers['Authorization'] = 'Bearer $token';
//         final response = await dio.get(
//             '$baseUrl/Match/Match/status/tour?status=Started&tourId=$tourId');
//         final entities = (response.data as List).cast<Map<String, dynamic>>();
//         return entities;
//       } else {
//         throw Exception('Token is null');
//       }
//     } catch (e) {
//       throw Exception('Failed to get all Live Matches: $e');
//     }
//   }
// }
// import 'package:cricyard/providers/token_manager.dart';
// import 'package:cricyard/data/network/network_api_service.dart';
// import '/resources/api_constants.dart';

// class MatchApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final NetworkApiService networkApiService = NetworkApiService();


//   // Fetch all entities
//   Future<List<Map<String, dynamic>>> getEntities() async {
//     try {
//       final token = await TokenManager.getToken();
//       print('token is $token');
//       if (token != null) {
//         final response = await networkApiService.getGetApiResponse(
//             '$baseUrl/Match/Match', 
//             // token
//             );
//         final entities = (response as List).cast<Map<String, dynamic>>();
//         return entities;
//       } else {
//         throw Exception('Token is null');
//       }
//     } catch (e) {
//       throw Exception('Failed to get all entities: $e');
//     }
//   }

//   // Fetch all entities with pagination
//   Future<List<Map<String, dynamic>>> getAllWithPagination(
//       String token, int page, int size) async {
//     try {
//       final response = await networkApiService.getGetApiResponse(
//           '$baseUrl/Match/Match/getall/page?page=$page&size=$size', 
//           // token
//           );
//       final entities = (response['content'] as List).cast<Map<String, dynamic>>();
//       return entities;
//     } catch (e) {
//       throw Exception('Failed to get all without pagination: $e');
//     }
//   }

//   // Create a new match entity
//   Future<Map<String, dynamic>> createEntity(Map<String, dynamic> entity) async {
//     try {
//       final token = await TokenManager.getToken();
//       print("in post api $entity");
//       final response = await networkApiService.getPostApiResponse(
//           '$baseUrl/Match/Match', entity, 
//           // token
//           );
//       return response;
//     } catch (e) {
//       throw Exception('Failed to create entity: $e');
//     }
//   }

//   // Update a match entity
//   Future<void> updateEntity(
//       String token, int entityId, Map<String, dynamic> entity) async {
//     try {
//       await networkApiService.getPutApiResponse(
//           '$baseUrl/Match/Match/$entityId', entity, 
//           // token
//           );
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   // Cancel a match
//   Future<void> cancel(int entityId) async {
//     try {
//       final token = await TokenManager.getToken();
//       await networkApiService.getPutApiResponse(
//           '$baseUrl/Match/Match/cancel/$entityId', {}, 
//           // token
//           );
//     } catch (e) {
//       throw Exception('Failed to cancel match: $e');
//     }
//   }

//   // Delete a match entity
//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       await networkApiService.getDeleteApiResponse(
//           '$baseUrl/Match/Match/$entityId', 
//           // token
//           );
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }

//   // Get my matches by tournament ID
//   Future<List<Map<String, dynamic>>> mymatches(int tourId) async {
//     try {
//       final token = await TokenManager.getToken();
//       if (token != null) {
//         final response = await networkApiService.getGetApiResponse(
//             '$baseUrl/Match/Match/myMatches/$tourId', 
//             // token
//             );
//         final entities = (response as List).cast<Map<String, dynamic>>();
//         return entities;
//       } else {
//         throw Exception('Token is null');
//       }
//     } catch (e) {
//       throw Exception('Failed to get my matches: $e');
//     }
//   }

//   // Get all matches by tournament ID
//   Future<List<Map<String, dynamic>>> allmatches(int tourId) async {
//     try {
//       final token = await TokenManager.getToken();
//       if (token != null) {
//         final response = await networkApiService.getGetApiResponse(
//             '$baseUrl/Match/Match/tournament/$tourId', 
//             // token
//             );
//         final entities = (response as List).cast<Map<String, dynamic>>();
//         return entities;
//       } else {
//         throw Exception('Token is null');
//       }
//     } catch (e) {
//       throw Exception('Failed to get all matches: $e');
//     }
//   }

//   // Get live matches
//   Future<List<Map<String, dynamic>>> liveMatches() async {
//     try {
//       final token = await TokenManager.getToken();
//       if (token != null) {
//         final response = await networkApiService.getGetApiResponse(
//             '$baseUrl/Match/Match/status?status=Started', 
//             // token
//             );
//         final entities = (response as List).cast<Map<String, dynamic>>();
//         return entities;
//       } else {
//         throw Exception('Token is null');
//       }
//     } catch (e) {
//       throw Exception('Failed to get live matches: $e');
//     }
//   }

//   // Fetch live matches by tournament ID
//   Future<List<Map<String, dynamic>>> liveMatchesByTourId(int tourId) async {
//     try {
//       final token = await TokenManager.getToken();
//       if (token != null) {
//         final response = await networkApiService.getGetApiResponse(
//             '$baseUrl/Match/Match/status/tour?status=Started&tourId=$tourId',
//             // token
//             );
//         final entities = (response as List).cast<Map<String, dynamic>>();
//         return entities;
//       } else {
//         throw Exception('Token is null');
//       }
//     } catch (e) {
//       throw Exception('Failed to get live matches by tournament ID: $e');
//     }
//   }
// }
import 'package:cricyard/providers/token_manager.dart';
import 'package:cricyard/data/network/network_api_service.dart';
import '/resources/api_constants.dart';

class MatchApiService {
  final NetworkApiService networkApiService = NetworkApiService();

  // Fetch all match entities
  Future<List<Map<String, dynamic>>> getEntities() async {
    try {
      final token = await TokenManager.getToken();
      print('token is $token');
      if (token != null) {
        final response = await networkApiService.getGetApiResponse(
          ApiConstants.getEntitiesMatch,
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

  // Fetch all match entities with pagination
  Future<List<Map<String, dynamic>>> getAllWithPagination(int page, int size) async {
    try {
      final response = await networkApiService.getGetApiResponse(
        '${ApiConstants.getAllWithPaginationMatch}?page=$page&size=$size',
      );
      final entities = (response['content'] as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all without pagination: $e');
    }
  }

  // Create a new match entity
  Future<Map<String, dynamic>> createEntity(Map<String, dynamic> entity) async {
    try {
      final token = await TokenManager.getToken();
      print("in post api $entity");
      final response = await networkApiService.getPostApiResponse(
        ApiConstants.createEntityMatch, entity,
      );
      return response;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  // Update a match entity
  Future<void> updateEntity(int entityId, Map<String, dynamic> entity) async {
    try {
      await networkApiService.getPutApiResponse(
        '${ApiConstants.updateEntityMatch}/$entityId', entity,
      );
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  // Cancel a match
  Future<void> cancel(int entityId) async {
    try {
      final token = await TokenManager.getToken();
      await networkApiService.getPutApiResponse(
        '${ApiConstants.cancelMatch}/$entityId', {},
      );
    } catch (e) {
      throw Exception('Failed to cancel match: $e');
    }
  }

  // Delete a match entity
  Future<void> deleteEntity(int entityId) async {
    try {
      await networkApiService.getDeleteApiResponse(
        '${ApiConstants.deleteEntityMatch}/$entityId',
      );
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  // Get my matches by tournament ID
  Future<List<Map<String, dynamic>>> myMatches(int tourId) async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        final response = await networkApiService.getGetApiResponse(
          '${ApiConstants.myMatches}/$tourId',
        );
        final entities = (response as List).cast<Map<String, dynamic>>();
        return entities;
      } else {
        throw Exception('Token is null');
      }
    } catch (e) {
      throw Exception('Failed to get my matches: $e');
    }
  }

  // Get all matches by tournament ID
  Future<List<Map<String, dynamic>>> allmatches(int tourId) async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        final response = await networkApiService.getGetApiResponse(
          '${ApiConstants.allMatchesByTourId}/$tourId',
        );
        final entities = (response as List).cast<Map<String, dynamic>>();
        return entities;
      } else {
        throw Exception('Token is null');
      }
    } catch (e) {
      throw Exception('Failed to get all matches: $e');
    }
  }

  // Get live matches
  Future<List<Map<String, dynamic>>> liveMatches() async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        final response = await networkApiService.getGetApiResponse(
          ApiConstants.liveMatches,
        );
        final entities = (response as List).cast<Map<String, dynamic>>();
        return entities;
      } else {
        throw Exception('Token is null');
      }
    } catch (e) {
      throw Exception('Failed to get live matches: $e');
    }
  }

  // Fetch live matches by tournament ID
  Future<List<Map<String, dynamic>>> liveMatchesByTourId(int tourId) async {
    try {
      final token = await TokenManager.getToken();
      if (token != null) {
        final response = await networkApiService.getGetApiResponse(
          '${ApiConstants.liveMatchesByTourId}?tourId=$tourId',
        );
        final entities = (response as List).cast<Map<String, dynamic>>();
        return entities;
      } else {
        throw Exception('Token is null');
      }
    } catch (e) {
      throw Exception('Failed to get live matches by tournament ID: $e');
    }
  }
}
