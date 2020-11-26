import 'package:flutter/material.dart';
import 'package:crud_app/constant.dart';
import 'package:crud_app/core/models/todo.dart';

class AddEditTodoDialog extends StatefulWidget {
  AddEditTodoDialog(
      {Key key,
      this.addNewTodoCallback,
      this.editTodoSubjectCallback,
      this.dialogMode,
      this.todo})
      : super(key: key);

  final Future<void> Function(String subject) addNewTodoCallback;
  final Future<void> Function(String subject) editTodoSubjectCallback;
  final ManageTodoDialogMode dialogMode;
  final Todo todo;

  @override
  State<StatefulWidget> createState() => new _AddEditTodoDialogState();
}

class _AddEditTodoDialogState extends State<AddEditTodoDialog> {
  List<TextEditingController> _textEditingControllers;

  @override
  void initState() {
    super.initState();
    _textEditingControllers = new List();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(widget.dialogMode == ManageTodoDialogMode.ADD
            ? 'Add new Todo'
            : 'Edit Todo'),
        content: new Wrap(children: getTextInputsWidgets(context)),
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

  List<Widget> getTextInputsWidgets(BuildContext context) {
    List<Widget> listTextInput = new List();
    var textEditingController = TextEditingController();

    textEditingController.clear();
    if (widget.dialogMode == ManageTodoDialogMode.EDIT) textEditingController.value = TextEditingValue(text: widget.todo.subject);

    listTextInput
        .add(createInputTextWidget(textEditingController, 'Enter Subject'));
    _textEditingControllers.add(textEditingController);
    return listTextInput;
  }

  Widget createInputTextWidget(
      TextEditingController textEditingController, String label) {
    return new Row(
      children: [
        new Expanded(
            child: new TextField(
          controller: textEditingController,
          autofocus: true,
          decoration: new InputDecoration(labelText: label),
        )),
      ],
    );
  }

  void addEditTodo() async {
    try {
      String todoSubject = _textEditingControllers[0].text.toString();
      if (todoSubject.length <= 0) return;
      if (widget.dialogMode == ManageTodoDialogMode.ADD) {
        await widget.addNewTodoCallback(todoSubject);
      } else {
        await widget.editTodoSubjectCallback(todoSubject);
      }
      _textEditingControllers[0].clear();
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }
}
