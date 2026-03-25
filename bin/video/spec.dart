part of video;

/// {@template test_media_generator.video.VideoSpec}
/// This class represents the specifications for generating a test video.
/// {@endtemplate}
class VideoSpec {
  final Codec codec;
  final Size size;
  final FrameRate frameRate;
  final PixelFormat pixelFormat;

  /// {@macro test_media_generator.video.VideoSpec}
  VideoSpec({
    required this.codec,
    required this.size,
    required this.frameRate,
    required this.pixelFormat,
  });
}
