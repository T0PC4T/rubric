// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'elements.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CanvasModel _$CanvasModelFromJson(Map<String, dynamic> json) {
  return _CanvasModel.fromJson(json);
}

/// @nodoc
mixin _$CanvasModel {
  // required Color backgroundColor,
  List<ElementModel> get elements =>
      throw _privateConstructorUsedError; // required Color backgroundColor,
  set elements(List<ElementModel> value) => throw _privateConstructorUsedError;

  /// Serializes this CanvasModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CanvasModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CanvasModelCopyWith<CanvasModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CanvasModelCopyWith<$Res> {
  factory $CanvasModelCopyWith(
    CanvasModel value,
    $Res Function(CanvasModel) then,
  ) = _$CanvasModelCopyWithImpl<$Res, CanvasModel>;
  @useResult
  $Res call({List<ElementModel> elements});
}

/// @nodoc
class _$CanvasModelCopyWithImpl<$Res, $Val extends CanvasModel>
    implements $CanvasModelCopyWith<$Res> {
  _$CanvasModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CanvasModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? elements = null}) {
    return _then(
      _value.copyWith(
            elements:
                null == elements
                    ? _value.elements
                    : elements // ignore: cast_nullable_to_non_nullable
                        as List<ElementModel>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CanvasModelImplCopyWith<$Res>
    implements $CanvasModelCopyWith<$Res> {
  factory _$$CanvasModelImplCopyWith(
    _$CanvasModelImpl value,
    $Res Function(_$CanvasModelImpl) then,
  ) = __$$CanvasModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ElementModel> elements});
}

/// @nodoc
class __$$CanvasModelImplCopyWithImpl<$Res>
    extends _$CanvasModelCopyWithImpl<$Res, _$CanvasModelImpl>
    implements _$$CanvasModelImplCopyWith<$Res> {
  __$$CanvasModelImplCopyWithImpl(
    _$CanvasModelImpl _value,
    $Res Function(_$CanvasModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CanvasModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? elements = null}) {
    return _then(
      _$CanvasModelImpl(
        elements:
            null == elements
                ? _value.elements
                : elements // ignore: cast_nullable_to_non_nullable
                    as List<ElementModel>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CanvasModelImpl extends _CanvasModel {
  _$CanvasModelImpl({this.elements = const []}) : super._();

  factory _$CanvasModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CanvasModelImplFromJson(json);

  // required Color backgroundColor,
  @override
  @JsonKey()
  List<ElementModel> elements;

  @override
  String toString() {
    return 'CanvasModel(elements: $elements)';
  }

  /// Create a copy of CanvasModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CanvasModelImplCopyWith<_$CanvasModelImpl> get copyWith =>
      __$$CanvasModelImplCopyWithImpl<_$CanvasModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CanvasModelImplToJson(this);
  }
}

abstract class _CanvasModel extends CanvasModel {
  factory _CanvasModel({List<ElementModel> elements}) = _$CanvasModelImpl;
  _CanvasModel._() : super._();

  factory _CanvasModel.fromJson(Map<String, dynamic> json) =
      _$CanvasModelImpl.fromJson;

  // required Color backgroundColor,
  @override
  List<ElementModel> get elements; // required Color backgroundColor,
  set elements(List<ElementModel> value);

  /// Create a copy of CanvasModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CanvasModelImplCopyWith<_$CanvasModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ElementModel _$ElementModelFromJson(Map<String, dynamic> json) {
  return _ElementModel.fromJson(json);
}

/// @nodoc
mixin _$ElementModel {
  String get id => throw _privateConstructorUsedError;
  set id(String value) => throw _privateConstructorUsedError;
  ElementTypes get type => throw _privateConstructorUsedError;
  set type(ElementTypes value) => throw _privateConstructorUsedError;
  double get x => throw _privateConstructorUsedError;
  set x(double value) => throw _privateConstructorUsedError;
  double get y => throw _privateConstructorUsedError;
  set y(double value) => throw _privateConstructorUsedError;
  double get width => throw _privateConstructorUsedError;
  set width(double value) => throw _privateConstructorUsedError;
  double get height => throw _privateConstructorUsedError;
  set height(double value) => throw _privateConstructorUsedError;
  Map<String, dynamic> get properties => throw _privateConstructorUsedError;
  set properties(Map<String, dynamic> value) =>
      throw _privateConstructorUsedError;

  /// Serializes this ElementModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ElementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ElementModelCopyWith<ElementModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ElementModelCopyWith<$Res> {
  factory $ElementModelCopyWith(
    ElementModel value,
    $Res Function(ElementModel) then,
  ) = _$ElementModelCopyWithImpl<$Res, ElementModel>;
  @useResult
  $Res call({
    String id,
    ElementTypes type,
    double x,
    double y,
    double width,
    double height,
    Map<String, dynamic> properties,
  });
}

/// @nodoc
class _$ElementModelCopyWithImpl<$Res, $Val extends ElementModel>
    implements $ElementModelCopyWith<$Res> {
  _$ElementModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ElementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
    Object? properties = null,
  }) {
    return _then(
      _value.copyWith(
            id:
                null == id
                    ? _value.id
                    : id // ignore: cast_nullable_to_non_nullable
                        as String,
            type:
                null == type
                    ? _value.type
                    : type // ignore: cast_nullable_to_non_nullable
                        as ElementTypes,
            x:
                null == x
                    ? _value.x
                    : x // ignore: cast_nullable_to_non_nullable
                        as double,
            y:
                null == y
                    ? _value.y
                    : y // ignore: cast_nullable_to_non_nullable
                        as double,
            width:
                null == width
                    ? _value.width
                    : width // ignore: cast_nullable_to_non_nullable
                        as double,
            height:
                null == height
                    ? _value.height
                    : height // ignore: cast_nullable_to_non_nullable
                        as double,
            properties:
                null == properties
                    ? _value.properties
                    : properties // ignore: cast_nullable_to_non_nullable
                        as Map<String, dynamic>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ElementModelImplCopyWith<$Res>
    implements $ElementModelCopyWith<$Res> {
  factory _$$ElementModelImplCopyWith(
    _$ElementModelImpl value,
    $Res Function(_$ElementModelImpl) then,
  ) = __$$ElementModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    ElementTypes type,
    double x,
    double y,
    double width,
    double height,
    Map<String, dynamic> properties,
  });
}

/// @nodoc
class __$$ElementModelImplCopyWithImpl<$Res>
    extends _$ElementModelCopyWithImpl<$Res, _$ElementModelImpl>
    implements _$$ElementModelImplCopyWith<$Res> {
  __$$ElementModelImplCopyWithImpl(
    _$ElementModelImpl _value,
    $Res Function(_$ElementModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ElementModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? x = null,
    Object? y = null,
    Object? width = null,
    Object? height = null,
    Object? properties = null,
  }) {
    return _then(
      _$ElementModelImpl(
        id:
            null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                    as String,
        type:
            null == type
                ? _value.type
                : type // ignore: cast_nullable_to_non_nullable
                    as ElementTypes,
        x:
            null == x
                ? _value.x
                : x // ignore: cast_nullable_to_non_nullable
                    as double,
        y:
            null == y
                ? _value.y
                : y // ignore: cast_nullable_to_non_nullable
                    as double,
        width:
            null == width
                ? _value.width
                : width // ignore: cast_nullable_to_non_nullable
                    as double,
        height:
            null == height
                ? _value.height
                : height // ignore: cast_nullable_to_non_nullable
                    as double,
        properties:
            null == properties
                ? _value.properties
                : properties // ignore: cast_nullable_to_non_nullable
                    as Map<String, dynamic>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ElementModelImpl extends _ElementModel {
  _$ElementModelImpl({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.properties,
  }) : super._();

  factory _$ElementModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ElementModelImplFromJson(json);

  @override
  String id;
  @override
  ElementTypes type;
  @override
  double x;
  @override
  double y;
  @override
  double width;
  @override
  double height;
  @override
  Map<String, dynamic> properties;

  @override
  String toString() {
    return 'ElementModel(id: $id, type: $type, x: $x, y: $y, width: $width, height: $height, properties: $properties)';
  }

  /// Create a copy of ElementModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ElementModelImplCopyWith<_$ElementModelImpl> get copyWith =>
      __$$ElementModelImplCopyWithImpl<_$ElementModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ElementModelImplToJson(this);
  }
}

abstract class _ElementModel extends ElementModel {
  factory _ElementModel({
    required String id,
    required ElementTypes type,
    required double x,
    required double y,
    required double width,
    required double height,
    required Map<String, dynamic> properties,
  }) = _$ElementModelImpl;
  _ElementModel._() : super._();

  factory _ElementModel.fromJson(Map<String, dynamic> json) =
      _$ElementModelImpl.fromJson;

  @override
  String get id;
  set id(String value);
  @override
  ElementTypes get type;
  set type(ElementTypes value);
  @override
  double get x;
  set x(double value);
  @override
  double get y;
  set y(double value);
  @override
  double get width;
  set width(double value);
  @override
  double get height;
  set height(double value);
  @override
  Map<String, dynamic> get properties;
  set properties(Map<String, dynamic> value);

  /// Create a copy of ElementModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ElementModelImplCopyWith<_$ElementModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
