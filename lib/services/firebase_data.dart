import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_firebase/models/todo_model.dart';

class FirebaseData {
  final firebaseStore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> todo() {
    return firebaseStore.collection('users').doc(firebaseAuth.currentUser!.uid).collection('todos');
  }

  Future<List<Todo>> getData() async {
    final todos = await todo().get();
    final List<Todo> lista = [];
    for(var elements in todos.docs) {
      lista.add(Todo.fromMap(elements.data()['todos']));
    }
    return lista;
  }

  Future removeData(Todo removeTodo) async {
    await todo().doc(removeTodo.uuid).delete();
  }

  Future insertData(Todo insertTodo) async {
    await todo().doc(insertTodo.uuid).set({'todos' : insertTodo.toMap()});
  }

  Future changeBool(Todo changeBool, bool value) async {
    await todo().doc(changeBool.uuid).update({'todos.isDone': value});
  }

}
