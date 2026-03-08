import '../../core/logger.dart';
import '../config.dart';
import 'cpu.dart';

/// This file defines the abstract class `Backend`
/// which represents a video processing backend.
/// It includes properties for the backend's name,
/// filter, hardware device arguments, and availability status.
abstract class Backend {
  /// The name of the backend.
  String get name;

  /// The filter string to be used with this backend.
  String get filter;

  /// A list of command-line arguments required to set up the
  /// hardware device for this backend.
  List<String> get hwDeviceArgs;

  /// A boolean indicating whether this backend is available
  /// on the current system.
  bool get isAvailable;

  /// A method to check if the backend is available.
  static Backend detect() {
    for (final Backend backend in Config.backends) {
      if (backend.isAvailable) {
        log.i('Using GPU backend: ${backend.name}');
        return backend;
      }
    }
    log.i('Using GPU backend: cpu');
    return Cpu();
  }
}
