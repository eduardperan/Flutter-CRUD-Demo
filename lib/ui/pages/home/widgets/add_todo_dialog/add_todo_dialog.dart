import 'package:flutter/material.dart';
import 'package:crud_app/core/models/todo.dart';
import './widgets/widgets.dart';

class AddTodoDialog extends StatefulWidget {
  AddTodoDialog({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => new _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  List<TextEditingController> _textEditingControllers;
  Todo _todo;

  @override
  void initState() {
    super.initState();
    _textEditingControllers = new List();
    _todo = new Todo();
    _todo.set('completed', false);
    _todo.set('items', []);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: Text('Add new Todo'),
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
        listTextInput.add(EditTextField(textEditingController,
            'Enter ' + name, (value) => _todo.set(name, value)));
      }

      _textEditingControllers.add(textEditingController);
    });

    return listTextInput;
  }

  void addEditTodo() async {
    //dispatch add todo action
  }
}
