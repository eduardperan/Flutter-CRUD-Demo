import 'package:redux/redux.dart';
import 'package:crud_app/redux/app_state/app_state.dart';

Store<AppState> store = Store<AppState>(appReducer,
    initialState: AppState.initialState(), middleware: createStoreMiddleware());
