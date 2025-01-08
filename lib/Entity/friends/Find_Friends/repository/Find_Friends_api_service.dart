// import 'package:cricyard/providers/token_manager.dart';
import 'package:dio/dio.dart';
// import '../../../views/screens/LogoutService/Logoutservice.dart';
// import '/resources/api_constants.dart';
// class find_friendsApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();
//   final String token = TokenManager.getToken().toString();
//   Future<List<Map<String, dynamic>>> getEntities() async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get('$baseUrl/Find_Friends/Find_Friends');
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
//           '$baseUrl/Find_Friends/Find_Friends/getall/page?page=$page&size=$Size');
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
//           await dio.post('$baseUrl/Find_Friends/Find_Friends', data: entity);

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
//       await dio.put('$baseUrl/Find_Friends/Find_Friends/$entityId',
//           data: entity);
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update entity: $e');
//     }
//   }

//   Future<void> deleteEntity(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       await dio.delete('$baseUrl/Find_Friends/Find_Friends/$entityId');
//     } catch (e) {
//       throw Exception('Failed to delete entity: $e');
//     }
//   }

//   // find friends dhiwise
//   // Method to fetch all friends
//   Future<List<Map<String, dynamic>>> getAllFriends(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       // final response = await dio.get('$baseUrl/Find_Friends/my friends');
//       print(" in apiservice entered");
//       var response =
//           await dio.get('$baseUrl/Find_Friends/Find_Friends/myFriends');
//       print("apiservice called above and store response in response");

//       print("Response data: ${response.data}");
//       if (response.statusCode == 401) {
//         LogoutService.logout();
//       }
//       final friends = (response.data as List).cast<Map<String, dynamic>>();
//       return friends;
//     } catch (e) {
//       throw Exception('Failed to get all friends: $e');
//     }
//   } // Method to fetch all friends

//   Future<List<Map<String, dynamic>>> getAllUsers(String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       // final response = await dio.get('$baseUrl/Find_Friends/my friends');
//       print(" in apiservice entered");
//       var response = await dio.get('$baseUrl/api/getuser/accountid');
//       print("apiservice called above and store response in response");

//       print("Response data: ${response.data}");
//       if (response.statusCode == 401) {
//         LogoutService.logout();
//       }
//       final friends = (response.data as List).cast<Map<String, dynamic>>();
//       return friends;
//     } catch (e) {
//       throw Exception('Failed to get all friends: $e');
//     }
//   }

// //add friend
//   Future<void> addFriend(String token, int userId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       var response = await dio.post(
//         '$baseUrl/Find_Friends/Find_Friends/Add/$userId',
//       );
//       if (response.statusCode == 200) {
//         // Friend added successfully
//         print('Friend added successfully');
//       } else {
//         // Handle other status codes
//         print('Failed to add friend: ${response.data}');
//         throw Exception('Failed to add friend');
//       }
//     } on DioError catch (e) {
//       if (e.response?.statusCode == 409) {
//         // Friend already present
//         print('Friend already present');
//       } else {
//         // Handle other Dio errors
//         print('Error adding friend: $e');
//         throw e;
//       }
//     } catch (error) {
//       // Handle generic errors
//       print('Error adding friend: $error');
//       throw error;
//     }
//   }

//   Future<bool> deleteFriendById(int id, String token) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.delete(
//         '$baseUrl/Find_Friends/Find_Friends/$id',
//       );
//       if (response.statusCode == 200) {
//         // Friend deleted successfully
//         print('Friend deleted successfully');
//         return true;
//       } else {
//         // Failed to delete friend
//         print('Failed to delete friend: ${response.data}');
//         return false;
//       }
//     } catch (error) {
//       print('Error deleting friend: $error');
//       throw error;
//     }
//   }
// }
// import 'package:cricyard/providers/token_manager.dart';

import '../../../../views/screens/LogoutService/Logoutservice.dart';
import '/resources/api_constants.dart';
import 'package:cricyard/data/network/network_api_service.dart';

class FindFriendsApiService {
  final String baseUrl = ApiConstants.baseUrl;
  final NetworkApiService _networkApiService = NetworkApiService();

  Future<List<Map<String, dynamic>>> getEntities() async {
    try {
      final response =
          await _networkApiService.getGetApiResponse(ApiConstants.findFriends);
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
          '${ApiConstants.pagination}?page=$page&size=$size');
      final entities =
          (response['content'] as List).cast<Map<String, dynamic>>();
      return entities;
    } catch (e) {
      throw Exception('Failed to get all with pagination: $e');
    }
  }

  Future<Map<String, dynamic>> createEntity(Map<String, dynamic> entity) async {
    try {
      final response = await _networkApiService.getPostApiResponse(
          ApiConstants.findFriends, entity);
      return response;
    } catch (e) {
      throw Exception('Failed to create entity: $e');
    }
  }

  Future<void> updateEntity(int entityId, Map<String, dynamic> entity) async {
    try {
      await _networkApiService.getPutApiResponse(
          '${ApiConstants.findFriends}/$entityId', entity);
    } catch (e) {
      throw Exception('Failed to update entity: $e');
    }
  }

  Future<void> deleteEntity(String token, int entityId) async {
    try {
      await _networkApiService
          .getDeleteApiResponse('${ApiConstants.findFriends}/$entityId');
    } catch (e) {
      throw Exception('Failed to delete entity: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllFriends(String token) async {
    try {
      final response =
          await _networkApiService.getGetApiResponse(ApiConstants.myFriends);
      if (response == null) {
        LogoutService.logout();
      }
      final friends = (response as List).cast<Map<String, dynamic>>();
      return friends;
    } catch (e) {
      throw Exception('Failed to get all friends: $e');
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsers(String token) async {
    try {
      final response =
          await _networkApiService.getGetApiResponse(ApiConstants.users);
      if (response == null) {
        LogoutService.logout();
      }
      final users = (response as List).cast<Map<String, dynamic>>();
      return users;
    } catch (e) {
      throw Exception('Failed to get all users: $e');
    }
  }

  Future<void> addFriend(String token, int userId) async {
    try {
      final response = await _networkApiService
          .getPostApiResponse('${ApiConstants.addFriend}/$userId', {});
      if (response == null || response['statusCode'] != 200) {
        throw Exception('Failed to add friend');
      }
      print('Friend added successfully');
    } on DioError catch (e) {
      if (e.response?.statusCode == 409) {
        print('Friend already present');
      } else {
        print('Error adding friend: $e');
        throw e;
      }
    } catch (error) {
      print('Error adding friend: $error');
      throw error;
    }
  }

  Future<bool> deleteFriendById(int id, String token) async {
    try {
      final response = await _networkApiService
          .getDeleteApiResponse('${ApiConstants.deleteFriend}/$id');
      if (response == null || response['statusCode'] != 200) {
        print('Failed to delete friend');
        return false;
      }
      print('Friend deleted successfully');
      return true;
    } catch (error) {
      print('Error deleting friend: $error');
      throw error;
    }
  }
}
