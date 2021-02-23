import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:crud_app/redux/app_state/app_state.dart';
import 'package:crud_app/redux/todo_state/todo_state.dart';
import 'package:crud_app/ui/widgets/circular_progress.dart';
import 'widgets/widgets.dart';

class HomePage extends StatelessWidget {
  HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, TodoStateViewModel>(
      converter: (Store<AppState> store) => TodoStateViewModel.create(store),
      builder: (BuildContext context, TodoStateViewModel todoStateViewModel) {
        return Scaffold(
            appBar: AppBar(
              title: Text('Flutter todo list Demo'),
              actions: <Widget>[SignOutButton()],
            ),
            body: Stack(
              children: <Widget>[
                TodosListView(),
                CircularProgress(todoStateViewModel.isFetchTodosLoading),
              ],
            ),
            floatingActionButton: AddTodoButton());
      },
    );
  }
}
