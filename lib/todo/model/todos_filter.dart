import '../../api/todo.api.dart';
import 'package:flutter/material.dart';

enum TodosFilter {
  all(value: 'All', label: '全部', icon: Icons.pending),
  pending(value: 'Pending', label: '待處理', icon: Icons.pending),
  progress(value: 'Progress', label: '進行中', icon: Icons.directions_run),
  resolved(value: 'Resolved', label: '已完成', icon: Icons.done);

  final String value;
  final String label;
  final IconData icon;

  const TodosFilter(
      {required this.value, required this.label, required this.icon});
}

extension TodosFilterX on TodosFilter {
  bool apply(Todo todo) {
    switch (this) {
      case TodosFilter.all:
        return true;
      case TodosFilter.pending:
        return todo.state.value == 'Pending';
      case TodosFilter.progress:
        return todo.state.value == 'Progress';
      case TodosFilter.resolved:
        return todo.state.value == 'Resolved';
    }
  }

  Iterable<Todo> applyAll(Iterable<Todo> todos) {
    return todos.where(apply);
  }
}
