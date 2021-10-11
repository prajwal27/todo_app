// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_state.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TodoState> _$todoStateSerializer = new _$TodoStateSerializer();

class _$TodoStateSerializer implements StructuredSerializer<TodoState> {
  @override
  final Iterable<Type> types = const [TodoState, _$TodoState];
  @override
  final String wireName = 'TodoState';

  @override
  Iterable<Object> serialize(Serializers serializers, TodoState object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[
      'allTodos',
      serializers.serialize(object.allTodos,
          specifiedType:
              const FullType(BuiltList, const [const FullType(Todo)])),
      'isLoading',
      serializers.serialize(object.isLoading,
          specifiedType: const FullType(bool)),
      'filter',
      serializers.serialize(object.filter,
          specifiedType: const FullType(TodoStatus)),
    ];

    return result;
  }

  @override
  TodoState deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TodoStateBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final dynamic value = iterator.current;
      switch (key) {
        case 'allTodos':
          result.allTodos.replace(serializers.deserialize(value,
                  specifiedType:
                      const FullType(BuiltList, const [const FullType(Todo)]))
              as BuiltList<Object>);
          break;
        case 'isLoading':
          result.isLoading = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'filter':
          result.filter = serializers.deserialize(value,
              specifiedType: const FullType(TodoStatus)) as TodoStatus;
          break;
      }
    }

    return result.build();
  }
}

class _$TodoState extends TodoState {
  @override
  final ValueChanged<TodoAction> dispatch;
  @override
  final BuiltList<Todo> allTodos;
  @override
  final bool isLoading;
  @override
  final TodoStatus filter;

  factory _$TodoState([void Function(TodoStateBuilder) updates]) =>
      (new TodoStateBuilder()..update(updates)).build();

  _$TodoState._({this.dispatch, this.allTodos, this.isLoading, this.filter})
      : super._() {
    if (allTodos == null) {
      throw new BuiltValueNullFieldError('TodoState', 'allTodos');
    }
    if (isLoading == null) {
      throw new BuiltValueNullFieldError('TodoState', 'isLoading');
    }
    if (filter == null) {
      throw new BuiltValueNullFieldError('TodoState', 'filter');
    }
  }

  @override
  TodoState rebuild(void Function(TodoStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TodoStateBuilder toBuilder() => new TodoStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    final dynamic _$dynamicOther = other;
    return other is TodoState &&
        dispatch == _$dynamicOther.dispatch &&
        allTodos == other.allTodos &&
        isLoading == other.isLoading &&
        filter == other.filter;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc(0, dispatch.hashCode), allTodos.hashCode),
            isLoading.hashCode),
        filter.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TodoState')
          ..add('dispatch', dispatch)
          ..add('allTodos', allTodos)
          ..add('isLoading', isLoading)
          ..add('filter', filter))
        .toString();
  }
}

class TodoStateBuilder implements Builder<TodoState, TodoStateBuilder> {
  _$TodoState _$v;

  ValueChanged<TodoAction> _dispatch;
  ValueChanged<TodoAction> get dispatch => _$this._dispatch;
  set dispatch(ValueChanged<TodoAction> dispatch) =>
      _$this._dispatch = dispatch;

  ListBuilder<Todo> _allTodos;
  ListBuilder<Todo> get allTodos =>
      _$this._allTodos ??= new ListBuilder<Todo>();
  set allTodos(ListBuilder<Todo> allTodos) => _$this._allTodos = allTodos;

  bool _isLoading;
  bool get isLoading => _$this._isLoading;
  set isLoading(bool isLoading) => _$this._isLoading = isLoading;

  TodoStatus _filter;
  TodoStatus get filter => _$this._filter;
  set filter(TodoStatus filter) => _$this._filter = filter;

  TodoStateBuilder();

  TodoStateBuilder get _$this {
    if (_$v != null) {
      _dispatch = _$v.dispatch;
      _allTodos = _$v.allTodos?.toBuilder();
      _isLoading = _$v.isLoading;
      _filter = _$v.filter;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TodoState other) {
    if (other == null) {
      throw new ArgumentError.notNull('other');
    }
    _$v = other as _$TodoState;
  }

  @override
  void update(void Function(TodoStateBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TodoState build() {
    _$TodoState _$result;
    try {
      _$result = _$v ??
          new _$TodoState._(
              dispatch: dispatch,
              allTodos: allTodos.build(),
              isLoading: isLoading,
              filter: filter);
    } catch (_) {
      String _$failedField;
      try {
        _$failedField = 'allTodos';
        allTodos.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'TodoState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
