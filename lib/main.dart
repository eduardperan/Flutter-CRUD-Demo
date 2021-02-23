import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:crud_app/app.dart';
import 'package:crud_app/redux/store.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(renderApp());
}

Widget renderApp() {
  return StoreProvider(
    store: store,
    child: new App()
  );
}
