import 'package:flutter/material.dart';
import 'package:todoapp/bloc/todos_connector.dart';

class TodosFilterClear extends StatelessWidget {
  String _getFilterName(TodoStatus filter) {
    return filter.toString().split('.').last.replaceAll('_', ' ');
  }

  @override
  Widget build(BuildContext context) {
    return TodosConnector(
      builder: (BuildContext c, TodoViewModel model) {
        return PopupMenuButton<TodoStatus>(
          onSelected: (TodoStatus filter) => model.clearFilter(filter),
          itemBuilder: (BuildContext context) {
            return TodoStatus.values.map<PopupMenuItem<TodoStatus>>(
              (TodoStatus status) {
                return PopupMenuItem<TodoStatus>(
                  value: status,
                  child: Text(
                    _getFilterName(status),
                  ),
                );
              },
            ).toList();
          },
          child: const Padding(
            padding:  EdgeInsets.all(8.0),
            child: Icon(Icons.clear_all),
          ),
        );
      },
    );
  }
}
