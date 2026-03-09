part of audio;

/// This file defines the abstract base class [Codec]
/// which serves as a blueprint for specific audio codec implementations.
abstract class Codec {
  /// The name of the codec.
  String get name;

  /// The file extension associated with this codec.
  String get extension;

  /// The encoder to be used with this codec.
  String get encoder;

  /// A list of supported bit depths for this codec.
  List<BitDepth> get bitDepths => <BitDepth>[
    BitDepth.bd8,
    BitDepth.bd16,
    BitDepth.bd24,
    BitDepth.bd32,
  ];

  /// A list of supported bit rates for this codec.
  List<BitRate> get bitRates => <BitRate>[
    BitRate.br64,
    BitRate.br96,
    BitRate.br128,
    BitRate.br192,
    BitRate.br256,
    BitRate.br320,
  ];

  /// A list of supported channels for this codec.
  List<Channels> get channels => <Channels>[
    Channels.ch1,
    Channels.ch2,
    Channels.ch6,
    Channels.ch8,
  ];

  /// A list of supported sample rates for this codec.
  List<SampleRate> get sampleRates => <SampleRate>[
    SampleRate.sr8,
    SampleRate.sr16,
    SampleRate.sr44,
    SampleRate.sr48,
    SampleRate.sr96,
  ];

  /// A list of additional encoder flags specific to this codec.
  List<String> get encoderFlags => <String>[];
}
