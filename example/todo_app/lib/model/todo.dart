import 'package:flutter/material.dart';

@immutable
class Todo {
  final String text;

  final bool completed;

  const Todo(this.text, this.completed);

  Todo copyWith({String? text, bool? completed}) =>
      Todo(text ?? this.text, completed ?? this.completed);

  Todo markCompleted() => copyWith(completed: true);

  Todo toggleCompleted() => copyWith(completed: !completed);

  static bool isPending(Todo todo) => !todo.completed;

  static bool isCompleted(Todo todo) => todo.completed;
}
