part of '../audio.dart';

/// {@template test_media_generator.audio.BitDepth}
/// This defines the various bit depths used in audio processing.
/// Bit depth refers to the number of bits used to represent each audio sample,
/// which directly impacts the dynamic range and noise floor of the audio.
///
/// https://en.wikipedia.org/wiki/Audio_bit_depth
/// {@endtemplate}
enum BitDepth {
  /// 8-bit audio has a dynamic range of 48 dB
  /// and is typically used for low-quality audio.
  bd8(8, 'u8'),

  /// 16-bit audio has a dynamic range of 96 dB
  /// and is the standard for CD-quality audio.
  bd16(16, 's16'),

  /// 24-bit audio has a dynamic range of 144 dB
  /// and is used in professional audio recording.
  /// FFmpeg uses 32-bit sample format (s32) to represent 24-bit audio,
  /// so we map it to s32 for encoding.
  bd24(24, 's32'),

  /// 32-bit audio has a dynamic range of 192 dB
  /// and is used for high-resolution audio.
  bd32(32, 's32');

  /// {@macro test_media_generator.audio.BitDepth}
  const BitDepth(this.value, this.format);

  /// The integer value of the bit depth in bits.
  final int value;

  /// The corresponding FFmpeg sample format string for this bit depth.
  final String format;

  /// The friendly label of the bit depth, such as '16bit'.
  String get label => '${value}bit';

  /// A human-readable name for the bit depth, used in spoken descriptions.
  String get spokenName => '$value bit';
}
