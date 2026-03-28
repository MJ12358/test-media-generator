part of audio;

/// {@template test_media_generator.TtsService}
/// Responsible for generating speech audio from text.
/// {@endtemplate}
class TtsService {
  /// {@macro test_media_generator.TtsService}
  TtsService({required String outputDir, String binary = 'espeak-ng'})
    : _outputDir = '$outputDir/tmp',
      _binary = binary {
    Directory(_outputDir).createSync(recursive: true);
  }

  final String _outputDir;
  final String _binary;

  /// Generates a speech audio file from the given filename.
  /// The filename is humanized to create the speech content.
  Future<String> generate({
    required String filename,
    required String text,
  }) async {
    await _validate();

    final String speechPath = _getSpeechPath(filename);

    if (File(speechPath).existsSync()) {
      return speechPath; // cache hit
    }

    final ProcessResult result = await Process.run(_binary, <String>[
      text,
      '-g',
      '5',
      '-w',
      speechPath,
    ]);

    if (result.exitCode != 0) {
      throw Exception('TTS generation failed: ${result.stderr}');
    }

    return speechPath;
  }

  /// Generates the path for the speech audio file
  /// based on the original filename.
  String _getSpeechPath(String filename) {
    final String base = filename.replaceAll(RegExp(r'\.[^.]+$'), '');
    return '$_outputDir/tts_$base.wav';
  }

  /// Validates that the TTS binary is available on the system.
  Future<void> _validate() async {
    final ProcessResult result = await Process.run(_binary, <String>[
      '--version',
    ]);
    if (result.exitCode != 0) {
      throw Exception('$_binary not found');
    }
  }
}
