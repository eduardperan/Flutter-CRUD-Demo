import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/constant.dart';

String selectUserId(AppState state) => state.auth.userId;
AuthStatus selectAuthStatus(AppState state) => state.auth.authStatus;
bool selectIsLoading(AppState state) => state.auth.isLoading;
bool selectIsLoginForm(AppState state) => state.auth.isLoginForm;
String selectErrorMessage(AppState state) => state.auth.errorMessage;
bool selectHasError(AppState state) => state.auth.errorMessage.isNotEmpty && state.auth.errorMessage != null;