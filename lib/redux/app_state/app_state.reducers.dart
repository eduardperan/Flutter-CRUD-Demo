import 'app_state.models.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';

AppState appReducer(AppState state, action) {
  return AppState(
    auth: authReducer(state.auth, action)
  );
}
