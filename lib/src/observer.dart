import 'dart:async';

import 'package:easy_state/src/observable/observable.dart';
import 'package:easy_state/src/observer_subscribe.dart';
import 'package:flutter/widgets.dart';

class Observer extends StatefulWidget {
  const Observer({
    Key? key,
    required this.observables,
    required this.builder,
  }) : super(key: key);

  final Widget Function(BuildContext context) builder;
  final List<Observable> observables;

  @override
  State<StatefulWidget> createState() => _ObserverState();
}

class _ObserverState extends State<Observer> with ObserverSubscribe {
  List<Observable> get _observables => widget.observables;

  void _reaction() => setState(() {});

  @override
  void initState() {
    assert(_observables.isNotEmpty, 'Observable is empty');
    addSubscriptions(widget.observables, _reaction);
    super.initState();
  }

  @override
  void dispose() {
    cancelSubscriptions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);
}
