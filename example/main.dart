import 'package:simple_state/simple_state.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      const MaterialApp(
        home: ExampleView(),
      ),
    );

class ExampleView extends StatefulWidget {
  const ExampleView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ExampleViewState();
}

class _ExampleViewState extends State<ExampleView> {
  final counter = ObservableList<int>();
  final observ = Observable('value');

  late final Reaction _whenReaction;

  Future<void> _asyncWhen() => Reaction.asyncWhen(
        listenables: [counter],
        condition: () => counter.length == 5,
        reaction: counter.clear,
      );

  @override
  void initState() {
    _whenReaction = Reaction.when(
      listenables: [counter],
      condition: () => counter.length == 2,
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
          listenables: [counter],
          builder: (_) => Text(
            counter.toString(),
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Increment'),
        onPressed: () => counter.add(counter.length + 1),
      ),
    );
  }
}
