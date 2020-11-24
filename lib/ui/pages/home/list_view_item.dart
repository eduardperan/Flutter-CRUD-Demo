import 'package:flutter/material.dart';
import 'package:crud_app/core/models/todo.dart';
import 'package:crud_app/constant.dart';
import 'package:crud_app/ui/pages/home/add_edit_todo_dialog.dart';

class ListViewItem extends StatelessWidget {
  final void Function(Todo todo) _toggleCompleteCallBack;
  final void Function(String todoId, int index) _deleteTodoCallBack;
  final Future Function(String todoId, String subject) _updateTodoSubjectCallBack;
  final Todo _todo;
  final int _index;

  ListViewItem(this._todo, this._index, this._toggleCompleteCallBack, this._deleteTodoCallBack,
      this._updateTodoSubjectCallBack);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(_todo.key),
        background: Container(color: Colors.red),
        onDismissed: (direction) {
          _deleteTodoCallBack(_todo.key, _index);
        },
        child: ListTile(
          title: Text(
            _todo.subject,
            style: TextStyle(fontSize: 20.0),
          ),
          trailing: Wrap(
            spacing: 8, // space between two icons
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.edit,
                    color: Colors.green,
                    size: 20.0,
                  ),
                  onPressed: () {
                    showAddTodoDialog(context);
                  }),
              IconButton(
                  icon: (_todo.completed)
                      ? Icon(
                          Icons.done_outline,
                          color: Colors.green,
                          size: 20.0,
                        )
                      : Icon(Icons.done, color: Colors.grey, size: 20.0),
                  onPressed: () {
                    _toggleCompleteCallBack(_todo);
                  }),
            ],
          ),
        ));
  }

  Future updateTodoSubject(String subject) async {
    await _updateTodoSubjectCallBack(_todo.key, subject);
  }

  showAddTodoDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AddEditTodoDialog(
              editTodoSubjectCallback: updateTodoSubject,
              dialogMode: ManageTodoDialogMode.EDIT,
              subject: _todo.subject);
        });
  }
}
