import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:simple_state/src/reaction.dart';

/// Widget creates a reaction
class ReactionWidget extends StatefulWidget {
  /// Creates an reaction widget.
  const ReactionWidget({
    super.key,
    required this.condition,
    required this.reaction,
    required this.child,
    this.fireImmediately = false,
  });

  final ConditionCallback condition;

  final ReactionWidgetCallback reaction;

  final bool fireImmediately;

  final Widget child;

  @override
  State<ReactionWidget> createState() => _ReactionWidgetState();
}

class _ReactionWidgetState extends State<ReactionWidget> {
  late final Reaction _reaction;

  @override
  void initState() {
    _reaction = Reaction.when(
      condition: widget.condition,
      reaction: () => widget.reaction(context),
      fireImmediately: widget.fireImmediately,
    );

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

/// Signature of widget callbacks or asynchronous callbacks that accept a context and return no data.
typedef ReactionWidgetCallback = FutureOr<void> Function(BuildContext context);
