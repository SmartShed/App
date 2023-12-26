import 'package:flutter_localization/flutter_localization.dart';

import '../../utils/cache/settings.dart';
import '../../views/localization/locals.dart';
import '../logger/log.dart';

class UserSettingsController {
  static final _logger = LoggerService.getLogger('UserSettingsController');

  static late FlutterLocalization _flutterLocalization;

  static final List<String> _dateFormatList = [
    'dd MMM yyyy', // 01 Jan 2024
    'dd-MM-yyyy', // 01-01-2024
    'dd/MM/yyyy', // 01/01/2024
    'dd MMMM yyyy', // 01 January 2024
    'dd-MMMM-yyyy', // 01-January-2024
    'dd/MMMM/yyyy', // 01/January/2024
    'dd MMM yy', // 01 Jan 24
    'dd-MM-yy', // 01-01-24
    'dd/MM/yy', // 01/01/24
    'dd MMMM yy', // 01 January 24
    'dd-MMMM-yy', // 01-January-24
    'dd/MMMM/yy', // 01/January/24
  ];

  static final List<String> _timeFormatList = [
    'HH:mm', // 24:00
    'hh:mm a', // 12:00 AM
  ];

  static final List<String> _languageList = [
    'English', // English
    'हिन्दी', // Hindi
  ];

  static final Map<String, String> _languageMap = {
    _languageList[0]: Locale.en,
    _languageList[1]: Locale.hi,
  };

  static Future<void> init() async {
    await UserSettingsCacheHandler.init();
    _flutterLocalization = FlutterLocalization.instance;
    _flutterLocalization.init(mapLocales: LOCALES, initLanguageCode: "en");
  }

  static void setSetState(void Function(void Function()) setState) {
    _flutterLocalization.onTranslatedLanguage = (_) => setState(() {});
    _flutterLocalization.translate(languageCode);
  }

  static String get dateFormat {
    _logger.info('Getting date format');
    return UserSettingsCacheHandler.dateFormat ?? _dateFormatList[0];
  }

  static String get timeFormat {
    _logger.info('Getting time format');
    return UserSettingsCacheHandler.timeFormat ?? _timeFormatList[0];
  }

  static String get dateTimeFormat {
    _logger.info('Getting date time format');
    return '$dateFormat $timeFormat';
  }

  static String get language {
    _logger.info('Getting language');
    return UserSettingsCacheHandler.language ?? _languageList[0];
  }

  static String get languageCode {
    _logger.info('Getting language code');
    return _languageMap[language] ?? Locale.en;
  }

  static Future<void> saveDateFormat(String dateFormat) async {
    await UserSettingsCacheHandler.saveDateFormat(dateFormat);
    _logger.info('Date format saved');
  }

  static Future<void> saveTimeFormat(String timeFormat) async {
    await UserSettingsCacheHandler.saveTimeFormat(timeFormat);
    _logger.info('Time format saved');
  }

  static Future<void> saveLanguage(String language) async {
    await UserSettingsCacheHandler.saveLanguage(language);
    _flutterLocalization.translate(_languageMap[language] ?? Locale.en);
    _logger.info('Language saved');
  }

  static List<String> get dateFormatList {
    _logger.info('Getting date format list');
    return _dateFormatList;
  }

  static List<String> get timeFormatList {
    _logger.info('Getting time format list');
    return _timeFormatList;
  }

  static List<String> get languageList {
    _logger.info('Getting language list');
    return _languageList;
  }

  static Future<void> reset() async {
    await UserSettingsCacheHandler.reset();
    _flutterLocalization.translate(Locale.en);
    _logger.info('User settings reset');
  }
}
