import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:redux/redux.dart';
import 'package:crud_app/core/services/api/auth.dart';
import 'package:crud_app/constant.dart';
import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';

void _setCurrentUserMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  try {
    Auth auth = new Auth();
    store.dispatch(SetIsLoadingAction(true));
    FirebaseUser user = await auth.getCurrentUser();
    store.dispatch(SetUserIdAction(user?.uid));
    store.dispatch(SetAuthStatusAction(
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN));
  } catch (e) {
    print(e);
  } finally {
    store.dispatch(SetIsLoadingAction(false));
    next(action);
  }
}

void _signInUserMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  if (!(action is SignInUserAction)) return;
  String email = action.email;
  String password = action.password;
  try {
    Auth auth = new Auth();
    store.dispatch(SetIsLoadingAction(true));
    store.dispatch(SetErrorMessageAction(""));
    FirebaseUser user = await auth.signIn(email, password);
    store.dispatch(SetAuthStatusAction(
        user?.uid == null ? AuthStatus.NOT_LOGGED_IN : AuthStatus.LOGGED_IN));
    if (action is SignInUserAction) action.callback();
  } on PlatformException catch (e) {
    switch (e.message) {
      case 'An internal error has occurred. [ Unable to resolve host "www.googleapis.com":No address associated with hostname ]':
        store.dispatch(SetErrorMessageAction('Network Error.'));
        break;
      default:
        store.dispatch(SetErrorMessageAction(e.message));
        break;
    }
  } catch (e) {
    print('Error: $e');
    store.dispatch(SetErrorMessageAction(e.message));
  } finally {
    store.dispatch(SetIsLoadingAction(false));
    next(action);
  }
}

void _signUpUserMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  if (!(action is SignUpUserAction)) return;
  String email = action.email;
  String password = action.password;
  try {
    Auth auth = new Auth();
    store.dispatch(SetIsLoadingAction(true));
    store.dispatch(SetErrorMessageAction(""));
    await auth.signUp(email, password);
    store.dispatch(SetIsLoginFormAction(true));
    if (action is SignUpUserAction) action.callback();
  } on PlatformException catch (e) {
    switch (e.message) {
      case 'An internal error has occurred. [ Unable to resolve host "www.googleapis.com":No address associated with hostname ]':
        store.dispatch(SetErrorMessageAction('Network Error.'));
        break;
      default:
        store.dispatch(SetErrorMessageAction(e.message));
        break;
    }
  } catch (e) {
    print('Error: $e');
    store.dispatch(SetErrorMessageAction(e.message));
  } finally {
    store.dispatch(SetIsLoadingAction(false));
    next(action);
  }
}

void _signOutUserMiddleware(
    Store<AppState> store, action, NextDispatcher next) async {
  try {
    Auth auth = new Auth();
    store.dispatch(SetIsLoadingAction(true));
    store.dispatch(SetErrorMessageAction(""));
    await auth.signOut();
    store.dispatch(SetAuthStatusAction(AuthStatus.NOT_LOGGED_IN));
    store.dispatch(SetIsLoginFormAction(true));
  } on PlatformException catch (e) {
    switch (e.message) {
      case 'An internal error has occurred. [ Unable to resolve host "www.googleapis.com":No address associated with hostname ]':
        store.dispatch(SetErrorMessageAction('Network Error.'));
        break;
      default:
        store.dispatch(SetErrorMessageAction(e.message));
        break;
    }
  } catch (e) {
    print('Error: $e');
    store.dispatch(SetErrorMessageAction(e.message));
  } finally {
    store.dispatch(SetIsLoadingAction(false));
    next(action);
  }
}

List<Middleware<AppState>> authStateMiddleware = [
  TypedMiddleware<AppState, SetCurrentUserAction>(_setCurrentUserMiddleware),
  TypedMiddleware<AppState, SignInUserAction>(_signInUserMiddleware),
  TypedMiddleware<AppState, SignUpUserAction>(_signUpUserMiddleware),
  TypedMiddleware<AppState, SignOutUserAction>(_signOutUserMiddleware)
];
