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
  void addListener(VoidCallback listener) => _value.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => _value.removeListener(listener);

  @override
  List<T> operator +(List<T> other) => _value.value = _value.value + other;

  @override
  void add(T element) {
    _value.value.add(element);
    _value.notifyListeners();
  }

  @override
  void addAll(Iterable<T> iterable) {
    _value.value.addAll(iterable);
    _value.notifyListeners();
  }

  @override
  void clear() {
    _value.value.clear();
    _value.notifyListeners();
  }

  @override
  void fillRange(int start, int end, [T? fill]) {
    _value.value.fillRange(start, end, fill);
    _value.notifyListeners();
  }

  @override
  void insert(int index, T element) {
    _value.value.insert(index, element);
    _value.notifyListeners();
  }

  @override
  void insertAll(int index, Iterable<T> iterable) {
    _value.value.insertAll(index, iterable);
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
  void removeRange(int start, int end) {
    _value.value.removeRange(start, end);
    _value.notifyListeners();
  }

  @override
  void removeWhere(bool Function(T element) test) {
    _value.value.removeWhere(test);
    _value.notifyListeners();
  }

  @override
  void replaceRange(int start, int end, Iterable<T> newContents) {
    _value.value.replaceRange(start, end, newContents);
    _value.notifyListeners();
  }

  @override
  void retainWhere(bool Function(T element) test) {
    _value.value.retainWhere(test);
    _value.notifyListeners();
  }

  @override
  void setAll(int index, Iterable<T> iterable) {
    _value.value.setAll(index, iterable);
    _value.notifyListeners();
  }

  @override
  void setRange(int start, int end, Iterable<T> iterable, [int skipCount = 0]) {
    _value.value.setRange(start, end, iterable, skipCount);
    _value.notifyListeners();
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
}
