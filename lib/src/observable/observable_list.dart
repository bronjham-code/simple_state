// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:collection';
import 'dart:math';

import 'package:easy_state/src/observable/observable.dart';
import 'package:flutter/foundation.dart';

class ObservableList<T> with ListMixin<T> implements Observable<List<T>> {
  ObservableList(List<T> value) : _value = ValueNotifier(value);

  final ValueNotifier<List<T>> _value;

  @override
  int get length => _value.value.length;

  @override
  set length(int newLength) => _value.value.length = newLength;

  @override
  T operator [](int index) => _value.value[index];

  @override
  void operator []=(int index, T value) {
    _value.value[index] = value;
    _value.notifyListeners();
  }

  @override
  List<T> get value => this;

  @override
  set value(List<T> value) => _value.value = value;

  @override
  List<T> operator +(List<T> other) => _value.value = _value.value + other;

  @override
  void clear() {
    _value.value.clear();
    _value.notifyListeners();
  }

  @override
  bool remove(Object? element) {
    final isRemoved = _value.value.remove(value);
    if (isRemoved) {
      _value.notifyListeners();
    }

    return isRemoved;
  }

  @override
  T removeAt(int index) {
    final beforeLength = _value.value.length;
    final removeAt = _value.value.removeAt(index);
    final afterLength = _value.value.length;

    if (beforeLength != afterLength) {
      _value.notifyListeners();
    }

    return removeAt;
  }

  @override
  T removeLast() {
    final beforeLength = _value.value.length;
    final removeLast = _value.value.removeLast();
    final afterLength = _value.value.length;

    if (beforeLength != afterLength) {
      _value.notifyListeners();
    }

    return removeLast;
  }

  @override
  void shuffle([Random? random]) {
    _value.value.shuffle(random);
    _value.notifyListeners();
  }

  @override
  void sort([int Function(T a, T b)? compare]) {
    _value.value.sort();
    _value.notifyListeners();
  }

  @override
  void addListener(VoidCallback listener) => _value.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => _value.removeListener(listener);
}
