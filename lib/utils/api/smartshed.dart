import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../../controllers/logger/log.dart';

class SmartShedApiHandler {
  static final _logger = LoggerService.getLogger('SmartShedApiHandler');

  SmartShedApiHandler._internal();
  static final SmartShedApiHandler _smartShedApiHandler =
      SmartShedApiHandler._internal();
  factory SmartShedApiHandler() => _smartShedApiHandler;

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> addSection(String name) async {
    try {
      _logger.info('Calling addSection API with name: $name');
      final response = await _dio.post(
        APIConstants.addSection,
        data: {
          'name': name,
        },
      );

      return {
        'status': 'success',
        'message': response.data['message'],
        'section': response.data['section'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> addForm(
    String title,
    String descriptionHindi,
    String descriptionEnglish,
    String sectionName,
  ) async {
    try {
      _logger.info('Calling addForm API with title: $title');
      final response = await _dio.post(
        APIConstants.addForm,
        data: {
          'title': title,
          'descriptionHindi': descriptionHindi,
          'descriptionEnglish': descriptionEnglish,
          'sectionName': sectionName,
        },
      );

      return {
        'status': 'success',
        'message': response.data['message'],
        'form': response.data['form'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> addSubForm(
    String titleHindi,
    String titleEnglish,
    String note,
    String formID,
  ) async {
    try {
      _logger.info('Calling addSubForm API with title: $titleHindi');
      final response = await _dio.post(
        APIConstants.addSubForm,
        data: {
          'titleHindi': titleHindi,
          'titleEnglish': titleEnglish,
          'note': note,
          'formID': formID,
        },
      );

      return {
        'status': 'success',
        'message': response.data['message'],
        'subForm': response.data['subForm'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
        'message': e.response!.data['message'],
      };
    }
  }

  Future<Map<String, dynamic>> addQuestion(
    String textEnglish,
    String textHindi,
    String ansType,
    bool isForSubForm,
    String id,
  ) async {
    try {
      _logger.info('Calling addQuestion API with text: $textEnglish');
      final response = await _dio.post(
        APIConstants.addQuestion,
        data: {
          'textEnglish': textEnglish,
          'textHindi': textHindi,
          'ansType': ansType,
          isForSubForm ? 'subFormID' : 'formID': id,
        },
      );

      return {
        'status': 'success',
        'message': response.data['message'],
        'question': response.data['question'],
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
