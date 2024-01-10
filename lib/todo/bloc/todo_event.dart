part of 'todo_bloc.dart';

@immutable
sealed class TodosOverviewEvent extends Equatable {
  const TodosOverviewEvent();

  @override
  List<Object> get props => [];
}

final class TodoDeleted extends TodosOverviewEvent {
  const TodoDeleted(this.id);
  final String id;
}

final class TodoUpdated extends TodosOverviewEvent {
  const TodoUpdated(this.id, this.formData);
  final String id;
  final TodoFormData formData;
}

final class TodoFilterChanged extends TodosOverviewEvent {
  const TodoFilterChanged(this.filter);
  final TodosFilter filter;
}

final class TodoSortChanged extends TodosOverviewEvent {
  const TodoSortChanged(this.sort);
  final TodoSort sort;
}

final class TodoRefresh extends TodosOverviewEvent {
  const TodoRefresh({this.callback});
  final Function? callback;
}

final class TodoSelected extends TodosOverviewEvent {
  const TodoSelected(this.todo);
  final Todo todo;
}
