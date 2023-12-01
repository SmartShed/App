import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../../controllers/logger/log.dart';

class AuthAPIHandler {
  static final _logger = LoggerService.getLogger('AuthAPIHandler');

  AuthAPIHandler._internal();
  static final AuthAPIHandler _authAPIHandler = AuthAPIHandler._internal();
  factory AuthAPIHandler() => _authAPIHandler;

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> register(
      String email, String password, String name, String position) async {
    try {
      _logger.info('Registering user: $email');
      final response = await _dio.post(
        APIConstants.register,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'position': position,
        },
      );

      _logger.info('User registered successfully: $email');
      return {
        'status': 'success',
        'auth_token': response.data['auth_token'],
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      _logger.error('Error registering user: $email');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> registerWithGoogle(
      String email, String name, String position) async {
    try {
      _logger.info('Registering user with Google: $email');
      final response = await _dio.post(
        APIConstants.registerWithGoogle,
        data: {
          'email': email,
          'name': name,
          'position': position,
        },
      );

      _logger.info('User registered with Google successfully: $email');
      return {
        'status': 'success',
        'auth_token': response.data['auth_token'],
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      _logger.error('Error registering user with Google: $email');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      _logger.info('Logging in user: $email');
      final response = await _dio.post(
        APIConstants.login,
        data: {
          'email': email,
          'password': password,
        },
      );

      _logger.info('User logged in successfully: $email');
      return {
        'status': 'success',
        'auth_token': response.data['auth_token'],
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      _logger.error('Error logging in user: $email');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> loginWithGoogle(String email) async {
    try {
      _logger.info('Logging in user with Google: $email');
      final response = await _dio.post(
        APIConstants.loginWithGoogle,
        data: {
          'email': email,
        },
      );

      _logger.info('User logged in with Google successfully: $email');
      return {
        'status': 'success',
        'auth_token': response.data['auth_token'],
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      _logger.error('Error logging in user with Google: $email');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> me(String authToken) async {
    try {
      _logger.info('Fetching user details');
      final response = await _dio.get(
        "http://localhost:8000/api/auth/me",
        options: Options(
          headers: {
            'auth_token': authToken,
          },
        ),
      );

      _logger.info('User details fetched successfully');
      return {
        'status': 'success',
        'user': response.data,
      };
    } on DioException catch (e) {
      _logger.error('Error fetching user details');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> logout(String authToken) async {
    try {
      _logger.info('Logging out user');
      final response = await _dio.post(
        APIConstants.logout,
        options: Options(
          headers: {
            'auth_token': authToken,
          },
        ),
      );

      _logger.info('User logged out successfully');
      return {
        'status': 'success',
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      _logger.error('Error logging out user');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }
}
