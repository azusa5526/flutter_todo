import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/api/todo.api.dart';
import 'package:todo/develop.dart';
import 'package:todo/todo/bloc/todo_bloc.dart';

class EditTodo extends StatelessWidget {
  const EditTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('編輯 Todo'), actions: [
          IconButton(
              onPressed: () => showDialog<String>(
                  context: context, builder: (context) => const UpdateDialog()),
              icon: const Icon(Icons.edit_outlined)),
          IconButton(
              onPressed: () => showDialog<String>(
                  context: context, builder: (context) => const DeleteDialog()),
              icon: const Icon(Icons.delete_forever_outlined)),
          const SizedBox(
            width: 8.0,
          )
        ]),
        body: BlocListener<TodosOverviewBloc, TodosOverviewState>(
            listener: (context, state) {
              if (state.status == TodoOverviewStatus.success) {
                context.pop();
              }
            },
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: const TodoForm())));
  }
}

class TodoFormData {
  String title;
  String content;
  String state;

  TodoFormData(
      {required this.title, required this.state, required this.content});
}

class TodoForm extends StatefulWidget {
  const TodoForm({super.key});

  @override
  State<TodoForm> createState() => _TodoFormState();
}

final _formKey = GlobalKey<FormState>();
final formData = TodoFormData(title: '', content: '', state: '');

class _TodoFormState extends State<TodoForm> {
  @override
  Widget build(BuildContext context) {
    Todo? selectedTodo = context.read<TodosOverviewBloc>().state.selectedTodo;

    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              initialValue: selectedTodo != null ? selectedTodo.title : '',
              onSaved: (inputValue) {
                formData.title = (inputValue == null || inputValue.isEmpty)
                    ? '無標題'
                    : inputValue;
              },
              decoration: const InputDecoration(
                  hintText: "Title", border: InputBorder.none),
            ),
            TextFormField(
              initialValue: selectedTodo != null ? selectedTodo.content : '',
              onSaved: (inputValue) {
                formData.content = inputValue ?? '';
              },
              decoration: const InputDecoration(
                  hintText: "Content", border: InputBorder.none),
            ),
            DropdownMenu<TodoState>(
                expandedInsets: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width,
                initialSelection: selectedTodo != null
                    ? selectedTodo.state
                    : TodoState.pending,
                inputDecorationTheme:
                    const InputDecorationTheme(border: InputBorder.none),
                onSelected: (filter) {
                  console('dropdwon', filter);
                  formData.state = filter?.value ?? TodoState.pending.value;
                },
                dropdownMenuEntries: TodoState.values.map((state) {
                  return DropdownMenuEntry(value: state, label: state.label);
                }).toList()),
          ],
        ));
  }
}

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Todo? selectedTodo = context.read<TodosOverviewBloc>().state.selectedTodo;

    return AlertDialog(
      title: const Text('刪除這項 Todo?'),
      content: const Text('Todo 一經刪除將無法恢復'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            if (selectedTodo != null) {
              context.read<TodosOverviewBloc>()
                ..add(TodoDeleted(selectedTodo.id))
                ..add(const TodoRefresh());
              Navigator.pop(context, 'OK');
            }
          },
          child: const Text('刪除'),
        ),
      ],
    );
  }
}

class UpdateDialog extends StatelessWidget {
  const UpdateDialog({super.key});

  @override
  Widget build(BuildContext context) {
    Todo? selectedTodo = context.read<TodosOverviewBloc>().state.selectedTodo;

    return AlertDialog(
      title: const Text('修改這項 Todo?'),
      content: const Text(''),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, 'Cancel'),
          child: const Text('取消'),
        ),
        TextButton(
          onPressed: () {
            if (selectedTodo != null) {
              _formKey.currentState!.save();
              if (formData.state.isEmpty) {
                formData.state = selectedTodo.state.value;
              }

              context.read<TodosOverviewBloc>()
                ..add(TodoUpdated(selectedTodo.id, formData))
                ..add(const TodoRefresh());
              Navigator.pop(context, 'OK');
            }
          },
          child: const Text('修改'),
        ),
      ],
    );
  }
}
