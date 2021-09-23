import 'dart:async';

class Observable<T> {
  Observable(T value) : _value = value;
  final _syncController = StreamController<bool>.broadcast();
  T? _value;

  T? get value => _value;
  Stream<bool> get stream => _syncController.stream;

  set value(T? value) {
    _value = value;
    _sync();
  }

  void _sync() => _syncController.add(true);
}
