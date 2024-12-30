import 'dart:convert';
import 'dart:typed_data';
import 'package:dio/dio.dart';

import '../resources/api_constants.dart';

class PhotoProvider {
  Dio dio = Dio();
  final String baseUrl = ApiConstants.baseUrl;

  Future<Uint8List?> fetchPhoto() async {
    try {
      final res = await dio.post("$baseUrl/");
      if (res.statusCode == 200) {
        String base64EncodedImage = res.data.toString(); // Assuming res.data contains base64 encoded image
        return base64Decode(base64EncodedImage);
      }
    } catch (e) {
      print("Error fetching or decoding image: $e");
    }
    return null;
  }
}
