import 'package:crud_app/core/models/field.dart';
import 'package:firebase_database/firebase_database.dart';

abstract class IFormFiled {
  Object get(String field);
  void set(String field, Object value);
  List<Field> getFields();
  fromSnapshot(DataSnapshot snapshot);
  toJson();
}
