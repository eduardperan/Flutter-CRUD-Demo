import 'package:flutter/material.dart';
import 'package:crud_app/constant.dart';

class AddEditTodoDialog extends StatefulWidget {
  AddEditTodoDialog(
      {Key key,
      this.addNewTodoCallback,
      this.editTodoSubjectCallback,
      this.dialogMode,
      this.subject})
      : super(key: key);

  final Future<void> Function(String subject) addNewTodoCallback;
  final Future<void> Function(String subject) editTodoSubjectCallback;
  final ManageTodoDialogMode dialogMode;
  final String subject;

  @override
  State<StatefulWidget> createState() => new _AddEditTodoDialogState();
}

class _AddEditTodoDialogState extends State<AddEditTodoDialog> {
  final _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _textEditingController.clear();
    if(widget.dialogMode == ManageTodoDialogMode.EDIT)
      _textEditingController.value = TextEditingValue(text: widget.subject);
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
        actions: getActionsWidgets(context));
  }

  List<Widget> getActionsWidgets(BuildContext context) {
    return <Widget>[
      new FlatButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.pop(context);
          }),
      new FlatButton(
          child: const Text('Save'),
          onPressed: () {
            addEditTodo();
          })
    ];
  }

  void addEditTodo() async {
    try {
      String todoSubject = _textEditingController.text.toString();
      if (todoSubject.length <= 0) return;
      if (widget.dialogMode == ManageTodoDialogMode.ADD) {
        await widget.addNewTodoCallback(todoSubject);
      } else {
        await widget.editTodoSubjectCallback(todoSubject);
      }
      _textEditingController.clear();
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }
}
