// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'editor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CanvasEditingModelImpl _$$CanvasEditingModelImplFromJson(
  Map<String, dynamic> json,
) => _$CanvasEditingModelImpl(
  selected:
      json['selected'] == null
          ? null
          : ElementModel.fromJson(json['selected'] as Map<String, dynamic>),
  focused:
      json['focused'] == null
          ? null
          : ElementModel.fromJson(json['focused'] as Map<String, dynamic>),
  gridSize:
      $enumDecodeNullable(_$GridSizesEnumMap, json['gridSize']) ??
      GridSizes.medium,
  showGrid: json['showGrid'] as bool? ?? true,
);

Map<String, dynamic> _$$CanvasEditingModelImplToJson(
  _$CanvasEditingModelImpl instance,
) => <String, dynamic>{
  'selected': instance.selected,
  'focused': instance.focused,
  'gridSize': _$GridSizesEnumMap[instance.gridSize]!,
  'showGrid': instance.showGrid,
};

const _$GridSizesEnumMap = {
  GridSizes.none: 'none',
  GridSizes.small: 'small',
  GridSizes.medium: 'medium',
  GridSizes.large: 'large',
  GridSizes.extraLarge: 'extraLarge',
};
