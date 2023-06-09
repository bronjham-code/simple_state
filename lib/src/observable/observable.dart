import 'package:flutter/foundation.dart';
import 'package:simple_state/src/store.dart';

/// Creates a observable simple value that wraps this value.

class Observable<T> extends ObservableBase<T> {
  /// Creates a observable that wraps this value.
  Observable(super.value);

  set value(T newValue) => super._value.value = newValue;
}

/// Creates a observable base class does not have access to value setter
class ObservableBase<T> implements ChangeNotifier {
  /// Creates a observable base class.
  ObservableBase(T value) : _value = ValueNotifier(value);

  final ValueNotifier<T> _value;

  T get value {
    Store.instance.reportRead(this);

    return _value.value;
  }

  @override
  void dispose() => _value.dispose();

  @override
  bool get hasListeners => _value.hasListeners;

  @override
  void notifyListeners() => _value.notifyListeners();

  @override
  void addListener(VoidCallback listener) => _value.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => _value.removeListener(listener);
}
