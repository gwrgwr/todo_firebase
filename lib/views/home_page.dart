import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_firebase/bloc/todo_bloc.dart';
import 'package:todo_firebase/models/todo_model.dart';
import 'package:todo_firebase/services/firebase_auth.dart';
import 'package:todo_firebase/services/firebase_data.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myFirebaseAuth = MyFirebaseAuth();
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseData = FirebaseData();
  final bloc = TodoBloc(GetIt.instance.get<FirebaseData>());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: TextButton(
          onPressed: () {
            myFirebaseAuth.logout();
          },
          child: Text(
            'Sair',
          ),
        ),
      ),
      appBar: AppBar(
        title: StreamBuilder<User?>(
            stream: firebaseAuth.userChanges(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text("Olá, ${snapshot.data!.displayName}");
              } else {
                return Text('Loading');
              }
            }),
      ),
      body: Column(
        children: [
          Text('Sua Lista de Tarefas'),
          BlocBuilder<TodoBloc, TodoState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is TodoSuccessState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.listTodo.length,
                  itemBuilder: (context, index) {
                    final item = state.listTodo[index];
                    return Text(item.todo);
                  },
                );
              }

              if (state is TodoErrorState) {
                return Text(state.message);
              }

              return Container();
            },
          ),
          IconButton(
            onPressed: () {
              bloc.add(
                TodoInsertEvent(
                  todo: Todo(
                    uuid: Uuid().v1(),
                    todo: 'todo',
                    description: 'description',
                    isDone: false,
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.add,
            ),
          )
        ],
      ),
    );
  }
}
