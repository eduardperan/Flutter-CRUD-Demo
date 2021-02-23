import 'package:crud_app/core/models/models.dart';

class TodoState {
  final List<Todo> todoList;
  final Todo selectedTodo;
  final bool isFetchTodosLoading;
  final bool isTodoSaving;
  final String todoErrorMessage;

  TodoState({
    this.todoList = const [],
    this.selectedTodo,
    this.isFetchTodosLoading = false,
    this.isTodoSaving = false,
    this.todoErrorMessage = ''
  });

  TodoState fromInstance({
    List<Todo> todoList,
    Todo selectedTodo,
    bool isFetchTodosLoading,
    bool isTodoSaving,
    String todoErrorMessage
  }) {
    return new TodoState(
        todoList: todoList ?? this.todoList,
        selectedTodo: selectedTodo ?? this.selectedTodo,
        isFetchTodosLoading: isFetchTodosLoading ?? this.isFetchTodosLoading,
        isTodoSaving: isTodoSaving ?? this.isTodoSaving,
        todoErrorMessage: todoErrorMessage ?? this.todoErrorMessage);
  }
}
