import 'dart:io';

import 'package:dart_logz/dart_logz.dart';

import 'encoding_exception.dart';

/// {@template test_media_generator.Command}
/// A class to build and run ffmpeg commands.
///
/// This class provides a structured way to construct ffmpeg
/// command-line arguments and execute them.
/// It also includes validation to ensure that ffmpeg
/// is available on the system.
///
/// https://ffmpeg.org/
/// {@endtemplate}
class Command {
  /// {@macro test_media_generator.Command}
  Command();

  /// The ffmpeg executable.
  static const String _exe = 'ffmpeg';

  /// A list of arguments to pass to ffmpeg.
  final List<String> _args = <String>[];

  /// Adds a list of arguments to the command.
  void add(List<String> values) {
    _args.addAll(values);
  }

  /// Runs the command.
  ///
  /// Throws an [EncodingException] if the command fails.
  Future<void> run(String filename) async {
    await _validate();
    logz.s(toString());

    final ProcessResult result = await Process.run(_exe, _args);

    if (result.exitCode != 0) {
      throw EncodingException.fromResult(filename, result);
    }
  }

  @override
  String toString() {
    return <String>[_exe, ..._args.map(_quote)].join(' ');
  }

  /// Quotes an argument if it contains spaces.
  String _quote(String v) {
    return v.contains(' ') ? '"$v"' : v;
  }

  Future<void> _validate() async {
    final ProcessResult result = await Process.run(_exe, <String>['-version']);
    if (result.exitCode != 0) {
      throw Exception('$_exe not found');
    }
  }
}
