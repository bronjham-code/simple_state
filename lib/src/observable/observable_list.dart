import 'package:easy_state/src/observable/observable.dart';

class ObservableList<T> extends Observable<List<T>> {
  ObservableList(List<T> value) : super(value);

  List<T> get _val => super.value;
  set _val(List<T> value) => super.value = value;

  void add(T value) => _val = _val..add(value);
  void remove(T value) => _val = _val..remove(value);
  void removeLast() => _val = _val..removeLast();
  void addAll(Iterable<T> iterable) => _val = _val..addAll(iterable);
}
