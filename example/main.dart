import 'package:easy_state/easy_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ExampleView extends StatefulWidget {
  const ExampleView({Key? key}) : super(key: key);

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
      reaction: _asyncWhen,
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
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Increment'),
        onPressed: () {
          counter.value = counter.value! + 1;
        },
      ),
    );
  }
}
