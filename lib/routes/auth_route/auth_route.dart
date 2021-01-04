import 'package:flutter/widgets.dart';
import 'package:crud_app/ui/widgets/auth_waiting_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';
import 'package:crud_app/ui/pages/login_signup_page.dart';
import 'package:crud_app/constant.dart';
import 'package:crud_app/routes.dart';

class AuthRoute extends StatelessWidget {

  void _checkAuthStatus(BuildContext context, AuthStatus authStatus) {
    if (authStatus == AuthStatus.LOGGED_IN)
      Navigator.pushReplacementNamed(context, Routes.home);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthStatus>(
      onInitialBuild:(AuthStatus authStatus) => _checkAuthStatus(context, authStatus),
      onDidChange: (AuthStatus authStatus) => _checkAuthStatus(context, authStatus),
      converter: (Store<AppState> store) => authStatusSelector(store.state),
      builder: (BuildContext context, AuthStatus authStatus) {
        switch (authStatus) {
          case AuthStatus.NOT_LOGGED_IN:
            return new LoginSignupPage();
            break;
          default:
            return AuthWaitingScreen();
        }
      },
    );
  }
}
