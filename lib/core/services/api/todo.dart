import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:crud_app/core/interfaces/base_todo_api.dart';
import 'package:crud_app/core/models/models.dart';

class TodoApi implements BaseTodoApi {
  final FirebaseDatabase _database = FirebaseDatabase.instance;
  Future<void> createNewTodo(String userId, Todo todo) async {
    await _database
        .reference()
        .child('todo')
        .child(userId)
        .push()
        .set(todo.toJson());
  }

  Future<void> updateTodo(String userId, Todo updateTodo) async {
    await _database
        .reference()
        .child('todo')
        .child(userId)
        .child(updateTodo.get('key'))
        .update(updateTodo.toJson());
  }

  Future<void> toggleComplete(String userId, Todo todo) async {
    await _database
        .reference()
        .child('todo')
        .child(userId)
        .child(todo.get('key'))
        .set(todo.toJson());
  }

  Future<void> deleteTodo(String userId, String key) async {
    await _database.reference().child('todo').child(userId).child(key).remove();
  }
}
