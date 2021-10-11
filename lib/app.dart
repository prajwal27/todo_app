import 'package:flutter/material.dart';
import 'package:todoapp/bloc/todos_connector.dart';
import 'package:todoapp/data/api_service.dart';
import 'package:todoapp/data/todo_service.dart';
import 'package:todoapp/environment/environment.dart';
import 'package:todoapp/intl/app_strings.dart';
import 'package:todoapp/views/todos/todo_page.dart';

void run(Environment environment) {
  final ApiService _service = TodoService(
    '${environment.scheme}://${environment.host}',
  );

  runApp(TodosApp(service: _service));
}

class TodosApp extends StatefulWidget {
  const TodosApp({Key key, this.service}) : super(key: key);

  final ApiService service;

  @override
  _TodosAppState createState() => _TodosAppState();
}

class _TodosAppState extends State<TodosApp> {
  @override
  Widget build(BuildContext context) {
    return TodosProvider(
      service: widget.service,
      child: MaterialApp(
        title: 'Todo Demo',
        locale: AppStrings.english,
        localizationsDelegates: AppStrings.delegates,
        supportedLocales: AppStrings.supportedLocales,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TodoPage(),
      ),
    );
  }
}
