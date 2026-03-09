part of audio;

/// This defines the various bit depths used in audio processing.
/// Bit depth refers to the number of bits used to represent each audio sample,
/// which directly impacts the dynamic range and noise floor of the audio.
///
/// https://en.wikipedia.org/wiki/Audio_bit_depth
enum BitDepth {
  /// 8-bit audio has a dynamic range of 48 dB
  /// and is typically used for low-quality audio.
  bd8(8),

  /// 16-bit audio has a dynamic range of 96 dB
  /// and is the standard for CD-quality audio.
  bd16(16),

  /// 24-bit audio has a dynamic range of 144 dB
  /// and is used in professional audio recording.
  bd24(24),

  /// 32-bit audio has a dynamic range of 192 dB
  /// and is used for high-resolution audio.
  bd32(32);

  const BitDepth(this.value);

  /// The friendly name of the bit depth, such as '16bit'.
  String get name {
    return '${value}bit';
  }

  /// The integer value of the bit depth in bits.
  final int value;
}
