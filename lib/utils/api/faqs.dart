import 'package:dio/dio.dart';

import '../../constants/api.dart';
import '../../controllers/auth/login.dart';
import '../../controllers/logger/log.dart';

class FaqsApiHandler {
  static final _logger = LoggerService.getLogger('FaqsApiHandler');

  FaqsApiHandler._internal();
  static final FaqsApiHandler _faqsApiHandler = FaqsApiHandler._internal();
  factory FaqsApiHandler() => _faqsApiHandler;

  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getFaqs() async {
    try {
      _logger.info('Getting FAQs');
      final response = await _dio.get(
        APIConstants.getFaqs
            .replaceAll(':position', LoginController.user!.position),
      );

      _logger.info('FAQs retrieved successfully');

      return {
        'status': 'success',
        'faqs': response.data['faqs'],
      };
    } on DioException catch (e) {
      _logger.error(e);
      return {
        'status': 'error',
      };
    }
  }
}
