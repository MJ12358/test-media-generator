part of audio;

/// {@template test_media_generator.Opus}
/// This defines the Opus audio codec,
/// which is a widely used lossy audio format.
///
/// https://en.wikipedia.org/wiki/Opus_(audio_format)
/// {@endtemplate}
class Opus extends Codec {
  /// {@macro test_media_generator.Opus}
  Opus();

  @override
  String get name => 'opus';

  @override
  String get extension => 'ogg';

  @override
  String get encoder => 'libopus';

  @override
  /// Opus is lossy, but can encode from different bit depths.
  List<BitDepth> get bitDepths => <BitDepth>[BitDepth.bd16, BitDepth.bd24];

  @override
  /// Opus internally supports up to 48kHz.
  List<SampleRate> get sampleRates => <SampleRate>[
    SampleRate.sr8,
    SampleRate.sr16,
    SampleRate.sr48,
  ];
}
