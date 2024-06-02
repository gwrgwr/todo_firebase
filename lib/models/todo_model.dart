// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Todo {
  final String uuid;
  final String todo;
  final String description;
  Todo({
    required this.uuid,
    required this.todo,
    required this.description,
  });

  Todo copyWith({
    String? uuid,
    String? todo,
    String? description,
  }) {
    return Todo(
      uuid: uuid ?? this.uuid,
      todo: todo ?? this.todo,
      description: description ?? this.description,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uuid': uuid,
      'todo': todo,
      'description': description,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    return Todo(
      uuid: map['uuid'] as String,
      todo: map['todo'] as String,
      description: map['description'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Todo(uuid: $uuid, todo: $todo, description: $description)';

  @override
  bool operator ==(covariant Todo other) {
    if (identical(this, other)) return true;
  
    return 
      other.uuid == uuid &&
      other.todo == todo &&
      other.description == description;
  }

  @override
  int get hashCode => uuid.hashCode ^ todo.hashCode ^ description.hashCode;
}
