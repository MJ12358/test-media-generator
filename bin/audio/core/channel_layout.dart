part of audio;

/// {@template test_media_generator.audio.ChannelLayout}
/// This defines the various channel configurations used in audio processing.
/// The number of channels refers to the number of discrete audio signals.
///
/// https://en.wikipedia.org/wiki/Audio_signal
/// {@endtemplate}
enum ChannelLayout {
  /// Mono (1 channel) has a single audio signal,
  /// typically used for voice recordings.
  mono(<SpeakerPosition>[SpeakerPosition.fl]),

  /// Stereo (2 channels) has two audio signals,
  /// typically used for music and general audio.
  stereo(<SpeakerPosition>[SpeakerPosition.fl, SpeakerPosition.fr]),

  /// 5.1 Surround (6 channels) has six audio signals,
  /// typically used for home theater systems.
  surround5_1(<SpeakerPosition>[
    SpeakerPosition.fl,
    SpeakerPosition.fr,
    SpeakerPosition.fc,
    SpeakerPosition.lfe,
    SpeakerPosition.bl,
    SpeakerPosition.br,
  ]),

  /// 7.1 Surround (8 channels) has eight audio signals,
  /// typically used for high-end home theater systems.
  surround7_1(<SpeakerPosition>[
    SpeakerPosition.fl,
    SpeakerPosition.fr,
    SpeakerPosition.fc,
    SpeakerPosition.lfe,
    SpeakerPosition.bl,
    SpeakerPosition.br,
    SpeakerPosition.sl,
    SpeakerPosition.sr,
  ]);

  /// {@macro test_media_generator.audio.ChannelLayout}
  const ChannelLayout(this.positions);

  /// A list of speaker positions for this channel layout.
  final List<SpeakerPosition> positions;

  /// The friendly label of the channels, such as '2ch'.
  String get label {
    return '${count}ch';
  }

  /// The integer value of the channels.
  ///
  /// This is equal to the length of the positions list,
  /// which defines the number of discrete audio signals.
  int get count => positions.length;
}
