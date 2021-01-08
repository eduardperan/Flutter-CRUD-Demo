import 'package:redux/redux.dart';
import 'package:crud_app/core/services/authentication.dart';
import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  final setCurrentUser = setCurrentUserMiddleware(new Auth());
  final signInUser = signInUserMiddleware(new Auth());
  final signUpUser = signUpUserMiddleware(new Auth());
  
  return [
    TypedMiddleware<AppState, SetCurrentUserAction>(setCurrentUser),
    TypedMiddleware<AppState, SignInUserAction>(signInUser),
    TypedMiddleware<AppState, SignUpUserAction>(signUpUser)
  ];
}