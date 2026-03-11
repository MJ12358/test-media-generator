part of video;

/// {@template test_media_generator.video.Backend}
/// This defines the abstract class `Backend`
/// which represents a video processing backend.
/// It includes properties for the backend's name,
/// filter, hardware device arguments, and availability status.
/// {@endtemplate}
abstract class Backend {
  /// The name of the backend.
  String get name;

  /// The filter string to be used with this backend.
  String? get filter => null;

  /// A list of command-line arguments required to set up the
  /// hardware device for this backend.
  List<String> get hwDeviceArgs => <String>[];

  /// A boolean indicating whether this backend is available
  /// on the current system.
  bool get isAvailable;

  /// The encoders available on the system,
  /// used for checking hardware encoder support.
  String get _encoders =>
      Process.runSync('ffmpeg', <String>['-encoders']).stdout.toString();

  /// A method to check if the backend is available.
  static Backend detect() {
    for (final Backend backend in Config.backends) {
      if (backend.isAvailable) {
        log.i('Using GPU backend: ${backend.name}');
        return backend;
      }
    }
    log.i('GPU backend not available, falling back to CPU encoding.');
    return Cpu();
  }
}
