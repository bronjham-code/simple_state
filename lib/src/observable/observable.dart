import 'package:flutter/foundation.dart';

class Observable<T> {
  Observable(T value) : _value = ValueNotifier(value);

  late final ValueNotifier<T> _value;

  T get value => _value.value;

  set value(T value) => _value.value = value;

  void addListener(VoidCallback listener) {
    _value.addListener(listener);
    final value = _value.value;
    if (value is ChangeNotifier) {
      value.addListener(listener);
    }
  }

  void removeListener(VoidCallback listener) {
    _value.removeListener(listener);
    final value = _value.value;
    if (value is ChangeNotifier) {
      value.removeListener(listener);
    }
  }
}
