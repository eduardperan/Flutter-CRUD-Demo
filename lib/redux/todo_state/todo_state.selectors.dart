import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/core/models/models.dart';

List<Todo> selectTodoList(AppState state) => state.todo.todoList;
Todo selectSelectedTodo(AppState state) => state.todo.selectedTodo;
bool selectIsFetchTodosLoading(AppState state) => state.todo.isFetchTodosLoading;
bool selectIsTodoSaving(AppState state) => state.todo.isTodoSaving;
String selectTodoErrorMessage(AppState state) => state.todo.todoErrorMessage;
