import 'package:built_collection/built_collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/abstract/app_bloc.dart';
import 'package:todoapp/abstract/app_connector.dart';
import 'package:todoapp/abstract/app_view_model.dart';
import 'package:todoapp/bloc/todos_bloc.dart';
import 'package:todoapp/data/api_service.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/models/todo_state.dart';

// abstract template the view model that would be used by views
// why abstract?
// Because this can be implemented by a basic model class in case of Bloc and
// implemented by a ChangeNotifier in case of provider
abstract class TodoViewModel implements AppViewModel, AppState {
  BuiltList<Todo> get allTodos;

  bool get isLoading;

  TodoStatus get filter;

  BuiltList<Todo> get filtered;

  void getAllTodos();

  void applyFilter(TodoStatus filter);

  void clearFilter(TodoStatus filter);

  void addNewTodo(String content);

  void updateTodo(Todo todo);

  void deleteTodo(Todo todo);

  void Function(TodoAction) get dispatch;
}

enum TodoStatus {
  Completed,
  Not_Completed,
  All,
}

// TodosConnector - Offers access view model for the views to communicate with
// its environment
class TodosConnector extends AppConnector<TodoAction, TodoState> {
  const TodosConnector({
    Key key,
    AppWidgetBuilder<TodoViewModel> builder,
    AppWidgetBuilderCondition<TodoViewModel> condition,
  }) : super(
          key: key,
          builder: builder,
          condition: condition,
        );

  @override
  Bloc<TodoAction, TodoState> getBloc(BuildContext context) {
    return BlocProvider.of<TodoBloc>(context);
  }
}

class TodosProvider extends StatelessWidget {
  const TodosProvider({Key key, this.service, this.child}) : super(key: key);
  final ApiService service;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBloc>(
      create: (BuildContext context) {
        return TodoBloc(service: service)..add(GetTodos());
      },
      child: child,
    );
  }
}
