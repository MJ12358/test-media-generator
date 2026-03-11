part of images;

/// {@template test_media_generator.image.PixelFormat}
/// This defines the pixel formats that can be used for encoding images.
/// Pixel formats specify how pixel data is stored and interpreted,
/// which can affect the quality and compatibility of the generated image files.
///
/// https://en.wikipedia.org/wiki/Pixel_format
/// {@endtemplate}
enum PixelFormat {
  /// The RGB24 pixel format, which uses 24 bits per pixel
  /// (8 bits for each of the red, green, and blue channels).
  rgb24('rgb24'),

  /// The RGB48LE pixel format, which uses 48 bits per pixel
  /// (16 bits for each of the red, green, and blue channels) in little-endian.
  rgb48le('rgb48le'),

  /// The RGBA pixel format, which uses 32 bits per pixel
  /// (8 bits for each of the red, green, blue, and alpha channels).
  rgba('rgba');

  /// {@macro test_media_generator.image.PixelFormat}
  const PixelFormat(this.value);

  /// The string value of the pixel format, such as 'rgb24'.
  final String value;
}
