import 'package:built_collection/built_collection.dart';
import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:todoapp/models/todo.dart';
import 'package:todoapp/models/todo_state.dart';

part 'serializers.g.dart';

@SerializersFor(<Type>[
  Todo,
  TodoState,
])

// serializers used by the app
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
