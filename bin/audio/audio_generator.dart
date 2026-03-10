part of audio;

class AudioGenerator implements Generator {
  final String _outputDir = Config.outputDir;
  final int _duration = Config.duration;
  // final int _sineFrequency = Config.sineFrequency;

  AudioGenerator() {
    Directory(_outputDir).createSync(recursive: true);
  }

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

    final String outputPath = '$_outputDir/$filename';

    if (File(outputPath).existsSync()) {
      log.w('Skipping (exists): $filename');
      return;
    }

    try {
      final List<String> args = <String>[];

      // Global args
      args.addAll(<String>['-y']);

      // Input args
      args.addAll(<String>[
        '-f',
        'lavfi',
        '-i',
        _getAudioFilter(channels, sampleRate),
      ]);

      // Apply channels
      args.addAll(<String>['-ac', '${channels.count}']);

      // Add encoder
      args.addAll(<String>['-c:a', codec.encoder]);

      // Add bit rate
      args.addAll(<String>['-b:a', '${bitRate.value}k']);

      // Final args
      args.add(outputPath);

      log.i('Encoding: $filename');

      final ProcessResult result = await Process.run('ffmpeg', args);

      if (result.exitCode != 0) {
        throw EncodingException.fromResult(filename, result);
      }
    } on EncodingException catch (e) {
      log.e(e.message);
    } on UnsupportedException catch (e) {
      log.w(e.message);
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

    log.s('Audio test set generated in $_outputDir');
  }
}
