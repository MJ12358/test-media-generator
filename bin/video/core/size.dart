part of video;

/// {@template test_media_generator.video.Size}
/// A collection of predefined sizes for generating test video files.
/// Each size is represented by a friendly name (e.g., '1080p')
/// and its corresponding dimensions (e.g., '1920x1080').
///
/// https://en.wikipedia.org/wiki/Display_resolution
/// {@endtemplate}
enum Size {
  /// 140p resolution, typically used for very low-quality video.
  s140(256, 144),

  /// 140p resolution with vertical orientation,
  /// typically used for very low-quality video.
  s140v(144, 256),

  /// 360p resolution, commonly used for low-quality streaming video.
  s360(640, 360),

  /// 360p resolution with vertical orientation,
  /// commonly used for low-quality streaming video.
  s360v(360, 640),

  /// 720p resolution, commonly used for HD video.
  s720(1280, 720),

  /// 720p resolution with vertical orientation,
  /// commonly used for HD video.
  s720v(720, 1280),

  /// 1080p resolution, commonly used for Full HD video.
  s1080(1920, 1080),

  /// 1080p resolution with vertical orientation,
  /// commonly used for Full HD video.
  s1080v(1080, 1920),

  /// 1440p resolution, commonly used for Quad HD video.
  s1440(2560, 1440),

  /// 1440p resolution with vertical orientation,
  /// commonly used for Quad HD video.
  s1440v(1440, 2560),

  /// 2160p resolution, commonly used for 4K video.
  s2160(3840, 2160),

  /// 2160p resolution with vertical orientation,
  /// commonly used for 4K video.
  s2160v(2160, 3840),

  /// 4320p resolution, commonly used for 8K video.
  s4320(7680, 4320),

  /// 4320p resolution with vertical orientation,
  /// commonly used for 8K video.
  s4320v(4320, 7680);

  /// {@macro test_media_generator.video.Size}
  const Size(this.width, this.height);

  /// The width of the video in pixels.
  final int width;

  /// The height of the video in pixels.
  final int height;

  /// The actual dimensions of the size, represented as a string.
  String get label => '${width}x$height';
}
