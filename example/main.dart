import 'package:easy_state/easy_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExampleView extends StatefulWidget {
  const ExampleView();

  @override
  State<StatefulWidget> createState() => _ExampleViewState();
}

class _ExampleViewState extends State<ExampleView> {
  final counter = Observable<int>(0);

  late final Reaction _whenReaction;

  Future<void> _asyncWhen() async {
    await Reaction.asyncWhen(
      observables: [counter],
      condition: () => counter.value == 5,
      reaction: () => counter.value = 0,
    );
  }

  @override
  void initState() {
    _whenReaction = Reaction.when(
      observables: [counter],
      condition: () => counter.value == 2,
      reaction: () => _asyncWhen,
    );
    super.initState();
  }

  @override
  void dispose() {
    _whenReaction.cancelSubscriptions();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Observer(
          observables: [counter],
          builder: (_) => Text(
            counter.value.toString(),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => counter.value! + 1,
      ),
    );
  }
}
