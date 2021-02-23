import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/redux/auth_state/auth_state.dart';

class SignOutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    return FlatButton(
        child: Text('Logout',
            style: TextStyle(fontSize: 17.0, color: Colors.white)),
        onPressed: () => store.dispatch(SignOutUserAction()));
  }
}
