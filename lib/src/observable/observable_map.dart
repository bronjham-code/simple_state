// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:collection';

import 'package:easy_state/src/observable/observable.dart';
import 'package:flutter/foundation.dart';

class ObservableMap<K, V> with MapMixin<K, V> implements Observable<Map<K, V>> {
  ObservableMap(Map<K, V> value) : _value = ValueNotifier(value);

  final ValueNotifier<Map<K, V>> _value;

  @override
  Map<K, V> get value => this;

  @override
  set value(Map<K, V> value) => _value.value = value;

  @override
  V? operator [](Object? key) => _value.value[key];

  @override
  void operator []=(K key, V value) {
    _value.value[key] = value;
    _value.notifyListeners();
  }

  @override
  void clear() {
    _value.value.clear();
    _value.notifyListeners();
  }

  @override
  Iterable<K> get keys => _value.value.keys;

  @override
  V? remove(Object? key) {
    final removed = _value.value.remove(key);
    _value.notifyListeners();
    return removed;
  }

  @override
  void addAll(Map<K, V> other) {
    _value.value.addAll(other);
    _value.notifyListeners();
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    _value.value.addEntries(newEntries);
    _value.notifyListeners();
  }

  @override
  void addListener(VoidCallback listener) => _value.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => _value.removeListener(listener);
}
