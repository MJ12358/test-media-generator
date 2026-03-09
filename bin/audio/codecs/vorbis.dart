part of audio;

/// {@template test_media_generator.Vorbis}
/// This defines the Vorbis audio codec,
/// which is a widely used lossy audio format.
///
/// https://en.wikipedia.org/wiki/Vorbis
/// {@endtemplate}
class Vorbis extends Codec {
  /// {@macro test_media_generator.Vorbis}
  Vorbis();

  @override
  String get name => 'vorbis';

  @override
  String get extension => 'ogg';

  @override
  String get encoder => 'libvorbis';

  @override
  List<BitDepth> get bitDepths => <BitDepth>[
    BitDepth.bd16,
    BitDepth.bd24,
    BitDepth.bd32,
  ];

  @override
  List<String> get encoderFlags => <String>['-q:a', '5'];
}
