import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/todo/bloc/todo_bloc.dart';
import 'package:todo/todo/model/todos_filter.dart';

class TodoFilterButton extends StatelessWidget {
  const TodoFilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    final activeFilter =
        context.select((TodosOverviewBloc bloc) => bloc.state.filter);

    return PopupMenuButton<TodosFilter>(
        initialValue: activeFilter,
        icon: const Icon(
          Icons.category_outlined,
        ),
        onSelected: (todoFilter) {
          context.read<TodosOverviewBloc>().add(TodoFilterChanged(todoFilter));
        },
        itemBuilder: (context) => TodosFilter.values.map((filterItem) {
              return PopupMenuItem(
                value: filterItem,
                child: ListTile(
                  leading: Icon(filterItem.icon),
                  title: Text(filterItem.label),
                  visualDensity:
                      const VisualDensity(vertical: -2.0, horizontal: 3.0),
                ),
              );
            }).toList());
  }
}
