import 'package:redux/redux.dart';
import 'auth_state.models.dart';
import 'auth_state.actions.dart';

Reducer<AuthState> authReducer = combineReducers<AuthState>([
  new TypedReducer<AuthState, SetAuthUserIdAction>(setAuthUserIdReducer),
  new TypedReducer<AuthState, SetAuthStatusAction>(setAuthStatusReducer),
  new TypedReducer<AuthState, SetAuthIsLoadingAction>(setAuthIsLoadingReducer)
]);

AuthState setAuthUserIdReducer(AuthState authState, SetAuthUserIdAction action) {
  return authState.fromInstance(userId: action.authUserId);
}

AuthState setAuthStatusReducer(AuthState authState, SetAuthStatusAction action) {
  return authState.fromInstance(authStatus: action.authStatus);
}

AuthState setAuthIsLoadingReducer(AuthState authState, SetAuthIsLoadingAction action) {
  return authState.fromInstance(isLoading: action.authIsLoading);
}
