import 'package:meta/meta.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';

@immutable
class AppState {
  final AuthState auth;
  AppState({@required this.auth});
  AppState.initialState() : auth = new AuthState();
}
