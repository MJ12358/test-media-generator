import 'backend.dart';

class Cpu extends Backend {
  @override
  String get name => 'cpu';

  @override
  String get filter => 'null';

  @override
  List<String> get hwDeviceArgs => <String>[];

  @override
  bool get isAvailable => true;
}
