import 'package:easy_state/easy_state.dart';
import 'package:flutter/material.dart';

class ExampleView extends StatefulWidget {
  const ExampleView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExampleViewState();
}

class _ExampleViewState extends State<ExampleView> {
  final counter = ObservableList<int>([]);

  late final Reaction _whenReaction;

  Future<void> _asyncWhen() async {
    await Reaction.asyncWhen(
      observables: [counter],
      condition: () => counter.value.length == 5,
      reaction: () => counter.value.length = 0,
    );
  }

  @override
  void initState() {
    _whenReaction = Reaction.when(
      observables: [counter],
      condition: () => counter.value.length == 2,
      reaction: _asyncWhen,
    );
    super.initState();
  }

  @override
  void dispose() {
    _whenReaction.removeListeners();
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
          counter.value.add(counter.value.length + 1);
        },
      ),
    );
  }
}
