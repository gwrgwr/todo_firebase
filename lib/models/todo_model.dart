// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todo {
  final String uuid;
  final String todo;
  final String description;
  final bool isDone;
  Todo({
    required this.uuid,
    required this.todo,
    required this.description,
    required this.isDone,
  });

  Todo copyWith({
    String? uuid,
    String? todo,
    String? description,
    bool? isDone,
  }) {
    return Todo(
      uuid: uuid ?? this.uuid,
      todo: todo ?? this.todo,
      description: description ?? this.description,
      isDone: isDone ?? this.isDone,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'todo': todo,
      'description': description,
      'isDone': isDone,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      uuid: map['uuid'] as String,
      todo: map['todo'] as String,
      description: map['description'] as String,
      isDone: map['isDone'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Todo(uuid: $uuid, todo: $todo, description: $description, isDone: $isDone)';
  }

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.todo == todo &&
      other.description == description &&
      other.isDone == isDone;
  }

  @override
  int get hashCode {
    return uuid.hashCode ^
      todo.hashCode ^
      description.hashCode ^
      isDone.hashCode;
  }
}
