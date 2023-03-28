// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tree_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TreeModel _$TreeModelFromJson(Map<String, dynamic> json) {
  return _TreeModel.fromJson(json);
}

/// @nodoc
mixin _$TreeModel {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  List<TreeModel> get treeList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TreeModelCopyWith<TreeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreeModelCopyWith<$Res> {
  factory $TreeModelCopyWith(TreeModel value, $Res Function(TreeModel) then) =
      _$TreeModelCopyWithImpl<$Res, TreeModel>;
  @useResult
  $Res call({String id, String name, List<TreeModel> treeList});
}

/// @nodoc
class _$TreeModelCopyWithImpl<$Res, $Val extends TreeModel>
    implements $TreeModelCopyWith<$Res> {
  _$TreeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? treeList = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      treeList: null == treeList
          ? _value.treeList
          : treeList // ignore: cast_nullable_to_non_nullable
              as List<TreeModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TreeModelCopyWith<$Res> implements $TreeModelCopyWith<$Res> {
  factory _$$_TreeModelCopyWith(
          _$_TreeModel value, $Res Function(_$_TreeModel) then) =
      __$$_TreeModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, List<TreeModel> treeList});
}

/// @nodoc
class __$$_TreeModelCopyWithImpl<$Res>
    extends _$TreeModelCopyWithImpl<$Res, _$_TreeModel>
    implements _$$_TreeModelCopyWith<$Res> {
  __$$_TreeModelCopyWithImpl(
      _$_TreeModel _value, $Res Function(_$_TreeModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? treeList = null,
  }) {
    return _then(_$_TreeModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      treeList: null == treeList
          ? _value._treeList
          : treeList // ignore: cast_nullable_to_non_nullable
              as List<TreeModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TreeModel implements _TreeModel {
  _$_TreeModel(
      {required this.id,
      required this.name,
      required final List<TreeModel> treeList})
      : _treeList = treeList;

  factory _$_TreeModel.fromJson(Map<String, dynamic> json) =>
      _$$_TreeModelFromJson(json);

  @override
  final String id;
  @override
  final String name;
  final List<TreeModel> _treeList;
  @override
  List<TreeModel> get treeList {
    if (_treeList is EqualUnmodifiableListView) return _treeList;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_treeList);
  }

  @override
  String toString() {
    return 'TreeModel(id: $id, name: $name, treeList: $treeList)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TreeModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            const DeepCollectionEquality().equals(other._treeList, _treeList));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, const DeepCollectionEquality().hash(_treeList));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TreeModelCopyWith<_$_TreeModel> get copyWith =>
      __$$_TreeModelCopyWithImpl<_$_TreeModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TreeModelToJson(
      this,
    );
  }
}

abstract class _TreeModel implements TreeModel {
  factory _TreeModel(
      {required final String id,
      required final String name,
      required final List<TreeModel> treeList}) = _$_TreeModel;

  factory _TreeModel.fromJson(Map<String, dynamic> json) =
      _$_TreeModel.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  List<TreeModel> get treeList;
  @override
  @JsonKey(ignore: true)
  _$$_TreeModelCopyWith<_$_TreeModel> get copyWith =>
      throw _privateConstructorUsedError;
}
