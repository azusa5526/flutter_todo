import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/todo/bloc/todo_bloc.dart';
import '../../develop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/todo_filter_button.dart';
import 'package:todo/api/todo.api.dart' show Todo;

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Todo List'),
        actions: const [TodoFilterButton()],
      ),
      body: const Column(children: [TodoListView()]),
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
        selector: (state) => state.filteredTodos,
        builder: (context, filteredTodos) {
          return Expanded(
              child: ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {
                  context
                      .read<TodosOverviewBloc>()
                      .add(TodoSelected(filteredTodos[index]));
                  context.push('/edit');
                },
                trailing: Icon(filteredTodos[index].state.icon),
                title: Text(filteredTodos[index].title),
              );
            },
            itemCount: filteredTodos.length,
          ));
        });
  }
}
