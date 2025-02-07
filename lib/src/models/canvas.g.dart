// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CanvasSettingsImpl _$$CanvasSettingsImplFromJson(Map<String, dynamic> json) =>
    _$CanvasSettingsImpl(
      backgroundColor: colorFromJson((json['backgroundColor'] as num).toInt()),
      name: json['name'] as String,
    );

Map<String, dynamic> _$$CanvasSettingsImplToJson(
  _$CanvasSettingsImpl instance,
) => <String, dynamic>{
  'backgroundColor': colorToJson(instance.backgroundColor),
  'name': instance.name,
};
