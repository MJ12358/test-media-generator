import 'dart:io';

enum Color {
  green('\x1B[32m'),
  yellow('\x1B[33m'),
  red('\x1B[31m'),
  cyan('\x1B[36m'),
  magenta('\x1B[35m'),
  reset('\x1B[0m');

  final String code;
  const Color(this.code);
}

class LoggerService {
  /// Factory constructor to return the same instance.
  factory LoggerService() {
    return _instance;
  }

  /// Private constructor.
  LoggerService._internal();

  /// Singleton instance.
  static final LoggerService _instance = LoggerService._internal();

  /// Whether to show debug logs.
  bool debugMode = false;

  /// Info - Prints with no special formatting.
  void i(String message) {
    _print(message);
  }

  /// Success - Prints in [Color.green] to indicate successful operations.
  void s(String message) {
    _print(message, Color.green);
  }

  /// Warning - Prints in [Color.yellow] to indicate potential issues.
  void w(String message) {
    _print('Warning: $message', Color.yellow);
  }

  /// Error - Prints in [Color.red] to indicate errors.
  void e(String message) {
    _print('Error: $message', Color.red);
  }

  /// Debug - Prints in [Color.cyan] to indicate debug information.
  /// Only shown in debug mode.
  void d(String message) {
    if (debugMode) {
      _print('Debug: $message', Color.cyan);
    }
  }

  /// Fatal - Prints in [Color.magenta] to indicate fatal errors.
  /// StackTrace is optional and only shown in debug mode.
  void f(String message, Object error, [StackTrace? stackTrace]) {
    _print('Fatal: $message', Color.magenta);
    _print('  Details: $error', Color.magenta);
    if (debugMode && stackTrace != null) {
      _print('  Stack trace: $stackTrace', Color.magenta);
    }
  }

  /// Utility to colorize messages.
  void _print(String message, [Color? color]) {
    if (color != null) {
      stdout.writeln('${color.code}$message${Color.reset.code}');
    } else {
      stdout.writeln(message);
    }
  }
}

/// Global access point.
final LoggerService log = LoggerService();
