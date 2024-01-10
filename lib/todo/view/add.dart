import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:todo/api/todo.api.dart';
import 'package:todo/develop.dart';
import 'package:todo/todo/bloc/todo_bloc.dart';

class AddTodo extends StatelessWidget {
  const AddTodo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('新增 Todo'),
          actions: [
            BlocListener<TodosOverviewBloc, TodosOverviewState>(
              listener: (context, state) {
                if (state.status == TodoOverviewStatus.success) {
                  context.pop();
                }
              },
              child: ElevatedButton(
                onPressed: () async {
                  _formKey.currentState!.save();
                  if (_formKey.currentState!.validate()) {
                    try {
                      await create(
                          title: formData.title,
                          content: formData.content,
                          state: formData.state);
                      if (context.mounted) {
                        BlocProvider.of<TodosOverviewBloc>(context)
                            .add(const TodoRefresh());
                      }
                    } catch (error) {
                      console('_addTodo err', error);
                    }
                  }
                },
                child: const Text('儲存'),
              ),
            ),
            const SizedBox(
              width: 8.0,
            )
          ],
        ),
        body: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: const TodoForm()));
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
final formData =
    TodoFormData(title: '', content: '', state: TodoState.pending.value);

class _TodoFormState extends State<TodoForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              onSaved: (inputValue) {
                // console('title inputValue', inputValue);
                formData.title = (inputValue == null || inputValue.isEmpty)
                    ? '無標題'
                    : inputValue;
              },
              decoration: const InputDecoration(
                  hintText: "Title", border: InputBorder.none),
            ),
            TextFormField(
              onSaved: (inputValue) {
                formData.content = inputValue ?? '';
              },
              decoration: const InputDecoration(
                  hintText: "Content", border: InputBorder.none),
            ),
            // SizedBox(
            //   width: double.infinity,
            //   child: DropdownButtonFormField<TodoState>(
            //     value: TodoState.pending,
            //     onChanged: (state) {
            //       console(state);
            //     },
            //     items: TodoState.values.map((state) {
            //       return DropdownMenuItem<TodoState>(
            //         value: state,
            //         child: Text(state.label),
            //       );
            //     }).toList(),
            //     decoration: const InputDecoration(border: InputBorder.none),
            //   ),
            // ),
            DropdownMenu<TodoState>(
                expandedInsets: EdgeInsets.zero,
                width: MediaQuery.of(context).size.width,
                initialSelection: TodoState.pending,
                inputDecorationTheme:
                    const InputDecorationTheme(border: InputBorder.none),
                onSelected: (filter) {
                  console('dropdwon', filter);
                  formData.state = filter?.value ?? TodoState.pending.value;
                },
                dropdownMenuEntries: TodoState.values.map((state) {
                  return DropdownMenuEntry(
                      value: state,
                      label: state.label,
                      leadingIcon: Icon(state.icon));
                }).toList())
          ],
        ));
  }
}
