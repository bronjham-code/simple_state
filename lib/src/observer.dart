import 'dart:async';

import 'package:easy_state/src/observable.dart';
import 'package:flutter/widgets.dart';

class Observer extends StatelessWidget {
  Observer({
    Key? key,
    required this.observables,
    required this.builder,
  }) : super(key: key) {
    assert(observables.isNotEmpty);
    for (final observable in observables) {
      observable.stream.listen((e) => _syncController.add(e));
    }
  }
  final Widget Function(BuildContext context) builder;
  final List<Observable> observables;
  final _syncController = StreamController<bool>.broadcast();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      key: key,
      stream: _syncController.stream,
      builder: (ctx, _) => builder(ctx),
    );
  }
}
