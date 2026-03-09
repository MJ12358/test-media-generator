part of audio;

/// This defines the various sample rates used in audio processing.
/// Sample rate refers to the number of audio samples captured per second,
/// which directly impacts the frequency range and quality of the audio.
///
/// https://en.wikipedia.org/wiki/Sampling_(signal_processing)
enum SampleRate {
  /// 8 kHz is typically used for
  /// telephone audio and voice recordings.
  sr8(8000),

  /// 16 kHz is commonly used for
  /// speech and voice recordings.
  sr16(16000),

  /// 44.1 kHz is the standard sample rate for
  /// CD-quality audio.
  sr44(44100),

  /// 48 kHz is commonly used for
  /// professional audio and video production.
  sr48(48000),

  /// 96 kHz is used for high-resolution
  /// audio and professional recording.
  sr96(96000);

  const SampleRate(this.value);

  /// The friendly name of the sample rate, such as '96kHz'.
  String get name {
    return '${value ~/ 1000}kHz';
  }

  /// The integer value of the sample rate in Hz.
  final int value;
}
