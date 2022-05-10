import 'package:flutter/foundation.dart';

class Observable<T> implements ChangeNotifier {
  Observable(T value) : _value = ValueNotifier<T>(value);

  late final ValueNotifier<T> _value;

  T get value => _value.value;

  set value(T value) => _value.value = value;

  @override
  void addListener(VoidCallback listener) => _value.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => _value.removeListener(listener);

  @override
  void dispose() => _value.dispose();

  @override
  bool get hasListeners => _value.hasListeners;

  @override
  void notifyListeners() => _value.notifyListeners();
}
