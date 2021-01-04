import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/constant.dart';

String userIdSelector(AppState state) => state.auth.userId;
AuthStatus authStatusSelector(AppState state) => state.auth.authStatus;