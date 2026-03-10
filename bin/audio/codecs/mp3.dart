part of audio;

/// {@template test_media_generator.MP3}
/// This defines the MP3 audio codec,
/// which is a widely used lossy audio format.
///
/// https://en.wikipedia.org/wiki/MP3
///
/// https://trac.ffmpeg.org/wiki/Encode/MP3
/// {@endtemplate}
class MP3 extends Codec {
  final bool _isVbr;

  /// {@macro test_media_generator.MP3}
  factory MP3() {
    return MP3._(isVbr: false);
  }

  /// {@macro test_media_generator.MP3}
  ///
  /// This constructor creates a variable bitrate (VBR) MP3 codec configuration.
  factory MP3.vbr() {
    return MP3._(isVbr: true);
  }

  MP3._({required bool isVbr}) : _isVbr = isVbr;

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
  List<BitDepth> get bitDepths => <BitDepth>[BitDepth.bd16, BitDepth.bd24];

  @override
  List<BitRate> get bitRates {
    if (_isVbr) {
      // VBR doesn't use fixed bit rates
      // But we specify a target bitrate for VBR encoding.
      return <BitRate>[BitRate.br256];
    } else {
      return super.bitRates;
    }
  }

  @override
  /// MP3 supports mono and stereo only.
  List<ChannelLayout> get channels => <ChannelLayout>[
    ChannelLayout.mono,
    ChannelLayout.stereo,
  ];

  @override
  List<String> get encoderFlags {
    if (_isVbr) {
      return <String>['-q:a', '3'];
    } else {
      return super.encoderFlags;
    }
  }
}
