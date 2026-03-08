/// This file defines the abstract base class [Codec]
/// which serves as a blueprint for specific video codec implementations.
abstract class Codec {
  /// The name of the codec.
  String get name;

  /// The file extension associated with this codec.
  String get extension;

  /// The audio codec to be used with this video codec.
  /// This can be used to specify the audio encoding format
  /// that pairs well with the video codec.
  String get audio;

  /// A list of tuning parameters for the codec.
  /// This can be used to specify codec-specific settings.
  List<String> get tuning => <String>[];

  /// A list of additional encoder flags specific to this codec.
  List<String> get encoderFlags => <String>[];

  /// A list of pixel formats supported by this codec.
  List<String> get pixelFormats => <String>['yuv420p', 'yuv422p', 'yuv444p'];
}
