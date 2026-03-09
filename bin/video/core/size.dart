part of video;

/// A collection of predefined sizes for generating test video files.
/// Each size is represented by a friendly name (e.g., '1080p')
/// and its corresponding dimensions (e.g., '1920x1080').
///
/// https://en.wikipedia.org/wiki/Image_resolution
enum Size {
  /// 140p resolution, typically used for very low-quality video.
  s140('140p', '256x144'),

  /// 360p resolution, commonly used for low-quality streaming video.
  s360('360p', '640x360'),

  /// 720p resolution, commonly used for HD video.
  s720('720p', '1280x720'),

  /// 1080p resolution, commonly used for Full HD video.
  s1080('1080p', '1920x1080'),

  /// 1440p resolution, commonly used for Quad HD video.
  s1440('1440p', '2560x1440'),

  /// 2160p resolution, commonly used for 4K video.
  s2160('2160p', '3840x2160'),

  /// 4320p resolution, commonly used for 8K video.
  s4320('4320p', '7680x4320');

  const Size(this.name, this.value);

  /// The friendly name of the size, such as '1080p'.
  final String name;

  /// The actual dimensions of the size, represented as a string.
  final String value;
}
