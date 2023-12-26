import 'package:hive_flutter/hive_flutter.dart';

import '../../controllers/logger/log.dart';

class UserSettingsCacheHandler {
  static final _logger = LoggerService.getLogger('UserSettingsCacheHandler');

  static const _dateFormatBoxName = 'dateFormatBox';
  static const _dateFormatKey = 'dateFormat';

  static const _timeFormatBoxName = 'timeFormatBox';
  static const _timeFormatKey = 'timeFormat';

  static const _languageBoxName = 'languageBox';
  static const _languageKey = 'language';

  static late Box<String> _dateFormatBox;
  static late Box<String> _timeFormatBox;
  static late Box<String> _languageBox;

  static Future<void> init() async {
    await Hive.initFlutter();
    _dateFormatBox = await Hive.openBox<String>(_dateFormatBoxName);
    _timeFormatBox = await Hive.openBox<String>(_timeFormatBoxName);
    _languageBox = await Hive.openBox<String>(_languageBoxName);
    _logger.info('UserSettingsCacheHandler initialized');
  }

  static String? get dateFormat {
    _logger.info('Getting date format');
    return _dateFormatBox.get(_dateFormatKey);
  }

  static String? get timeFormat {
    _logger.info('Getting time format');
    return _timeFormatBox.get(_timeFormatKey);
  }

  static String? get language {
    _logger.info('Getting language');
    return _languageBox.get(_languageKey);
  }

  static Future<void> saveDateFormat(String dateFormat) async {
    await UserSettingsCacheHandler.init();
    await _dateFormatBox.put(_dateFormatKey, dateFormat);
    _logger.info('Date format saved');
  }

  static Future<void> saveTimeFormat(String timeFormat) async {
    await UserSettingsCacheHandler.init();
    await _timeFormatBox.put(_timeFormatKey, timeFormat);
    _logger.info('Time format saved');
  }

  static Future<void> saveLanguage(String language) async {
    await UserSettingsCacheHandler.init();
    await _languageBox.put(_languageKey, language);
    _logger.info('Language saved');
  }

  static Future<void> reset() async {
    await _dateFormatBox.clear();
    await _timeFormatBox.clear();
    await _languageBox.clear();
    _logger.info('User settings cache cleared');
  }
}
