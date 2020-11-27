import 'package:flutter/material.dart';
import 'package:crud_app/core/models/todo.dart';
import 'package:crud_app/constant.dart';
import 'package:crud_app/ui/pages/home/add_edit_todo_dialog.dart';
import 'package:crud_app/ui/widgets/view_details_dialog.dart';

class ListViewItem extends StatelessWidget {
  final void Function(Todo todo) _toggleCompleteCallBack;
  final void Function(String todoId, int index) _deleteTodoCallBack;
  final Future<void> Function(Todo todo) _updateTodoSubjectCallBack;
  final Todo _todo;
  final int _index;

  ListViewItem(this._todo, this._index, this._toggleCompleteCallBack,
      this._deleteTodoCallBack, this._updateTodoSubjectCallBack);

  @override
  Widget build(BuildContext context) {
    var key = _todo.get('key').toString();
    var subject = _todo.get('subject').toString();
    var completed = _todo.get('completed');
    return Dismissible(
        key: Key(key),
        background: Container(color: Colors.red),
        onDismissed: (direction) {
          _deleteTodoCallBack(key, _index);
        },
        child: ListTile(
          title: Text(
            subject,
            style: TextStyle(fontSize: 20.0),
          ),
          trailing: Wrap(
            spacing: 8, // space between two icons
            children: <Widget>[
              IconButton(
                  icon: Icon(
                    Icons.view_list,
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
                    _toggleCompleteCallBack(_todo);
                  }),
            ],
          ),
        ));
  }

  Future<void> updateTodoSubject(Todo todo) async {
    await _updateTodoSubjectCallBack(todo);
  }

  showEditTodoDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AddEditTodoDialog(
              editTodoSubjectCallback: updateTodoSubject,
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
