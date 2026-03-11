import 'dart:io';

/// {@template test_media_generator.Generator}
/// This defines the abstract base class [Generator],
/// which serves as a blueprint for specific media generator implementations.
/// {@endtemplate}
abstract class Generator {
  /// {@macro test_media_generator.Generator}
  Generator({required this.outputDir}) {
    Directory(outputDir).createSync(recursive: true);
  }

  /// The output directory where generated media files will be saved.
  final String outputDir;

  /// Generates the media files based on the defined configuration.
  Future<void> generate();
}
