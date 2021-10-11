import 'dart:convert';

import 'package:built_collection/built_collection.dart';
import 'package:http/http.dart' as http;
import 'package:todoapp/data/api_service.dart';
import 'package:todoapp/models/todo.dart';

// Todos Service responsible for CRUD operations
class TodoService extends ApiService {
  TodoService(this.url);

  final String url;
  final Map<String, String> _headers = <String,String>{
    'Content-type': 'application/json; charset=UTF-8'
  };

  // creates a new todo
  @override
  Future<Todo> addTodo(Todo todo) async {
    final http.Response response = await http.post(
      '$url/users/1/todos',
      body: jsonEncode(todo.toJson()),
      headers: _headers,
    );
    final String jsonBody = response.body;
    final Map<String, dynamic> parsed =
        jsonDecode(jsonBody) as Map<String, dynamic>;
    return Todo.fromJson(parsed);
  }

  // updates a todo
  @override
  Future<Todo> updateTodo(Todo todo) async {
    final String body = jsonEncode(todo.toJson());
    final http.Response response = await http.put(
      '$url/users/1/todos/${todo.id}',
      body: body,
      headers: _headers,
    );
    // ignore error
    if (response.statusCode > 300) {
      return todo;
    }
    final String jsonBody = response.body;
    final Map<String, dynamic> parsed =
        jsonDecode(jsonBody) as Map<String, dynamic>;
    return Todo.fromJson(parsed);
  }

  // deletes a todo
  @override
  Future<bool> deleteToDo(Todo todo) async {
    final http.Response response = await http.delete(
      '$url/users/1/todos/${todo.id}',
      headers: _headers,
    );
    // ignore error
    if (response.statusCode > 300) {
      return true;
    }
    return response.statusCode >= 200 && response.statusCode < 300;
  }

  // fetches all todos
  @override
  Future<BuiltList<Todo>> getAllTodos() async {
    final http.Response response = await http.get(
      '$url/users/1/todos',
      headers: _headers,
    );
    final String jsonBody = response.body;
    final List<dynamic> parsed = jsonDecode(jsonBody) as List<dynamic>;
    return BuiltList<Todo>(
      parsed.map((dynamic e) {
        return Todo.fromJson(e as Map<String, dynamic>);
      }).toList(),
    );
  }
}
