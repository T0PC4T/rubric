// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'canvas.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CanvasSettingsImpl _$$CanvasSettingsImplFromJson(Map<String, dynamic> json) =>
    _$CanvasSettingsImpl(
      name: json['name'] as String,
      backgroundColor: colorFromJson((json['backgroundColor'] as num).toInt()),
      canvasColor: colorFromJson((json['canvasColor'] as num).toInt()),
    );

Map<String, dynamic> _$$CanvasSettingsImplToJson(
  _$CanvasSettingsImpl instance,
) => <String, dynamic>{
  'name': instance.name,
  'backgroundColor': colorToJson(instance.backgroundColor),
  'canvasColor': colorToJson(instance.canvasColor),
};
