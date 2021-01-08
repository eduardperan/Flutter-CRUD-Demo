import 'package:crud_app/constant.dart';
import 'package:flutter/cupertino.dart';

class SetUserIdAction {
  final String userId;
  SetUserIdAction(this.userId);
}

class SetAuthStatusAction {
  final AuthStatus authStatus;
  SetAuthStatusAction(this.authStatus);
}

class SetIsLoadingAction {
  final bool isLoading;
  SetIsLoadingAction(this.isLoading);
}

class SetIsLoginFormAction {
  final bool isLoginForm;
  SetIsLoginFormAction(this.isLoginForm);
}

class SetErrorMessageAction {
  final String errorMessage;
  SetErrorMessageAction(this.errorMessage);
}

class SetCurrentUserAction {}

class SignInUserAction {
  final String email;
  final String password;
  final VoidCallback callback;
  SignInUserAction({@required this.email, @required this.password, this.callback});
}

class SignUpUserAction {
  final String email;
  final String password;
  final VoidCallback callback;
  SignUpUserAction({@required this.email, @required this.password, this.callback});
}