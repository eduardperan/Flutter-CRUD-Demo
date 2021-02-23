import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:crud_app/core/services/api/todo.dart';
import 'package:crud_app/core/models/models.dart';
import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/redux/todo_state/todo_state.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';

void _addTodoMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  if (!(action is AddTodo)) return;

  try {
    String userId = selectUserId(store.state);

    if (userId.length <= 0 || userId.isEmpty) {
      throw Exception('User is required.');
    }

    Todo todo = action.todo;
    TodoApi todoApi = new TodoApi();

    store.dispatch(SetIsTodoSaving(true));
    store.dispatch(SetTodoErrorMessage(""));

    await todoApi.createNewTodo(userId, todo);

    if (action is AddTodo) action.callback();
  } on PlatformException catch (e) {
    switch (e.message) {
      case 'An internal error has occurred. [ Unable to resolve host "www.googleapis.com":No address associated with hostname ]':
        store.dispatch(SetTodoErrorMessage('Network Error.'));
        break;
      default:
        store.dispatch(SetTodoErrorMessage(e.message));
        break;
    }
  } catch (e) {
    print('Error: $e');
    store.dispatch(SetTodoErrorMessage('Failed to create todo.'));
  } finally {
    store.dispatch(SetIsTodoSaving(false));
    next(action);
  }
}

void _updateTodoMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  if (!(action is UpdateTodo)) return;

  try {
    String userId = selectUserId(store.state);
    if (userId.length <= 0 || userId.isEmpty) {
      throw Exception('User is required.');
    }

    Todo updateTodo = action.updateTodo;
    TodoApi todoApi = new TodoApi();

    store.dispatch(SetIsTodoSaving(true));
    store.dispatch(SetTodoErrorMessage(""));

    await todoApi.updateTodo(userId, updateTodo);

    if (action is UpdateTodo) action.callback();
  } on PlatformException catch (e) {
    switch (e.message) {
      case 'An internal error has occurred. [ Unable to resolve host "www.googleapis.com":No address associated with hostname ]':
        store.dispatch(SetTodoErrorMessage('Network Error.'));
        break;
      default:
        store.dispatch(SetTodoErrorMessage(e.message));
        break;
    }
  } catch (e) {
    print('Error: $e');
    store.dispatch(SetTodoErrorMessage('Failed to update todo.'));
  } finally {
    store.dispatch(SetIsTodoSaving(false));
    next(action);
  }
}

void _deleteTodoMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  if (!(action is DeleteTodo)) return;

  try {
    String userId = selectUserId(store.state);

    if (userId.length <= 0 || userId.isEmpty) {
      throw Exception('User is required.');
    }

    String todoId = action.todoId;
    TodoApi todoApi = new TodoApi();

    store.dispatch(SetIsTodoSaving(true));
    store.dispatch(SetTodoErrorMessage(""));

    await todoApi.deleteTodo(userId, todoId);

    if (action is DeleteTodo) action.callback();

  } on PlatformException catch (e) {
    switch (e.message) {
      case 'An internal error has occurred. [ Unable to resolve host "www.googleapis.com":No address associated with hostname ]':
        store.dispatch(SetTodoErrorMessage('Network Error.'));
        break;
      default:
        store.dispatch(SetTodoErrorMessage(e.message));
        break;
    }
  } catch (e) {
    print('Error: $e');
    store.dispatch(SetTodoErrorMessage('Failed to delete todo.'));
  } finally {
    store.dispatch(SetIsTodoSaving(false));
    next(action);
  }
}

List<Middleware<AppState>> todoStateMiddleware = [
  TypedMiddleware<AppState, AddTodo>(_addTodoMiddleware),
  TypedMiddleware<AppState, UpdateTodo>(_updateTodoMiddleware),
  TypedMiddleware<AppState, DeleteTodo>(_deleteTodoMiddleware)
];
