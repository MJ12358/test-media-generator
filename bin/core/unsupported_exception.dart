/// Throws when an unsupported operation is attempted,
/// such as using a backend that is not supported on the current platform.
class UnsupportedException implements Exception {
  final String message;

  UnsupportedException._(this.message);

  factory UnsupportedException.codecBackend(String key) {
    return UnsupportedException._(
      'Unsupported codec/backend combination: $key',
    );
  }
}
