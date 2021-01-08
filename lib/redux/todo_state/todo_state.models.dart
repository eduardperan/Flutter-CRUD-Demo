import 'package:crud_app/core/models/todo.dart';

class TodoState {
  final List<Todo> todoList;
  final Todo selectedTodo;
  final bool isLoading;

  TodoState({
    this.todoList = const [],
    this.selectedTodo,
    this.isLoading = false,
  });

  TodoState fromInstance({
    List<Todo> todoList,
    Todo selectedTodo,
    bool isLoading,
  }) {
    return new TodoState(
     todoList: todoList ?? this.todoList,
     selectedTodo: selectedTodo ?? this.selectedTodo,
     isLoading: isLoading ?? this.isLoading
    );
  }
}
