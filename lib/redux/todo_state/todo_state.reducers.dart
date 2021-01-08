import 'package:redux/redux.dart';
import 'package:crud_app/core/models/todo.dart';
import 'todo_state.models.dart';
import 'todo_state.actions.dart';

TodoState todoReducer(TodoState todoState, action) {
  return TodoState(
      todoList: todoListReducer(todoState.todoList, action),
      selectedTodo: _selectedTodoReducer(todoState, action),
      isLoading: _isLoadingReducer(todoState.isLoading, action));
}

Reducer<List<Todo>> todoListReducer = combineReducers<List<Todo>>([
  new TypedReducer<List<Todo>, AddTodoAction>(_addTodoReducer),
  new TypedReducer<List<Todo>, UpdateTodoAction>(_updateTodoReducer),
  new TypedReducer<List<Todo>, DeleteTodoAction>(_deleteTodo),
]);

List<Todo> _addTodoReducer(List<Todo> todoList, AddTodoAction action) {
  return List.from(todoList)..add(action.todo);
}

List<Todo> _updateTodoReducer(List<Todo> todoList, UpdateTodoAction action) {
  return todoList
      .map(
          (todo) => todo.get('key') == action.todoId ? action.updateTodo : todo)
      .toList();
}

List<Todo> _deleteTodo(List<Todo> todoList, DeleteTodoAction action) {
  return todoList.where((todo) => todo.get('key') != action.todoId).toList();
}

Todo _selectedTodoReducer(TodoState todoState, action) {
  if (action is SetSelectedTodoAction) 
    return todoState.todoList
            .firstWhere((todo) => todo.get('key') == action.todoId) ??
        todoState.selectedTodo;
  
  return todoState.selectedTodo;
}

bool _isLoadingReducer(bool isLoading, action) {
  if (action is SetIsLoadingAction) 
    return action.isLoading;

  return isLoading;
}
