part of '../images.dart';

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

  @override
  List<PixelFormat> get pixelFormats => <PixelFormat>[
    PixelFormat.rgb24,
    PixelFormat.bgr24,
  ];

  @override
  /// BMP is an uncompressed format, so we use very low resolutions
  /// to keep file sizes manageable.
  List<Size> get sizes => <Size>[Size.s256, Size.s512, Size.s1080, Size.s1080v];
}
