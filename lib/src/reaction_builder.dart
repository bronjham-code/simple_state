import 'package:flutter/widgets.dart';
import 'package:simple_state/src/reaction.dart';

/// Widget creates a reaction
class ReactionBuilder<T> extends StatefulWidget {
  /// Creates an reaction widget.
  const ReactionBuilder({
    super.key,
    required this.child,
    required this.create,
  });

  final Widget child;

  final ReactionCreateCallback<T> create;

  @override
  State<ReactionBuilder<T>> createState() => _ReactionBuilderState<T>();
}

class _ReactionBuilderState<T> extends State<ReactionBuilder<T>> {
  late final Reaction<T> _reaction;

  @override
  void initState() {
    _reaction = widget.create(context);

    super.initState();
  }

  @override
  void dispose() {
    _reaction.removeListeners();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}

/// Signature of reaction creater
typedef ReactionCreateCallback<T> = Reaction<T> Function(BuildContext context);
