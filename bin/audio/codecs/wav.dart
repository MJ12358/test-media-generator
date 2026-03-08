import 'codec.dart';

class WAV extends Codec {
  final bool _is16Bit;
  final bool _is24Bit;

  WAV._({required bool is16Bit, required bool is24Bit})
    : _is16Bit = is16Bit,
      _is24Bit = is24Bit;

  factory WAV.bit16() {
    return WAV._(is16Bit: true, is24Bit: false);
  }

  factory WAV.bit24() {
    return WAV._(is16Bit: false, is24Bit: true);
  }

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
  List<int> get bitDepths {
    if (_is16Bit) {
      return <int>[16];
    } else if (_is24Bit) {
      return <int>[24];
    } else {
      return <int>[16]; // Default to 16-bit PCM
    }
  }

  @override
  /// PCM is uncompressed, bit rate = sample_rate * bit_depth * channels.
  List<int> get bitRates => <int>[];
}
