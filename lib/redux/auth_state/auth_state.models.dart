import 'package:crud_app/constant.dart';

class AuthState {
  final String userId;
  final AuthStatus authStatus;
  final bool isLoading;
  AuthState({this.userId = "", this.isLoading = false, this.authStatus = AuthStatus.NOT_DETERMINED});

  AuthState fromInstance({
    String userId,
    AuthStatus authStatus,
    bool isLoading,
  }) {
    return new AuthState(
      userId: userId ?? this.userId,
      authStatus: authStatus ?? this.authStatus,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
