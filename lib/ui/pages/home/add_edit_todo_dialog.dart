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

  final Future<void> Function(Todo todo) addNewTodoCallback;
  final Future<void> Function(Todo todo) editTodoSubjectCallback;
  final ManageTodoDialogMode dialogMode;
  final Todo todo;

  @override
  State<StatefulWidget> createState() => new _AddEditTodoDialogState();
}

class _AddEditTodoDialogState extends State<AddEditTodoDialog> {
  List<TextEditingController> _textEditingControllers;
  Todo _todo;
  bool _isEditMode;

  @override
  void initState() {
    super.initState();
    _textEditingControllers = new List();
    _isEditMode = widget.dialogMode == ManageTodoDialogMode.EDIT ? true : false;
    Todo todo = new Todo();
    todo.set('completed', false);
    _todo = _isEditMode ? widget.todo : todo;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text(_isEditMode ? 'Add new Todo' : 'Edit Todo'),
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
    TextEditingController textEditingController;

    _todo.getFields().forEach((field) {
      if (field.name == 'key' || field.type == FieldType.BOOLEAN) return;

      textEditingController = new TextEditingController();

      if (_isEditMode)
        textEditingController.value =
            TextEditingValue(text: _todo.get(field.name).toString());

      listTextInput.add(createInputTextWidget(textEditingController,
          'Enter ' + field.name, (value) => _todo.set(field.name, value)));

      _textEditingControllers.add(textEditingController);
    });

    return listTextInput;
  }

  Widget createInputTextWidget(TextEditingController textEditingController,
      String label, onChangeCallBack) {
    return new Row(
      children: [
        new Expanded(
            child: new TextField(
          controller: textEditingController,
          autofocus: true,
          decoration: new InputDecoration(labelText: label),
          onChanged: onChangeCallBack,
        )),
      ],
    );
  }

  void addEditTodo() async {
    try {
      if (!_isEditMode) {
        await widget.addNewTodoCallback(_todo);
      } else {
        await widget.editTodoSubjectCallback(_todo);
      }
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }
}
