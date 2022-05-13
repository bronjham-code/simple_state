import 'package:easy_state/src/notifiers/list_notifier.dart';
import 'package:easy_state/src/observable/observable.dart';

class ObservableList<T> extends Observable<List<T>> {
  ObservableList(List<T> value) : super(ListNotifier<T>(value));
}
