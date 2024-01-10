import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/develop.dart';
import 'package:todo/todo/bloc/todo_bloc.dart';
import '../model/todos_sort.dart';

class TodoSortButton extends StatelessWidget {
  const TodoSortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
        icon: const Icon(Icons.sort_outlined),
        onSelected: (option) {
          context.read<TodosOverviewBloc>().add(TodoSortChanged(option));
          console('TodoSortButton onSelected',
              context.read<TodosOverviewBloc>().state.sort);
        },
        itemBuilder: (context) => TodoSort.values.map((option) {
              return PopupMenuItem(
                  value: option,
                  child: ListTile(
                    title: Text(option.label),
                    leading: Icon(option.icon),
                    visualDensity: const VisualDensity(vertical: -2.0),
                  ));
            }).toList());
  }
}
