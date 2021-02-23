import 'app_state.models.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';
import 'package:crud_app/redux/todo_state/todo_state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    auth: authReducer(state.auth, action),
    todo: todoReducer(state.todo, action)
  );
}
