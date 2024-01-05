part of 'todo_bloc.dart';

enum TodoOverviewStatus { initial, loading, success, failure }

final class TodosOverviewState extends Equatable {
  const TodosOverviewState(
      {this.status = TodoOverviewStatus.initial,
      this.todos = const [],
      this.filter = TodosFilter.progress,
      this.selectedTodo});

  final TodoOverviewStatus status;
  final List<Todo> todos;
  final TodosFilter filter;
  final Todo? selectedTodo;

  List<Todo> get filteredTodos => filter.applyAll(todos).toList();

  TodosOverviewState copyWith({
    TodoOverviewStatus? status,
    List<Todo>? todos,
    TodosFilter? filter,
    Todo? selectedTodo,
  }) {
    return TodosOverviewState(
        status: status ?? this.status,
        todos: todos ?? this.todos,
        filter: filter ?? this.filter,
        selectedTodo: selectedTodo);
  }

  @override
  List<Object> get props => [status, todos, filter];
}
