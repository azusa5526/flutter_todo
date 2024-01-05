import 'package:flutter/material.dart';
import 'package:todo/todo/bloc/todo_bloc.dart';
import '../../develop.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/todo_filter_button.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Home build func');
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Home bitch'),
        actions: const [TodoFilterButton()],
      ),
      body: const Column(children: [Text('123'), TodoListView()]),
    );
  }
}

class TodoListView extends StatelessWidget {
  const TodoListView({super.key});

  @override
  Widget build(BuildContext context) {
    debugPrint('Listview build func');
    return BlocBuilder<TodosOverviewBloc, TodosOverviewState>(
        builder: (context, state) {
      return Expanded(
          child: ListView.builder(
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(state.filteredTodos.toList()[index].title),
          );
        },
        itemCount: state.filteredTodos.length,
      ));
    });
  }
}
