import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
import '../../api/todo.api.dart';
import 'dart:developer';
import '../model/todos_filter.dart';
import 'package:todo/develop.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodosOverviewBloc extends Bloc<TodosOverviewEvent, TodosOverviewState> {
  TodosOverviewBloc() : super(const TodosOverviewState()) {
    on<TodoRefresh>(_onRefresh, transformer: sequential());
    on<TodoFilterChanged>(_onFilterChanged);
    on<TodoDeleted>(_onDeleted, transformer: sequential());
    on<TodoSelected>(_onSelected);
  }

  Future<void> _onRefresh(TodoRefresh event, Emitter emit) async {
    emit(state.copyWith(status: TodoOverviewStatus.loading));
    try {
      List<Todo> todos = (await fetchAll()).toList();
      emit(state.copyWith(todos: todos, status: TodoOverviewStatus.success));
      // if (event.callback != null) event.callback!();
    } on HttpException {
      debugPrint('_onRefresh fail');
      emit(state.copyWith(status: TodoOverviewStatus.failure));
    }
  }

  _onFilterChanged(TodoFilterChanged event, Emitter emit) async {
    emit(state.copyWith(filter: event.filter));
  }

  Future<void> _onDeleted(TodoDeleted event, Emitter emit) async {
    emit(state.copyWith(status: TodoOverviewStatus.loading));
    try {
      await delete(event.id);
      emit(state.copyWith(selectedTodo: null));
    } on HttpException {
      debugPrint('_onDelete fail');
      emit(state.copyWith(status: TodoOverviewStatus.failure));
    }
  }

  _onSelected(TodoSelected event, Emitter emit) {
    emit(state.copyWith(selectedTodo: event.todo));
  }
}
