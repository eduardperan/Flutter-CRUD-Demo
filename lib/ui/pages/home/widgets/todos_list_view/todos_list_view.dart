import 'package:flutter/material.dart';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:crud_app/core/services/api/auth.dart';
import 'package:crud_app/core/models/models.dart';
import 'widgets/widgets.dart';

class TodosListView extends StatefulWidget {
  TodosListView({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final Auth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _TodosListViewState();
}

class _TodosListViewState extends State<TodosListView> {
  List<Todo> _todoList;

  // final FirebaseDatabase _database = FirebaseDatabase.instance;
  // final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  // StreamSubscription<Event> _onTodoAddedSubscription;
  // StreamSubscription<Event> _onTodoChangedSubscription;
  // Query _todoQuery;

  @override
  void initState() {
    super.initState();
    //_todoList = new List();
    // _todoQuery = _database.reference().child("todo").child(widget.userId);
    // _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
    // _onTodoChangedSubscription =
    //     _todoQuery.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {
    // _onTodoAddedSubscription.cancel();
    // _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  // onEntryChanged(Event event) {
  //   var oldEntry = _todoList.singleWhere((entry) {
  //     return entry.get('key') == event.snapshot.key;
  //   });

  //   Todo todo = new Todo();
  //   todo.fromSnapshot(event.snapshot);

  //   setState(() {
  //     _todoList[_todoList.indexOf(oldEntry)] = todo;
  //   });
  // }

  // onEntryAdded(Event event) {
  //   Todo todo = new Todo();
  //   todo.fromSnapshot(event.snapshot);
  //   setState(() {
  //     _todoList.add(todo);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    if (_todoList.length <= 0)
      return Center(
          child: Text(
        "Welcome. Your list is empty",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),
      ));

    return ListView.builder(
        shrinkWrap: true,
        itemCount: _todoList.length,
        itemBuilder: (BuildContext context, int index) {
          Todo todo = _todoList[index];
          return ListViewItem(todo, index);
        });
  }
}
