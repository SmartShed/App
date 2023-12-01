import 'package:logger/logger.dart';

export 'package:logger/logger.dart' show Level;

class LoggerService extends Logger {
  static late Level _level;

  static void init([Level level = Level.debug]) {
    _level = level;
  }

  LoggerService._internal({
    LogPrinter? printer,
    Level? level,
  }) : super(
          printer: printer,
          level: level,
        );

  static LoggerService getLogger([String className = 'LoggerService']) {
    return LoggerService._internal(
      printer: Writer(className),
      level: _level,
    );
  }

  void trace(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    t(message, time: time, error: error, stackTrace: stackTrace);
  }

  void debug(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    d(message, time: time, error: error, stackTrace: stackTrace);
  }

  void info(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    i(message, time: time, error: error, stackTrace: stackTrace);
  }

  void warning(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    w(message, time: time, error: error, stackTrace: stackTrace);
  }

  void error(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    e(message, time: time, error: error, stackTrace: stackTrace);
  }

  void fatal(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    f(message, time: time, error: error, stackTrace: stackTrace);
  }
}

class Writer extends LogPrinter {
  final String className;

  Writer(this.className);

  @override
  List<String> log(LogEvent event) {
    final color = PrettyPrinter.defaultLevelColors[event.level];
    final emoji = PrettyPrinter.defaultLevelEmojis[event.level];

    return [color!('$emoji $className - ${event.message}')];
  }
}
