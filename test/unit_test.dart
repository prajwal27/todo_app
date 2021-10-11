import 'package:flutter_test/flutter_test.dart';
import 'package:todoapp/bloc/todos_bloc.dart';
import 'package:todoapp/data/todo_service.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/models/todo_state.dart';

import 'mock_todo_service.dart';

void main() {
  TodoService _service;
  TodoBloc _bloc;
  TodoState initState = TodoState.initState(dispatch: _bloc.add);

  setUp(() {
    _service = MockTodoService();
    _bloc = TodoBloc(
      service: _service,
      initialState: initState,
    );
  });

  tearDown(() {
    _bloc?.close();
  });

  group('Todo Tests', () {
    test(
      'Initial State',
      () async {
        expect(
          _bloc.state,
          initState,
        );
      },
    );

    test(
      'Add Todo',
      () async {
        final List<TodoState> statesExpected = <TodoState>[];
        // sets loading
        initState = initState.rebuild((TodoStateBuilder b) {
          b.isLoading = true;
        });
        statesExpected.add(initState);

        // adds a todo
        initState = initState.rebuild((TodoStateBuilder b) {
          b.allTodos.add(Todo((TodoBuilder t) {
            t
              ..completed = false
              ..title = 'Title 11'
              ..id = 11;
          }));
        });
        statesExpected.add(initState);

        // sets loading
        initState = initState.rebuild((TodoStateBuilder b) {
          b.isLoading = false;
        });
        statesExpected.add(initState);

        // expect
        expectLater(
          _bloc,
          emitsInAnyOrder(statesExpected),
        );

        // add action
        _bloc.add(AddTodo('Title 11'));
      },
    );
  });
}
