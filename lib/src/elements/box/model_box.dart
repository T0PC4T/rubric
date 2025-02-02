import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'model_box.freezed.dart';
part 'model_box.g.dart';

@freezed
class BoxElementModel with _$BoxElementModel {
  @JsonSerializable()
  const factory BoxElementModel({
    @JsonKey(toJson: _colorToJson, fromJson: _colorFromJson)
    required Color color,
  }) = _BoxElementModel;

  factory BoxElementModel.fromJson(Map<String, dynamic> json) =>
      _$BoxElementModelFromJson(json);
}

_colorToJson(Color color) {
  return color.toARGB32();
}

Color _colorFromJson(int value) {
  return Color(value);
}
