import 'package:envied/envied.dart';

part 'env.g.dart';

// class EnvController {
//   static final _logger = LoggerService.getLogger('EnvController');

//   static Future<void> init() async {
//     await dotenv.load(fileName: ".env");
//   }

//   static String getEnv(String key) {
//     String? value = dotenv.env[key];
//     if (value == null) {
//       _logger.error('Environment variable $key not found');
//       return '';
//     }
//     return value;
//   }

//   static String getDefaultBackendUrl() {
//     return getEnv('DEFAULT_BACKEND_URL');
//   }
// }

@Envied(path: '.env', useConstantCase: true)
abstract class Env {
  @EnviedField(obfuscate: true)
  static final String defaultBackendUrl = _Env.defaultBackendUrl;

  @EnviedField(obfuscate: true)
  static final String googleSignInClientId = _Env.googleSignInClientId;

  @EnviedField(obfuscate: true)
  static final String googleClientId = _Env.googleClientId;

  @EnviedField(obfuscate: true)
  static final String googleClientEmail = _Env.googleClientEmail;

  @EnviedField(obfuscate: true)
  static final String googlePrivateKey = _Env.googlePrivateKey;

  @EnviedField(obfuscate: true)
  static final String employeeSheetId = _Env.employeeSheetId;

  @EnviedField(obfuscate: true)
  static final String urlsSheetId = _Env.urlsSheetId;
}
