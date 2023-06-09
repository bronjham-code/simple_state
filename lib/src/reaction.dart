import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:simple_state/src/observer_listener_mixin.dart';
import 'package:simple_state/src/store.dart';

/// Reactions are essentially a subscription to changes `ObservableBase<T>` essentially any implementation of `Listenable`.
class Reaction<T> with ObserverListenerMixin {
  /// Creates a new reaction.
  Reaction.when({
    required PointerCallback<T> pointer,
    required ReactionCallback<T> reaction,
    ReactionWhenCallback<T>? when,
    bool fireImmediately = false,
  })  : _when = when,
        _pointer = pointer,
        _reaction = reaction {
    Store.instance.beginBuild(_listen);
    _pointer();
    Store.instance.endBuild(_listen);

    if (fireImmediately) {
      _runReaction();
    }
  }
  T? _previousValue;

  final PointerCallback<T> _pointer;

  final ReactionCallback<T> _reaction;

  final ReactionWhenCallback<T>? _when;

  /// Creates a async reaction.
  static Future<void> asyncWhen<T>({
    required PointerCallback<T> pointer,
    required ReactionCallback<T> reaction,
    ReactionWhenCallback<T>? when,
    bool fireImmediately = false,
  }) async {
    final completer = Completer<void>();

    final whenReaction = Reaction.when(
      when: when,
      pointer: pointer,
      reaction: completer.complete,
      fireImmediately: fireImmediately,
    );

    await completer.future;
    whenReaction.removeListeners();
    await reaction(pointer());
  }

  void _listen(Listenable listenable) {
    addListener(listenable, _runReaction);
  }

  void _runReaction() {
    final when = _when;
    final currentValue = _pointer();

    if (when != null &&
        !when(
          currentValue,
          _previousValue,
        )) {
      return;
    }
    _previousValue = currentValue;
    _reaction(currentValue);
  }
}

/// Signature of the pointer
typedef PointerCallback<T> = T Function();

/// Signature of the pointer
typedef ReactionWhenCallback<T> = bool Function(T current, T? previous);

/// Signature of callbacks or async callbacks that take no arguments and return no data.
typedef ReactionCallback<T> = FutureOr<void> Function(T);
