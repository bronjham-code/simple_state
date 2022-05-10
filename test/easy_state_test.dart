import 'package:flutter_test/flutter_test.dart';

import 'package:easy_state/easy_state.dart';

void main() {
  test('Change observable value', () {
    final observable = Observable<int>(0);
    expect(observable.value, 0);
    observable.value = 33;
    expect(observable.value, 33);
  });

  test('Change observable list value', () {
    final observableList = ObservableList<int>([]);
    expect(observableList.value.length, 0);
    observableList.value.add(33);
    expect(observableList.value.length, 1);
    expect(observableList.value.last, 33);
  });

  test('Change observable set value', () {
    final observableList = ObservableSet<int>({});
    expect(observableList.value.length, 0);
    observableList.value.add(33);
    expect(observableList.value.length, 1);
    expect(observableList.value.last, 33);
  });

  test('Change observable map value', () {
    final observableList = ObservableMap<int, int?>({});
    expect(observableList.value.length, 0);
    observableList.value.putIfAbsent(33, () => 34);
    expect(observableList.value.length, 1);
    expect(observableList.value[33], 34);
  });
}
