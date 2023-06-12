import 'package:flutter/foundation.dart';

/// A mixin that allows you to add and remove listeners.
mixin ObserverListenerMixin {
  VoidCallback? _callback;
  final _listenables = <Listenable>[];

  void addListener(Listenable listenable, VoidCallback callback) {
    if (_listenables.contains(listenable)) {
      return;
    }
    _callback = callback;
    _listenables.add(listenable);
    listenable.addListener(callback);
  }

  void removeListeners() {
    final callback = _callback;
    if (callback != null) {
      for (final listenable in _listenables) {
        listenable.removeListener(callback);
      }
    }
    _listenables.clear();
  }
}
