import 'package:simple_state/src/observer_listener_mixin.dart';
import 'package:flutter/widgets.dart';

/// The observer widget is rebuilt every time the listener is called.
class Observer extends StatefulWidget {
  /// Creates an observable widget.
  const Observer({
    super.key,
    required this.listenables,
    required this.builder,
  });

  final WidgetBuilder builder;

  final List<Listenable> listenables;

  @override
  State<StatefulWidget> createState() => _ObserverState();
}

class _ObserverState extends State<Observer> with ObserverListenerMixin {
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
