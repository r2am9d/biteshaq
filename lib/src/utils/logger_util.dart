import 'package:logger/logger.dart';

class LoggerUtil {
  factory LoggerUtil() => _instance;

  LoggerUtil._internal();

  static final LoggerUtil _instance = LoggerUtil._internal();

  final Logger _logger = Logger(printer: PrettyPrinter(printEmojis: false));

  void debug(dynamic message) {
    _logger.wtf(message);
  }

  void warning(dynamic message) {
    _logger.w(message);
  }

  void error(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error, stackTrace);
  }
}
