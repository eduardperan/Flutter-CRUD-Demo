import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:crud_app/core/services/authentication.dart';
import 'package:crud_app/constant.dart';
import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';

Middleware<AppState> setCurrentUserMiddleware(Auth auth) {
  return (Store<AppState> store, action, NextDispatcher next) async {
    try {
      store.dispatch(new SetIsLoadingAction(true));

      FirebaseUser user = await auth.getCurrentUser();

      store.dispatch(new SetUserIdAction(user?.uid));
      store.dispatch(new SetAuthStatusAction(
          user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN));
    } catch (e) {
      print(e);
    } finally {
      store.dispatch(new SetIsLoadingAction(false));
      next(action);
    }
  };
}

Middleware<AppState> signInUserMiddleware(Auth auth) {
  return (Store<AppState> store, action, NextDispatcher next) async {

    if(!(action is SignInUserAction)) return;

    String email = action._email;
    String password = action._password;

    try {
      store.dispatch(new SetIsLoadingAction(true));
      store.dispatch(new SetErrorMessageAction(""));

      FirebaseUser user = await auth.signIn(email, password);

      store.dispatch(new SetAuthStatusAction(
          user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN));

      if (action is SignInUserAction) action.callback();
    } on PlatformException catch (e) {
      switch (e.message) {
        case 'An internal error has occurred. [ Unable to resolve host "www.googleapis.com":No address associated with hostname ]':
          store.dispatch(new SetErrorMessageAction('Network Error.'));
          break;
        default:
          store.dispatch(new SetErrorMessageAction(e.message));
          break;
      }
    } catch (e) {
      print('Error: $e');
      store.dispatch(new SetErrorMessageAction(e.message));
    } finally {
      store.dispatch(new SetIsLoadingAction(false));
      next(action);
    }
  };
}


Middleware<AppState> signUpUserMiddleware(Auth auth) {
  return (Store<AppState> store, action, NextDispatcher next) async {

    if(!(action is SignUpUserAction)) return;

    String email = action._email;
    String password = action._password;

    try {
      store.dispatch(new SetIsLoadingAction(true));
      store.dispatch(new SetErrorMessageAction(""));

      await auth.signUp(email, password);

      if (action is SignUpUserAction) action.callback();
    } on PlatformException catch (e) {
      switch (e.message) {
        case 'An internal error has occurred. [ Unable to resolve host "www.googleapis.com":No address associated with hostname ]':
          store.dispatch(new SetErrorMessageAction('Network Error.'));
          break;
        default:
          store.dispatch(new SetErrorMessageAction(e.message));
          break;
      }
    } catch (e) {
      print('Error: $e');
      store.dispatch(new SetErrorMessageAction(e.message));
    } finally {
      store.dispatch(new SetIsLoginFormAction(true));
      store.dispatch(new SetIsLoadingAction(false));
      next(action);
    }
  };
}
