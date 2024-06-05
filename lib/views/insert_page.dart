import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_firebase/bloc/todo_bloc.dart';
import 'package:todo_firebase/components/my_snackbar.dart';
import 'package:todo_firebase/models/todo_model.dart';
import 'package:todo_firebase/services/firebase_data.dart';
import 'package:uuid/uuid.dart';

class InsertPage extends StatelessWidget {
  InsertPage(
      {required this.pageController,
      required this.taskNameControllerGlobal,
      super.key});

  final TextEditingController taskNameControllerGlobal;

  final taskDescriptionController = TextEditingController();
  final bloc = TodoBloc(GetIt.instance.get<FirebaseData>());
  final PageController pageController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 10,
      ),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Align(
                alignment: Alignment.center,
                child: Text(
                  'Adicione uma nova tarefa',
                  style: TextStyle(
                    fontSize: 22,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              const Text(
                'Insira o nome da tarefa',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onTapOutside: (event) =>
                    FocusScope.of(context).requestFocus(FocusNode()),
                validator: (value) {
                  if (value != null) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                controller: taskNameControllerGlobal,
                decoration: InputDecoration(
                  hintText: 'Tarefa',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Descrição da Tarefa',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                onTapOutside: (event) =>
                    FocusScope.of(context).requestFocus(FocusNode()),
                validator: (value) {
                  if (value != null) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },
                keyboardType: TextInputType.text,
                controller: taskDescriptionController,
                decoration: InputDecoration(
                  hintText: 'Descrição',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5),
              Align(
                alignment: Alignment.bottomRight,
                child: FilledButton(
                  onPressed: () {
                    if (taskNameControllerGlobal.text.isNotEmpty &&
                        taskDescriptionController.text.isNotEmpty) {
                      bloc.add(
                        TodoInsertEvent(
                          todo: Todo(
                            isDone: false,
                            todo: taskNameControllerGlobal.text,
                            description: taskDescriptionController.text,
                            uuid: const Uuid().v1(),
                          ),
                        ),
                      );
                      taskNameControllerGlobal.clear();
                      taskDescriptionController.clear();
                      pageController.jumpToPage(0);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        MySnackbar.mySnackBar(text: 'Os campos são obrigatórios!'),
                      );
                    }
                  },
                  child: const Text(
                    'Adicionar',
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
