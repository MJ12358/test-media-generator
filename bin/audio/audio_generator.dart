part of audio;

class AudioGenerator implements Generator {
  final String _outputDir = Config.outputDir;
  final int _duration = Config.duration;
  final int _sineFrequency = Config.sineFrequency;

  AudioGenerator() {
    Directory(_outputDir).createSync(recursive: true);
  }

  String _getFileName(
    Codec codec,
    BitDepth bitDepth,
    BitRate bitRate,
    Channels channels,
    SampleRate sampleRate,
  ) {
    return '${codec.name}_'
        '${bitDepth.name}_'
        '${bitRate.name}_'
        '${channels.name}_'
        '${sampleRate.name}'
        '.${codec.extension}';
  }

  String _getAudioFilter(SampleRate sampleRate) {
    return 'sine=frequency=$_sineFrequency'
        ':sample_rate=${sampleRate.value}:'
        'duration=$_duration';
  }

  Future<void> _encode({
    required Codec codec,
    required BitDepth bitDepth,
    required BitRate bitRate,
    required Channels channels,
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

    final List<String> args = <String>[];

    // Global args
    args.addAll(<String>['-y']);

    // Input args
    args.addAll(<String>['-f', 'lavfi', '-i', _getAudioFilter(sampleRate)]);

    // Apply channels
    args.addAll(<String>['-ac', channels.toString()]);

    // Add encoder
    args.addAll(<String>['-c:a', codec.encoder]);

    // Add bit rate
    args.addAll(<String>['-b:a', '${bitRate}k']);

    // Final args
    args.add(outputPath);

    log.i('Encoding: $filename');
    try {
      final ProcessResult result = await Process.run('ffmpeg', args);

      final File file = File(outputPath);

      // Check if the encoding was successful and the output file is valid.
      if (result.exitCode != 0 ||
          !file.existsSync() ||
          file.lengthSync() == 0) {
        log.e('Error encoding $filename: ${result.stderr}');
        // Clean up any invalid output file.
        if (file.existsSync()) {
          file.deleteSync();
        }
      }
    } catch (e) {
      log.e('Exception encoding $filename: $e');
    }
  }

  @override
  Future<void> generate() async {
    for (final Codec codec in Config.codecs) {
      for (final BitDepth bitDepth in codec.bitDepths) {
        for (final BitRate bitRate in codec.bitRates) {
          for (final Channels channels in codec.channels) {
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
