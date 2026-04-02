part of images;

/// {@template test_media_generator.image.Size}
/// A collection of predefined sizes for generating test image files.
/// Each size is represented by its actual dimensions (e.g., '1920x1080').
///
/// https://en.wikipedia.org/wiki/Image_resolution
/// {@endtemplate}
enum Size {
  /// A common size for small images and icons.
  s256(256, 256),

  /// A common size for medium-resolution images.
  s512(512, 512),

  /// A common size for high-resolution images and wallpapers.
  s1080(1920, 1080),

  /// A common size for portrait-oriented images.
  s1080v(1080, 1920),

  /// A common size for 4K images.
  s2160(3840, 2160),

  /// A common size for 4K portrait-oriented images.
  s2160v(2160, 3840),

  /// A common size for 8K images.
  s4320(7680, 4320),

  /// A common size for 8K portrait-oriented images.
  s4320v(4320, 7680),

  /// A size with odd / prime dimensions to test edge cases.
  odd(257, 509),

  /// A size with odd / prime dimensions in portrait orientation
  /// to test edge cases.
  oddv(509, 257),

  /// A size with an extreme aspect ratio to test edge cases.
  extreme(4096, 256),

  /// A size with an extreme aspect ratio in portrait orientation
  /// to test edge cases.
  extremev(256, 4096);

  /// {@macro test_media_generator.image.Size}
  const Size(this.width, this.height);

  /// The width of the image in pixels.
  final int width;

  /// The height of the image in pixels.
  final int height;

  /// The actual dimensions of the size, represented as a string.
  String get label => '${width}x$height';
}
