import 'package:args/args.dart';

import 'core/logger.dart';
import 'video/video_generator.dart';

const String version = '0.0.1';

ArgParser _buildParser() {
  return ArgParser()
    ..addFlag(
      'help',
      abbr: 'h',
      negatable: false,
      help: 'Print this usage information.',
    )
    ..addFlag(
      'version',
      abbr: 'v',
      negatable: false,
      help: 'Print the tool version.',
    )
    ..addCommand(
      'generate',
      ArgParser()
        ..addFlag('audio', abbr: 'a', help: 'Generate audio files')
        ..addFlag('images', abbr: 'i', help: 'Generate image files')
        ..addFlag('videos', abbr: 'v', help: 'Generate video files'),
    );
}

void _printUsage(ArgParser argParser) {
  log.i('Usage: dart test_media_generator.dart <flags> [arguments]');
  log.i(argParser.usage);
}

void main(List<String> arguments) async {
  final ArgParser argParser = _buildParser();
  bool generateAudio = false;
  bool generateImages = false;
  bool generateVideos = false;

  try {
    final ArgResults results = argParser.parse(arguments);

    // Process the parsed arguments.
    if (results.flag('help')) {
      _printUsage(argParser);
      return;
    }
    if (results.flag('version')) {
      log.i('test_media_generator version: $version');
      return;
    }
    if (results.command?.name == 'generate') {
      generateAudio = results.command!.flag('audio');
      generateImages = results.command!.flag('images');
      generateVideos = results.command!.flag('videos');
    }

    if (generateAudio) {
      log.w('Audio generation is not implemented yet.');
    }
    if (generateImages) {
      log.w('Image generation is not implemented yet.');
    }
    if (generateVideos) {
      final VideoGenerator generator = VideoGenerator();
      await generator.generate();
    }
  } on FormatException catch (e) {
    // Print usage information if an invalid argument was provided.
    log.e(e.message);
    log.i('');
    _printUsage(argParser);
  }
}
