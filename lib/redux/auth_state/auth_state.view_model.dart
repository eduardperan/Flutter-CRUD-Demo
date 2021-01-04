import 'package:crud_app/constant.dart';
import 'package:redux/redux.dart';
import 'auth_state.actions.dart';
import 'package:crud_app/redux/app_state/app_state.dart';

class AuthStateViewModel {
  final String userId;
  final AuthStatus authStatus;
  final bool isLoading;
  final Function(String) setAuthUserIdAction;
  final Function(AuthStatus) setAuthStatus;
  final Function(bool) setAuthIsLoading;
  final Function() setCurrentUser;

  AuthStateViewModel(
      {this.userId,
      this.authStatus,
      this.isLoading,
      this.setAuthUserIdAction,
      this.setAuthStatus,
      this.setAuthIsLoading,
      this.setCurrentUser});

  factory AuthStateViewModel.create(Store<AppState> store) {
    _setAuthUserId(String userId) {
      store.dispatch(SetAuthUserIdAction(userId));
    }

    _setAuthStatus(AuthStatus authStatus) {
      store.dispatch(SetAuthStatusAction(authStatus));
    }

    _setAuthIsLoading(bool isLoading) {
      store.dispatch(SetAuthIsLoadingAction(isLoading));
    }

    _setCurrentUser() {
      store.dispatch(SetCurrentUserAction());
    }

    return AuthStateViewModel(
        userId: store.state.auth.userId,
        authStatus: store.state.auth.authStatus,
        isLoading: store.state.auth.isLoading,
        setAuthUserIdAction: _setAuthUserId,
        setAuthStatus: _setAuthStatus,
        setAuthIsLoading: _setAuthIsLoading,
        setCurrentUser: _setCurrentUser);
  }
}
