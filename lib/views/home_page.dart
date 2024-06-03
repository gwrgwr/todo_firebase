import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_firebase/bloc/todo_bloc.dart';
import 'package:todo_firebase/models/todo_model.dart';
import 'package:todo_firebase/services/firebase_data.dart';
import 'package:todo_firebase/states/change_bool_state.dart';
import 'package:uuid/uuid.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final firebaseData = FirebaseData();
  final bloc = TodoBloc(GetIt.instance.get<FirebaseData>());
  final controller = ChangeBoolState();
  final taskNameController = TextEditingController();
  @override
  void initState() {
    super.initState();
    bloc.add(TodoRetriveEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 250,
                    child: TextField(
                      controller: taskNameController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primary,
                        hintText: 'Nome da tarefa',
                        hintStyle: TextStyle(
                          color: Theme.of(context).scaffoldBackgroundColor,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Icon(
                        Icons.add,
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                const Text(
                  'Sua Lista de Tarefas',
                  style: TextStyle(
                    fontSize: 18,
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
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: index.isEven
                                    ? [
                                        const Color(0xffc1a67c),
                                        const Color(0xff0f0e0e)
                                      ]
                                    : [
                                        const Color(0xff0f0e0e),
                                        const Color(0xffc1a67c)
                                      ],
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ValueListenableBuilder(
                                  valueListenable: controller,
                                  builder: (context, myValue, child) {
                                    return Checkbox(
                                      value: item.isDone,
                                      onChanged: (value) {
                                        controller.change();
                                        bloc.add(
                                          TodoChangeBoolEvent(
                                            todo: item,
                                            value: item.isDone = myValue,
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                                SizedBox(
                                  width: 200,
                                  child: Center(child: Text(item.todo)),
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
          ],
        ),
      ),
    );
  }
}
