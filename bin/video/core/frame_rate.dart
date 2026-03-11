part of video;

/// {@template test_media_generator.video.FrameRate}
/// This defines the various frame rates used in video processing.
/// Frame rate refers to the number of frames displayed per second (fps)
///
/// https://en.wikipedia.org/wiki/Frame_rate
/// {@endtemplate}
enum FrameRate {
  /// 24 frames per second is the standard for
  /// film and cinematic content.
  fr24(24),

  /// 30 frames per second is common for
  /// television and online video content.
  fr30(30),

  /// 60 frames per second is used for
  /// high-motion content such as sports and gaming.
  fr60(60);

  /// {@macro test_media_generator.video.FrameRate}
  const FrameRate(this.value);

  /// The friendly name of the frame rate, such as '30fps'.
  String get name {
    return '${value}fps';
  }

  /// The integer value of the frame rate in frames per second.
  final int value;
}
