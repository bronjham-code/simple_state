import 'dart:collection';
import 'package:flutter/foundation.dart';

class ObservableMap<K, V> extends ChangeNotifier with MapMixin<K, V> {
  ObservableMap([Map<K, V>? value]) : _value = value ?? {};

  final Map<K, V> _value;

  @override
  V? operator [](Object? key) => _value[key];

  @override
  void operator []=(K key, V value) {
    _value[key] = value;
    notifyListeners();
  }

  @override
  void clear() {
    _value.clear();
    notifyListeners();
  }

  @override
  Iterable<K> get keys => _value.keys;

  @override
  V? remove(Object? key) {
    final removed = _value.remove(key);
    notifyListeners();
    return removed;
  }

  @override
  void addAll(Map<K, V> other) {
    _value.addAll(other);
    notifyListeners();
  }

  @override
  void addEntries(Iterable<MapEntry<K, V>> newEntries) {
    _value.addEntries(newEntries);
    notifyListeners();
  }
}
