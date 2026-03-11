part of audio;

/// {@template test_media_generator.audio.BitRate}
/// This defines the bit rate of an audio file, which is the number of bits
/// that are processed per second. Higher bit rates generally indicate better
/// audio quality, but also result in larger file sizes.
///
/// https://en.wikipedia.org/wiki/Bit_rate
/// {@endtemplate}
enum BitRate {
  /// 64 kbps is considered low quality and
  /// is typically used for speech.
  br64(64),

  /// 96 kbps is considered medium quality and
  /// is often used for streaming.
  br96(96),

  /// 128 kbps is considered good quality for music and
  /// is commonly used.
  br128(128),

  /// 192 kbps is considered high quality for music and
  /// is often used for streaming services that offer
  /// better audio quality than standard MP3s.
  br192(192),

  /// 256 kbps is considered very high quality for
  /// music and is used for streaming services that
  /// offer high-quality audio.
  br256(256),

  /// 320 kbps is considered the highest quality for
  /// music and is used for streaming services that
  /// offer the best audio quality available.
  br320(320);

  /// {@macro test_media_generator.audio.BitRate}
  const BitRate(this.value);

  /// The friendly name of the bit rate, such as '128kbps'.
  String get name {
    return '${value}kbps';
  }

  /// The integer value of the bit rate in kbps.
  final int value;
}
