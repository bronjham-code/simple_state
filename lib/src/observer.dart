import 'package:easy_state/src/observable/observable.dart';
import 'package:easy_state/src/observer_listener.dart';
import 'package:flutter/widgets.dart';

class Observer extends StatefulWidget {
  const Observer({
    Key? key,
    required this.observables,
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;
  final List<Observable> observables;

  @override
  State<StatefulWidget> createState() => _ObserverState();
}

class _ObserverState extends State<Observer> with ObserverListener {
  List<Observable> get _observables => widget.observables;

  void _emptyCallback() {}

  void _reaction() => setState(_emptyCallback);

  @override
  void initState() {
    if (_observables.isNotEmpty) {
      addListeners(_observables, _reaction);
    }

    super.initState();
  }

  @override
  void dispose() {
    if (_observables.isNotEmpty) {
      removeListeners();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);
}
