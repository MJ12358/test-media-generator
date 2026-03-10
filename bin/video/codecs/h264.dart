part of video;

/// {@template test_media_generator.H264}
/// This defines the H264 video codec, which is a widely used video coding
/// format known for its high compression efficiency and broad compatibility.
///
/// https://en.wikipedia.org/wiki/Advanced_Video_Coding
/// {@endtemplate}
class H264 extends Codec {
  /// {@macro test_media_generator.H264}
  H264();

  @override
  String get name => 'h264';

  @override
  String get extension => 'mp4';

  @override
  String get audio => 'aac';

  @override
  /// H264 is a highly efficient codec, so we can generate higher resolutions.
  /// However, NVENC encoder has some limitations on supported resolutions.
  List<Size> get sizes {
    if (VideoGenerator.backend is Nvidia) {
      return <Size>[
        Size.s140,
        Size.s360,
        Size.s720,
        Size.s1080,
        Size.s1440,
        Size.s2160,
      ];
    } else {
      return super.sizes;
    }
  }

  @override
  List<String> get tuning => <String>['-crf', '23'];
}
