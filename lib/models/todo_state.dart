import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/bloc/todos_bloc.dart';
import 'package:todoapp/bloc/todos_connector.dart';
import 'package:todoapp/models/serializers.dart';
import 'package:todoapp/models/todo.dart';

part 'todo_state.g.dart';

typedef ValueChanged<T> = Function(T);

// Todos application state
// Responsible to maintaine the state of todos
abstract class TodoState
    implements Built<TodoState, TodoStateBuilder>, TodoViewModel {
  factory TodoState([void Function(TodoStateBuilder) updates]) = _$TodoState;

  TodoState._();

  static TodoState initState({ValueChanged<TodoAction> dispatch}) => TodoState(
        (TodoStateBuilder b) => b
          ..allTodos = ListBuilder<Todo>()
          ..isLoading = true
          ..filter = TodoStatus.All
          ..dispatch = dispatch,
      );

  @override
  @BuiltValueField(serialize: false)
  @protected
  @nullable
  ValueChanged<TodoAction> get dispatch;

  Map<String, dynamic> toJson() {
    return serializers.serializeWith(
      TodoState.serializer,
      this,
    ) as Map<String, dynamic>;
  }

  static TodoState fromJson(Map<String, dynamic> json) {
    return serializers.deserializeWith(TodoState.serializer, json);
  }

  static Serializer<TodoState> get serializer => _$todoStateSerializer;

  @override
  BuiltList<Todo> get filtered => filter == TodoStatus.All
      ? allTodos
      : filter == TodoStatus.Completed ? completed : notCompleted;

  BuiltList<Todo> get completed =>
      allTodos.where((Todo todo) => todo.isCompleted).toBuiltList();

  BuiltList<Todo> get notCompleted =>
      allTodos.where((Todo todo) => todo.isNotCompleted).toBuiltList();

  @override
  void applyFilter(TodoStatus filter) => dispatch(FilterTodo(filter));

  @override
  void clearFilter(TodoStatus filter) => dispatch(ClearAllTodo(filter));

  @override
  void addNewTodo(String content) => dispatch(AddTodo(content));

  @override
  void deleteTodo(Todo todo) => dispatch(DeleteTodo(todo));

  @override
  void updateTodo(Todo todo) => dispatch(UpdateTodo(todo));

  @override
  void getAllTodos() => dispatch(GetTodos());
}
