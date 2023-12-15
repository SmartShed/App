import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../../controllers/logger/log.dart';

class EmployeesAPIHandler {
  static final _logger = LoggerService.getLogger('EmployeesAPIHandler');

  EmployeesAPIHandler._internal();
  static final EmployeesAPIHandler _positionAPIHandler =
      EmployeesAPIHandler._internal();
  factory EmployeesAPIHandler() => _positionAPIHandler;

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> addEmployees(List<List<String>> emails) async {
    try {
      _logger.info('Adding employees');
      final response = await _dio.post(
        APIConstants.employees,
        data: {
          'authority': emails[0],
          'supervisor': emails[1],
          'worker': emails[2],
        },
      );

      _logger.info('Employees added successfully');
      return {
        'status': 'success',
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      _logger.error('Error adding employees');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> getEmployees() async {
    try {
      _logger.info('Getting employees');
      final response = await _dio.get(
        APIConstants.employees,
      );

      _logger.info('Employees retrieved successfully');
      return {
        'status': 'success',
        'message': response.data['message'],
        'employees': response.data['employees'],
      };
    } on DioException catch (e) {
      _logger.error('Error getting employees');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> getEmployeesFromGoogleSheet() async {
    try {
      _logger.info('Getting employees from Google Sheet');
      final response = await _dio.get(
        APIConstants.getEmployeesFromGoogleSheet,
      );

      _logger.info('Employees retrieved successfully');
      return {
        'status': 'success',
        'message': 'Employees retrieved successfully',
        'employees': response.data['values'],
      };
    } on DioException {
      _logger.error('Error getting employees from Google Sheet');
      return {
        'status': 'error',
        'message': 'Error getting employees from Google Sheet',
      };
    }
  }

  Future<Map<String, dynamic>> getUsers({String? position}) async {
    try {
      _logger.info('Getting users');
      final response = await _dio.get(
        APIConstants.getUsers,
        queryParameters: {
          'position': position,
        },
      );

      _logger.info('Users retrieved successfully');
      return {
        'status': 'success',
        'message': response.data['message'],
        'users': response.data['users'],
      };
    } on DioException catch (e) {
      _logger.error('Error getting users');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> deleteUsers(List<String> userIds) async {
    try {
      _logger.info('Deleting users');
      final response = await _dio.post(
        APIConstants.deleteUsers,
        data: {
          'users': userIds,
        },
      );

      _logger.info('Users deleted successfully');
      return {
        'status': 'success',
        'message': response.data['message'],
      };
    } on DioException catch (e) {
      _logger.error('Error deleting users');
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }
}
