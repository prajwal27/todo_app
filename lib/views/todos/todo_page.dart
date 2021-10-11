import 'package:flutter/material.dart';
import 'package:todoapp/bloc/todos_connector.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/views/todos/add_todo_tile.dart';
import 'package:todoapp/views/todos/todo_tile.dart';
import 'package:todoapp/views/todos/todos_clear_button.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({
    Key key,
  }) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todos'),
        actions: <Widget>[
          TodosFilterClear(),
        ],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: AddTodoTile(),
          ),
          Expanded(
            child: TodosConnector(
              condition: (TodoViewModel o, TodoViewModel n) => true,
              builder: (BuildContext context, TodoViewModel model) {
                if (model.filtered.isEmpty) {
                  return Center(
                    child: model.isLoading
                        ? const CircularProgressIndicator()
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              const Text('Nothing to show'),
                              if (model.allTodos.isEmpty)
                                FlatButton(
                                  color: Theme.of(context).primaryColor,
                                  textColor: Colors.white,
                                  child: const Text('Refresh'),
                                  onPressed: () => model.getAllTodos(),
                                )
                            ],
                          ),
                  );
                }
                return ListView.builder(
                  itemCount: model.filtered.length,
                  itemBuilder: (BuildContext context, int i) {
                    final Todo t = model.filtered[i];
                    return TodoTile(key: ValueKey<int>(t.id), todo: t);
                  },
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: TodosConnector(
        condition: (TodoViewModel o, TodoViewModel n) => o.filter != n.filter,
        builder: (_, TodoViewModel model) => Container(
          color: Theme.of(context).accentColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: TodoStatus.values.reversed
                .map(
                  (TodoStatus e) => FlatButton(
                    textColor: e == model.filter ? Colors.white : Colors.black,
                    child:
                        Text(e.toString().split('.').last.replaceAll('_', ' ')),
                    onPressed: () => model.applyFilter(e),
                  ),
                )
                .toList(),
          ),
        ),
      ),
    );
  }
}
