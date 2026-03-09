import 'dart:io';

/// Throws when an encoding error occurs during the media generation process.
class EncodingException implements Exception {
  final String message;

  EncodingException._(this.message);

  factory EncodingException.fromResult(String filename, ProcessResult result) {
    return EncodingException._('Error encoding $filename: ${result.stderr}');
  }
}
