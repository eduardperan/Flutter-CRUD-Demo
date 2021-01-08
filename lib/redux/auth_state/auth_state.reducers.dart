import 'package:redux/redux.dart';
import 'auth_state.models.dart';
import 'auth_state.actions.dart';

Reducer<AuthState> authReducer = combineReducers<AuthState>([
  new TypedReducer<AuthState, SetUserIdAction>(setUserIdReducer),
  new TypedReducer<AuthState, SetAuthStatusAction>(setAuthStatusReducer),
  new TypedReducer<AuthState, SetIsLoadingAction>(setIsLoadingReducer),
  new TypedReducer<AuthState, SetIsLoginFormAction>(setIsLoginFormReducer),
  new TypedReducer<AuthState, SetErrorMessageAction>(setErrorMessageReducer),
]);

AuthState setUserIdReducer(
    AuthState authState, SetUserIdAction action) {
  return authState.fromInstance(userId: action.userId);
}

AuthState setAuthStatusReducer(
    AuthState authState, SetAuthStatusAction action) {
  return authState.fromInstance(authStatus: action.authStatus);
}

AuthState setIsLoadingReducer(AuthState authState, SetIsLoadingAction action) {
  return authState.fromInstance(isLoading: action.isLoading);
}

AuthState setIsLoginFormReducer(
    AuthState authState, SetIsLoginFormAction action) {
  return authState.fromInstance(isLoginForm: action.isLoginForm);
}

AuthState setErrorMessageReducer(
    AuthState authState, SetErrorMessageAction action) {
  return authState.fromInstance(errorMessage: action.errorMessage);
}
