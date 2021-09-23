import 'dart:async';

import 'package:easy_state/src/observable/observable.dart';
import 'package:easy_state/src/observer_subscribe.dart';

class Reaction with ObserverSubscribe {
  Reaction.when({
    required List<Observable> observables,
    required bool Function() condition,
    required void Function() reaction,
    bool fireImmediately = false,
  })  : _condition = condition,
        _reaction = reaction {
    addSubscriptions(observables, _runReaction);
    if (fireImmediately) {
      _runReaction();
    }
  }

  static Future<void> asyncWhen({
    required List<Observable> observables,
    required bool Function() condition,
    required void Function() reaction,
  }) async {
    final completer = Completer<bool>();

    final whenReaction = Reaction.when(
      observables: observables,
      condition: condition,
      reaction: () {
        completer.complete(true);
      },
    );

    await completer.future;
    whenReaction.cancelSubscriptions();
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
