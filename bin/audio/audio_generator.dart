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

  /// Generates a sine wave audio filter based on the
  /// channel layout and sample rate.
  String _getAudioFilter(ChannelLayout channels, SampleRate sampleRate) {
    final double segment = duration / channels.count;
    final List<String> expr = <String>[];

    for (int i = 0; i < channels.count; i++) {
      final double start = i * segment;
      final double end = (i + 1) * segment;
      final SpeakerPosition position = channels.positions[i];

      expr.add('${position.sineExpr()}*between(t,$start,$end)');
    }

    return 'aevalsrc="${expr.join('|')}:s=${sampleRate.value}:d=$duration"';
  }

  @override
  String getFileName(AudioSpec spec) {
    return '${spec.codec.name}_'
        '${spec.bitDepth.name}_'
        '${spec.bitRate.name}_'
        '${spec.channels.label}_'
        '${spec.sampleRate.name}'
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
    // if (spec.codec.bitDepths.contains(spec.bitDepth)) {
    //   cmd.add(<String>['-sample_fmt', spec.bitDepth.ffmpegName]);
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
