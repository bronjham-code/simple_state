import 'package:flutter_test/flutter_test.dart';

import 'package:easy_state/easy_state.dart';

void main() {
  test('Change observable value', () {
    final observableList = ObservableList<int>([0]);
    observableList.add(1);
    expect(observableList.value!.length, 2);
  });
}
