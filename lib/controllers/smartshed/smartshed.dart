import 'package:smartshed/controllers/toast/toast.dart';

import '../logger/log.dart';

class SmartShedController {
  static final _logger = LoggerService.getLogger('SmartShedController');

  static Future<bool> createSection(String sectionName) async {
    if (sectionName.isEmpty) {
      ToastController.error('Please enter section name');
      _logger.warning('Empty fields detected');
      return false;
    }

    _logger.info('Creating section with sectionName: $sectionName');

    // TODO: Add API call here
    await Future.delayed(const Duration(seconds: 2));

    return true;
  }

  static Future<bool> createForm(
    String sectionName,
    String formTitle,
    String descriptionEnglish,
    String descriptionHindi,
  ) async {
    if (sectionName.isEmpty || formTitle.isEmpty) {
      ToastController.error('Please fill all the fields');
      _logger.warning('Empty fields detected');
      return false;
    }

    _logger.info(
      'Creating form with sectionName: $sectionName, formName: $formTitle, descriptionEnglish: $descriptionEnglish, descriptionHindi: $descriptionHindi',
    );

    // TODO: Add API call here
    await Future.delayed(const Duration(seconds: 2));

    return true;
  }
}
