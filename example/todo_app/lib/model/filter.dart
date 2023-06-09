import 'package:simple_state/simple_state.dart';
import 'package:simple_state_todo/model/filter_type.dart';

class Filter<T> {
  late final String name;

  final FilterType type;

  final ObservableList<T> _items;

  final bool Function(T)? _filter;

  late final ObservableList<T> filteredItems;

  Filter(this.type, this._items, this._filter) {
    name = type.name[0].toUpperCase() + type.name.substring(1);
    if (_filter != null) {
      filteredItems = ObservableList<T>(_filtered.toList());
      _items.addListener(_update);
    } else {
      filteredItems = _items;
    }
  }

  Iterable<T> get _filtered => _items.value.where(_filter!);

  void _update() {
    filteredItems.value.clear();
    filteredItems.value.addAll(_filtered);
  }

  void dispose() {
    _items.removeListener(_update);
    filteredItems.dispose();
  }
}
