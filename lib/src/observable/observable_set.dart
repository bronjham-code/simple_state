import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:simple_state/src/observable/observable.dart';
import 'package:simple_state/src/store.dart';

/// A observable collection of objects in which each object can occur only once.
///
class ObservableSet<T> implements ObservableBase<Set<T>> {
  ObservableSet([Set<T>? value]) : _value = _ObservableSet(value ?? {});
  final _ObservableSet<T> _value;

  @override
  Set<T> get value {
    Store.instance.reportRead(this);

    return _value;
  }

  @override
  void addListener(VoidCallback listener) => _value.addListener(listener);

  @override
  void dispose() => _value.dispose();

  @override
  bool get hasListeners => _value.hasListeners;

  @override
  void notifyListeners() => _value.notifyListeners();

  @override
  void removeListener(VoidCallback listener) => _value.removeListener(listener);
}

class _ObservableSet<T> extends ChangeNotifier with SetMixin<T> {
  /// Creates an observable [Set].
  _ObservableSet([Set<T>? value]) : _value = value ?? {};

  final Set<T> _value;

  @override
  bool add(T value) {
    final isAdded = _value.add(value);
    if (isAdded) {
      notifyListeners();
    }

    return isAdded;
  }

  @override
  bool contains(Object? element) => _value.contains(element);

  @override
  Iterator<T> get iterator => _value.iterator;

  @override
  int get length => _value.length;

  @override
  T? lookup(Object? element) => _value.lookup(element);

  @override
  bool remove(Object? value) {
    final isRemoved = _value.remove(value);

    if (isRemoved) {
      notifyListeners();
    }

    return isRemoved;
  }

  @override
  Set<T> toSet() => _value.toSet();
}
