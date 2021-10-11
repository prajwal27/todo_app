import 'package:built_collection/built_collection.dart';
import 'package:built_collection/src/list.dart';
import 'package:todoapp/data/todo_service.dart';
import 'package:todoapp/models/todo.dart';

class MockTodoService implements TodoService {
  static int _length = 10;

  @override
  Future<Todo> addTodo(Todo todo) async {
    _length++;
    return todo.rebuild(
      (TodoBuilder t) => t
        ..completed = false
        ..id = _length,
    );
  }

  @override
  Future<bool> deleteToDo(Todo todo) async {
    return true;
  }

  @override
  Future<BuiltList<Todo>> getAllTodos() async {
    return BuiltList<Todo>.from(
      List<Todo>.generate(
        _length,
        (int index) => Todo(
          (TodoBuilder b) {
            b
              ..isLoading = false
              ..id = index
              ..title = 'Title $index'
              ..completed = false;
          },
        ),
      ),
    );
  }

  @override
  Future<Todo> updateTodo(Todo todo) async {
    return todo;
  }

  @override
  String get url => '';
}
