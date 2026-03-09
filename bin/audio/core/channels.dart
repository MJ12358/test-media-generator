part of audio;

/// This defines the various channel configurations used in audio processing.
/// The number of channels refers to the number of discrete audio signals.
///
/// https://en.wikipedia.org/wiki/Audio_signal
enum Channels {
  /// Mono (1 channel) has a single audio signal,
  /// typically used for voice recordings.
  ch1(1),

  /// Stereo (2 channels) has two audio signals,
  /// typically used for music and general audio.
  ch2(2),

  /// 5.1 Surround (6 channels) has six audio signals,
  /// typically used for home theater systems.
  ch6(6),

  /// 7.1 Surround (8 channels) has eight audio signals,
  /// typically used for high-end home theater systems.
  ch8(8);

  const Channels(this.value);

  /// The friendly name of the channels, such as '2ch'.
  String get name {
    return '${value}ch';
  }

  /// The integer value of the channels.
  final int value;
}
