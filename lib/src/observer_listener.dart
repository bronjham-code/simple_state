import 'package:easy_state/src/observable/observable.dart';
import 'package:flutter/foundation.dart';

mixin ObserverListener {
  VoidCallback? _callback;
  final _observables = <Observable>[];

  void addListeners(List<Observable> observables, VoidCallback callback) {
    if (_observables.isNotEmpty) {
      removeListeners();
    }
    _callback = callback;
    _observables.addAll(observables);
    for (final observable in observables) {
      observable.addListener(callback);
    }
  }

  void removeListeners() {
    if (_callback != null) {
      for (final observable in _observables) {
        observable.removeListener(_callback!);
      }
    }
    _observables.clear();
  }
}
