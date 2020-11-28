import 'package:crud_app/core/models/data.dart';
import 'package:crud_app/core/models/field.dart';

class Todo extends Data {
  Todo() :
    super([
        Field<String>('subject', ""), 
        Field<bool>('completed', false),
        Field<String>('notes', ""),
        Field<List<Object>>('items', List())
      ]);
}
