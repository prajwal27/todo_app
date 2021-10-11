// defines an abstract service used by the app
import 'package:todoapp/models/todo.dart';
import 'package:built_collection/built_collection.dart';

abstract class ApiService {
  // creates a new todo
  Future<Todo> addTodo(Todo todo);

  // updates a todo
  Future<Todo> updateTodo(Todo todo);

  // deletes a todo
  Future<bool> deleteToDo(Todo todo);

  // fetches all todos
  Future<BuiltList<Todo>> getAllTodos();
}
