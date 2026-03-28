part of audio;

/// {@template test_media_generator.audio.Codec}
/// This file defines the abstract base class [Codec]
/// which serves as a blueprint for specific audio codec implementations.
/// {@endtemplate}
abstract class Codec {
  /// The name of the codec.
  String get name;

  /// A human-readable name for the codec, used in spoken descriptions.
  /// Defaults to the name in uppercase with commas
  /// (e.g., "AAC" -> "A, A, C").
  String get spokenName {
    return name.toUpperCase().split('').join(', ');
  }

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
