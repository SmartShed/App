import 'package:envied/envied.dart';

part 'env.g.dart';

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
