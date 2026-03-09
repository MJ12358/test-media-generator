part of video;

/// This defines the pixel formats that can be used for encoding video frames.
/// Pixel formats specify how pixel data is stored and interpreted,
/// which can affect the quality and compatibility of the generated video files.
///
/// https://en.wikipedia.org/wiki/Pixel_format
enum PixelFormat {
  /// The YUV420P pixel format, which uses 12 bits per pixel
  /// (8 bits for the Y channel and 4 bits for the U and V channels).
  yuv420p('yuv420p'),

  /// The YUV422P pixel format, which uses 16 bits per pixel
  /// (8 bits for the Y channel and 8 bits for the U and V channels).
  yuv422p('yuv422p'),

  /// The YUV444P pixel format, which uses 24 bits per pixel
  /// (8 bits for each of the Y, U, and V channels).
  yuv444p('yuv444p'),

  /// The YUVJ420P pixel format, which is similar to YUV420P but uses
  /// full range (0-255) for the Y, U, and V channels instead
  /// of the limited range (16-235 for Y and 16-240 for U and V).
  yuvj420p('yuvj420p'),

  /// The YUVJ422P pixel format, which is similar to YUV422P but uses
  /// full range (0-255) for the Y, U, and V channels instead
  /// of the limited range (16-235 for Y and 16-240 for U and V).
  yuvj422p('yuvj422p'),

  /// The YUVJ444P pixel format, which is similar to YUV444P but uses
  /// full range (0-255) for the Y, U, and V channels instead
  /// of the limited range (16-235 for Y and 16-240 for U and V).
  yuvj444p('yuvj444p');

  const PixelFormat(this.value);

  final String value;
}
