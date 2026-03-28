part of audio;

/// {@template test_media_generator.AudioGenerator}
/// This class is responsible for generating test audio files.
/// {@endtemplate}
class AudioGenerator extends Generator<AudioSpec> {
  late final int duration;
  late final TtsService tts;

  /// {@macro test_media_generator.AudioGenerator}
  AudioGenerator() : super(outputDir: Config.outputDir) {
    duration = Config.duration;
    tts = TtsService(outputDir: outputDir);
  }

  /// Generates a sine wave audio expression for each channel
  /// based on the channel layout and duration.
  String _getSource(AudioSpec spec) {
    // final double segment = duration / spec.channels.count;
    final List<String> expr = <String>[];
    for (int i = 0; i < spec.channels.count; i++) {
      // final String start = (i * segment).toStringAsFixed(6);
      // final String end = ((i + 1) * segment).toStringAsFixed(6);
      final SpeakerPosition position = spec.channels.positions[i];
      // expr.add('${position.sineExpr()}*between(t,$start,$end)*0.8');
      expr.add(position.sineExpr());
    }
    return 'aevalsrc=${expr.join('|')}';
  }

  /// Generates a sine wave audio filter based on the
  /// channel layout and sample rate.
  String _getAudioFilter(AudioSpec spec) {
    final String src = _getSource(spec);
    return <String>[
      src,
      'sample_rate=${spec.sampleRate.value}',
      'duration=$duration',
    ].join(':');
  }

  /// Generates a complex filter to concatenate the speech audio
  /// with the generated sine wave audio, and applies the necessary
  /// resampling and format conversion to match the target specification.
  String _getComplexFilter(AudioSpec spec) {
    final String sample = <String>[
      '[0:a]aresample=${spec.sampleRate.value}',
      'aformat=channel_layouts=${spec.channels.name}[s0]',
    ].join(',');

    return <String>[
      sample,
      '[1:a]anull[s1]',
      '[s0][s1]concat=n=2:v=0:a=1[out]',
      // '[0:a][1:a]concat=n=2:v=0:a=1[out]',
    ].join(';');
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
  Future<Command> getCommand(
    AudioSpec spec,
    String outputPath,
    String filename,
  ) async {
    final Command cmd = Command();

    final String speechPath = await tts.generate(
      filename: filename,
      text: spec.toSpokenString(),
    );

    // Global args
    cmd.add(<String>['-y']);

    // Input 0: speech
    cmd.add(<String>['-i', speechPath]);

    // Input 1: generated tones
    cmd.add(<String>['-f', 'lavfi', '-i', _getAudioFilter(spec)]);

    // Concatenate speech + tone
    cmd.add(<String>['-filter_complex', _getComplexFilter(spec)]);
    cmd.add(<String>['-map', '[out]']);

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
