part of images;

/// {@template test_media_generator.images.ImageSpec}
/// This class represents the specifications for generating a test image.
/// {@endtemplate}
class ImageSpec {
  final Codec codec;
  final Size size;
  final PixelFormat pixelFormat;

  /// {@macro test_media_generator.images.ImageSpec}
  ImageSpec({
    required this.codec,
    required this.size,
    required this.pixelFormat,
  });
}
