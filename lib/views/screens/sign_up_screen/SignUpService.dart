import 'package:cricyard/providers/token_manager.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../resources/api_constants.dart';

class SignUpApiService {
  final String baseUrl = ApiConstants.baseUrl;
  final Dio dio = Dio();

// get all account
  Future<List<Map<String, dynamic>>> getallAccount(String token) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get('$baseUrl/users/sysaccount/sysaccount');

      final responseData = response.data;

      print('response data is ... $responseData');

      if (responseData is List) {
        // If the response is a list, cast it to the expected type
        final entities = responseData.cast<Map<String, dynamic>>();
        return entities;
      } else if (responseData is Map<String, dynamic>) {
        // If the response is a single object, wrap it in a list
        return [responseData];
      } else {
        // Handle other unexpected response types here
        throw Exception('Unexpected response type');
      }
    } catch (e) {
      throw Exception('Failed to Account: $e');
    }
  }

// get all user
  Future<List<Map<String, dynamic>>> getallUser() async {
    try {
      final token = await TokenManager.getToken();
      dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio.get('$baseUrl/api//token/getalluser');

      final responseData = response.data;

      print('response data is ... $responseData');

      if (responseData is List) {
        // If the response is a list, cast it to the expected type
        final entities = responseData.cast<Map<String, dynamic>>();
        return entities;
      } else if (responseData is Map<String, dynamic>) {
        // If the response is a single object, wrap it in a list
        return [responseData];
      } else {
        // Handle other unexpected response types here
        throw Exception('Unexpected response type');
      }
    } catch (e) {
      throw Exception('Failed to Get All User: $e');
    }
  }

// get by mobile Number
  Future<Map<String, dynamic>> getByMobNumber(String mobNo) async {
    try {
      // dio.options.headers['Authorization'] = 'Bearer $token';
      final response =
          await dio.get('$baseUrl/api/getuser/mobile?mob_num=$mobNo');
      print(response.data);

      // return response.data;
      return Future.delayed(
        Duration(seconds: 2),
        () => {'fullName': response.data['fullName']},
      );
    } catch (e) {
      print('error is $e');
      throw Exception('Failed To Get User: $e');
    }
  }

// Create account
  Future<Map<String, dynamic>> createAccount(
      Map<String, dynamic> entity) async {
    print('sysaccout :$entity');
    try {
      // dio.options.headers['Authorization'] = 'Bearer $token';
      final response = await dio
          .post('$baseUrl/token/users/sysaccount/savesysaccount', data: entity);

      print(' created account is $response');
      return response.data;
    } catch (e) {
      print('error is $e');
      throw Exception('Failed To Create Account: $e');
    }
  }

// SEND EMAIL FOR OTP
  Future<Response> sendEmail(Map<String, dynamic> entity) async {
    try {
      print("in post api...$entity");
      // dio.options.headers['Authorization'] = 'Bearer $token';
      final response =
          await dio.post('$baseUrl/token/user/send_email', data: entity);
      print(entity);
      print('email response is: $response');

      return response;
    } catch (e) {
      throw Exception('Failed to Send Email: $e');
    }
  }

  // RESEND EMAIL FOR OTP
  Future<void> resendEmail(String email) async {
    try {
      print('resend otp start $baseUrl/token/user/resend_otp/email=$email');

      // dio.options.headers['Authorization'] = 'Bearer $token';
      final response =
          await dio.post('$baseUrl/token/user/resend_otp?email=$email');
      print('resend donee');
      print(response);
    } catch (e) {
      throw Exception('Failed to ReSend Email: $e');
    }
  }

  // OTP VEFICATION

  Future<Response> otpVerification(String email, String otp) async {
    try {
      final response = await dio.post(
        '$baseUrl/token/user/otp_verification',
        queryParameters: {'email': email, 'otp': otp},
      );

      if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "OTP verified successfully!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.green,
          textColor: Colors.white,
        );
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
          msg: "Bad request: Wrong OTP",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Error: ${response.statusMessage}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
      }

      return response;
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to Verify OTP: $e",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
      throw Exception('Failed to Verify OTP: $e');
    }
  }
//   Future<void> otpVerification(String email, String otp) async {
//     try {
//       final response = await dio.post(
//         '$baseUrl/token/user/otp_verification',
//         queryParameters: {'email': email, 'otp': otp},
//       );

//       if (response.statusCode == 200) {
//         Fluttertoast.showToast(
//           msg: "OTP verified successfully!",
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.green,
//           textColor: Colors.white,
//         );
//       } else if (response.statusCode == 400) {
//         Fluttertoast.showToast(
//           msg: "Bad request: Wrong OTP",
//           toastLength: Toast.LENGTH_LONG,
//           gravity: ToastGravity.BOTTOM,
//           backgroundColor: Colors.red,
//           textColor: Colors.white,
//         );
//       }
//     } catch (e) {
//       Fluttertoast.showToast(
//         msg: "Failed to Verify OTP: $e",
//         toastLength: Toast.LENGTH_LONG,
//         gravity: ToastGravity.BOTTOM,
//         backgroundColor: Colors.red,
//         textColor: Colors.white,
//       );
//     }
//   }

  Future<void> createuser(Map<String, dynamic> entity) async {
    //print("user......$token");
    print("user......$entity");
    try {
      print("in post api...$entity");
      //dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.post('$baseUrl/token/addOneAppUser', data: entity);
      print(entity);
    } catch (e) {
      throw Exception('Failed to create User: $e');
    }
  }

  Future<void> updateUser(
      String token, int entityId, Map<String, dynamic> entity) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.put('$baseUrl/api/updateAppUserDto/$entityId', data: entity);
      print(entity);
    } catch (e) {
      throw Exception('Failed to update Backend: $e');
    }
  }

  Future<void> deleteUser(String token, int entityId) async {
    try {
      dio.options.headers['Authorization'] = 'Bearer $token';
      await dio.delete('$baseUrl/api/delete_usr/$entityId');
    } catch (e) {
      throw Exception('Failed to delete User: $e');
    }
  }
}
