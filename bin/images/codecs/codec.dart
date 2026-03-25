part of images;

/// This file defines the abstract base class [Codec]
/// which serves as a blueprint for specific image codec implementations.
abstract class Codec {
  /// The name of the codec.
  String get name;

  /// The file extension associated with this codec.
  String get extension;

  /// The encoder to be used with this codec.
  ///
  /// Optionally, this can be used to specify a custom encoder for this codec.
  String? get encoder => null;

  /// A map of encoder options specific to this codec.
  ///
  /// Optionally, this can be used to provide extra command-line arguments.
  List<String> get encoderFlags => <String>[];

  /// The pixel formats supported by this codec.
  List<PixelFormat> get pixelFormats => PixelFormat.values;

  /// A list of sizes(resolutions) to generate.
  List<Size> get sizes => Size.values;
}
