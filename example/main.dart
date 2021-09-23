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
        onPressed: () => counter.set(
          (oldValue) => oldValue! + 1,
        ),
      ),
    );
  }
}
