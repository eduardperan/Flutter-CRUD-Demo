import 'package:crud_app/constant.dart';

class SetAuthUserIdAction {
  final String authUserId;
  SetAuthUserIdAction(this.authUserId);
}

class SetAuthStatusAction {
  final AuthStatus authStatus;
  SetAuthStatusAction(this.authStatus);
}

class SetAuthIsLoadingAction {
  final bool authIsLoading;
  SetAuthIsLoadingAction(this.authIsLoading);
}

class SetCurrentUserAction {}
