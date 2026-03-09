part of images;

/// {@template test_media_generator.BMP}
/// This defines the BMP image codec,
/// which is a simple raster graphics image format
/// that has been widely used in the past.
///
/// https://en.wikipedia.org/wiki/BMP_file_format
/// {@endtemplate}
class BMP extends Codec {
  /// {@macro test_media_generator.BMP}
  BMP();

  @override
  String get name => 'bmp';

  @override
  String get extension => 'bmp';
}
