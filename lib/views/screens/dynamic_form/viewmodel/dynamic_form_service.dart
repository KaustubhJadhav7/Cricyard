// import 'package:dio/dio.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import '../../../resources/api_constants.dart';
// import '../../widgets/custom_messenger.dart';
// import '../LogoutService/Logoutservice.dart';

// class DynamicForApiService {
//   final String baseUrl = ApiConstants.baseUrl;
//   final Dio dio = Dio();
// //api/dynamic_form_build
//   Future<void> BuildForms(String token, int id, BuildContext context) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response =
//           await dio.get('$baseUrl/api/dynamic_form_build?form_id=$id');
//       if (response.statusCode == 401) {
//         LogoutService.logout();
//       }
//       if (response.statusCode! <= 209) {
//         //  Fluttertoast.showToast(
//         //    msg: 'Build success',
//         //    backgroundColor: Colors.red,
//         //  );
//         ScaffoldMessenger.of(context).showSnackBar(
//             ShowSnackAlert.CustomMessenger(context, Colors.green.shade600,
//                 Colors.green.shade900, ' Build Success'));
//       } else {
//         Fluttertoast.showToast(
//           msg: 'Unable to build',
//           backgroundColor: Colors.red,
//         );
//         throw Exception('Unexpected response type');
//       }
//     } catch (e) {
//       throw Exception('Failed to Build form: $e');
//     }
//   }

//   Future<List<Map<String, dynamic>>> getallDynamicForms(
//     String token,
//   ) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       final response = await dio.get('$baseUrl/api/form_setup');
//       if (response.statusCode == 401) {
//         LogoutService.logout();
//       }
//       final responseData = response.data['items'];
//       if (responseData is List) {
//         final entities = responseData.cast<Map<String, dynamic>>();
//         return entities;
//       } else if (responseData is Map<String, dynamic>) {
//         return [responseData];
//       } else {
//         throw Exception('Unexpected response type');
//       }
//     } catch (e) {
//       throw Exception('Failed to get modules by projectId: $e');
//     }
//   }

//   Future<void> createDynamicForm(
//       String token, Map<String, dynamic> entity) async {
//     try {
//       print("in post api...$entity");
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       var response = await dio.post('$baseUrl/api/form_setup', data: entity);
//       if (response.statusCode == 401) {
//         LogoutService.logout();
//       }
//       print('response is ${response.data}');
//     } catch (e) {
//       throw Exception('Failed to create Dynamic form: $e');
//     }
//   }

//   Future<void> updateDynamicForm(
//       String token, int entityId, Map<String, dynamic> entity) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       var response =
//           await dio.put('$baseUrl/api/form_setup/$entityId', data: entity);
//       if (response.statusCode == 401) {
//         LogoutService.logout();
//       }
//       print(entity);
//     } catch (e) {
//       throw Exception('Failed to update Dynamic form: $e');
//     }
//   }

//   Future<void> deleteDynamicForm(String token, int entityId) async {
//     try {
//       dio.options.headers['Authorization'] = 'Bearer $token';
//       var response = await dio.delete('$baseUrl/api/form_setup/$entityId');
//       if (response.statusCode == 401) {
//         LogoutService.logout();
//       }
//     } catch (e) {
//       throw Exception('Failed to delete Dynamic form: $e');
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../../resources/api_constants.dart';
import '../../../widgets/custom_messenger.dart';
import '../../LogoutService/Logoutservice.dart';
import 'package:cricyard/data/network/network_api_service.dart';

class DynamicFormApiService {
  final NetworkApiService _networkService;

  DynamicFormApiService(this._networkService);

  // Build form by ID
  Future<void> buildForms(int id, BuildContext context) async {
    try {
      String apiUrl = '/api/dynamic_form_build?form_id=$id';
      final response = await _networkService.getGetApiResponse(apiUrl);

      // Check for response status
      if (response['status'] == 401) {
        LogoutService.logout();
      } else if (response['status'] != null && response['status'] <= 209) {
        ScaffoldMessenger.of(context).showSnackBar(
          ShowSnackAlert.CustomMessenger(
            context,
            Colors.green.shade600,
            Colors.green.shade900,
            'Build Success',
          ),
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Unable to build',
          backgroundColor: Colors.red,
        );
        throw Exception('Unexpected response type');
      }
    } catch (e) {
      throw Exception('Failed to build form: $e');
    }
  }

  // Fetch all dynamic forms
  Future<List<Map<String, dynamic>>> getAllDynamicForms() async {
    try {
      String apiUrl = '/api/form_setup';
      final response = await _networkService.getGetApiResponse(apiUrl);

      final responseData = response['items'];
      if (responseData is List) {
        return responseData.cast<Map<String, dynamic>>();
      } else if (responseData is Map<String, dynamic>) {
        return [responseData];
      } else {
        throw Exception('Unexpected response type');
      }
    } catch (e) {
      throw Exception('Failed to fetch dynamic forms: $e');
    }
  }

  // Create a dynamic form
  Future<void> createDynamicForm(Map<String, dynamic> entity) async {
    try {
      String apiUrl = '/api/form_setup';
      await _networkService.getPostApiResponse(apiUrl, entity);
    } catch (e) {
      throw Exception('Failed to create dynamic form: $e');
    }
  }

  // Update a dynamic form
  Future<void> updateDynamicForm(int entityId, Map<String, dynamic> entity) async {
    try {
      String apiUrl = '/api/form_setup/$entityId';
      await _networkService.getPutApiResponse(apiUrl, entity);
    } catch (e) {
      throw Exception('Failed to update dynamic form: $e');
    }
  }

  // Delete a dynamic form
  Future<void> deleteDynamicForm(int entityId) async {
    try {
      String apiUrl = '/api/form_setup/$entityId';
      await _networkService.getDeleteApiResponse(apiUrl);
    } catch (e) {
      throw Exception('Failed to delete dynamic form: $e');
    }
  }
}