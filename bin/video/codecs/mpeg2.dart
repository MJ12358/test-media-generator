part of video;

/// {@template test_media_generator.MPEG2}
/// This defines the MPEG2 video codec, which is a widely used video coding
/// format that was popular for DVDs and digital television broadcasting.
///
/// https://en.wikipedia.org/wiki/MPEG-2
/// {@endtemplate}
class MPEG2 extends Codec {
  /// {@macro test_media_generator.MPEG2}
  MPEG2();

  @override
  String get name => 'mpeg2';

  @override
  String get extension => 'mpg';

  @override
  String get audio => 'mp2';

  @override
  List<String> get tuning => <String>[
    '-b:v',
    '8M',
    '-minrate',
    '8M',
    '-maxrate',
    '8M',
    '-bufsize',
    '1835k',
    '-g',
    '15',
  ];
}
