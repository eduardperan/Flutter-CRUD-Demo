import 'package:flutter/material.dart';
import 'package:crud_app/constant.dart';

class AddEditTodoDialog extends StatefulWidget {
  AddEditTodoDialog(
      {Key key,
      this.addNewTodoCallback,
      this.editTodoSubjectCallback,
      this.dialogMode})
      : super(key: key);

  final Future Function(String subject) addNewTodoCallback;
  final Future Function(String subject) editTodoSubjectCallback;
  final ManageTodoDialogMode dialogMode;

  @override
  State<StatefulWidget> createState() => new _AddEditTodoDialogState();
}

class _AddEditTodoDialogState extends State<AddEditTodoDialog> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textEditingController.clear();
    return AlertDialog(
        content: new Row(
          children: <Widget>[
            new Expanded(
                child: new TextField(
              controller: _textEditingController,
              autofocus: true,
              decoration: new InputDecoration(
                labelText: widget.dialogMode == ManageTodoDialogMode.ADD
                    ? 'Add new Todo'
                    : 'Edit Todo',
              ),
            ))
          ],
        ),
        actions: getActionsWidgets());
  }

  List<Widget> getActionsWidgets() {
    return <Widget>[
      new FlatButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          }),
      new FlatButton(
          child: const Text('Save'),
          onPressed: () async {
            await addEditTodo();
            Navigator.pop(context);
          })
    ];
  }

  Future addEditTodo() async {
    try {
      String todoSubject = _textEditingController.text.toString();
      if (widget.dialogMode == ManageTodoDialogMode.ADD) {
        await widget.addNewTodoCallback(todoSubject);
      } else {
        await widget.editTodoSubjectCallback(todoSubject);
      }
    } catch (e) {
      print(e);
    }
  }
}
