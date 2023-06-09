import 'package:flutter/widgets.dart';
import 'package:simple_state/src/reaction.dart';

/// Widget creates a reaction
class ReactionBuilder<T> extends StatefulWidget {
  /// Creates an reaction widget.
  const ReactionBuilder({
    super.key,
    required this.child,
    required this.reaction,
  });

  final Widget child;

  final Reaction<T> reaction;

  @override
  State<ReactionBuilder<T>> createState() => _ReactionBuilderState<T>();
}

class _ReactionBuilderState<T> extends State<ReactionBuilder<T>> {
  @override
  void dispose() {
    widget.reaction.removeListeners();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
