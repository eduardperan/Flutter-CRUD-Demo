import 'package:crud_app/core/models/field.dart';
import 'package:crud_app/core/interfaces/iform_field.dart';
import 'package:firebase_database/firebase_database.dart';

class TodoField implements IFormField {
  List<Field> _fields;

  TodoField(this._fields) {
    this._fields.add(Field<String>('key', null));
  }

  Object get(String fieldName) {
    return this._fields.firstWhere((field) => field.name == fieldName).value;
  }

  void set(String fieldName, Object newValue) {
    this._fields.firstWhere((field) => field.name == fieldName).value =
        newValue;
  }

  void fromSnapshot(DataSnapshot snapshot) {
    this.set('key', snapshot.key);
    Map<dynamic, dynamic> todoMap = snapshot.value;
    todoMap.forEach((key, value) {
      this.set(key, value);
    });
  }

  List<Field> getFields() => this._fields;

  toJson() {
    Map<String, dynamic> data = {};
    this._fields.forEach((field) {
      if (field.name != 'key') data.putIfAbsent(field.name, () => field.value);
    });
    return data;
  }
}
