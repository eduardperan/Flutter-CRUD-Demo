import 'package:crud_app/core/models/field.dart';
import 'package:crud_app/core/interfaces/iform_field.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:crud_app/constant.dart';

class Data implements IFormFiled {
  Map<Field, Object> _fields;

  Data(List<Field> fieldsArgs) {
    fieldsArgs.add(new Field('key', FieldType.STRING));
    this._fields =
        Map.fromIterable(fieldsArgs, key: (f) => f, value: (v) => null);
  }

  Object get(String fieldName) {
    return this
        ._fields
        .entries
        .singleWhere((field) => field.key.name == fieldName)
        .value;
  }

  void set(String fieldName, Object newValue) {
    this._fields = this._fields.map((key, value) {
      if ((key.type == FieldType.BOOLEAN && newValue is bool) ||
        (key.type == FieldType.STRING && newValue is String) ||
        (key.type == FieldType.DATE && newValue is DateTime) ||
        (key.type == FieldType.NUMBER && newValue is int) ||
        (key.type == FieldType.LIST && newValue is List)
      ){
        return MapEntry(key, value = (key.name == fieldName) ? newValue : value);
      } else {
        return MapEntry(key, value);
      }
    });
  }

  void fromSnapshot(DataSnapshot snapshot) {
    this.set('key', snapshot.key);
    Map<dynamic, dynamic> todoMap = snapshot.value;
    todoMap.forEach((key, value) {
      this.set(key, value);
    });
  }

  List<Field> getFields() => this._fields.keys.toList();
 
  toJson() {
    Map<String, dynamic> data = {};
    this._fields.forEach((key, value) {
      if (key.name != 'key')
        data.putIfAbsent(key.name, () => value);
    });
    return data;
  }
}
