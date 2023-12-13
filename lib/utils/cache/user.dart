import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../../controllers/logger/log.dart';
import '../../models/user.dart';

class UserCacheHandler {
  static final _logger = LoggerService.getLogger('UserCacheHandler');

  static const _boxName = 'userBox';
  static const _userKey = 'user';

  static late Box<SmartShedUser> _box;

  static Future<void> init() async {
    String path = '';
    if (kIsWeb) {
      path = 'userBox';
    } else {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      path = appDocumentDir.path;
    }
    Hive.init(path);
    Hive.registerAdapter(SmartShedUserAdapter());
    _box = await Hive.openBox<SmartShedUser>(_boxName);
    _logger.info('UserCacheHandler initialized');
  }

  static SmartShedUser? get user {
    _logger.info('Getting user');
    return _box.get(_userKey);
  }

  static Future<void> saveUser(SmartShedUser user) async {
    await _box.put(_userKey, user);
    _logger.info('User saved');
  }

  static Future<void> saveUserFromJson(Map<String, dynamic> userJson) async {
    SmartShedUser user = SmartShedUser.fromJson(userJson);

    await _box.put(_userKey, user);
    _logger.info('User saved');
  }

  static Future<void> deleteUser() async {
    await _box.delete(_userKey);
    _logger.info('User deleted');
  }

  static Future<bool> get hasUser async {
    final hasUser = _box.containsKey(_userKey);
    _logger.info('Has user: $hasUser');
    return hasUser;
  }
}
