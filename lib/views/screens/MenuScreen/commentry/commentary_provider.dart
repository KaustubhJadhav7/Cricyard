import 'package:dio/dio.dart';
import '../../../../resources/api_constants.dart';

class CommentaryProvider {
  final String baseUrl = ApiConstants.baseUrl;
  final Dio dio = Dio();

  Future<List<Map<String, dynamic>>> fetchCommentary() async {
    try {
      final response = await dio.get('$baseUrl/');

      if (response.statusCode == 200) {
        print("Successfully fetched commentary");

        List<Map<String, dynamic>> commentaryData = List<Map<String, dynamic>>.from(response.data);

        return commentaryData;
      } else {
        throw Exception('Failed to fetch commentary');
      }
    } catch (e) {
      throw Exception('Failed to fetch commentary: $e');
    }
  }
}
