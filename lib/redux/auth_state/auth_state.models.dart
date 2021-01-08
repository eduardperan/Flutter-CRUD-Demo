import 'package:crud_app/constant.dart';

class AuthState {
  final String userId;
  final AuthStatus authStatus;
  final bool isLoading;
  final bool isLoginForm;
  final String errorMessage;

  AuthState({
    this.userId = "",
    this.authStatus = AuthStatus.NOT_DETERMINED,
    this.isLoading = false,
    this.isLoginForm = true,
    this.errorMessage = "",
  });

  AuthState fromInstance({
    String userId,
    AuthStatus authStatus,
    bool isLoading,
    bool isLoginForm,
    String errorMessage,
  }) {
    return new AuthState(
      userId: userId ?? this.userId,
      authStatus: authStatus ?? this.authStatus,
      isLoading: isLoading ?? this.isLoading,
      isLoginForm: isLoginForm ?? this.isLoginForm,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
