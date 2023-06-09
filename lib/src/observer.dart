import 'package:flutter/widgets.dart';
import 'package:simple_state/src/observer_listener_mixin.dart';
import 'package:simple_state/src/store.dart';

/// The observer widget is rebuilt every time the listener is called.
class Observer extends StatefulWidget {
  /// Creates an observable widget.
  const Observer({
    super.key,
    required this.builder,
  });

  final WidgetBuilder builder;

  @override
  State<Observer> createState() => _ObserverState();
}

class _ObserverState extends State<Observer> with ObserverListenerMixin {
  void _reaction() => setState(() {});

  void _listen(Listenable listenable) => addListener(listenable, _reaction);

  Widget _build(BuildContext context) {
    Store.instance.beginBuild(_listen);
    final child = widget.builder(context);
    Store.instance.endBuild(_listen);

    return child;
  }

  @override
  void dispose() {
    removeListeners();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) => _build(context);
}
