import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_firebase/models/todo_model.dart';

class FirebaseData {
  final firebaseStore = FirebaseFirestore.instance;
  final firebaseAuth = FirebaseAuth.instance;

  DocumentReference<Map<String, dynamic>> todo() {
    return firebaseStore.collection('users').doc(firebaseAuth.currentUser!.uid);
  }

  Future<List<Todo>> getData() async {
    final todos = await todo().get();
    final teste = todos.data()!['todos'] as List<dynamic>;
    final List<Todo> lista = [];
    for (var element in teste) {
      lista.add(Todo.fromMap(element));
    }
    return lista;
  }

  Future removeData(String todoId) async {
    await todo().update({
      'todos': <Todo>[].where(
        (element) => element.uuid == todoId,
      )
    });
  }

  Future insertData(Todo insertTodo) async {
    await todo().update({
      'todos': FieldValue.arrayUnion([insertTodo.toMap()])
    });
  }
}
