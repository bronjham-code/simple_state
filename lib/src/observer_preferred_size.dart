import 'package:flutter/widgets.dart';
import 'package:simple_state/src/observer.dart';

/// The observer preferred size widget is rebuilt every time the listener is called.
class ObserverPreferredSize extends PreferredSize {
  /// Creates a observable that has a preferred size that the parent can query.

  ObserverPreferredSize({
    super.key,
    required this.listenables,
    required this.builder,
  }) : super(
          preferredSize: builder(null).preferredSize,
          child: Observer(
            listenables: listenables,
            builder: builder,
          ),
        );

  final PreferredSizeWidgetBuilder builder;

  final List<Listenable> listenables;
}

/// Signature for a function that creates a preffered size widget.
///
/// It is also worth paying attention to the fact that the first call to the builder function
/// will return a null context, this is necessary to get the sizes.
typedef PreferredSizeWidgetBuilder = PreferredSizeWidget Function(
    BuildContext? context);
