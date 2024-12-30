// import 'dart:convert';
// import 'dart:io';
// import 'package:cricyard/providers/token_manager.dart';
// import 'package:dio/dio.dart';

// import '/resources/api_constants.dart';
// import 'package:http/http.dart' as http;

// const String baseUrl = ApiConstants.baseUrl;
// final Dio dio = Dio();

// Future<Map<String, dynamic>> sendData({
//   required String urlPath,
//   required Map<String, dynamic> data,
//   String? authKey,
// }) async {
//   String backendServiceHost = ApiConstants.baseUrl + urlPath;
//   var response;
//   try {
//     response = await http.post(
//       Uri.parse(backendServiceHost),
//       headers: <String, String>{
//         'Content-Type': 'application/json',
//         if (authKey != null) 'Authorization': authKey
//       },
//       body: jsonEncode(data),
//     );
//   } on http.ClientException catch (e) {
//     // Handle ClientException
//     return {'ClientException': ' ${e.message}'};
//   } on Exception catch (e) {
//     // Handle other exceptions
//     return {'error': 'Exception: $e'};
//   }

//   // Check if response is null
//   if (response == null) {
//     return {'error': 'Null response'};
//   }

//   // Check if the status code indicates success
//   if (response.statusCode == 200) {
//     return jsonDecode(response.body);
//   } else {
//     // Return error if the status code is not 200
//     return {'error': 'HTTP error: ${response.statusCode}'};
//   }
// }

// Future<Map<String, dynamic>> getUser(int userId) async {
//   try {
//     // final token = await TokenManager.getToken();
//     // dio.options.headers['Authorization'] = 'Bearer $token';
//     final response = await dio.get('$baseUrl/token/getuser/$userId');
//     // final entities = (response.data).cast<Map<String, dynamic>>();
//     // print(response.data);
//     return response.data;
//   } catch (e) {
//     throw Exception('Failed to get all User: $e');
//   }
// }

// // Future<Map<String, dynamic>> sendData(
// //     {required String urlPath,
// //     required Map<String, dynamic> data,
// //     String? authKey}) async {
// //   String backendServiceHost = ApiConstants.baseUrl + urlPath;
// //   var response;
// //   try {
// //     response = await http.post(
// //       Uri.parse(backendServiceHost),
// //       headers: <String, String>{
// //         'Content-Type': 'application/json',
// //         if (authKey != null) 'Authorization': authKey
// //       },
// //       body: jsonEncode(data),
// //     );
// //   } on SocketException {
// //     return {'internetConnectionError': 'no internet connection'};
// //   }
// //   return jsonDecode(response.body);
// // }

// Future<int> checkUrlValidity(String url) async {
//   try {
//     final response = await http.get(Uri.parse(url));

//     return response.statusCode;
//   } catch (e) {
//     return 404;
//   }
// }
import 'dart:convert';
import 'package:cricyard/providers/token_manager.dart';
import 'package:dio/dio.dart';
import '/resources/api_constants.dart';
import 'package:cricyard/data/network/network_api_service.dart';

const String baseUrl = ApiConstants.baseUrl;
final NetworkApiService networkApiService = NetworkApiService(); // Object of NetworkApiService

// This function is refactored to use NetworkApiService
Future<Map<String, dynamic>> sendData({
  required String urlPath,
  required Map<String, dynamic> data,
  String? authKey,
}) async {
  String backendServiceHost = ApiConstants.baseUrl + urlPath;
  try {
    // Using NetworkApiService to perform a POST request
    final response = await networkApiService.getPostApiResponse(backendServiceHost, data);

    if (response is Map<String, dynamic>) {
      return response;
    } else {
      return {'error': 'Invalid response format'};
    }
  } catch (e) {
    return {'error': 'Failed to send data: $e'};
  }
}

// This function uses NetworkApiService to get user data by userId
Future<Map<String, dynamic>> getUser(int userId) async {
  try {
    // Replace Dio call with NetworkApiService's GET method
    final response = await networkApiService.getGetApiResponse('$baseUrl/token/getuser/$userId');

    if (response is Map<String, dynamic>) {
      return response;
    } else {
      return {'error': 'Invalid response format'};
    }
  } catch (e) {
    throw Exception('Failed to get User: $e');
  }
}

// This function checks URL validity using NetworkApiService's GET method
Future<int> checkUrlValidity(String url) async {
  try {
    final response = await networkApiService.getGetApiResponse(url);
    
    if (response != null) {
      return 200;  // Return success code if the response is valid
    } else {
      return 404;  // Return 404 if no response or invalid response
    }
  } catch (e) {
    return 404;  // Return 404 if any error occurs (e.g., connection error)
  }
}
