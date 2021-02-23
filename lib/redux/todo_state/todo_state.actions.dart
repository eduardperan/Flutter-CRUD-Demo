import 'package:flutter/cupertino.dart';
import 'package:crud_app/core/models/models.dart';

class FetchTodos {}

class SetSelectedTodo {
  final String todoId;
  SetSelectedTodo(this.todoId);
}

class SetIsFetchTodosLoading {
  final bool isFetchTodosLoading;
  SetIsFetchTodosLoading(this.isFetchTodosLoading);
}

class SetIsTodoSaving {
  final bool isTodoSaving;
  SetIsTodoSaving(this.isTodoSaving);
}

class SetTodoErrorMessage {
  final String todoErrorMessage;
  SetTodoErrorMessage(this.todoErrorMessage);
}

class AddTodo {
  final Todo todo;
  final VoidCallback callback;
  AddTodo({@required this.todo, this.callback});
}

class UpdateTodo {
  final String todoId;
  final Todo updateTodo;
  final VoidCallback callback;
  UpdateTodo({@required this.todoId, this.updateTodo, this.callback});
}

class DeleteTodo {
  final String todoId;
  final VoidCallback callback;
  DeleteTodo({@required this.todoId, this.callback});
}
