import 'package:flutter/material.dart';
import 'package:crud_app/core/services/authentication.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:crud_app/core/models/todo.dart';
import 'package:crud_app/ui/pages/home/list_view_item.dart';
import 'package:crud_app/ui/pages/home/add_edit_todo_dialog.dart';
import 'package:crud_app/constant.dart';
import 'dart:async';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.auth, this.userId, this.logoutCallback})
      : super(key: key);

  final BaseAuth auth;
  final VoidCallback logoutCallback;
  final String userId;

  @override
  State<StatefulWidget> createState() => new _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Todo> _todoList;

  final FirebaseDatabase _database = FirebaseDatabase.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  StreamSubscription<Event> _onTodoAddedSubscription;
  StreamSubscription<Event> _onTodoChangedSubscription;

  Query _todoQuery;

  @override
  void initState() {
    super.initState();

    _todoList = new List();
    _todoQuery = _database
        .reference()
        .child("todo")
        .orderByChild("userId")
        .equalTo(widget.userId);
    _onTodoAddedSubscription = _todoQuery.onChildAdded.listen(onEntryAdded);
    _onTodoChangedSubscription =
        _todoQuery.onChildChanged.listen(onEntryChanged);
  }

  @override
  void dispose() {
    _onTodoAddedSubscription.cancel();
    _onTodoChangedSubscription.cancel();
    super.dispose();
  }

  onEntryChanged(Event event) {
    var oldEntry = _todoList.singleWhere((entry) {
      return entry.key == event.snapshot.key;
    });

    setState(() {
      _todoList[_todoList.indexOf(oldEntry)] =
          Todo.fromSnapshot(event.snapshot);
    });
  }

  onEntryAdded(Event event) {
    setState(() {
      _todoList.add(Todo.fromSnapshot(event.snapshot));
    });
  }

  signOut() async {
    try {
      await widget.auth.signOut();
      widget.logoutCallback();
    } catch (e) {
      print(e);
    }
  }

  Future createNewTodo(String subject) async {
    String userId = widget.userId;

    if (userId.length <= 0) 
      throw Exception('User is required.');
    
    if (subject.length <= 0) 
      throw Exception('Todo subject is required.');
    
    Todo todo = new Todo(subject, userId, false);
    await _database.reference().child("todo").push().set(todo.toJson());
  }

  Future updateTodoSubject(String todoId, String subject) async {

    if (todoId.length <= 0) 
      throw Exception('Todo id is required.');
    
    if (subject.length <= 0) 
      throw Exception('Todo subject is required.');

    await _database
        .reference()
        .child("todo")
        .child(todoId)
        .update({'subject': subject});
  }

  toggleComplete(Todo todo) async {
    todo.completed = !todo.completed;   
    if (todo == null) throw Exception('Todo is required.');
    try {
      await _database.reference().child("todo").child(todo.key).set(todo.toJson());
    } catch (e) {
      print(e);
    }
  }

  deleteTodo(String todoId, int index) async {

    if (todoId.length <= 0) 
      throw Exception('Todo id is required.');
    
    if (index < 0 || index == null) 
      throw Exception('Todo index is required.');

    try {
      await _database.reference().child("todo").child(todoId).remove();
      print("Delete $todoId successful");
      setState(() {
        _todoList.removeAt(index);
      });
    } catch (e) {
      print(e);
    }
  }

  showAddTodoDialog(BuildContext context) async {
    await showDialog<String>(
        context: context,
        builder: (BuildContext context) {
          return AddEditTodoDialog(
              addNewTodoCallback: createNewTodo,
              dialogMode: ManageTodoDialogMode.ADD);
        });
  }

  Widget showTodoList() {
    if (_todoList.length > 0) {
      return ListView.builder(
          shrinkWrap: true,
          itemCount: _todoList.length,
          itemBuilder: (BuildContext context, int index) {
            Todo todo = _todoList[index];
            return ListViewItem(
                todo, index, toggleComplete, deleteTodo, updateTodoSubject);
          });
    } else {
      return Center(
          child: Text(
        "Welcome. Your list is empty",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 30.0),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Flutter todo list Demo'),
          actions: <Widget>[
            new FlatButton(
                child: new Text('Logout',
                    style: new TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: signOut)
          ],
        ),
        body: showTodoList(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showAddTodoDialog(context);
          },
          tooltip: 'Increment',
          child: Icon(Icons.add),
        ));
  }
}
