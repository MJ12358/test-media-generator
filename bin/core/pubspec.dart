import 'dart:io';

import 'package:pubspec_parse/pubspec_parse.dart' as pub;

/// {@template test_media_generator.pubspec}
/// This class is responsible for parsing the pubspec.yaml file
/// to extract application information.
/// {@endtemplate}
class Pubspec {
  /// The name of the application.
  late final String name;

  /// The version of the application.
  late final String version;

  /// {@macro test_media_generator.pubspec}
  Pubspec() {
    final String pubspec = File('pubspec.yaml').readAsStringSync();
    final pub.Pubspec info = pub.Pubspec.parse(pubspec);
    name = info.name;
    version = info.version.toString();
  }
}
