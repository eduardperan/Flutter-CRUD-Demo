import 'package:flutter/material.dart';
import 'package:crud_app/core/models/todo.dart';
import 'package:crud_app/constant.dart';
import '../../add_edit_todo_dialog/add_edit_todo_dialog.dart';
import '../../view_details_dialog.dart';

class ListViewItem extends StatelessWidget {
  final Todo _todo;
  final int _index;

  ListViewItem(this._todo, this._index);

  @override
  Widget build(BuildContext context) {
    var key = _todo.get('key').toString();
    var subject = _todo.get('subject').toString();
    var completed = _todo.get('completed');
    return Dismissible(
        key: Key(key),
        background: Container(color: Colors.red),
        onDismissed: (direction) {
          //dispatch delete todo action
        },
        child: ListTile(
          title: Text(
            subject,
            style: TextStyle(fontSize: 20.0),
          ),
          trailing: Wrap(
            spacing: 0,
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.details,
                    color: Colors.black,
                    size: 20.0,
                  ),
                  onPressed: () {
                    showViewdDetailsDialog(context);
                  }),
              IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                    size: 20.0,
                  ),
                  onPressed: () {
                    showEditTodoDialog(context);
                  }),
              IconButton(
                  icon: completed
                      ? Icon(
                          Icons.done_outline,
                          color: Colors.green,
                          size: 20.0,
                        )
                      : Icon(Icons.done, color: Colors.grey, size: 20.0),
                  onPressed: () {
                    //dispatch toggle todo completed action
                  }),
            ],
          ),
        ));
  }

  Future<void> updateTodo(Todo todo) async {
    //dispatch update todo action
  }

  showEditTodoDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AddEditTodoDialog(
              editTodoCallback: updateTodo,
              dialogMode: ManageTodoDialogMode.EDIT,
              todo: _todo);
        });
  }

  showViewdDetailsDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return ViewDetailsDialog(_todo);
        });
  }
}
