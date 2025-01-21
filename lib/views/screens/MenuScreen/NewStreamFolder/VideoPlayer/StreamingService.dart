import 'package:cricyard/data/network/network_api_service.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'dart:typed_data';

import '../../../../../providers/token_manager.dart';
import '../../../../../resources/api_constants.dart';

final NetworkApiService _networkApiService = NetworkApiService();


class StreamingService {
  final String baseUrl = ApiConstants.baseUrl;
  final Dio dio = Dio();

  Future<dynamic> startWorkflow(int matchId) async {
    final token = await TokenManager.getToken();

    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response =
          await dio.get('$baseUrl/workflow/startStreaming/$matchId');

      // Assuming the response is a Map<String, dynamic>
      dynamic responseData = response.data;

      return responseData;
    } catch (e) {
      throw Exception('Failed to create Workflow: $e');
    }
  }

  // Future<Map<String, dynamic>?> getStartMatch(int matchId) async {
  //   try {
  //     final token = await TokenManager.getToken();
  //     dio.options.headers['Authorization'] = 'Bearer $token';
  //     final response =
  //         await dio.get('$baseUrl/Start_Match/Start_Match/matchId/$matchId');

  //     print('score response ${response.data}');
  //     // Check if response is successful and data is not null
  //     if (response.statusCode == 200 && response.data != null) {
  //       print('response get..');
  //       // Assuming the response is a Map<String, dynamic>
  //       Map<String, dynamic> responseData = response.data;
  //       return responseData;
  //       //
  //     } else {
  //       // If response is not successful, return null
  //       return null;
  //     }
  //   } catch (e) {
  //     // Handle errors and return null
  //     print('Failed to get Match: $e');
  //     return null;
  //   }
  // }
  Future<Map<String, dynamic>?> getStartMatch(int matchId) async {
    try {
      // Construct the URL
      final String url =
          '$baseUrl/Start_Match/Start_Match/matchId/$matchId';

      // Use the NetworkApiService to make the GET request
      final response = await _networkApiService.getGetApiResponse(url);

      print('Score response: $response');

      // Ensure the response is valid and cast it to Map<String, dynamic>
      if (response != null && response is Map<String, dynamic>) {
        print('Response received successfully.');
        return response;
      } else {
        print('Response is either null or not a Map.');
        return null;
      }
    } catch (e) {
      print('Failed to get match: $e');
      return null;
    }
  }

  Future<http.Response> uploadFrames(List<Uint8List> frames) async {
    var request = http.MultipartRequest('POST', Uri.parse(baseUrl));

    for (int i = 0; i < frames.length; i++) {
      request.files.add(
        http.MultipartFile.fromBytes(
          'frames',
          frames[i],
          filename: 'frame$i.jpg',
          contentType: MediaType('image', 'jpeg'),
        ),
      );
    }

    var response = await request.send();
    return http.Response.fromStream(response);
  }
}
