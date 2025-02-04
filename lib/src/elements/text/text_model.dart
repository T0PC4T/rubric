import 'dart:convert';

import 'package:fleather/fleather.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'text_model.freezed.dart';
part 'text_model.g.dart';

@freezed
class TextElementModel with _$TextElementModel {
  @JsonSerializable()
  const factory TextElementModel({
    @JsonKey(toJson: _documentToString, fromJson: _documentFromString)
    required ParchmentDocument document,
  }) = _TextElementModel;

  factory TextElementModel.fromJson(Map<String, dynamic> json) =>
      _$TextElementModelFromJson(json);
}

String _documentToString(ParchmentDocument document) {
  return jsonEncode(document.toJson());
}

ParchmentDocument _documentFromString(String value) {
  if (value.isEmpty) {
    return ParchmentDocument();
  }
  try {
    return ParchmentDocument.fromJson(jsonDecode(value));
  } catch (e) {
    return ParchmentDocument();
  }
}
