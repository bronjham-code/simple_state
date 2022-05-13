import 'package:simple_state/src/observable/observable.dart';
import 'package:simple_state/src/observer_listener.dart';
import 'package:flutter/widgets.dart';

class Observer extends StatefulWidget {
  const Observer({
    Key? key,
    required this.listenables,
    required this.builder,
  }) : super(key: key);

  final WidgetBuilder builder;
  final List<Listenable> listenables;

  @override
  State<StatefulWidget> createState() => _ObserverState();
}

class _ObserverState extends State<Observer> with ObserverListener {
  List<Listenable> get _listenables => widget.listenables;

  void _emptyCallback() {}

  void _reaction() => setState(_emptyCallback);

  @override
  void initState() {
    if (_listenables.isNotEmpty) {
      addListeners(_listenables, _reaction);
    }

    super.initState();
  }

  @override
  void dispose() {
    if (_listenables.isNotEmpty) {
      removeListeners();
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.builder(context);
}
