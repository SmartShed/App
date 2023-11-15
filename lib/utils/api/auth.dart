import 'package:dio/dio.dart';

import '../../constants/api.dart';

class AuthAPIHandler {
  AuthAPIHandler._internal();
  static final AuthAPIHandler _authAPIHandler = AuthAPIHandler._internal();
  factory AuthAPIHandler() => _authAPIHandler;

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> register(
      String email, String password, String name, String position) async {
    try {
      print("Registering with $email, $password, $name, $position at " +
          APIConstants.register);

      final response = await _dio.post(
        APIConstants.register,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'position': position,
        },
      );

      print(response.data);

      return {
        'status': 'success',
        'auth_token': response.data['auth_token'],
        'message': response.data['message'],
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Something went wrong. Please try again later.',
        'error': e,
      };
    }
  }

  Future<Map<String, dynamic>> registerWithGoogle(
      String email, String name, String position) async {
    try {
      final response = await _dio.post(
        APIConstants.registerWithGoogle,
        data: {
          'email': email,
          'name': name,
          'position': position,
        },
      );

      return {
        'status': 'success',
        'auth_token': response.data['auth_token'],
        'message': response.data['message'],
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Something went wrong. Please try again later.',
      };
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await _dio.post(
        APIConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      return {
        'status': 'success',
        'auth_token': response.data['auth_token'],
        'message': response.data['message'],
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Something went wrong. Please try again later.',
      };
    }
  }

  Future<Map<String, dynamic>> loginWithGoogle(String email) async {
    try {
      final response = await _dio.post(
        APIConstants.loginWithGoogle,
        data: {
          'email': email,
        },
      );

      return {
        'status': 'success',
        'auth_token': response.data['auth_token'],
        'message': response.data['message'],
      };
    } catch (e) {
      return {
        'status': 'error',
        'message': 'Something went wrong. Please try again later.',
        'error': e,
      };
    }
  }

  Future<Map<String, dynamic>> logout(String auth_token) async {
    return {};
  }
}
