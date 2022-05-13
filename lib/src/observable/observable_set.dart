import 'package:easy_state/src/notifiers/set_notifier.dart';
import 'package:easy_state/src/observable/observable.dart';

class ObservableSet<T> extends Observable<Set<T>> {
  ObservableSet(Set<T> value) : super(SetNotifier<T>(value));
}
