import 'package:flutter/material.dart';

class AuthWaitingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            body: Container(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          );
  }
}
