import 'package:flutter/material.dart';
import '../../api/todo.api.dart';
import 'package:todo/develop.dart';

enum TodoSort {
  asc(icon: Icons.keyboard_double_arrow_up_outlined, label: '依據標題遞增'),
  desc(icon: Icons.keyboard_double_arrow_down_outlined, label: '依據標題遞減');

  const TodoSort({required this.icon, required this.label});

  final IconData icon;
  final String label;
}

extension TodoSortX on TodoSort {
  List<Todo> sortTodo(List<Todo> todos) {
    switch (this) {
      case TodoSort.asc:
        console('I am asc');
        return todos.toList()..sort((a, b) => a.title.compareTo(b.title));
      case TodoSort.desc:
        console('I am desc');
        return todos.toList()..sort((a, b) => b.title.compareTo(a.title));
    }
  }
}
