import 'backend.dart';

class Cpu extends Backend {
  @override
  String get name => 'cpu';

  @override
  bool get isAvailable => true;
}
