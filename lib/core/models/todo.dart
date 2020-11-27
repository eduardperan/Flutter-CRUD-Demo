import 'package:crud_app/core/models/data.dart';
import 'package:crud_app/core/models/field.dart';
import 'package:crud_app/constant.dart';

class Todo extends Data {
  Todo() :
    super([
        Field('subject', FieldType.STRING), 
        Field('completed', FieldType.BOOLEAN),
        Field('Notes', FieldType.STRING)
      ]);
}
