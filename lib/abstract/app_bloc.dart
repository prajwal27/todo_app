import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';

abstract class AppEvent<E extends AppEvent<E, S, B>, S extends AppState,
    B extends AppBloc<E, S>> {
  bool get handleError => false;

  bool canHandleError(Object error) => false;

  void onError(Object error, StackTrace stackTrace) {}

  Stream<S> reduce(B bloc);
}

abstract class AppState {}

abstract class AppBloc<E extends AppEvent<E, S, AppBloc<E, S>>,
    S extends AppState> extends Bloc<E, S> {
  AppBloc(S initialState) : super(initialState);

  @override
  @protected
  Stream<S> mapEventToState(E event) async* {
    if (event is AppEvent) {
      Stream<S> reducer = event.reduce(this);
      if (event.handleError) {
        reducer = reducer.handleError(
          event.onError,
          test: event.canHandleError,
        );
      }
      yield* reducer;
    } else {
      assert(false, '$event is not a $AppEvent');
    }
  }
}
