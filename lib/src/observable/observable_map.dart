import 'package:easy_state/src/notifiers/map_notifier.dart';
import 'package:easy_state/src/observable/observable.dart';

class ObservableMap<K, V> extends Observable<Map<K, V>> {
  ObservableMap(Map<K, V> value) : super(MapNotifier<K, V>(value));
}
