part of video;

/// {@template test_media_generator.H265}
/// This defines the H265 video codec, which is a successor to H264 and offers
/// improved compression efficiency, especially for high-resolution video.
///
/// https://en.wikipedia.org/wiki/High_Efficiency_Video_Coding
/// {@endtemplate}
class H265 extends Codec {
  /// {@macro test_media_generator.H265}
  H265();

  @override
  String get name => 'h265';

  @override
  String get extension => 'mp4';

  @override
  String get audio => 'aac';

  @override
  List<String> get tuning => <String>['-crf', '28', '-tag:v', 'hvc1'];
}
