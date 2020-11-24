import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:crud_app/core/models/todo.dart';
import 'package:crud_app/constant.dart';
import 'package:crud_app/ui/pages/home/add_edit_todo_dialog.dart';

class ListViewItem extends StatelessWidget {
  final void Function(Todo todo) _toggleComplete;
  final void Function(String key, int index) _deleteTodo;
  final Todo _todo;
  final int _index;

  ListViewItem(this._todo, this._index, this._toggleComplete, this._deleteTodo);

  final FirebaseDatabase _database = FirebaseDatabase.instance;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(_todo.key),
        background: Container(color: Colors.red),
        onDismissed: (direction) async {
          _deleteTodo(_todo.key, _index);
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
                    _toggleComplete(_todo);
                  }),
            ],
          ),
        ));
  }

  Future updateTodoSubject(String subject) async {
    print(subject);
    if (subject.length <= 0) return;
    try {
      await _database
          .reference()
          .child("todo")
          .child(_todo.key)
          .update({'subject': subject});
    } catch (e) {
      print(e);
    }
  }

  showAddTodoDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AddEditTodoDialog(
              editTodoSubjectCallback: updateTodoSubject,
              dialogMode: ManageTodoDialogMode.EDIT);
        });
  }
}
