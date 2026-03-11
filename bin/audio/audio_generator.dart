part of audio;

/// {@template test_media_generator.AudioGenerator}
/// This class is responsible for generating test audio files.
/// {@endtemplate}
class AudioGenerator extends Generator {
  static const int _duration = Config.duration;

  /// {@macro test_media_generator.AudioGenerator}
  AudioGenerator() : super(outputDir: Config.outputDir);

  String _getFileName(
    Codec codec,
    BitDepth bitDepth,
    BitRate bitRate,
    ChannelLayout channels,
    SampleRate sampleRate,
  ) {
    return '${codec.name}_'
        '${bitDepth.name}_'
        '${bitRate.name}_'
        '${channels.label}_'
        '${sampleRate.name}'
        '.${codec.extension}';
  }

  // String _getAudioFilter(SampleRate sampleRate) {
  //   return 'sine=frequency=$_sineFrequency'
  //       ':sample_rate=${sampleRate.value}:'
  //       'duration=$_duration';
  // }

  String _getAudioFilter(ChannelLayout channels, SampleRate sampleRate) {
    final double segment = _duration / channels.count;
    final List<String> expr = <String>[];

    for (int i = 0; i < channels.count; i++) {
      final double start = i * segment;
      final double end = (i + 1) * segment;
      final SpeakerPosition position = channels.positions[i];

      expr.add('${position.sineExpr()}*between(t,$start,$end)');
    }

    return 'aevalsrc="${expr.join('|')}:s=${sampleRate.value}:d=$_duration"';
  }

  Future<void> _encode({
    required Codec codec,
    required BitDepth bitDepth,
    required BitRate bitRate,
    required ChannelLayout channels,
    required SampleRate sampleRate,
  }) async {
    final String filename = _getFileName(
      codec,
      bitDepth,
      bitRate,
      channels,
      sampleRate,
    );

    final String outputPath = '$outputDir/$filename';

    if (File(outputPath).existsSync()) {
      log.w('Skipping (exists): $filename');
      return;
    }

    try {
      final Command cmd = Command();

      // Global args
      cmd.add(<String>['-y']);

      // Input args
      cmd.add(<String>[
        '-f',
        'lavfi',
        '-i',
        _getAudioFilter(channels, sampleRate),
      ]);

      // Apply channels
      cmd.add(<String>['-ac', '${channels.count}']);

      // Add encoder
      cmd.add(<String>['-c:a', codec.encoder]);

      // Add bit rate
      cmd.add(<String>['-b:a', '${bitRate.value}k']);

      // Final args
      cmd.add(<String>[outputPath]);

      log.i('Encoding: $filename');

      await cmd.run(filename);
    } on EncodingException catch (e) {
      log.e(e.message);
    } catch (e) {
      log.e('Exception encoding $filename: $e');
    } finally {
      final File file = File(outputPath);
      if (file.existsSync() && file.lengthSync() == 0) {
        log.w('Cleaning up invalid output file: $filename');
        file.deleteSync();
      }
    }
  }

  @override
  Future<void> generate() async {
    for (final Codec codec in Config.codecs) {
      for (final BitDepth bitDepth in codec.bitDepths) {
        for (final BitRate bitRate in codec.bitRates) {
          for (final ChannelLayout channels in codec.channels) {
            for (final SampleRate sampleRate in codec.sampleRates) {
              await _encode(
                codec: codec,
                bitDepth: bitDepth,
                bitRate: bitRate,
                channels: channels,
                sampleRate: sampleRate,
              );
            }
          }
        }
      }
    }

    log.s('Audio test set generated in $outputDir');
  }
}
