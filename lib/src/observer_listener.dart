import 'package:flutter/foundation.dart';

mixin ObserverListener {
  VoidCallback? _callback;
  final _listenables = <Listenable>[];

  void addListeners(List<Listenable> observables, VoidCallback callback) {
    if (_listenables.isNotEmpty) {
      removeListeners();
    }
    _callback = callback;
    _listenables.addAll(observables);
    for (final observable in observables) {
      observable.addListener(callback);
    }
  }

  void removeListeners() {
    if (_callback != null) {
      for (final listenable in _listenables) {
        listenable.removeListener(_callback!);
      }
    }
    _listenables.clear();
  }
}
