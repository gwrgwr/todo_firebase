// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:todo_firebase/models/todo_model.dart';
import 'package:todo_firebase/services/firebase_data.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final FirebaseData firebaseData;
  TodoBloc(this.firebaseData) : super(TodoInitialState()) {


    on<TodoRetriveEvent>((event, emit) async {
      final lista = await firebaseData.getData();
      print(lista);
      emit(TodoSuccessState(listTodo: lista));
    });

    on<TodoRemoveEvent>(
      (event, emit) async {
        await firebaseData.removeData(event.todo.uuid);
        add(TodoRetriveEvent());
      },
    );

    on<TodoInsertEvent>((event, emit) async {
      firebaseData.insertData(event.todo);
      add(TodoRetriveEvent());
    },);
  }
}
