import 'dart:collection';
import 'dart:math';

import 'package:flutter/foundation.dart';

class ListNotifier<T> with ListMixin<T> implements ChangeNotifier {
  ListNotifier(List<T> value) : _value = value;

  final _changeNotifier = ChangeNotifier();

  List<T> _value;

  @override
  int get length => _value.length;

  @override
  set length(int newLength) => _value.length = newLength;

  @override
  T operator [](int index) => _value[index];

  @override
  void operator []=(int index, T value) {
    _value[index] = value;
    notifyListeners();
  }

  @override
  List<T> operator +(List<T> other) => _value = _value + other;

  @override
  void clear() {
    _value.clear();
    notifyListeners();
  }

  @override
  bool remove(Object? element) {
    final isRemoved = _value.remove(element);
    if (isRemoved) {
      notifyListeners();
    }

    return isRemoved;
  }

  @override
  T removeAt(int index) {
    final beforeLength = _value.length;
    final removeAt = _value.removeAt(index);
    final afterLength = _value.length;

    if (beforeLength != afterLength) {
      notifyListeners();
    }

    return removeAt;
  }

  @override
  T removeLast() {
    final beforeLength = _value.length;
    final removeLast = _value.removeLast();
    final afterLength = _value.length;

    if (beforeLength != afterLength) {
      notifyListeners();
    }

    return removeLast;
  }

  @override
  void shuffle([Random? random]) {
    _value.shuffle(random);
    notifyListeners();
  }

  @override
  void sort([int Function(T a, T b)? compare]) {
    _value.sort();
    notifyListeners();
  }

  @override
  void add(T element) {
    _value.add(element);
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
