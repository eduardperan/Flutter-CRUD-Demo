import 'package:flutter/material.dart';

class AuthWaitingScreen extends StatelessWidget {
  final bool show;
  AuthWaitingScreen({this.show = true});
  @override
  Widget build(BuildContext context) {
    if(this.show)
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        child: CircularProgressIndicator(),
      ),
    );

    return Container(
      height: 0.0,
      width: 0.0,
    );
  }
}
