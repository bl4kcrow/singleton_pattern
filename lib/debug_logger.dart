import 'package:flutter/material.dart';
import 'package:logging/logging.dart';
import 'package:intl/intl.dart' show DateFormat;

abstract class BaseLogger {
  @protected
  late Logger _logger;

  @protected
  final DateFormat _dateFormatter = DateFormat('H:m:s.S');
  static const appName = 'singleton_pattern_example';

  void log(
    message, [
    Object? error,
    StackTrace? stackTrace,
  ]) =>
      _logger.info(
        message,
        error,
        stackTrace,
      );
}

class DebugLogger extends BaseLogger {
  static DebugLogger? _instance;

  //* Private constructor
  DebugLogger._internal() {
    Logger.root.level = Level.ALL;
    Logger.root.onRecord.listen(_recordHander);

    _logger = Logger(BaseLogger.appName);
    debugPrint('<DebugLogger> creation');
    _instance = this;
  }

  //* Public factory constructor
  //* Lazy instantation
  factory DebugLogger() => _instance ?? DebugLogger._internal();

  //* Record handler for the logging message content
  //* It is added in the private constructor
  void _recordHander(LogRecord record) {
    debugPrint(
      '${_dateFormatter.format(record.time)}: ${record.message}, ${record.error}',
    );
  }
}
