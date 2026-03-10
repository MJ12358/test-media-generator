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
  /// This is dependent on bit depth and sample rate,
  /// but for simplicity we will only support these two channel configurations.
  List<ChannelLayout> get channels => <ChannelLayout>[
    ChannelLayout.mono,
    ChannelLayout.stereo,
  ];

  @override
  /// This is dependent on bit depth and channel configuration,
  /// but for simplicity we will only support 16-bit audio.
  List<BitDepth> get bitDepths => <BitDepth>[BitDepth.bd16];

  @override
  /// This is dependent on bit depth and channel configuration,
  /// but for simplicity we will only support these bit rates.
  List<BitRate> get bitRates => <BitRate>[
    BitRate.br64,
    BitRate.br96,
    BitRate.br128,
    BitRate.br192,
  ];

  @override
  List<String> get encoderFlags => <String>['-q:a', '5'];

  @override
  /// This is dependent on bit depth and channel configuration,
  /// but for simplicity we will only support these sample rates.
  List<SampleRate> get sampleRates => <SampleRate>[
    SampleRate.sr44,
    SampleRate.sr48,
  ];
}
