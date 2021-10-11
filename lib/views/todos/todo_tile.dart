import 'package:flutter/material.dart';
import 'package:todoapp/bloc/todos_connector.dart';
import 'package:todoapp/models/todo.dart';

class TodoTile extends StatefulWidget {
  const TodoTile({
    Key key,
    this.todo,
  }) : super(key: key);

  final Todo todo;

  @override
  _TodoTileState createState() => _TodoTileState();
}

class _TodoTileState extends State<TodoTile> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  bool _isEditing = false;

  Todo get todo => widget.todo;

  @override
  void didUpdateWidget(TodoTile oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.todo != widget.todo) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return TodosConnector(
      condition: (TodoViewModel o, TodoViewModel n) {
        // rebuilds when todos list in state changes
        if (_isEditing && !todo.isLoading) {
          _isEditing = false;
          if (mounted) {
            setState(() {});
          }
        }
        return true;
      },
      builder: (_, TodoViewModel model) {
        return Form(
          key: _form,
          child: ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                  child: _isEditing
                      ? TextFormField(
                          initialValue: todo.title,
                          validator: (String s) =>
                              s.isEmpty ? 'Cannot be empty' : null,
                          onSaved: (String s) {
                            model.updateTodo(
                                todo.rebuild((TodoBuilder b) => b.title = s));
                          },
                        )
                      : Text(todo.title),
                ),
                if (todo.isLoading == true) const CircularProgressIndicator(),
                IconButton(
                  icon: Icon(_isEditing ? Icons.save : Icons.edit),
                  onPressed: () {
                    if (todo.isLoading) {
                      return;
                    }
                    if (_isEditing) {
                      if (_form.currentState.validate()) {
                        _form.currentState.save();
                      }
                    } else {
                      setState(() {
                        _isEditing = true;
                      });
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () {
                    if (todo.isLoading) {
                      return;
                    }
                    model.deleteTodo(todo);
                  },
                ),
              ],
            ),
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (_) {
                if (todo.isLoading) {
                  return;
                }
                // mark complete only if not completed
                final Todo t =
                    todo.rebuild((TodoBuilder t) => t.completed = !t.completed);
                model.updateTodo(t);
              },
            ),
          ),
        );
      },
    );
  }
}
