import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef AppWidgetBuilder<T> = Widget Function(BuildContext context, T model);

typedef AppWidgetBuilderCondition<T> = bool Function(T previous, T current);

// abstract connector that glues the view with any state management solution
// (BLoC, Provide, Mobx etx)
abstract class AppConnector<A, S> extends StatelessWidget {
  const AppConnector({
    Key key,
    @required this.builder,
    this.condition,
  })  : assert(builder != null),
        super(key: key);

  final AppWidgetBuilder<S> builder;
  final AppWidgetBuilderCondition<S> condition;

  Bloc<A, S> getBloc(BuildContext context);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Bloc<A, S>, S>(
      cubit: getBloc(context),
      builder: builder,
      buildWhen: condition,
    );
  }
}
