import 'dart:async';

import 'package:easy_state/src/observable/observable.dart';

mixin ObserverSubscribe {
  final _subscriptions = <StreamSubscription<bool>>[];

  void addSubscriptions(List<Observable> observables, void Function() function) {
    for (final observable in observables) {
      _subscriptions.add(observable.stream.listen((_) => function()));
    }
  }

  void cancelSubscriptions() {
    for (final subscription in _subscriptions) {
      subscription.cancel();
    }
  }
}
