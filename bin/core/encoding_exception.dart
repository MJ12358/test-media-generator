import 'dart:io';

/// Throws when an encoding error occurs during the media generation process.
class EncodingException implements Exception {
  final String message;

  EncodingException._(this.message);

  /// Creates an [EncodingException] from a
  /// [ProcessResult] of a failed encoding command.
  factory EncodingException.fromResult(String filename, ProcessResult result) {
    return EncodingException._(
      'Encoding Exception: $filename\n${_formatResult(result)}',
    );
  }

  /// Formats the error message from the [ProcessResult] to extract
  /// relevant information while removing unnecessary details.
  static String _formatResult(ProcessResult result) {
    String e = result.stderr.toString();

    // Normalize line endings
    e = e.replaceAll('\r\n', '\n');

    // Find where the "real" output starts
    final int startIndex = _findStart(e);

    // If we found a starting point, trim the message to start from there
    if (startIndex != -1) {
      e = e.substring(startIndex);
    }

    // Optional: remove noisy progress lines like "size= ..."
    e = e.replaceAll(RegExp(r'^size=.*$', multiLine: true), '');

    e = e.trim();

    if (e.isEmpty) {
      e = 'Unknown error occurred during encoding';
    }

    return e;
  }

  /// Finds the starting index of the relevant
  /// error message in the FFmpeg output.
  static int _findStart(String e) {
    final List<RegExp> patterns = <RegExp>[
      RegExp('^Input #', multiLine: true),
      RegExp('^Stream mapping:', multiLine: true),
      RegExp(r'^\[.+?\]', multiLine: true), // [aac @ ...] style errors
      RegExp('^Error', multiLine: true),
    ];

    for (final RegExp pattern in patterns) {
      final RegExpMatch? match = pattern.firstMatch(e);
      if (match != null) {
        return match.start;
      }
    }

    return -1;
  }
}
