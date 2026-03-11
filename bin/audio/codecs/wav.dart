part of audio;

/// {@template test_media_generator.WAV}
/// This defines the WAV audio codec,
/// which is a widely used uncompressed audio format.
///
/// https://en.wikipedia.org/wiki/WAV
/// {@endtemplate}
class WAV extends Codec {
  final bool _is16Bit;
  final bool _is24Bit;

  /// {@macro test_media_generator.WAV}
  ///
  /// This constructor uses 16-bit depth, which is the most common.
  factory WAV.bit16() {
    return WAV._(is16Bit: true, is24Bit: false);
  }

  /// {@macro test_media_generator.WAV}
  ///
  /// This constructor uses 24-bit depth, which is less common.
  factory WAV.bit24() {
    return WAV._(is16Bit: false, is24Bit: true);
  }

  WAV._({required bool is16Bit, required bool is24Bit})
    : _is16Bit = is16Bit,
      _is24Bit = is24Bit;

  @override
  String get name {
    if (_is16Bit) {
      return 'wav16';
    } else if (_is24Bit) {
      return 'wav24';
    } else {
      return 'wav';
    }
  }

  @override
  String get extension => 'wav';

  @override
  String get encoder {
    if (_is16Bit) {
      return 'pcm_s16le';
    } else if (_is24Bit) {
      return 'pcm_s24le';
    } else {
      return 'pcm_s16le'; // Default to 16-bit PCM
    }
  }

  @override
  List<BitDepth> get bitDepths {
    if (_is16Bit) {
      return <BitDepth>[BitDepth.bd16];
    } else if (_is24Bit) {
      return <BitDepth>[BitDepth.bd24];
    } else {
      return <BitDepth>[BitDepth.bd16]; // Default to 16-bit PCM
    }
  }

  @override
  /// PCM is uncompressed, bit rate = sample_rate * bit_depth * channels.
  ///
  /// But we specify a high bit rate to ensure the generator can use this codec.
  List<BitRate> get bitRates => <BitRate>[BitRate.br320];
}
