part of '../images.dart';

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
  rgb24,

  /// The RGB48LE pixel format, which uses 48 bits per pixel
  /// (16 bits for each of the red, green, and blue channels)
  /// in little-endian.
  rgb48le,

  /// The RGBA pixel format, which uses 32 bits per pixel
  /// (8 bits for each of the red, green, blue, and alpha channels).
  rgba,

  /// The RGBA64LE pixel format, which uses 64 bits per pixel
  /// (16 bits for each of the red, green, blue, and alpha channels)
  /// in little-endian.
  rgba64le,

  /// The PAL8 pixel format, which uses 8 bits per pixel
  /// and a separate palette to define the colors.
  /// This format is commonly used for GIF images.
  pal8,

  /// The YUV420P pixel format, which uses 12 bits per pixel
  /// (8 bits for the Y channel and 4 bits for the U and V channels).
  yuv420p,

  /// The YUV422P pixel format, which uses 16 bits per pixel
  /// (8 bits for the Y channel and 8 bits for the U and V channels).
  yuv422p,

  /// The YUV444P pixel format, which uses 24 bits per pixel
  /// (8 bits for each of the Y, U, and V channels).
  yuv444p,

  /// The BGR24 pixel format, which uses 24 bits per pixel
  /// (8 bits for each of the blue, green, and red channels).
  /// This format is commonly used in BMP images.
  bgr24;

  /// {@macro test_media_generator.image.PixelFormat}
  const PixelFormat();
}
