import 'package:flutter/foundation.dart';

// This class is the shared state.
// It extends ChangeNotifier so it can notify listening widgets to rebuild.
class Counter with ChangeNotifier {
  int _count = 0;

  int get count => _count;

  void increment() {
    _count++;
    notifyListeners();
  }

  void decrement() {
    _count--;
    notifyListeners();
  }
}
