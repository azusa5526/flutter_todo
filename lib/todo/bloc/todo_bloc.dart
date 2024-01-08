import 'dart:io';

import 'package:bloc/bloc.dart';
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
    on<TodoRefresh>(_onRefresh);
    on<TodoFilterChanged>(_onFilterChanged);
    on<TodoDeleted>(_onDeleted);
  }

  Future<void> _onRefresh(TodoRefresh event, Emitter emit) async {
    emit(state.copyWith(status: TodoOverviewStatus.loading));
    try {
      List<Todo> todos = (await fetchAll()).toList();
      emit(state.copyWith(todos: todos, status: TodoOverviewStatus.success));
      console('_onRefresh', todos);
    } on HttpException {
      debugPrint('fetchAll fail');
      emit(state.copyWith(status: TodoOverviewStatus.failure));
    }
  }

  Future<void> _onFilterChanged(TodoFilterChanged event, Emitter emit) async {
    emit(state.copyWith(filter: event.filter));
  }

  Future<void> _onDeleted(TodoDeleted event, Emitter emit) async {}
}
