import 'package:flutter/material.dart';
import 'package:crud_app/core/services/authentication.dart';
import 'package:crud_app/app.dart';

void main() {
  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        title: 'Flutter login demo',
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new App(auth: new Auth()));
  }
}
