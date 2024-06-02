import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_firebase/bloc/todo_bloc.dart';
import 'package:todo_firebase/models/todo_model.dart';
import 'package:todo_firebase/services/firebase_data.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firebaseData = FirebaseData();
  final bloc = TodoBloc(GetIt.instance.get<FirebaseData>());

  @override
  void initState() {
    super.initState();
    bloc.add(TodoRetriveEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text(
            'Sua Lista de Tarefas',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          IconButton(
            onPressed: () {
              bloc.add(
                TodoInsertEvent(
                  todo: Todo(
                    uuid: const Uuid().v1(),
                    todo: 'todo',
                    description: 'description',
                  ),
                ),
              );
            },
            icon: Icon(
              Icons.add,
            ),
          ),
          BlocBuilder<TodoBloc, TodoState>(
            bloc: bloc,
            builder: (context, state) {
              if (state is TodoSuccessState) {
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: state.listTodo.length,
                  itemBuilder: (context, index) {
                    final item = state.listTodo[index];
                    return Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(item.todo),
                          ),
                          IconButton(
                            onPressed: () {
                              bloc.add(TodoRemoveEvent(todo: item));
                            },
                            icon: const Icon(
                              Icons.delete,
                            ),
                          )
                        ],
                      ),
                    );
                  },
                );
              }

              if (state is TodoErrorState) {
                return Text(state.message);
              }

              return Container();
            },
          ),
        ],
      ),
    );
  }
}
