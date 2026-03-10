part of video;

/// {@template test_media_generator.VP9}
/// This defines the VP9 video codec, which is an open and royalty-free
/// video coding format developed by Google.
///
/// https://en.wikipedia.org/wiki/VP9
///
/// https://trac.ffmpeg.org/wiki/Encode/VP9
/// {@endtemplate}
class VP9 extends Codec {
  /// {@macro test_media_generator.VP9}
  VP9();

  @override
  String get name => 'vp9';

  @override
  String get extension => 'webm';

  @override
  String get audio => 'libopus';

  @override
  /// Vaapi does not support encoding of VP9.
  List<FrameRate> get framerates {
    if (VideoGenerator.backend is Vaapi) {
      return <FrameRate>[];
    } else {
      return super.framerates;
    }
  }

  @override
  /// Vaapi does not support encoding of VP9.
  List<PixelFormat> get pixelFormats {
    if (VideoGenerator.backend is Vaapi) {
      return <PixelFormat>[];
    } else {
      return super.pixelFormats;
    }
  }

  @override
  /// Vaapi does not support encoding of VP9.
  List<Size> get sizes {
    if (VideoGenerator.backend is Vaapi) {
      return <Size>[];
    } else {
      return super.sizes;
    }
  }

  @override
  List<String> get tuning => <String>['-b:v', '0', '-crf', '32'];
}
