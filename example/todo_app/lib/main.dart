import 'package:flutter/material.dart';
import 'package:simple_state/simple_state.dart';
import 'package:simple_state_todo/model/todo.dart';
import 'package:simple_state_todo/model/todo_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MyHomePage(title: 'Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    super.key,
    required this.title,
  });

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final _todoList = TodoList();

  final _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onControllerChanged);
  }

  void _onAddPressed() {
    _todoList.add();
    _controller.text = '';
    FocusManager.instance.primaryFocus?.unfocus();
  }

  void _onControllerChanged() => _todoList.setTitle(_controller.text);

  void _onDeletePressed(Todo todo) => _todoList.delete(todo);

  void _toggleCompleted(Todo todo) => _todoList.toggleCompleted(todo);

  void _onRemoveCompletedPressed() => _todoList.removeCompleted();

  void _onMarkAllCompletedPressed() => _todoList.markAllCompleted();

  Widget _buildTodoItem(Todo todo) => Row(
        children: [
          Checkbox(
            value: todo.completed,
            onChanged: (_) => _toggleCompleted(todo),
          ),
          Expanded(child: Text(todo.text)),
          IconButton(
            onPressed: () => _onDeletePressed(todo),
            icon: const Icon(Icons.delete),
          ),
        ],
      );

  Widget _buildFilter(String name) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(name),
      );

  Widget _buildActionButton({
    required String title,
    VoidCallback? onPressed,
  }) =>
      ElevatedButton(
        onPressed: onPressed,
        child: Text(title),
      );

  Widget _buildActionBar() => Observer(
        listenables: [_todoList.items],
        builder: (_) => Wrap(
          alignment: WrapAlignment.center,
          spacing: 12,
          children: [
            _buildActionButton(
                title: 'Remove completed',
                onPressed:
                    _todoList.hasCompleted ? _onRemoveCompletedPressed : null),
            _buildActionButton(
              title: 'Mark all completed',
              onPressed:
                  _todoList.hasNotCompleted ? _onMarkAllCompletedPressed : null,
            ),
          ],
        ),
      );

  Widget _buildInfoText() => Observer(
        listenables: [_todoList.items],
        builder: (_) {
          final String text;
          if (_todoList.items.isEmpty) {
            text = "There are no Todos here. Why don't you add one?.";
          } else {
            final pending = _todoList.pending.filteredItems;
            final completed = _todoList.completed.filteredItems;
            final suffix = pending.length == 1 ? 'todo' : 'todos';
            text =
                '${pending.length} pending $suffix, ${completed.length} completed';
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(text, textAlign: TextAlign.center),
          );
        },
      );

  List<bool> _isFilterSelected() {
    final isSelected = _todoList.filters
        .map((f) => _todoList.selectedFilter.value == f)
        .toList();

    return isSelected;
  }

  Widget _buildFilterBar() => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Center(
          child: Observer(
            listenables: [_todoList.selectedFilter],
            builder: (_) => ToggleButtons(
              onPressed: _todoList.setFilterByIndex,
              isSelected: _isFilterSelected(),
              children:
                  _todoList.filters.map((f) => _buildFilter(f.name)).toList(),
            ),
          ),
        ),
      );

  Widget _buildTodoList() => Observer(
        listenables: [
          _todoList.selectedFilter,
          _todoList.items,
        ],
        builder: (_) {
          final filteredItems = _todoList.selectedFilter.value.filteredItems;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: filteredItems.length,
            itemBuilder: (_, index) => _buildTodoItem(filteredItems[index]),
          );
        },
      );

  Widget _buildAddTodoForm() => Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: _controller,
              decoration:
                  const InputDecoration(hintText: 'What should be done?'),
            ),
          ),
          Observer(
            listenables: [_todoList.title],
            builder: (_) => TextButton(
              onPressed:
                  _todoList.title.value.isNotEmpty ? _onAddPressed : null,
              child: const Text('Add'),
            ),
          ),
        ],
      );

  Widget _buildBarTitle(int selectedLength) => Column(
        children: [
          Text(widget.title),
          Opacity(
            opacity: 0.7,
            child: Text(
              'Pending tools: $selectedLength',
              style: const TextStyle(fontSize: 12),
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ObserverPreferredSize(
        listenables: [_todoList.pending.filteredItems],
        builder: (_) => AppBar(
          title: _buildBarTitle(_todoList.pending.filteredItems.length),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildAddTodoForm(),
            _buildFilterBar(),
            _buildActionBar(),
            _buildInfoText(),
            Expanded(child: _buildTodoList()),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();

    _todoList.dispose();
    _controller.dispose();
    _controller.removeListener(_onControllerChanged);
  }
}
