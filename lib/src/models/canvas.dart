// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:rubric/src/models/elements.dart';

class CanvasModel {
  List<ElementModel> elements;
  CanvasModel({this.elements = const []});

  CanvasModel copyWith({List<ElementModel>? elements}) {
    return CanvasModel(
      elements:
          (elements ?? this.elements)
              .map<ElementModel>((e) => e.copyWith())
              .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'elements': elements.map((x) => x.toMap()).toList(),
    };
  }

  factory CanvasModel.fromMap(Map<String, dynamic> map) {
    return CanvasModel(
      elements: List<ElementModel>.from(
        (map['elements'] as List<int>).map<ElementModel>(
          (x) => ElementModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  @override
  String toString() => 'CanvasModel(elements: $elements)';

  @override
  bool operator ==(covariant CanvasModel other) {
    if (identical(this, other)) return true;

    return listEquals(other.elements, elements);
  }

  @override
  int get hashCode => elements.hashCode;
}
