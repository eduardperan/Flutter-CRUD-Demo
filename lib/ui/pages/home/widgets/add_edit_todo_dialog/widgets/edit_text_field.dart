import 'package:flutter/material.dart';

class EditTextField extends StatelessWidget {
  final TextEditingController _textEditingController;
  final String _label;
  final void Function(String value) _onChangeCallBack;

  EditTextField(
      this._textEditingController, this._label, this._onChangeCallBack);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: [
        new Expanded(
            child: new TextField(
          controller: this._textEditingController,
          autofocus: true,
          decoration: new InputDecoration(labelText: this._label),
          onChanged: this._onChangeCallBack,
        )),
      ],
    );
  }
}
