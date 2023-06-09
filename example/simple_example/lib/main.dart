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
  final _counter = ObservableList<int>();

  late final Reaction _whenReaction;

  Future<void> _asyncWhen() => Reaction.asyncWhen(
        condition: () => _counter.value.length == 5,
        reaction: _counter.value.clear,
      );

  @override
  void initState() {
    _whenReaction = _counter.when(
      (observable) => observable.value.length == 2,
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
        builder: (_) => AppBar(
          title: Text(
            _counter.value.length.toString(),
          ),
        ),
      ),
      body: Center(
        child: Observer(
          builder: (_) => Text(
            _counter.value.toString(),
            style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        icon: const Icon(Icons.add),
        label: const Text('Add Item'),
        onPressed: () => _counter.value.add(_counter.value.length + 1),
      ),
    );
  }
}
