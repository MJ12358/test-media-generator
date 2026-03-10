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
  List<String> get tuning => <String>['-b:v', '0', '-crf', '32'];
}
