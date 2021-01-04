import 'package:firebase_auth/firebase_auth.dart';
import 'package:redux/redux.dart';
import 'package:crud_app/core/services/authentication.dart';
import 'package:crud_app/constant.dart';
import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';

Middleware<AppState> setCurrentUserMiddleware(Auth auth) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    try {
      FirebaseUser user = await auth.getCurrentUser();
      store.dispatch(new SetAuthUserIdAction(user?.uid));
      store.dispatch(new SetAuthStatusAction(
          user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN));
    } catch (e) {
      print(e);
    }
    next(action);
  };
}
