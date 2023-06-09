import 'package:simple_state/simple_state.dart';
import 'package:simple_state_todo/model/filter.dart';
import 'package:simple_state_todo/model/filter_type.dart';
import 'package:simple_state_todo/model/todo.dart';

class TodoList {
  final title = Observable('');
  final items = ObservableList([
    const Todo('Play chess', false),
    const Todo('Play football', false),
    const Todo('Clean floor', false),
    const Todo('Purchase food', false),
    const Todo('Do homework', true),
    const Todo('Go for a walk', false),
    const Todo('Start new project', false),
    const Todo('Finalize report', false),
    const Todo('Wash dishes', false),
    const Todo('Plat the guitar', true),
  ]);

  late final Filter<Todo> all;

  late final Filter<Todo> pending;

  late final Filter<Todo> completed;

  late final List<Filter<Todo>> filters;

  late final Observable<Filter<Todo>> selectedFilter;

  TodoList() {
    filters = [
      all = Filter(FilterType.all, items, null),
      pending = Filter(FilterType.pending, items, Todo.isPending),
      completed = Filter(FilterType.completed, items, Todo.isCompleted),
    ];

    selectedFilter = Observable(all);
  }

  bool get hasCompleted => items.value.any((todo) => todo.completed);

  bool get hasNotCompleted => items.value.any((todo) => !todo.completed);

  void add() {
    items.value.insert(0, Todo(title.value, false));
    title.value = '';
  }

  void removeCompleted() => items.value.removeWhere((todo) => todo.completed);

  void toggleCompleted(Todo todo) => items.value[items.value.indexOf(todo)] = todo.toggleCompleted();

  void markAllCompleted() {
    for (int index = 0; index < items.value.length; ++index) {
      final todo = items.value[index];
      if (!todo.completed) {
        items.value[index] = todo.markCompleted();
      }
    }
  }

  void setFilterByIndex(int index) => selectedFilter.value = filters[index];

  void setTitle(String value) => title.value = value;

  void delete(Todo todo) => items.value.remove(todo);

  void dispose() {
    for (final filter in filters) {
      filter.dispose();
    }

    title.dispose();
    items.dispose();
    selectedFilter.dispose();
  }
}
