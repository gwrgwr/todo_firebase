import 'package:get_it/get_it.dart';
import 'package:todo_firebase/bloc/todo_bloc.dart';
import 'package:todo_firebase/services/firebase_data.dart';

void setup() {
  final getIt = GetIt.instance;
  getIt.registerSingleton<FirebaseData>(FirebaseData());
  getIt.registerSingleton<TodoBloc>(TodoBloc(getIt.get<FirebaseData>()));
}