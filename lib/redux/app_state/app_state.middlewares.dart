import 'package:redux/redux.dart';
import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';
import 'package:crud_app/redux/todo_state/todo_state.dart';

List<Middleware<AppState>> createStoreMiddleware() {
  return [
    ...authStateMiddleware,
    ...todoStateMiddleware
  ];
}