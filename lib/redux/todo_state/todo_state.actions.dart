import 'package:flutter/cupertino.dart';
import 'package:crud_app/core/models/todo.dart';

class FetchTodosAction {}

class SetSelectedTodoAction {
  final String todoId;
  SetSelectedTodoAction(this.todoId);
}

class SetIsLoadingAction {
  final bool isLoading;
  SetIsLoadingAction(this.isLoading);
}

class AddTodoAction {
  final Todo todo;
  final VoidCallback callback;
  AddTodoAction({@required this.todo, this.callback});
}

class UpdateTodoAction {
  final String todoId;
  final Todo updateTodo;
  final VoidCallback callback;
  UpdateTodoAction({@required this.todoId, this.updateTodo, this.callback});
}

class DeleteTodoAction {
  final String todoId;
  final VoidCallback callback;
  DeleteTodoAction({@required this.todoId, this.callback});
}
