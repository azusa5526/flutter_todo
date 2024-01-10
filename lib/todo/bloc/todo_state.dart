part of 'todo_bloc.dart';

enum TodoOverviewStatus { initial, loading, success, failure }

final class TodosOverviewState extends Equatable {
  const TodosOverviewState(
      {this.status = TodoOverviewStatus.initial,
      this.todos = const [],
      this.filter = TodosFilter.pending,
      this.sort = TodoSort.asc,
      this.selectedTodo});

  final TodoOverviewStatus status;
  final List<Todo> todos;
  final TodosFilter filter;
  final TodoSort sort;
  final Todo? selectedTodo;

  List<Todo> get filteredTodos => filter.applyAll(todos).toList();
  List<Todo> get displayedTodos {
    Iterable<Todo> temp;
    temp = filter.applyAll(todos);
    temp = sort.sortTodo(temp.toList());
    return temp.toList();
  }

  TodosOverviewState copyWith({
    TodoOverviewStatus? status,
    List<Todo>? todos,
    TodosFilter? filter,
    TodoSort? sort,
    Todo? selectedTodo,
  }) {
    return TodosOverviewState(
        status: status ?? this.status,
        todos: todos ?? this.todos,
        filter: filter ?? this.filter,
        sort: sort ?? this.sort,
        selectedTodo: selectedTodo);
  }

  @override
  List<Object?> get props => [status, todos, filter, selectedTodo, sort];
}
