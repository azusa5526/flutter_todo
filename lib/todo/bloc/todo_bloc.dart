import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/widgets.dart';
import 'package:equatable/equatable.dart';
import '../../api/todo.api.dart';
import 'dart:developer';
import '../model/todos_filter.dart';
import 'package:todo/develop.dart';
import '../view/edit.dart' show TodoFormData;
import '../model/todos_sort.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodosOverviewBloc extends Bloc<TodosOverviewEvent, TodosOverviewState> {
  TodosOverviewBloc() : super(const TodosOverviewState()) {
    on<TodoRefresh>(_onRefresh, transformer: sequential());
    on<TodoFilterChanged>(_onFilterChange);
    on<TodoSortChanged>(_onSortChange);
    on<TodoDeleted>(_onDelete, transformer: sequential());
    on<TodoUpdated>(_onUpdate, transformer: sequential());
    on<TodoSelected>(_onSelect);
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

  _onFilterChange(TodoFilterChanged event, Emitter emit) async {
    emit(state.copyWith(filter: event.filter));
  }

  _onSortChange(TodoSortChanged event, Emitter emit) async {
    emit(state.copyWith(sort: event.sort));
  }

  Future<void> _onDelete(TodoDeleted event, Emitter emit) async {
    emit(state.copyWith(status: TodoOverviewStatus.loading));
    try {
      await delete(event.id);
      emit(state.copyWith(selectedTodo: null));
    } on HttpException {
      debugPrint('_onDelete fail');
      emit(state.copyWith(status: TodoOverviewStatus.failure));
    }
  }

  Future<void> _onUpdate(TodoUpdated event, Emitter emit) async {
    emit(state.copyWith(status: TodoOverviewStatus.loading));
    try {
      console('_onUpdate', event.formData);
      await update(event.id,
          title: event.formData.title,
          content: event.formData.content,
          state: event.formData.state);
      emit(state.copyWith(selectedTodo: null));
    } on HttpException {
      debugPrint('_onUpdate fail');
      emit(state.copyWith(status: TodoOverviewStatus.failure));
    }
  }

  _onSelect(TodoSelected event, Emitter emit) {
    emit(state.copyWith(selectedTodo: event.todo));
  }
}
