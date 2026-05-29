part of 'images.dart';

/// {@template test_media_generator.images.ImageSpec}
/// This class represents the specifications for generating a test image.
/// {@endtemplate}
class ImageSpec {
  /// {@macro test_media_generator.images.Codec}
  final Codec codec;

  /// {@macro test_media_generator.images.Size}
  final Size size;

  /// {@macro test_media_generator.images.PixelFormat}
  final PixelFormat pixelFormat;

  /// {@macro test_media_generator.images.ImageSpec}
  ImageSpec({
    required this.codec,
    required this.size,
    required this.pixelFormat,
  });
}
