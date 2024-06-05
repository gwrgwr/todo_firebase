import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_firebase/bloc/todo_bloc.dart';
import 'package:todo_firebase/services/firebase_data.dart';
import 'package:todo_firebase/states/change_bool_state.dart';

class HomePage extends StatefulWidget {
  HomePage(
      {required this.pageController,
      required this.taskNameControllerGlobal,
      super.key});

  final PageController pageController;
  final TextEditingController taskNameControllerGlobal;
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
                    width: 290,
                    child: TextField(
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                      cursorColor: Theme.of(context).colorScheme.tertiary,
                      controller: widget.taskNameControllerGlobal,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.primary,
                        hintText: 'Nome da tarefa',
                        hintStyle: TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      widget.pageController.jumpToPage(1);
                    },
                    icon: Container(
                      padding: const EdgeInsets.all(16),
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
                  'Sua Lista',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 20),
                BlocBuilder<TodoBloc, TodoState>(
                  bloc: bloc,
                  builder: (context, state) {
                    if (state is TodoSuccessState) {
                      if (state.listTodo.isEmpty) {
                        return const Center(
                          child: Text(
                            'Adicione tarefas na lista',
                            style: TextStyle(
                              fontSize: 18,
                            ),
                          ),
                        );
                      } else {
                        return ListView.separated(
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 10),
                          shrinkWrap: true,
                          itemCount: state.listTodo.length,
                          itemBuilder: (context, index) {
                            final item = state.listTodo[index];
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: index.isEven
                                      ? [
                                          Theme.of(context).colorScheme.primary,
                                          Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                        ]
                                      : [
                                          Theme.of(context)
                                              .colorScheme
                                              .tertiary,
                                          Theme.of(context).colorScheme.primary,
                                        ],
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  ValueListenableBuilder(
                                    valueListenable: controller,
                                    builder: (context, myValue, child) {
                                      return Checkbox(
                                        activeColor:
                                            Theme.of(context).canvasColor,
                                        checkColor: index.isEven
                                            ? Theme.of(context)
                                                .colorScheme
                                                .primary
                                            : Theme.of(context)
                                                .colorScheme
                                                .tertiary,
                                        side: BorderSide(
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
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
                                    child: Center(
                                      child: Text(
                                        item.todo,
                                        style: TextStyle(
                                          fontFamily: 'Roboto Mono',
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      bloc.add(TodoRemoveEvent(todo: item));
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Theme.of(context)
                                          .scaffoldBackgroundColor,
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        );
                      }
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
