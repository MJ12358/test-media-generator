part of images;

/// {@template test_media_generator.image.Size}
/// A collection of predefined sizes for generating test image files.
/// Each size is represented by its actual dimensions (e.g., '1920x1080').
///
/// https://en.wikipedia.org/wiki/Image_resolution
/// {@endtemplate}
enum Size {
  /// The smallest possible size.
  s1('1x1'),

  /// A common thumbnail size.
  s16('16x16'),

  /// A common size for small images and icons.
  s256('256x256'),

  /// A common size for medium-resolution images.
  s512('512x512'),

  /// A common size for high-resolution images and wallpapers.
  s1080('1920x1080'),

  /// A common size for 4K images.
  s2160('3840x2160'),

  /// A common size for 8K images.
  s4320('7680x4320'),

  /// A size with odd / prime dimensions to test edge cases.
  odd('257x509'),

  /// A size with an extreme aspect ratio to test edge cases.
  extreme('4096x256');

  /// {@macro test_media_generator.image.Size}
  const Size(this.value);

  /// The actual dimensions of the size, represented as a string.
  final String value;
}
