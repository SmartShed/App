import 'package:hive_flutter/hive_flutter.dart';

class XAuthTokenHandler {
  static const _boxName = 'xAuthTokenBox';
  static const _tokenKey = 'xAuthToken';

  static late Box<String> _box;

  static Future<void> init() async {
    await Hive.initFlutter();
    _box = await Hive.openBox<String>(_boxName);
  }

  static String? get token => _box.get(_tokenKey);

  static Future<void> saveToken(String token) async {
    await _box.put(_tokenKey, token);
  }

  static Future<void> deleteToken() async {
    await _box.delete(_tokenKey);
  }

  // static bool get hasToken => _box.containsKey(_tokenKey);

  static Future<bool> get hasToken async {
    await init();
    return _box.containsKey(_tokenKey);
  }
}
