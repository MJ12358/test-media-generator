part of audio;

/// {@template test_media_generator.AAC}
/// This defines the AAC audio codec,
/// which is a widely used lossy audio format.
///
/// https://en.wikipedia.org/wiki/Advanced_Audio_Coding
/// {@endtemplate}
class AAC extends Codec {
  /// {@macro test_media_generator.AAC}
  AAC();

  @override
  String get name => 'aac';

  @override
  String get extension => 'm4a';

  @override
  String get encoder => 'aac';

  @override
  /// AAC is lossy, but can encode from different bit depths.
  List<BitDepth> get bitDepths => <BitDepth>[BitDepth.bd16, BitDepth.bd24];
}
