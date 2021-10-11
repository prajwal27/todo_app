import 'package:flutter/material.dart';
import 'package:todoapp/bloc/todos_connector.dart';

class AddTodoTile extends StatefulWidget {
  @override
  _AddTodoTileState createState() => _AddTodoTileState();
}

class _AddTodoTileState extends State<AddTodoTile> {
  final TextEditingController _controller = TextEditingController();

  String _error;

  bool _saving = false;

  @override
  void dispose() {
    super.dispose();
    _controller?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TodosConnector(
      condition: (TodoViewModel o, TodoViewModel n) {
        // reacts to state changes
        if (_saving && !n.isLoading) {
          _controller.clear();
        }

        if (n.isLoading == false && _saving == true && mounted) {
          setState(() {
            _saving = false;
          });
        }

        // rebuilds ui only when this condition is true
        return o.isLoading != n.isLoading;
      },
      builder: (BuildContext context, TodoViewModel model) {
        return Row(
          children: <Widget>[
            Expanded(
              child: TextField(
                controller: _controller,
                decoration: InputDecoration(
                  errorText: _error,
                  hintText: 'Title',
                  border: const OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                icon: const Icon(Icons.add),
                onPressed: model.isLoading
                    ? null
                    : () {
                        if (_controller.text.isEmpty) {
                          setState(() {
                            _error = 'Please enter a title';
                          });
                          return;
                        }
                        _saving = true;
                        FocusScope.of(context).requestFocus(FocusNode());
                        model.addNewTodo(_controller.text);
                      },
              ),
            ),
          ],
        );
      },
    );
  }
}
