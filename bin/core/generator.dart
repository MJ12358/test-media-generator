/// This defines the abstract base class [Generator],
/// which serves as a blueprint for specific media generator implementations.
abstract class Generator {
  /// Generates the media files based on the defined configuration.
  Future<void> generate();
}
