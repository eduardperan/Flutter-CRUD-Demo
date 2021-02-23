import 'package:flutter/material.dart';
import 'add_todo_dialog/add_todo_dialog.dart';

class AddTodoButton extends StatelessWidget {
  showAddTodoDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AddTodoDialog();
        });
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        showAddTodoDialog(context);
      },
      tooltip: 'Increment',
      child: Icon(Icons.add),
    );
  }
}
