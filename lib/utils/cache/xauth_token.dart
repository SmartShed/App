import 'package:hive_flutter/hive_flutter.dart';

import '../../controllers/logger/log.dart';

class XAuthTokenHandler {
  static final _logger = LoggerService.getLogger('XAuthTokenHandler');

  static const _boxName = 'xAuthTokenBox';
  static const _tokenKey = 'xAuthToken';

  static late Box<String> _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<String>(_boxName);
    _logger.info('XAuthTokenHandler initialized');
  }

  static String? get token {
    _logger.info('Getting token');
    return _box.get(_tokenKey);
  }

  static Future<void> saveToken(String token) async {
    await XAuthTokenHandler.init();
    await _box.put(_tokenKey, token);
    _logger.info('Token saved');
  }

  static Future<void> deleteToken() async {
    await init();
    await _box.delete(_tokenKey);
    _logger.info('Token deleted');
  }

  static Future<bool> get hasToken async {
    await init();
    final hasToken = _box.containsKey(_tokenKey);
    _logger.info('Has token: $hasToken');
    return hasToken;
  }
}
