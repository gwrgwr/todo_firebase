// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todo {
  bool isDone;
  final String todo;
  final String description;
  final String uuid;
  Todo({
    required this.isDone,
    required this.todo,
    required this.description,
    required this.uuid,
  });

  Todo copyWith({
    bool? isDone,
    String? todo,
    String? description,
    String? uuid,
  }) {
    return Todo(
      isDone: isDone ?? this.isDone,
      todo: todo ?? this.todo,
      description: description ?? this.description,
      uuid: uuid ?? this.uuid,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDone': isDone,
      'todo': todo,
      'description': description,
      'uuid': uuid,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      isDone: map['isDone'] as bool,
      todo: map['todo'] as String,
      description: map['description'] as String,
      uuid: map['uuid'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Todo(isDone: $isDone, todo: $todo, description: $description, uuid: $uuid)';
  }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;
  
    return 
      other.isDone == isDone &&
      other.todo == todo &&
      other.description == description &&
      other.uuid == uuid;
  }

  @override
  int get hashCode {
    return isDone.hashCode ^
      todo.hashCode ^
      description.hashCode ^
      uuid.hashCode;
  }
}
