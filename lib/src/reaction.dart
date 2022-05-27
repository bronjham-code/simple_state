import 'dart:async';

import 'package:simple_state/src/observer_listener_mixin.dart';
import 'package:flutter/foundation.dart';

/// Reactions are essentially a subscription to changes `Observable<T>`, `ObservableList<T>`, `ObservableMap<K,V>`
/// and `ObservableSet<T>` essentially any implementation of `Listenable`.
class Reaction with ObserverListenerMixin {
  /// Creates a new reaction.
  Reaction.when({
    required List<Listenable> listenables,
    required ConditionCallback condition,
    required VoidCallback reaction,
    bool fireImmediately = false,
  })  : _condition = condition,
        _reaction = reaction {
    addListeners(listenables, _runReaction);
    if (fireImmediately) {
      _runReaction();
    }
  }

  final ConditionCallback _condition;

  final VoidCallback _reaction;

  /// Creates a async reaction.
  static Future<void> asyncWhen({
    required List<Listenable> listenables,
    required ConditionCallback condition,
    required ReactionCallback reaction,
    bool fireImmediately = false,
  }) async {
    final completer = Completer<void>();

    final whenReaction = Reaction.when(
      listenables: listenables,
      condition: condition,
      reaction: completer.complete,
      fireImmediately: fireImmediately,
    );

    await completer.future;
    whenReaction.removeListeners();
    await reaction();
  }

  void _runReaction() {
    if (_condition()) {
      _reaction();
    }
  }
}

/// Signature of the conditions returning true
typedef ConditionCallback = bool Function();

/// Signature of callbacks or async callbacks that take no arguments and return no data.
typedef ReactionCallback = FutureOr<void> Function();
