import 'dart:async';

import 'package:easy_state/src/observer_listener.dart';
import 'package:flutter/foundation.dart';

class Reaction with ObserverListener {
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

  static Future<void> asyncWhen({
    required List<Listenable> listenables,
    required ConditionCallback condition,
    required VoidCallback reaction,
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
    reaction();
  }

  void _runReaction() {
    if (_condition()) {
      _reaction();
    }
  }
}

typedef ConditionCallback = bool Function();
