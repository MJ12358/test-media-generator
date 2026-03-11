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
  List<BitDepth> get bitDepths => BitDepth.values;

  /// A list of supported bit rates for this codec.
  List<BitRate> get bitRates => BitRate.values;

  /// A list of supported channels for this codec.
  List<ChannelLayout> get channels => ChannelLayout.values;

  /// A list of supported sample rates for this codec.
  List<SampleRate> get sampleRates => SampleRate.values;

  /// A list of additional encoder flags specific to this codec.
  List<String> get encoderFlags => <String>[];
}
