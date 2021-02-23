import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:crud_app/core/models/models.dart';
import 'package:crud_app/redux/app_state/app_state.dart';
import 'todo_state.actions.dart';
import 'todo_state.selectors.dart';

class TodoStateViewModel {
  final List<Todo> todoList;
  final Todo selectedTodo;
  final bool isFetchTodosLoading;
  final bool isTodoSaving;
  final String todoErrorMessage;
  final void Function(String) setSelectedTodo;
  final void Function(bool) setIsFetchTodosLoading;
  final void Function(bool) setTodoSaving;
  final void Function(String) setTodoErrorMessage;
  final void Function(Todo, VoidCallback) addTodo;
  final void Function(String, Todo, VoidCallback) updateTodo;
  final void Function(String, VoidCallback) deleteTodo;

  TodoStateViewModel(
      {@required this.todoList,
      @required this.selectedTodo,
      @required this.isFetchTodosLoading,
      @required this.isTodoSaving,
      @required this.todoErrorMessage,
      @required this.setSelectedTodo,
      @required this.setIsFetchTodosLoading,
      @required this.setTodoSaving,
      @required this.setTodoErrorMessage,
      @required this.addTodo,
      @required this.updateTodo,
      @required this.deleteTodo});

  factory TodoStateViewModel.create(Store<AppState> store) {
    void _setSelectedTodo(String todoId) {
      store.dispatch(SetSelectedTodo(todoId));
    }

    void _setIsFetchTodosLoading(bool isFetchTodosLoading) {
      store.dispatch(SetIsFetchTodosLoading(isFetchTodosLoading));
    }

    void _setIsTodoSaving(bool isTodoSaving) {
      store.dispatch(SetIsTodoSaving(isTodoSaving));
    }

    void _setTodoErrorMessage(String todoErrorMessage) {
      store.dispatch(SetTodoErrorMessage(todoErrorMessage));
    }

    void _addTodo(Todo todo, VoidCallback callback) {
      store.dispatch(AddTodo(todo: todo, callback: callback));
    }

    void _updateTodo(String todoId, Todo updateTodo, VoidCallback callback) {
      store.dispatch(UpdateTodo(
          todoId: todoId, updateTodo: updateTodo, callback: callback));
    }

    void _deleteTodo(String todoId, VoidCallback callback) {
      store.dispatch(DeleteTodo(todoId: todoId, callback: callback));
    }

    return TodoStateViewModel(
        todoList: selectTodoList(store.state),
        selectedTodo: selectSelectedTodo(store.state),
        isFetchTodosLoading: selectIsFetchTodosLoading(store.state),
        isTodoSaving: selectIsTodoSaving(store.state),
        todoErrorMessage: selectTodoErrorMessage(store.state),
        setSelectedTodo: _setSelectedTodo,
        setIsFetchTodosLoading: _setIsFetchTodosLoading,
        setTodoSaving: _setIsTodoSaving,
        setTodoErrorMessage: _setTodoErrorMessage,
        addTodo: _addTodo,
        updateTodo: _updateTodo,
        deleteTodo: _deleteTodo);
  }
}
