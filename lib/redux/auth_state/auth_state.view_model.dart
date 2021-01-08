import 'package:crud_app/constant.dart';
import 'package:flutter/cupertino.dart';
import 'package:redux/redux.dart';
import 'package:crud_app/redux/app_state/app_state.dart';
import 'auth_state.actions.dart';
import 'auth_state.selectors.dart';

class AuthStateViewModel {
  final String userId;
  final AuthStatus authStatus;
  final bool isLoading;
  final bool isLoginForm;
  final String errorMessage;
  final void Function(String) setAuthUserId;
  final void Function(AuthStatus) setAuthStatus;
  final void Function(bool) setIsLoading;
  final void Function(bool) setIsLoginForm;
  final void Function(String) setErrorMessage;
  final void Function() setCurrentUser;
  final void Function(String, String, VoidCallback) signInUser;
  final void Function(String, String, VoidCallback) signUpUser;

  AuthStateViewModel(
      {this.userId,
      this.authStatus,
      this.isLoading,
      this.isLoginForm,
      this.errorMessage,
      this.setAuthUserId,
      this.setAuthStatus,
      this.setIsLoading,
      this.setIsLoginForm,
      this.setErrorMessage,
      this.setCurrentUser,
      this.signInUser,
      this.signUpUser});

  factory AuthStateViewModel.create(Store<AppState> store) {
    void _setUserId(String userId) {
      store.dispatch(SetUserIdAction(userId));
    }

    void _setAuthStatus(AuthStatus authStatus) {
      store.dispatch(SetAuthStatusAction(authStatus));
    }

    void _setIsLoading(bool isLoading) {
      store.dispatch(SetIsLoadingAction(isLoading));
    }

    void _setIsLoginForm(bool isLoginForm) {
      store.dispatch(SetIsLoginFormAction(isLoginForm));
    }

    void _setErrorMessage(String errorMessage) {
      store.dispatch(SetErrorMessageAction(errorMessage));
    }

    void _setCurrentUser() {
      store.dispatch(SetCurrentUserAction());
    }

    void _signInUser(String email, String password, VoidCallback callback) {
      store.dispatch(SignInUserAction(email: email, password: password, callback: callback));
    }

    void _signUpUser(String email, String password, VoidCallback callback) {
      store.dispatch(SignUpUserAction(email: email, password: password, callback: callback));
    }

    return AuthStateViewModel(
        userId: selectUserId(store.state),
        authStatus: selectAuthStatus(store.state),
        isLoading: selectIsLoading(store.state),
        isLoginForm: selectIsLoginForm(store.state),
        errorMessage: selectErrorMessage(store.state),
        setAuthUserId: _setUserId,
        setAuthStatus: _setAuthStatus,
        setIsLoading: _setIsLoading,
        setIsLoginForm: _setIsLoginForm,
        setErrorMessage: _setErrorMessage,
        setCurrentUser: _setCurrentUser,
        signInUser: _signInUser,
        signUpUser: _signUpUser);
  }
}
