// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'task_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TaskModel _$TaskModelFromJson(Map<String, dynamic> json) {
  return _TaskModel.fromJson(json);
}

/// @nodoc
mixin _$TaskModel {
  @JsonKey(name: '_id')
  String get id => throw _privateConstructorUsedError;
  String? get previusId => throw _privateConstructorUsedError;
  String? get fatherId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get department => throw _privateConstructorUsedError;
  List<String> get assignedTo => throw _privateConstructorUsedError;
  String? get documentation => throw _privateConstructorUsedError;
  List<String> get systems => throw _privateConstructorUsedError;
  List<String> get tasks => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime? get deletedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TaskModelCopyWith<TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TaskModelCopyWith<$Res> {
  factory $TaskModelCopyWith(TaskModel value, $Res Function(TaskModel) then) =
      _$TaskModelCopyWithImpl<$Res, TaskModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String? previusId,
      String? fatherId,
      String name,
      String department,
      List<String> assignedTo,
      String? documentation,
      List<String> systems,
      List<String> tasks,
      DateTime createdAt,
      DateTime? deletedAt});
}

/// @nodoc
class _$TaskModelCopyWithImpl<$Res, $Val extends TaskModel>
    implements $TaskModelCopyWith<$Res> {
  _$TaskModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? previusId = freezed,
    Object? fatherId = freezed,
    Object? name = null,
    Object? department = null,
    Object? assignedTo = null,
    Object? documentation = freezed,
    Object? systems = null,
    Object? tasks = null,
    Object? createdAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      previusId: freezed == previusId
          ? _value.previusId
          : previusId // ignore: cast_nullable_to_non_nullable
              as String?,
      fatherId: freezed == fatherId
          ? _value.fatherId
          : fatherId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      assignedTo: null == assignedTo
          ? _value.assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      documentation: freezed == documentation
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as String?,
      systems: null == systems
          ? _value.systems
          : systems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tasks: null == tasks
          ? _value.tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TaskModelCopyWith<$Res> implements $TaskModelCopyWith<$Res> {
  factory _$$_TaskModelCopyWith(
          _$_TaskModel value, $Res Function(_$_TaskModel) then) =
      __$$_TaskModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String id,
      String? previusId,
      String? fatherId,
      String name,
      String department,
      List<String> assignedTo,
      String? documentation,
      List<String> systems,
      List<String> tasks,
      DateTime createdAt,
      DateTime? deletedAt});
}

/// @nodoc
class __$$_TaskModelCopyWithImpl<$Res>
    extends _$TaskModelCopyWithImpl<$Res, _$_TaskModel>
    implements _$$_TaskModelCopyWith<$Res> {
  __$$_TaskModelCopyWithImpl(
      _$_TaskModel _value, $Res Function(_$_TaskModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? previusId = freezed,
    Object? fatherId = freezed,
    Object? name = null,
    Object? department = null,
    Object? assignedTo = null,
    Object? documentation = freezed,
    Object? systems = null,
    Object? tasks = null,
    Object? createdAt = null,
    Object? deletedAt = freezed,
  }) {
    return _then(_$_TaskModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      previusId: freezed == previusId
          ? _value.previusId
          : previusId // ignore: cast_nullable_to_non_nullable
              as String?,
      fatherId: freezed == fatherId
          ? _value.fatherId
          : fatherId // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      department: null == department
          ? _value.department
          : department // ignore: cast_nullable_to_non_nullable
              as String,
      assignedTo: null == assignedTo
          ? _value._assignedTo
          : assignedTo // ignore: cast_nullable_to_non_nullable
              as List<String>,
      documentation: freezed == documentation
          ? _value.documentation
          : documentation // ignore: cast_nullable_to_non_nullable
              as String?,
      systems: null == systems
          ? _value._systems
          : systems // ignore: cast_nullable_to_non_nullable
              as List<String>,
      tasks: null == tasks
          ? _value._tasks
          : tasks // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deletedAt: freezed == deletedAt
          ? _value.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TaskModel implements _TaskModel {
  _$_TaskModel(
      {@JsonKey(name: '_id') required this.id,
      this.previusId,
      this.fatherId,
      required this.name,
      required this.department,
      required final List<String> assignedTo,
      this.documentation,
      required final List<String> systems,
      required final List<String> tasks,
      required this.createdAt,
      this.deletedAt})
      : _assignedTo = assignedTo,
        _systems = systems,
        _tasks = tasks;

  factory _$_TaskModel.fromJson(Map<String, dynamic> json) =>
      _$$_TaskModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String id;
  @override
  final String? previusId;
  @override
  final String? fatherId;
  @override
  final String name;
  @override
  final String department;
  final List<String> _assignedTo;
  @override
  List<String> get assignedTo {
    if (_assignedTo is EqualUnmodifiableListView) return _assignedTo;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_assignedTo);
  }

  @override
  final String? documentation;
  final List<String> _systems;
  @override
  List<String> get systems {
    if (_systems is EqualUnmodifiableListView) return _systems;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_systems);
  }

  final List<String> _tasks;
  @override
  List<String> get tasks {
    if (_tasks is EqualUnmodifiableListView) return _tasks;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tasks);
  }

  @override
  final DateTime createdAt;
  @override
  final DateTime? deletedAt;

  @override
  String toString() {
    return 'TaskModel(id: $id, previusId: $previusId, fatherId: $fatherId, name: $name, department: $department, assignedTo: $assignedTo, documentation: $documentation, systems: $systems, tasks: $tasks, createdAt: $createdAt, deletedAt: $deletedAt)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TaskModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.previusId, previusId) ||
                other.previusId == previusId) &&
            (identical(other.fatherId, fatherId) ||
                other.fatherId == fatherId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.department, department) ||
                other.department == department) &&
            const DeepCollectionEquality()
                .equals(other._assignedTo, _assignedTo) &&
            (identical(other.documentation, documentation) ||
                other.documentation == documentation) &&
            const DeepCollectionEquality().equals(other._systems, _systems) &&
            const DeepCollectionEquality().equals(other._tasks, _tasks) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      previusId,
      fatherId,
      name,
      department,
      const DeepCollectionEquality().hash(_assignedTo),
      documentation,
      const DeepCollectionEquality().hash(_systems),
      const DeepCollectionEquality().hash(_tasks),
      createdAt,
      deletedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TaskModelCopyWith<_$_TaskModel> get copyWith =>
      __$$_TaskModelCopyWithImpl<_$_TaskModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TaskModelToJson(
      this,
    );
  }
}

abstract class _TaskModel implements TaskModel {
  factory _TaskModel(
      {@JsonKey(name: '_id') required final String id,
      final String? previusId,
      final String? fatherId,
      required final String name,
      required final String department,
      required final List<String> assignedTo,
      final String? documentation,
      required final List<String> systems,
      required final List<String> tasks,
      required final DateTime createdAt,
      final DateTime? deletedAt}) = _$_TaskModel;

  factory _TaskModel.fromJson(Map<String, dynamic> json) =
      _$_TaskModel.fromJson;

  @override
  @JsonKey(name: '_id')
  String get id;
  @override
  String? get previusId;
  @override
  String? get fatherId;
  @override
  String get name;
  @override
  String get department;
  @override
  List<String> get assignedTo;
  @override
  String? get documentation;
  @override
  List<String> get systems;
  @override
  List<String> get tasks;
  @override
  DateTime get createdAt;
  @override
  DateTime? get deletedAt;
  @override
  @JsonKey(ignore: true)
  _$$_TaskModelCopyWith<_$_TaskModel> get copyWith =>
      throw _privateConstructorUsedError;
}
