part of audio;

/// {@template test_media_generator.AC3}
/// This defines the AC3 audio codec,
/// which is a widely used lossy audio format for surround sound.
///
/// https://en.wikipedia.org/wiki/Dolby_Digital#Dolby_AC-3
/// {@endtemplate}
class AC3 extends Codec {
  /// {@macro test_media_generator.AC3}
  AC3();

  @override
  String get name => 'ac3';

  @override
  String get extension => 'ac3';

  @override
  String get encoder => 'ac3';

  @override
  List<BitDepth> get bitDepths => <BitDepth>[BitDepth.bd16, BitDepth.bd24];

  @override
  /// AC3 supports up to 5.1 (6 channels).
  List<ChannelLayout> get channels => <ChannelLayout>[
    ChannelLayout.mono,
    ChannelLayout.stereo,
    ChannelLayout.surround5_1,
  ];
}
