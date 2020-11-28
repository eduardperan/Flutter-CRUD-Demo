import 'package:flutter/material.dart';
import 'package:crud_app/core/interfaces/iform_field.dart';

class ViewDetailsDialog extends StatelessWidget {
  final IFormFiled _iFormFiled;

  ViewDetailsDialog(this._iFormFiled);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        content: new Wrap(children: getTextInputsWidgets(context)),
        actions: getActionsWidgets(context));
  }

  List<Widget> getActionsWidgets(BuildContext context) {
    return <Widget>[
      new FlatButton(
          child: const Text('Close'),
          onPressed: () {
            Navigator.pop(context);
          })
    ];
  }

  List<Widget> getTextInputsWidgets(BuildContext context) {
    List<Widget> listTextInput = new List();
    this._iFormFiled.getFields().forEach((field) {
      var name = field.name;
      var value = field.value;
      if (name == 'key') return;
      listTextInput.add(createLabelTextWidget(name.toUpperCase(), value));
    });
    return listTextInput;
  }

  Widget createLabelTextWidget(String label, Object value) {
    return new Row(
      children: [Text(label + ': ' + value.toString())],
    );
  }
}
