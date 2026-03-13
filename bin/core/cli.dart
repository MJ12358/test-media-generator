import 'package:args/args.dart';
import 'package:dart_logz/dart_logz.dart';

/// {@template test_media_generator.cli}
/// This class defines the command-line interface (CLI)
/// for the media generator tool.
/// It includes methods for building the argument parser
/// and printing usage information.
/// {@endtemplate}
class Cli {
  static final ArgParser _parser = _buildParser();

  /// Parses the command-line arguments and returns [CliOptions].
  static CliOptions parse(List<String> arguments) {
    final ArgResults results = _parser.parse(arguments);

    bool generateAudio = false;
    bool generateImages = false;
    bool generateVideos = false;

    if (results.command?.name == 'generate') {
      final ArgResults cmd = results.command!;
      generateAudio = cmd.flag('audio');
      generateImages = cmd.flag('images');
      generateVideos = cmd.flag('videos');
    }

    return CliOptions(
      showHelp: results.flag('help'),
      showVersion: results.flag('version'),
      generateAudio: generateAudio,
      generateImages: generateImages,
      generateVideos: generateVideos,
    );
  }

  /// Builds the argument parser for the CLI,
  /// defining the available flags and commands.
  static ArgParser _buildParser() {
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

  /// Prints the usage information for the CLI.
  static void printUsage(String appName) {
    logz.i('Usage: dart $appName.dart <flags> [arguments]');
    logz.i(_parser.usage);
  }
}

/// A class to hold the parsed CLI options.
class CliOptions {
  final bool showHelp;
  final bool showVersion;
  final bool generateAudio;
  final bool generateImages;
  final bool generateVideos;

  const CliOptions({
    this.showHelp = false,
    this.showVersion = false,
    this.generateAudio = false,
    this.generateImages = false,
    this.generateVideos = false,
  });
}
