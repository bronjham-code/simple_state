import 'package:flutter_test/flutter_test.dart';

import 'package:easy_state/easy_state.dart';

void main() {
  test('Change observable value', () {
    final observableList = Observable<List<int>>([0]);
    observableList.set((oldValue) => oldValue!..add(1));
    expect(observableList.value!.length, 2);
  });
}
