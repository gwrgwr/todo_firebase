part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

final class TodoInitialState extends TodoState {}
final class TodoSuccessState extends TodoState {
  final List<Todo> listTodo;

  TodoSuccessState({required this.listTodo});
}
final class TodoErrorState extends TodoState {
  final String message;

  TodoErrorState({required this.message});
}
