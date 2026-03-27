part of audio;

/// {@template test_media_generator.AudioGenerator}
/// This class is responsible for generating test audio files.
/// {@endtemplate}
class AudioGenerator extends Generator<AudioSpec> {
  late final int duration;

  /// {@macro test_media_generator.AudioGenerator}
  AudioGenerator() : super(outputDir: Config.outputDir) {
    duration = Config.duration;
  }

  /// Generates a sine wave audio expression for each channel
  /// based on the channel layout and duration.
  String _getSource(ChannelLayout channels) {
    // final double segment = duration / channels.count;
    final List<String> expr = <String>[];
    for (int i = 0; i < channels.count; i++) {
      // final String start = (i * segment).toStringAsFixed(6);
      // final String end = ((i + 1) * segment).toStringAsFixed(6);
      final SpeakerPosition position = channels.positions[i];
      // expr.add('${position.sineExpr()}*between(t,$start,$end)*0.8');
      expr.add(position.sineExpr());
    }
    return 'aevalsrc=${expr.join('|')}';
  }

  /// Generates a sine wave audio filter based on the
  /// channel layout and sample rate.
  String _getAudioFilter(ChannelLayout channels, SampleRate sampleRate) {
    final String src = _getSource(channels);
    return <String>[
      src,
      'sample_rate=${sampleRate.value}',
      'duration=$duration',
    ].join(':');
  }

  @override
  String getFilename(AudioSpec spec) {
    return '${spec.codec.name}_'
        '${spec.bitDepth.label}_'
        '${spec.bitRate.label}_'
        '${spec.channels.label}_'
        '${spec.sampleRate.label}'
        '.${spec.codec.extension}';
  }

  @override
  Command getCommand(AudioSpec spec, String outputPath, String filename) {
    final Command cmd = Command();

    // Global args
    cmd.add(<String>['-y']);

    // Input args
    cmd.add(<String>[
      '-f',
      'lavfi',
      '-i',
      _getAudioFilter(spec.channels, spec.sampleRate),
    ]);

    // Apply channels
    cmd.add(<String>['-ac', '${spec.channels.count}']);

    // Add encoder
    cmd.add(<String>['-c:a', spec.codec.encoder]);

    // Add bit depth if supported
    // TODO: This errors for some codecs that support the bit depth
    // if (spec.codec.bitDepths.contains(spec.bitDepth)) {
    //   cmd.add(<String>['-sample_fmt', spec.bitDepth.format]);
    // }

    // Add bit rate
    cmd.add(<String>['-b:a', '${spec.bitRate.value}k']);

    // Final args
    cmd.add(<String>[outputPath]);

    return cmd;
  }

  @override
  Future<void> generate() async {
    for (final Codec codec in Config.codecs) {
      for (final BitDepth bitDepth in codec.bitDepths) {
        for (final BitRate bitRate in codec.bitRates) {
          for (final ChannelLayout channels in codec.channels) {
            for (final SampleRate sampleRate in codec.sampleRates) {
              await encode(
                AudioSpec(
                  codec: codec,
                  bitDepth: bitDepth,
                  bitRate: bitRate,
                  channels: channels,
                  sampleRate: sampleRate,
                ),
              );
            }
          }
        }
      }
    }

    logz.s('Audio test set generated in $outputDir');
  }
}
