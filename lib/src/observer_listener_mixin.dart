import 'package:flutter/foundation.dart';

mixin ObserverListenerMixin {
  VoidCallback? _callback;
  final _listenables = <Listenable>[];

  void addListeners(List<Listenable> listenables, VoidCallback callback) {
    if (_listenables.isNotEmpty) {
      removeListeners();
    }
    _callback = callback;
    _listenables.addAll(listenables);
    for (final listenable in listenables) {
      listenable.addListener(callback);
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
