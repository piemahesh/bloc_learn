// lib/utils/app_logger.dart

import 'package:logger/logger.dart';
import 'package:flutter/foundation.dart';

class AppLogger {
  // Private static instance of Logger
  static final Logger _logger = Logger(
    level: kReleaseMode ? Level.warning : Level.debug,
    printer: PrettyPrinter(
      methodCount: 2,
      errorMethodCount: 5,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      printTime: true,
    ),
  );

  // Static methods for different log levels:

  static void d(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.d(message, error: error, stackTrace: stackTrace);
  }

  static void i(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.i(message, error: error, stackTrace: stackTrace);
  }

  static void w(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.w(message, error: error, stackTrace: stackTrace);
  }

  static void e(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.e(message, error: error, stackTrace: stackTrace);
  }

  static void v(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.v(message, error: error, stackTrace: stackTrace);
  }

  static void wtf(dynamic message, [dynamic error, StackTrace? stackTrace]) {
    _logger.wtf(message, error: error, stackTrace: stackTrace);
  }
}
