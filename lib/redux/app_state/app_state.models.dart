import 'package:meta/meta.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';
import 'package:crud_app/redux/todo_state/todo_state.dart';

@immutable
class AppState {
  final AuthState auth;
  final TodoState todo;
  AppState({@required this.auth, @required this.todo});
  AppState.initialState()
      : auth = new AuthState(),
        todo = new TodoState();
}
