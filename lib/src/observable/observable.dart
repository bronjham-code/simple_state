import 'package:flutter/foundation.dart';

class Observable<T> {
  Observable(T value) : _value = ValueNotifier<T>(value);
  final ValueNotifier<T> _value;

  T get value => _value.value;

  set value(T value) => _value.value = value;

  void addListener(VoidCallback listener) => _value.addListener(listener);
  void removeListener(VoidCallback listener) => _value.removeListener(listener);
}
