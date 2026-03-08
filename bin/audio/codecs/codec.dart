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
  List<int> get bitDepths => <int>[8, 16, 24, 32];

  /// A list of supported bit rates for this codec.
  List<int> get bitRates => <int>[
    64, // 64 kbps
    96, // 96 kbps
    128, // 128 kbps
    192, // 192 kbps
    256, // High quality
    320, // Very high quality
  ];

  /// A list of supported channels for this codec.
  List<int> get channels => <int>[
    1, // Mono
    2, // Stereo
    6, // 5.1 Surround
    8, // 7.1 Surround
  ];

  /// A list of supported sample rates for this codec.
  List<int> get sampleRates => <int>[8000, 16000, 44100, 48000, 96000];

  /// A list of additional encoder flags specific to this codec.
  List<String> get encoderFlags => <String>[];
}
