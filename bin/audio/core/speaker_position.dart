part of audio;

/// {@template test_media_generator.audio.SpeakerPosition}
/// This defines the various speaker positions used in audio processing.
/// Each position is associated with a specific frequency for testing purposes.
///
/// https://en.wikipedia.org/wiki/Loudspeaker
/// {@endtemplate}
enum SpeakerPosition {
  /// Front Left (FL) is the left speaker in a stereo or surround sound setup.
  fl(440, 'Front Left'),

  /// Front Right (FR) is the right speaker in a stereo or surround sound setup.
  fr(550, 'Front Right'),

  /// Front Center (FC) is the center speaker in a surround sound setup.
  fc(660, 'Front Center'),

  /// Low-Frequency Effects (LFE) is the subwoofer channel
  /// in a surround sound setup.
  lfe(110, 'Low-Frequency Effects'),

  /// Back Left (BL) is the left rear speaker in a surround sound setup.
  bl(770, 'Back Left'),

  /// Back Right (BR) is the right rear speaker in a surround sound setup.
  br(880, 'Back Right'),

  /// Side Left (SL) is the left side speaker in a surround sound setup.
  sl(990, 'Side Left'),

  /// Side Right (SR) is the right side speaker in a surround sound setup.
  sr(1100, 'Side Right');

  /// {@macro test_media_generator.audio.SpeakerPosition}
  const SpeakerPosition(this.frequency, this.label);

  /// The integer value of the frequency associated with the speaker position.
  final int frequency;

  /// The friendly label of the speaker position, such as 'Front Left'.
  final String label;

  /// Returns a sine wave expression for the speaker position's frequency.
  String sineExpr() => 'sin(2*PI*$frequency*t)';
}
