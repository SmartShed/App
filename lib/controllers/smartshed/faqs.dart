import '../../models/faq.dart';
import '../../utils/api/faqs.dart';
import '../logger/log.dart';

class FaqHandler {
  static final _logger = LoggerService.getLogger('FaqHandler');

  static final _faqsApiHandler = FaqsApiHandler();

  static Future<List<SmartShedFAQ>?> getFaqs() async {
    _logger.info('Getting FAQs');

    final response = await _faqsApiHandler.getFaqs();

    if (response['status'] == 'success') {
      final faqs = response['faqs'] as List<dynamic>;
      final faqList = faqs.map((faq) => SmartShedFAQ.fromJson(faq)).toList();
      return faqList;
    }

    return null;
  }
}
