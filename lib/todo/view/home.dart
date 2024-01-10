import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/todo/bloc/todo_bloc.dart';
import '../../develop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/todo_filter_button.dart';
import 'package:todo/api/todo.api.dart' show Todo;
import '../widgets/todo_sort_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo List'),
        actions: const [
          TodoSortButton(),
          TodoFilterButton(),
          SizedBox(
            width: 4.0,
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: const Column(children: [TodoListView()]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push('/add'),
        child: const Icon(Icons.add),
      ),
    );
  }
}

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<TodosOverviewBloc, TodosOverviewState, List<Todo>>(
        selector: (state) => state.displayedTodos,
        builder: (context, displayedTodos) {
          return Expanded(
              child: ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  context
                      .read<TodosOverviewBloc>()
                      .add(TodoSelected(displayedTodos[index]));
                  context.push('/edit');
                },
                trailing: Icon(displayedTodos[index].state.icon),
                title: Text(displayedTodos[index].title),
              );
            },
            itemCount: displayedTodos.length,
            separatorBuilder: (context, index) {
              return Divider(color: Colors.grey[300]);
            },
          ));
        });
  }
}
