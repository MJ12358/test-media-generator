import 'dart:io';

import 'package:dart_logz/dart_logz.dart';

import 'command.dart';
import 'encoding_exception.dart';

/// {@template test_media_generator.Generator}
/// This defines the abstract base class [Generator],
/// which serves as a blueprint for specific media generator implementations.
/// {@endtemplate}
abstract class Generator<T> {
  /// {@macro test_media_generator.Generator}
  Generator({required this.outputDir}) {
    Directory(outputDir).createSync(recursive: true);
  }

  /// The output directory where generated media files will be saved.
  final String outputDir;

  /// Returns the file name for the given specification.
  String getFilename(T spec);

  /// Gets the command to generate the media file based on the specification.
  Command getCommand(T spec, String outputPath, String filename);

  /// Generates the media files based on the defined configuration.
  Future<void> generate();

  /// Encodes a media file based on the provided specification.
  Future<void> encode(T spec) async {
    final String filename = getFilename(spec);
    final String outputPath = '$outputDir/$filename';

    if (File(outputPath).existsSync()) {
      logz.w('Skipping (exists): $filename');
      return;
    }

    try {
      final Command cmd = getCommand(spec, outputPath, filename);
      logz.i('Encoding: $filename');
      await cmd.run(filename);
    } on EncodingException catch (e) {
      logz.e(e.message);
    } catch (e) {
      logz.e('Unknown Exception: $filename: $e');
    } finally {
      _cleanup(outputPath, filename);
    }
  }

  /// Cleans up any invalid output files that may have been
  /// created during the encoding process.
  void _cleanup(String outputPath, String filename) {
    final File file = File(outputPath);
    if (file.existsSync() && file.lengthSync() == 0) {
      logz.w('Cleaning up invalid output file: $filename');
      file.deleteSync();
    }
  }
}
