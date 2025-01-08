import 'dart:io';
import 'package:dio/dio.dart';
import '../exceptions/app_exceptions.dart';
import 'no_token_base_network_service.dart';
import 'dart:convert';

class NoTokenNetworkApiService extends NoTokenBaseNetworkService {
  final Dio _dio = Dio();

  NetworkApiService() {
    // Optionally configure Dio, e.g. add interceptors
    _dio.options.connectTimeout = const Duration(seconds: 30); // 30 seconds
    _dio.options.receiveTimeout = const Duration(seconds: 30);
  }

  @override
  Future<dynamic> getGetApiResponse(String? url) async {
    try {
      final headers = {
        'Content-Type': 'application/json', // Add other headers if needed
      };
      final response = await _dio.get(
        url!,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      throw FetchDataException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<dynamic> getPostApiResponse(String? url, dynamic body) async {
    try {
      print('url is: $url');
      final headers = {
        'Content-Type': 'application/json', // Add other headers if needed
      };
      final response = await _dio.post(
        url!,
        data: body,
        options: Options(headers: headers),
      );
      print('response is: ${_handleResponse(response)}');
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      print('error is $e');
      throw FetchDataException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<dynamic> getPutApiResponse(String? url, dynamic body) async {
    try {
      final headers = {
        'Content-Type': 'application/json', // Add other headers if needed
      };
      final response = await _dio.put(
        url!,
        data: body,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      throw FetchDataException('An unexpected error occurred: $e');
    }
  }

  @override
  Future<dynamic> getDeleteApiResponse(String? url) async {
    try {
      final headers = {
        'Content-Type': 'application/json', // Add other headers if needed
      };
      final response = await _dio.delete(
        url!,
        options: Options(headers: headers),
      );
      return _handleResponse(response);
    } on DioException catch (e) {
      return _handleDioError(e);
    } on SocketException {
      throw FetchDataException('No Internet Connection');
    } catch (e) {
      throw FetchDataException('An unexpected error occurred: $e');
    }
  }

  dynamic _handleResponse(Response response) {
    switch (response.statusCode) {
      case 200:
      case 201:
        try {
          // Handle empty body
          if (response.data == null || response.data.toString().isEmpty) {
            return null;
          }
          //-----
          print('response data is: ${response.data}');

          if (response.data is String) {
            return jsonDecode(response.data);
          }
          //-----
          return response.data;
        } catch (e) {
          throw FetchDataException('Error parsing response: $e');
        }
      case 400:
        throw BadRequestException('Bad request: ${response.data}');
      case 401:
        throw UnauthorizedException('Unauthorized request: ${response.data}');
      case 403:
        throw ForbiddenException('Forbidden request: ${response.data}');
      case 404:
        throw NotFoundException('Not found: ${response.data}');
      case 500:
        throw InternalServerErrorException('Server error: ${response.data}');
      default:
        throw FetchDataException(
            'Error while communicating with server: ${response.statusCode}');
    }
  }

  dynamic _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        throw FetchDataException("Request timed out.");
      case DioExceptionType.badResponse:
        return _handleResponse(error.response!);
      case DioExceptionType.cancel:
        throw FetchDataException("Request was cancelled.");
      case DioExceptionType.connectionError:
        throw FetchDataException("Connection failed due to internet issue.");
      default:
        throw FetchDataException("Unexpected error occurred.");
    }
  }
}
