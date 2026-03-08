import 'codec.dart';

class MP3 extends Codec {
  final bool _isVbr;

  factory MP3() {
    return MP3._(isVbr: false);
  }

  MP3._({required bool isVbr}) : _isVbr = isVbr;

  factory MP3.vbr() {
    return MP3._(isVbr: true);
  }

  @override
  String get name {
    return _isVbr ? 'mp3_vbr' : 'mp3';
  }

  @override
  String get extension => 'mp3';

  @override
  String get encoder => 'libmp3lame';

  @override
  /// MP3 is lossy, but can encode from different bit depths.
  List<int> get bitDepths => <int>[16, 24];

  @override
  List<int> get bitRates {
    if (_isVbr) {
      // VBR doesn't use fixed bit rates
      return <int>[];
    } else {
      return super.bitRates;
    }
  }

  @override
  /// MP3 supports mono and stereo only.
  List<int> get channels => <int>[1, 2];

  @override
  List<String> get encoderFlags {
    if (_isVbr) {
      return <String>['-q:a', '3'];
    } else {
      return <String>[];
    }
  }
}
