import 'package:simple_state/simple_state.dart';
import 'package:flutter/material.dart';

void main() => runApp(
      const MaterialApp(
        home: ExampleView(),
      ),
    );

class ExampleView extends StatefulWidget {
  const ExampleView({super.key});

  @override
  State<StatefulWidget> createState() => _ExampleViewState();
}

class _ExampleViewState extends State<ExampleView> {
  final counter = ObservableList<int>();

  late final Reaction _whenReaction;

  Future<void> _asyncWhen() => Reaction.asyncWhen(
        listenables: [counter],
        condition: () => counter.length == 5,
        reaction: counter.clear,
      );

  @override
  void initState() {
    _whenReaction = counter.when(
      (observable) => observable.length == 2,
      _asyncWhen,
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
      appBar: ObserverPreferredSize(
        listenables: [counter],
        builder: (_) => AppBar(
          title: Text(
            counter.length.toString(),
          ),
        ),
      ),
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
