import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';
import 'package:crud_app/ui/widgets/auth_waiting_screen.dart';
import 'widgets/widgets.dart';

class LoginSignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, AuthStateViewModel>(
      converter: (Store<AppState> store) => AuthStateViewModel.create(store),
      builder: (BuildContext context, AuthStateViewModel authStateViewModel) {
        final bool isLoading = authStateViewModel.isLoading;
        return Scaffold(
            appBar: !isLoading? AppBar(title: Text('Flutter login')): null,
            body: Stack(
              children: <Widget>[
                LogInSignUpForm(authStateViewModel),
                AuthWaitingScreen(show: isLoading),
              ],
            ));
      },
    );
  }
}
