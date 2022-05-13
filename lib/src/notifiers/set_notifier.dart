// ignore_for_file: invalid_use_of_visible_for_testing_member, invalid_use_of_protected_member

import 'dart:collection';

import 'package:flutter/foundation.dart';

class SetNotifier<T> with SetMixin<T> implements ChangeNotifier {
  SetNotifier(Set<T> value) : _value = value;

  final _changeNotifier = ChangeNotifier();

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
