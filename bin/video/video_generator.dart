import 'dart:io';

import '../core/logger.dart';
import '../core/unsupported_exception.dart';
import 'backend/backend.dart';
import 'backend/cpu.dart';
import 'codecs/codec.dart';
import 'codecs/mjpeg.dart';
import 'codecs/mpeg2.dart';
import 'config.dart';
import 'encoder_mapper.dart';

class VideoGenerator {
  static late Backend backend;

  final String _outputDir = Config.outputDir;
  final int _duration = Config.duration;
  final int _sineFrequency = Config.sineFrequency;
  final String _fontPath = Config.fontPath;
  final Map<String, String> _resolutions = Config.resolutions;
  final List<int> _framerates = Config.framerates;

  VideoGenerator() {
    Directory(_outputDir).createSync(recursive: true);
    backend = Backend.detect();
  }

  String _buildFileName(Codec codec, String size, int fps, String pixelFormat) {
    return '${codec.name}_'
        '${size}_'
        '${fps}fps_'
        '$pixelFormat.${codec.extension}';
  }

  String _buildVideoFilter(String size, int fps, String filename) {
    return '''
      testsrc=duration=$_duration:size=$size:rate=$fps, 
      drawtext=fontfile=$_fontPath: 
      text='$filename': 
      x=(w-text_w)/2: 
      y=(h-text_h)/2: 
      fontsize=h/15: 
      fontcolor=white: 
      box=1: 
      boxcolor=black@0.6: 
      boxborderw=10
    ''';
  }

  bool _needsStrictExperimental(String encoder) {
    return encoder == 'libaom-av1';
  }

  Future<void> _encode({
    required Codec codec,
    required String size,
    required int fps,
    required String pixelFormat,
  }) async {
    final String filename = _buildFileName(codec, size, fps, pixelFormat);

    final String outputPath = '$_outputDir/$filename';

    if (File(outputPath).existsSync()) {
      log.w('Skipping (exists): $filename');
      return;
    }

    try {
      final String encoder = EncoderMapper.getName(codec, backend);
      final String? filter = codec is MJPEG || codec is MPEG2
          ? null
          : backend.filter;

      final List<String> args = <String>[];

      // Global args
      args.addAll(backend.hwDeviceArgs);
      args.addAll(<String>['-y']);

      // Input args
      args.addAll(<String>[
        '-f',
        'lavfi',
        '-i',
        _buildVideoFilter(size, fps, filename),
        '-f',
        'lavfi',
        '-i',
        'sine=frequency=$_sineFrequency',
      ]);

      // Codec and filter args
      if (filter != null) {
        args.addAll(<String>['-vf', filter]);
      }

      if (_needsStrictExperimental(encoder)) {
        args.addAll(<String>['-strict', '-2']);
      }

      args.addAll(<String>['-c:v', encoder]);
      args.addAll(<String>['-c:a', codec.audio]);

      // CPU-only pixel format
      if (backend is Cpu) {
        args.addAll(<String>['-pix_fmt', pixelFormat]);
      }

      // Apply codec tuning
      args.addAll(codec.tuning);

      // Add encoder-specific flags
      args.addAll(codec.encoderFlags);

      // Final args
      args.add('-shortest');
      args.add(outputPath);

      log.i('Encoding: $filename');
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
    } on UnsupportedException catch (e) {
      log.w(e.message);
    } catch (e) {
      log.e('Exception encoding $filename: $e');
    }
  }

  Future<void> generate() async {
    for (final Codec codec in Config.codecs) {
      for (final String resolution in _resolutions.keys) {
        for (final int fps in _framerates) {
          for (final String pixelFormat in codec.pixelFormats) {
            await _encode(
              codec: codec,
              size: _resolutions[resolution]!,
              fps: fps,
              pixelFormat: pixelFormat,
            );
          }
        }
      }
    }

    log.s('Video test set generated in $_outputDir');
  }
}
