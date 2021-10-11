import 'package:built_collection/built_collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:todoapp/abstract/app_bloc.dart';
import 'package:todoapp/bloc/todos_connector.dart';
import 'package:todoapp/data/api_service.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/models/todo_state.dart';
import 'package:todoapp/utils/app_logger.dart';

// Action handled by TodoBloc
abstract class TodoAction extends AppEvent<TodoAction, TodoState, TodoBloc> {}

// Todos BLoC
class TodoBloc extends AppBloc<TodoAction, TodoState> {
  TodoBloc({
    @required ApiService service,
    TodoState initialState,
  })  : assert(service != null),
        _service = service,
        super(initialState ?? TodoState.initState());
  final ApiService _service;

  // ignore: unused_field
  final AppLogger _log = AppLogger(tag: '$TodoBloc');

  @override
  TodoState get state =>
      super.state.rebuild((TodoStateBuilder b) => b.dispatch = add);

  @override
  void onTransition(Transition<TodoAction, TodoState> transition) {
    super.onTransition(transition);
    // log every state transition if necessary
    // _log.d(transition.nextState);
  }

  @override
  Stream<Transition<TodoAction, TodoState>> transformEvents(
    Stream<TodoAction> events,
    TransitionFunction<TodoAction, TodoState> transitionFn,
  ) {
    final List<Type> _async = <Type>[
      ClearAllTodo,
      FilterTodo,
      UpdateTodo,
      DeleteTodo
    ];
    final Stream<TodoAction> async = events
        .where((TodoAction event) => _async.contains(event.runtimeType))
        .flatMap((TodoAction value) => Stream<TodoAction>.value(value));
    final Stream<TodoAction> sync =
        events.where((TodoAction event) => !_async.contains(event.runtimeType));
    return super.transformEvents(
        MergeStream<TodoAction>(<Stream<TodoAction>>[sync, async]),
        transitionFn);
  }

  TodoState _updateTodo(TodoState state, Todo todo) {
    return state.rebuild((TodoStateBuilder b) {
      final int index = state.allTodos.indexWhere(
        (Todo t) => t.id == todo.id,
      );
      if (index >= 0) {
        final ListBuilder<Todo> todos = b.allTodos;
        todos[index] = todo;
        b.allTodos = todos;
      }
    });
  }
}

class AddTodo extends TodoAction {
  AddTodo(this.content);

  final String content;

  @override
  Stream<TodoState> reduce(TodoBloc bloc) async* {
    TodoState state = bloc.state;
    final ApiService _service = bloc._service;
    state = state.rebuild((TodoStateBuilder b) => b.isLoading = true);
    yield state;
    final Todo todo = await _service.addTodo(Todo.create(title: content));
    state = state.rebuild((TodoStateBuilder b) {
      b.allTodos.add(todo.rebuild((TodoBuilder b) {
        return b.isLoading = false;
      }));
    });
    state = state.rebuild((TodoStateBuilder b) => b.isLoading = false);
    yield state;
  }
}

class UpdateTodo extends TodoAction {
  UpdateTodo(this.todo);

  final Todo todo;

  @override
  Stream<TodoState> reduce(TodoBloc bloc) async* {
    TodoState state = bloc.state;
    Todo todo = this.todo.rebuild((TodoBuilder t) => t.isLoading = true);
    state = state.rebuild((TodoStateBuilder b) => b.isLoading = true);
    yield bloc._updateTodo(state, todo);
    todo = await bloc._service.updateTodo(this.todo);
    todo = todo.rebuild((TodoBuilder t) => t.isLoading = false);
    yield bloc._updateTodo(state, todo);
  }
}

class DeleteTodo extends TodoAction {
  DeleteTodo(this.todo);

  final Todo todo;

  @override
  Stream<TodoState> reduce(TodoBloc bloc) async* {
    TodoState state = bloc.state;
    final Todo todo = this.todo.rebuild((TodoBuilder t) => t.isLoading = true);
    state = state.rebuild((TodoStateBuilder b) => b.isLoading = true);
    state = bloc._updateTodo(state, todo);
    yield state;
    // ignore: unused_local_variable
    final bool success = await bloc._service.deleteToDo(todo);
    state = state.rebuild((TodoStateBuilder b) {
      b.allTodos.removeWhere((Todo t) => t.id == todo.id);
    });
    yield state;
    state = state.rebuild((TodoStateBuilder b) => b.isLoading = false);
    yield state;
  }
}

class GetTodos extends TodoAction {
  @override
  Stream<TodoState> reduce(TodoBloc bloc) async* {
    TodoState state = bloc.state;
    final ApiService _service = bloc._service;
    state = state.rebuild((TodoStateBuilder b) => b.isLoading = true);
    yield state;
    final BuiltList<Todo> todos = await _service.getAllTodos();
    yield state.rebuild(
      (TodoStateBuilder b) => b
        ..allTodos.addAll(todos.map((Todo t) {
          return t.rebuild((TodoBuilder b) => b.isLoading = false);
        }).toList())
        ..isLoading = false,
    );
  }
}

class FilterTodo extends TodoAction {
  FilterTodo(this.filter) : assert(filter != null);

  final TodoStatus filter;

  @override
  Stream<TodoState> reduce(TodoBloc bloc) async* {
    TodoState state = bloc.state;
    state = state.rebuild((TodoStateBuilder b) => b.isLoading = true);
    yield state;
    state = state.rebuild((TodoStateBuilder b) => b.filter = filter);
    yield state.rebuild((TodoStateBuilder b) => b.isLoading = false);
  }
}

class ClearAllTodo extends TodoAction {
  ClearAllTodo(this.filter);

  final TodoStatus filter;

  @override
  Stream<TodoState> reduce(TodoBloc bloc) async* {
    TodoState state = bloc.state;
    state = state.rebuild((TodoStateBuilder b) => b.isLoading = true);
    yield state;
    yield state.rebuild((TodoStateBuilder b) {
      b.allTodos.removeWhere((Todo t) {
        if (filter == TodoStatus.All) {
          return true;
        }
        return filter == TodoStatus.Completed ? t.completed : t.isNotCompleted;
      });
      b.isLoading = false;
    });
  }
}
