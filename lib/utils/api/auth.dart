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
    String email,
    String password,
    String name,
    String position,
    String section,
  ) async {
    try {
      _logger.info('Registering user: $email');
      final response = await _dio.post(
        APIConstants.register,
        data: {
          'email': email,
          'password': password,
          'name': name,
          'position': position,
          'section': section,
        },
      );

      _logger.info('User registered successfully: $email');
      return {
        'status': 'success',
        'message': response.data['message'],
        'auth_token': response.data['auth_token'],
        'user': response.data['user'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> registerWithGoogle(
    String email,
    String name,
    String position,
    String section,
  ) async {
    try {
      _logger.info('Registering user with Google: $email');
      final response = await _dio.post(
        APIConstants.registerWithGoogle,
        data: {
          'email': email,
          'name': name,
          'position': position,
          'section': section,
        },
      );

      _logger.info('User registered with Google successfully: $email');
      return {
        'status': 'success',
        'message': response.data['message'],
        'auth_token': response.data['auth_token'],
        'user': response.data['user'],
      };
    } on DioException catch (e) {
      _logger.error(e);
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
        'message': response.data['message'],
        'auth_token': response.data['auth_token'],
        'user': response.data['user'],
      };
    } on DioException catch (e) {
      _logger.error(e);
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
        'message': response.data['message'],
        'auth_token': response.data['auth_token'],
        'user': response.data['user'],
      };
    } on DioException catch (e) {
      _logger.error(e);
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
        APIConstants.me,
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
      _logger.error(e);
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
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> validateToken(String authToken) async {
    try {
      _logger.info('Validating token');
      final response = await _dio.get(
        APIConstants.validateToken,
        options: Options(
          headers: {
            'auth_token': authToken,
          },
        ),
      );

      _logger.info('Token validated successfully');
      return {
        'status': 'success',
        'data': response.data,
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
      };
    }
  }

  Future<Map<String, dynamic>> sendOTP(String email) async {
    try {
      _logger.info('Sending OTP to $email');
      final response = await _dio.post(
        APIConstants.forgotPassword,
        data: {
          'email': email,
        },
      );

      _logger.info('OTP sent successfully to $email');
      return {
        'status': 'success',
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> validateOTP(String email, String otp) async {
    try {
      _logger.info('Validating OTP for $email');
      final response = await _dio.post(
        APIConstants.validateOTP,
        data: {
          'email': email,
          'otp': otp,
        },
      );

      _logger.info('OTP validated successfully for $email');
      return {
        'status': 'success',
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> resetPassword(
      String email, String password) async {
    try {
      _logger.info('Resetting password for $email');
      final response = await _dio.post(
        APIConstants.resetPassword,
        data: {
          'email': email,
          'password': password,
        },
      );

      _logger.info('Password reset successfully for $email');
      return {
        'status': 'success',
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }
}
