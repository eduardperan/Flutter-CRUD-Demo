import 'package:crud_app/core/models/todo_field.dart';
import 'package:crud_app/core/models/field.dart';

class Todo extends TodoField {
  Todo() :
    super([
        Field<String>('subject', ""), 
        Field<bool>('completed', false),
        Field<String>('notes', ""),
        Field<List<Object>>('items', List())
      ]);
}
