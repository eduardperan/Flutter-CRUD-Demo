import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:crud_app/my_app.dart';
import 'package:crud_app/redux/middleware.dart';
import 'package:crud_app/redux/app_state/app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(renderApp());
}

Widget renderApp() {
  return StoreProvider(
    store: Store<AppState>(
        appReducer,
        initialState: AppState.initialState(),
        middleware: createStoreMiddleware()
      ),
    child: new MyApp()
  );
}
