// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:collection';

import 'package:easy_state/src/observable/observable.dart';
import 'package:flutter/foundation.dart';

class ObservableSet<E> with SetMixin<E> implements Observable<Set<E>> {
  ObservableSet(Set<E> value) : _value = ValueNotifier(value);

  final ValueNotifier<Set<E>> _value;

  @override
  Set<E> get value => this;

  @override
  set value(Set<E> value) => _value.value = value;

  @override
  bool add(E value) {
    final isAdded = _value.value.add(value);
    if (isAdded) {
      _value.notifyListeners();
    }

    return isAdded;
  }

  @override
  bool contains(Object? element) => _value.value.contains(value);

  @override
  Iterator<E> get iterator => _value.value.iterator;

  @override
  int get length => _value.value.length;

  @override
  E? lookup(Object? element) => _value.value.lookup(element);

  @override
  bool remove(Object? value) {
    final isRemoved = _value.value.remove(value);

    if (isRemoved) {
      _value.notifyListeners();
    }

    return isRemoved;
  }

  @override
  Set<E> toSet() => _value.value.toSet();

  @override
  void addListener(VoidCallback listener) => _value.addListener(listener);

  @override
  void removeListener(VoidCallback listener) => _value.removeListener(listener);
}
