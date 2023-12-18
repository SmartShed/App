import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../logger/log.dart';

class EnvController {
  static final _logger = LoggerService.getLogger('EnvController');

  static Future<void> init() async {
    await dotenv.load(fileName: ".env");
  }

  static String getEnv(String key) {
    String? value = dotenv.env[key];
    if (value == null) {
      _logger.error('Environment variable $key not found');
      return '';
    }
    return value;
  }

  static String getDefaultBackendUrl() {
    return getEnv('DEFAULT_BACKEND_URL');
  }
}
