// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:collection';

import 'package:flutter/foundation.dart';

class MapNotifier<K, V> with MapMixin<K, V> implements ChangeNotifier {
  MapNotifier(Map<K, V> value) : _value = value;

  final Map<K, V> _value;

  final _changeNotifier = ChangeNotifier();

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

  @override
  void addListener(VoidCallback listener) => _changeNotifier.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => _changeNotifier.removeListener(listener);

  @override
  void dispose() => _changeNotifier.dispose();

  @override
  bool get hasListeners => _changeNotifier.hasListeners;

  @override
  void notifyListeners() => _changeNotifier.notifyListeners();
}
