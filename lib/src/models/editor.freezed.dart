// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'editor.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

CanvasEditingModel _$CanvasEditingModelFromJson(Map<String, dynamic> json) {
  return _CanvasEditingModel.fromJson(json);
}

/// @nodoc
mixin _$CanvasEditingModel {
  // required Color backgroundColor,
  ElementModel? get selected => throw _privateConstructorUsedError;
  GridSizes get gridSize => throw _privateConstructorUsedError;
  bool get showGrid => throw _privateConstructorUsedError;

  /// Serializes this CanvasEditingModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CanvasEditingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CanvasEditingModelCopyWith<CanvasEditingModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CanvasEditingModelCopyWith<$Res> {
  factory $CanvasEditingModelCopyWith(
    CanvasEditingModel value,
    $Res Function(CanvasEditingModel) then,
  ) = _$CanvasEditingModelCopyWithImpl<$Res, CanvasEditingModel>;
  @useResult
  $Res call({ElementModel? selected, GridSizes gridSize, bool showGrid});

  $ElementModelCopyWith<$Res>? get selected;
}

/// @nodoc
class _$CanvasEditingModelCopyWithImpl<$Res, $Val extends CanvasEditingModel>
    implements $CanvasEditingModelCopyWith<$Res> {
  _$CanvasEditingModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CanvasEditingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selected = freezed,
    Object? gridSize = null,
    Object? showGrid = null,
  }) {
    return _then(
      _value.copyWith(
            selected:
                freezed == selected
                    ? _value.selected
                    : selected // ignore: cast_nullable_to_non_nullable
                        as ElementModel?,
            gridSize:
                null == gridSize
                    ? _value.gridSize
                    : gridSize // ignore: cast_nullable_to_non_nullable
                        as GridSizes,
            showGrid:
                null == showGrid
                    ? _value.showGrid
                    : showGrid // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }

  /// Create a copy of CanvasEditingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $ElementModelCopyWith<$Res>? get selected {
    if (_value.selected == null) {
      return null;
    }

    return $ElementModelCopyWith<$Res>(_value.selected!, (value) {
      return _then(_value.copyWith(selected: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$CanvasEditingModelImplCopyWith<$Res>
    implements $CanvasEditingModelCopyWith<$Res> {
  factory _$$CanvasEditingModelImplCopyWith(
    _$CanvasEditingModelImpl value,
    $Res Function(_$CanvasEditingModelImpl) then,
  ) = __$$CanvasEditingModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ElementModel? selected, GridSizes gridSize, bool showGrid});

  @override
  $ElementModelCopyWith<$Res>? get selected;
}

/// @nodoc
class __$$CanvasEditingModelImplCopyWithImpl<$Res>
    extends _$CanvasEditingModelCopyWithImpl<$Res, _$CanvasEditingModelImpl>
    implements _$$CanvasEditingModelImplCopyWith<$Res> {
  __$$CanvasEditingModelImplCopyWithImpl(
    _$CanvasEditingModelImpl _value,
    $Res Function(_$CanvasEditingModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of CanvasEditingModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selected = freezed,
    Object? gridSize = null,
    Object? showGrid = null,
  }) {
    return _then(
      _$CanvasEditingModelImpl(
        selected:
            freezed == selected
                ? _value.selected
                : selected // ignore: cast_nullable_to_non_nullable
                    as ElementModel?,
        gridSize:
            null == gridSize
                ? _value.gridSize
                : gridSize // ignore: cast_nullable_to_non_nullable
                    as GridSizes,
        showGrid:
            null == showGrid
                ? _value.showGrid
                : showGrid // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CanvasEditingModelImpl implements _CanvasEditingModel {
  const _$CanvasEditingModelImpl({
    this.selected,
    this.gridSize = GridSizes.medium,
    this.showGrid = true,
  });

  factory _$CanvasEditingModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$CanvasEditingModelImplFromJson(json);

  // required Color backgroundColor,
  @override
  final ElementModel? selected;
  @override
  @JsonKey()
  final GridSizes gridSize;
  @override
  @JsonKey()
  final bool showGrid;

  @override
  String toString() {
    return 'CanvasEditingModel(selected: $selected, gridSize: $gridSize, showGrid: $showGrid)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CanvasEditingModelImpl &&
            (identical(other.selected, selected) ||
                other.selected == selected) &&
            (identical(other.gridSize, gridSize) ||
                other.gridSize == gridSize) &&
            (identical(other.showGrid, showGrid) ||
                other.showGrid == showGrid));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, selected, gridSize, showGrid);

  /// Create a copy of CanvasEditingModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CanvasEditingModelImplCopyWith<_$CanvasEditingModelImpl> get copyWith =>
      __$$CanvasEditingModelImplCopyWithImpl<_$CanvasEditingModelImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$CanvasEditingModelImplToJson(this);
  }
}

abstract class _CanvasEditingModel implements CanvasEditingModel {
  const factory _CanvasEditingModel({
    final ElementModel? selected,
    final GridSizes gridSize,
    final bool showGrid,
  }) = _$CanvasEditingModelImpl;

  factory _CanvasEditingModel.fromJson(Map<String, dynamic> json) =
      _$CanvasEditingModelImpl.fromJson;

  // required Color backgroundColor,
  @override
  ElementModel? get selected;
  @override
  GridSizes get gridSize;
  @override
  bool get showGrid;

  /// Create a copy of CanvasEditingModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CanvasEditingModelImplCopyWith<_$CanvasEditingModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
