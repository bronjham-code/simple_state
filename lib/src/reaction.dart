import 'dart:async';

import 'package:easy_state/src/observable/observable.dart';
import 'package:easy_state/src/observer_listener.dart';

class Reaction with ObserverListener {
  Reaction.when({
    required List<Observable> observables,
    required bool Function() condition,
    required void Function() reaction,
    bool fireImmediately = false,
  })  : _condition = condition,
        _reaction = reaction {
    addListeners(observables, _runReaction);
    if (fireImmediately) {
      _runReaction();
    }
  }

  static Future<void> asyncWhen({
    required List<Observable> observables,
    required bool Function() condition,
    required void Function() reaction,
    bool fireImmediately = false,
  }) async {
    final completer = Completer<void>();

    final whenReaction = Reaction.when(
      observables: observables,
      condition: condition,
      reaction: () => completer.complete(),
      fireImmediately: fireImmediately,
    );

    await completer.future;
    whenReaction.removeListeners();
    reaction();
  }

  final bool Function() _condition;
  final void Function() _reaction;

  void _runReaction() {
    if (_condition()) {
      _reaction();
    }
  }
}
