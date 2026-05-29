part of 'video.dart';

/// {@template test_media_generator.video.VideoSpec}
/// This class represents the specifications for generating a test video.
/// {@endtemplate}
class VideoSpec {
  /// {@macro test_media_generator.video.Codec}
  final Codec codec;

  /// {@macro test_media_generator.video.Size}
  final Size size;

  /// {@macro test_media_generator.video.FrameRate}
  final FrameRate frameRate;

  /// {@macro test_media_generator.video.PixelFormat}
  final PixelFormat pixelFormat;

  /// {@macro test_media_generator.video.VideoSpec}
  VideoSpec({
    required this.codec,
    required this.size,
    required this.frameRate,
    required this.pixelFormat,
  });
}
