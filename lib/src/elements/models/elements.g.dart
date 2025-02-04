// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'elements.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CanvasModelImpl _$$CanvasModelImplFromJson(Map<String, dynamic> json) =>
    _$CanvasModelImpl(
      elements:
          (json['elements'] as List<dynamic>?)
              ?.map((e) => ElementModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$CanvasModelImplToJson(_$CanvasModelImpl instance) =>
    <String, dynamic>{'elements': instance.elements};

_$ElementModelImpl _$$ElementModelImplFromJson(Map<String, dynamic> json) =>
    _$ElementModelImpl(
      id: json['id'] as String,
      type: $enumDecode(_$ElementTypesEnumMap, json['type']),
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      properties: json['properties'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$ElementModelImplToJson(_$ElementModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$ElementTypesEnumMap[instance.type]!,
      'x': instance.x,
      'y': instance.y,
      'width': instance.width,
      'height': instance.height,
      'properties': instance.properties,
    };

const _$ElementTypesEnumMap = {
  ElementTypes.box: 'box',
  ElementTypes.text: 'text',
};
