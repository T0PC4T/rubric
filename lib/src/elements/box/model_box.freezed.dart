// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'model_box.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BoxElementModel _$BoxElementModelFromJson(Map<String, dynamic> json) {
  return _BoxElementModel.fromJson(json);
}

/// @nodoc
mixin _$BoxElementModel {
  @JsonKey(toJson: _colorToJson, fromJson: _colorFromJson)
  Color get color => throw _privateConstructorUsedError;

  /// Serializes this BoxElementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BoxElementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BoxElementModelCopyWith<BoxElementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BoxElementModelCopyWith<$Res> {
  factory $BoxElementModelCopyWith(
    BoxElementModel value,
    $Res Function(BoxElementModel) then,
  ) = _$BoxElementModelCopyWithImpl<$Res, BoxElementModel>;
  @useResult
  $Res call({
    @JsonKey(toJson: _colorToJson, fromJson: _colorFromJson) Color color,
  });
}

/// @nodoc
class _$BoxElementModelCopyWithImpl<$Res, $Val extends BoxElementModel>
    implements $BoxElementModelCopyWith<$Res> {
  _$BoxElementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BoxElementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? color = null}) {
    return _then(
      _value.copyWith(
            color:
                null == color
                    ? _value.color
                    : color // ignore: cast_nullable_to_non_nullable
                        as Color,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BoxElementModelImplCopyWith<$Res>
    implements $BoxElementModelCopyWith<$Res> {
  factory _$$BoxElementModelImplCopyWith(
    _$BoxElementModelImpl value,
    $Res Function(_$BoxElementModelImpl) then,
  ) = __$$BoxElementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    @JsonKey(toJson: _colorToJson, fromJson: _colorFromJson) Color color,
  });
}

/// @nodoc
class __$$BoxElementModelImplCopyWithImpl<$Res>
    extends _$BoxElementModelCopyWithImpl<$Res, _$BoxElementModelImpl>
    implements _$$BoxElementModelImplCopyWith<$Res> {
  __$$BoxElementModelImplCopyWithImpl(
    _$BoxElementModelImpl _value,
    $Res Function(_$BoxElementModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BoxElementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? color = null}) {
    return _then(
      _$BoxElementModelImpl(
        color:
            null == color
                ? _value.color
                : color // ignore: cast_nullable_to_non_nullable
                    as Color,
      ),
    );
  }
}

/// @nodoc

@JsonSerializable()
class _$BoxElementModelImpl implements _BoxElementModel {
  const _$BoxElementModelImpl({
    @JsonKey(toJson: _colorToJson, fromJson: _colorFromJson)
    required this.color,
  });

  factory _$BoxElementModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$BoxElementModelImplFromJson(json);

  @override
  @JsonKey(toJson: _colorToJson, fromJson: _colorFromJson)
  final Color color;

  @override
  String toString() {
    return 'BoxElementModel(color: $color)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BoxElementModelImpl &&
            (identical(other.color, color) || other.color == color));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, color);

  /// Create a copy of BoxElementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BoxElementModelImplCopyWith<_$BoxElementModelImpl> get copyWith =>
      __$$BoxElementModelImplCopyWithImpl<_$BoxElementModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BoxElementModelImplToJson(this);
  }
}

abstract class _BoxElementModel implements BoxElementModel {
  const factory _BoxElementModel({
    @JsonKey(toJson: _colorToJson, fromJson: _colorFromJson)
    required final Color color,
  }) = _$BoxElementModelImpl;

  factory _BoxElementModel.fromJson(Map<String, dynamic> json) =
      _$BoxElementModelImpl.fromJson;

  @override
  @JsonKey(toJson: _colorToJson, fromJson: _colorFromJson)
  Color get color;

  /// Create a copy of BoxElementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BoxElementModelImplCopyWith<_$BoxElementModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
