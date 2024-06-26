part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class TodoInsertEvent extends TodoEvent {
  final Todo todo;

  TodoInsertEvent({required this.todo});
}
class TodoRemoveEvent extends TodoEvent {
  final Todo todo;

  TodoRemoveEvent({required this.todo});
}
class TodoRetriveEvent extends TodoEvent {}

class TodoChangeBoolEvent extends TodoEvent {
  final Todo todo;
  bool value;

  TodoChangeBoolEvent({required this.todo, required this.value});

}