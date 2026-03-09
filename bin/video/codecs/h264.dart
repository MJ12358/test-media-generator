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
  List<String> get tuning => <String>['-crf', '23'];
}
