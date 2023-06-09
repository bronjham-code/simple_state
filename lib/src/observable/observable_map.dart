import 'dart:collection';
import 'package:flutter/foundation.dart';
import 'package:simple_state/src/observable/observable.dart';
import 'package:simple_state/src/store.dart';

/// A observable collection of key/value pairs, from which you retrieve a value
/// using its associated key.
///
class ObservableMap<K, V> implements ObservableBase<Map<K, V>> {
  ObservableMap([Map<K, V>? value]) : _value = _ObservableMap(value ?? {});
  final _ObservableMap<K, V> _value;

  @override
  Map<K, V> get value {
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

class _ObservableMap<K, V> extends ChangeNotifier with MapMixin<K, V> {
  /// Creates an observable [LinkedHashMap].
  _ObservableMap([Map<K, V>? value]) : _value = value ?? {};

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
