import 'package:redux/redux.dart';
import 'package:crud_app/core/models/models.dart';
import 'todo_state.models.dart';
import 'todo_state.actions.dart';

TodoState todoReducer(TodoState todoState, action) {
  return TodoState(
      todoList: _todoListReducer(todoState.todoList, action),
      selectedTodo: _selectedTodoReducer(todoState, action),
      isFetchTodosLoading: _isFetchTodosLoadingReducer(todoState.isFetchTodosLoading, action),
      isTodoSaving: _isTodoSavingReducer(todoState.isTodoSaving, action),
      todoErrorMessage: _todoErrorMessageReducer(todoState.todoErrorMessage, action));
}

Reducer<List<Todo>> _todoListReducer = combineReducers<List<Todo>>([
  new TypedReducer<List<Todo>, AddTodo>(_addTodoReducer),
  new TypedReducer<List<Todo>, UpdateTodo>(_updateTodoReducer),
  new TypedReducer<List<Todo>, DeleteTodo>(_deleteTodo),
]);

List<Todo> _addTodoReducer(List<Todo> todoList, AddTodo action) {
  return List.from(todoList)..add(action.todo);
}

List<Todo> _updateTodoReducer(List<Todo> todoList, UpdateTodo action) {
  return todoList
      .map(
          (todo) => todo.get('key') == action.todoId ? action.updateTodo : todo)
      .toList();
}

List<Todo> _deleteTodo(List<Todo> todoList, DeleteTodo action) {
  return todoList.where((todo) => todo.get('key') != action.todoId).toList();
}

Todo _selectedTodoReducer(TodoState todoState, action) {
  if (action is SetSelectedTodo)
    return todoState.todoList
            .firstWhere((todo) => todo.get('key') == action.todoId) ??
        todoState.selectedTodo;

  return todoState.selectedTodo;
}

bool _isFetchTodosLoadingReducer(bool isFetchTodosLoading, action) {
  if (action is SetIsFetchTodosLoading) return action.isFetchTodosLoading;

  return isFetchTodosLoading;
}

bool _isTodoSavingReducer(bool isTodoSaving, action) {
  if (action is SetIsTodoSaving) return action.isTodoSaving;

  return isTodoSaving;
}

String _todoErrorMessageReducer(String todoErrorMessage, action) {
  if (action is SetTodoErrorMessage) return action.todoErrorMessage;

  return todoErrorMessage;
}
