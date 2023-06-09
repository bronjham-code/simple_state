import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:simple_state/src/observer_listener_mixin.dart';
import 'package:simple_state/src/store.dart';

/// Reactions are essentially a subscription to changes `Observable<T>`, `ObservableList<T>`, `ObservableMap<K,V>`
/// and `ObservableSet<T>` essentially any implementation of `Listenable`.
class Reaction with ObserverListenerMixin {
  /// Creates a new reaction.
  Reaction.when({
    required ConditionCallback condition,
    required VoidCallback reaction,
    bool fireImmediately = false,
  })  : _condition = condition,
        _reaction = reaction {
    Store.instance.beginBuild(_listen);
    _condition();
    Store.instance.endBuild(_listen);

    if (fireImmediately) {
      _runReaction();
    }
  }

  final ConditionCallback _condition;

  final VoidCallback _reaction;

  /// Creates a async reaction.
  static Future<void> asyncWhen({
    required ConditionCallback condition,
    required ReactionCallback reaction,
    bool fireImmediately = false,
  }) async {
    final completer = Completer<void>();

    final whenReaction = Reaction.when(
      condition: condition,
      reaction: completer.complete,
      fireImmediately: fireImmediately,
    );

    await completer.future;
    whenReaction.removeListeners();
    await reaction();
  }

  void _listen(Listenable listenable) {
    addListener(listenable, _runReaction);
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
