## Introduction
#### What is SimpleState?
It’s a Flutter package, that makes it easy to connect your application's reactive data to the user interface.

## Installation
 ```yaml
dependencies:
  simple_state: [latest-version]
``` 
## Usage
#### Simple observable object
To work with the simplest objects, `Observable<T>` is used, it allows you to notify the observer when it changes, but will not work with collections or if the contents of the object change.

```dart
class SimpleObservable extends StatelessWidget {
  SimpleObservable({Key? key}) : super(key: key);

  final _simpleObservable = Observable('Hello');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // Observer fires every time the listenables changes
          child: Observer(
            listenables: [_simpleObservable],
            builder: (_) => Text(_simpleObservable.value),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.flutter_dash),
          // Change observable value
          onPressed: () => _simpleObservable.value += '\nWorld',
        ),
      ),
    );
  }
}
```
#### Collections observable objects
To work with collections, three classes are implemented `ObservableList<T>`, `ObservableMap<K,V>` and `ObservableSet<T>`, in which when adding / changing / deleting an element of the collection, the observer is notified.

```dart
class CollectionsObservable extends StatelessWidget {
  CollectionsObservable({Key? key}) : super(key: key);

  final _listObservable = ObservableList([0]);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // Observer fires every time the listenables changes
          child: Observer(
            listenables: [_listObservable],
            builder: (_) => ListView.builder(
              itemCount: _listObservable.length,
              itemBuilder: (_, i) => Text(_listObservable[i].toString()),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.flutter_dash),
          // Add item observable value
          onPressed: () => _listObservable.add(_listObservable.length + 1),
        ),
      ),
    );
  }
}
```

#### Custom observable object
You can also implement complex objects that can notify the observer of a change.

```dart
class CustomTitleObservable extends ChangeNotifier {
  CustomTitleObservable([String? title]) : _title = title;

  String? _title;

  String get title => _title ?? '';

  set title(String value) {
    _title = value;

    notifyListeners();
  }
}

class CustomObservable extends StatelessWidget {
  CustomObservable({Key? key}) : super(key: key);

  late final _customObservable = CustomTitleObservable('#');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // Observer fires every time the listenables changes
          child: Observer(
            listenables: [_customObservable],
            builder: (_) => Text(_customObservable.title),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.flutter_dash),
          // Add item observable value
          onPressed: () => _customObservable.title += '!',
        ),
      ),
    );
  }
}
```
#### Reactions
Reactions are essentially a subscription to changes `Observable<T>`, `ObservableList<T>`, `ObservableMap<K,V>` and `ObservableSet<T>` essentially any implementation of `Listenable` You can create a reaction Reaction.when it returns an object of type Reaction, removeListeners() must be called to remove the reaction. You can also create an asynchronous reaction Reaction.asyncWhen.

```dart
class ReactionObservable extends StatefulWidget {
  const ReactionObservable({Key? key}) : super(key: key);

  @override
  _ReactionObservableState createState() => _ReactionObservableState();
}

class _ReactionObservableState extends State<ReactionObservable> {
  late final _setObservable = ObservableSet<int>({});

  late final Reaction _reaction;

  @override
  void initState() {
    // Creating a reaction that clears the set when the length of the set is five elements
    _reaction = Reaction.when(
      listenables: [_setObservable],
      condition: () => _setObservable.length == 5,
      reaction: _setObservable.clear,
    );

    super.initState();
  }

  @override
  void dispose() {
    // Deleting a reaction subscription
    _reaction.removeListeners();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          // Observer fires every time the listenables changes
          child: Observer(
            listenables: [_setObservable],
            builder: (_) => ListView.builder(
              itemCount: _setObservable.length,
              itemBuilder: (_, i) => Text(_setObservable.toList()[i].toString()),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.flutter_dash),
          // Add item observable value
          onPressed: () => _setObservable.add(_setObservable.length + 1),
        ),
      ),
    );
  }
}
```

See also an example using `/example` folder
