import 'dart:async';
import 'package:crud_app/core/models/models.dart';

abstract class BaseTodoApi {
  Future<void> createNewTodo(String userId, Todo todo);

  Future<void> updateTodo(String userId, Todo todo);

  Future<void> toggleComplete(String userId, Todo todo);

  Future<void> deleteTodo(String userId, String todoKey);
}
