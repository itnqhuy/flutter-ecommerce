import 'package:logger/logger.dart';

class MyLoggerHelper {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(
      methodCount: 2, // số lượng dòng hiển thị từ stack trace
      errorMethodCount: 8,
      lineLength: 120,
      colors: true,
      printEmojis: true,
      dateTimeFormat: DateTimeFormat.onlyTimeAndSinceStart,
    ),
    level: Level.debug, // Mặc định ghi log từ cấp độ debug trở lên
  );

  static void debug(String message) {
    _logger.d(message);
  }

  static void info(String message) {
    _logger.i(message);
  }

  static void warning(String message) {
    _logger.w(message);
  }

  static void error(String message, [dynamic error]) {
    _logger.e(message, error: error, stackTrace: StackTrace.current);
  }

  static void verbose(String message) {
    _logger.t(message);
  }

  static void fatal(String message) {
    _logger.f(message);
  }
}
