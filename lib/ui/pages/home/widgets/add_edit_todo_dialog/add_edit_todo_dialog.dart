import 'package:flutter/material.dart';
import 'package:crud_app/constant.dart';
import 'package:crud_app/core/models/todo.dart';
import 'widgets/widgets.dart';

class AddEditTodoDialog extends StatefulWidget {
  AddEditTodoDialog(
      {Key key,
      this.addNewTodoCallback,
      this.editTodoCallback,
      this.dialogMode,
      this.todo})
      : super(key: key);

  final Future<void> Function(Todo todo) addNewTodoCallback;
  final Future<void> Function(Todo todo) editTodoCallback;
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
    todo.set('items', ['asd', 'asdasd']);
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
      var name = field.name;
      var value = field.value;

      if (name.toLowerCase() == 'key') return;

      if (value is String || value is int || value is double) {
        textEditingController = new TextEditingController();
        if (_isEditMode)
          textEditingController.value =
              TextEditingValue(text: _todo.get(name).toString());

        listTextInput.add(new EditTextField(textEditingController,
            'Enter ' + name, (value) => _todo.set(name, value)));
      }

      _textEditingControllers.add(textEditingController);
    });

    return listTextInput;
  }

  void addEditTodo() async {
    try {
      if (!_isEditMode) {
        await widget.addNewTodoCallback(_todo);
      } else {
        await widget.editTodoCallback(_todo);
      }
      Navigator.pop(context);
    } catch (e) {
      print(e);
    }
  }
}
