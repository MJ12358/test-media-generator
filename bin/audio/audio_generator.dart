import 'dart:io';

import '../core/logger.dart';
import 'codecs/codec.dart';
import 'config.dart';

class AudioGenerator {
  final String _outputDir = Config.outputDir;
  final int _duration = Config.duration;
  final int _sineFrequency = Config.sineFrequency;

  AudioGenerator() {
    Directory(_outputDir).createSync(recursive: true);
  }

  String _buildFileName(
    Codec codec,
    int bitDepth,
    int bitRate,
    int channels,
    int sampleRate,
  ) {
    return '${codec.name}_'
        '${bitDepth}bit_'
        '${bitRate}kbps_'
        '${channels}ch_'
        '${sampleRate ~/ 1000}kHz.${codec.extension}';
  }

  String _buildAudioFilter(int sampleRate) {
    return 'sine=frequency=$_sineFrequency'
        ':sample_rate=$sampleRate:'
        'duration=$_duration';
  }

  Future<void> _encode({
    required Codec codec,
    required int bitDepth,
    required int bitRate,
    required int channels,
    required int sampleRate,
  }) async {
    final String filename = _buildFileName(
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
    args.addAll(<String>['-f', 'lavfi', '-i', _buildAudioFilter(sampleRate)]);

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

  Future<void> generate() async {
    for (final Codec codec in Config.codecs) {
      for (final int bitDepth in codec.bitDepths) {
        for (final int bitRate in codec.bitRates) {
          for (final int channels in codec.channels) {
            for (final int sampleRate in codec.sampleRates) {
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
