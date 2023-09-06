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

  List<int> get _getCounter => _counter.value;

  late final Reaction _whenReaction;

  Future<void> _asyncWhen() => Reaction.asyncWhen(
        pointer: () => _getCounter.length,
        reaction: (_) => _getCounter.clear(),
        when: (current, previous) => current == 5,
      );

  @override
  void dispose() {
    _whenReaction.removeListeners();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ReactionBuilder(
      create: (context) => Reaction.when(
        pointer: () => _getCounter.length,
        reaction: (_) => _asyncWhen(),
        when: (current, previous) => current == 2,
      ),
      child: Scaffold(
        appBar: ObserverPreferredSize(
          builder: (_) => AppBar(
            title: Text(
              _getCounter.length.toString(),
            ),
          ),
        ),
        body: Center(
          child: Observer(
            builder: (_) => ListView.builder(
              itemCount: _getCounter.length,
              itemBuilder: (context, index) => Text(
                _getCounter[index].toString(),
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.add),
          label: const Text('Add Item'),
          onPressed: () => _getCounter.add(_getCounter.length + 1),
        ),
      ),
    );
  }
}
