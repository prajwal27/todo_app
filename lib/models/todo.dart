import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:todoapp/abstract/app_bloc.dart';
import 'package:todoapp/models/serializers.dart';
import 'package:meta/meta.dart';

part 'todo.g.dart';

// Defines a Todo model
abstract class Todo implements Built<Todo, TodoBuilder>, AppState {
  factory Todo([void Function(TodoBuilder) updates]) = _$Todo;

  Todo._();

  // used to create a new todo
  static Todo create({@required String title}) {
    assert(title != null);
    return Todo((TodoBuilder b) {
      b
        ..title = title
        ..completed = false;
    });
  }

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(
      Todo.serializer,
      this,
    ) as Map<String, dynamic>;
  }

  static Todo fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(Todo.serializer, json);
  }

  static Serializer<Todo> get serializer => _$todoSerializer;

  // model fields
  @nullable
  int get id;

  String get title;

  bool get completed;

  // helper methods
  @nullable
  @BuiltValueField(serialize: false)
  bool get isLoading;

  bool get isCompleted => completed;

  bool get isNotCompleted => !completed;
}
