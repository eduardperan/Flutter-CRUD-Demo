import 'package:flutter/widgets.dart';
import 'package:crud_app/ui/widgets/auth_waiting_screen.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';
import 'package:crud_app/constant.dart';
import 'package:crud_app/routes.dart';

class ProtectedRoute extends StatelessWidget {
  final Widget page;
  ProtectedRoute({@required this.page});

  void _checkAuthStatus(BuildContext context, AuthStatus authStatus) {
    if (authStatus != AuthStatus.LOGGED_IN)
      Navigator.pushReplacementNamed(context, Routes.auth);
  }

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthStatus>(
      distinct: true,
      onInitialBuild: (AuthStatus authStatus) => _checkAuthStatus(context, authStatus),
      onDidChange: (AuthStatus authStatus) => _checkAuthStatus(context, authStatus),
      converter: (Store<AppState> store) => selectAuthStatus(store.state),
      builder: (BuildContext context, AuthStatus authStatus) {
        switch (authStatus) {
          case AuthStatus.LOGGED_IN:
            return this.page;
            break;
          default:
            return new AuthWaitingScreen();
        }
      },
    );
  }
}
