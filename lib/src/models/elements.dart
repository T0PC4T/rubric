// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:rubric/src/elements/box/box_elements.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/elements/text/text_elements.dart';
import 'package:rubric/src/elements/text/text_model.dart';

// enum ElementTypes { text, box, image, video }
typedef ElementBuilderFunction =
    Widget Function({Key? key, required ElementModel element});

enum ElementTypes {
  box(
    "Box",
    Icons.check_box_outline_blank_rounded,
    editorBuilder: BoxEditorElement.new,
    layerBuilder: BoxEditorElement.new,
    readerBuilder: BoxEditorElement.new,
    focusBuilder: BoxEditorElement.new,
  ),
  text(
    "Text",
    Icons.text_snippet_outlined,
    editorBuilder: TextEditorElement.new,
    layerBuilder: TextLayerWidget.new,
    readerBuilder: TextEditorElement.new,
    focusBuilder: TextEditorElement.new,
  );

  final String title;
  final IconData icon;
  final ElementBuilderFunction editorBuilder;
  final ElementBuilderFunction focusBuilder;
  final ElementBuilderFunction layerBuilder;
  final ElementBuilderFunction readerBuilder;
  const ElementTypes(
    this.title,
    this.icon, {
    required this.editorBuilder,
    required this.focusBuilder,
    required this.readerBuilder,
    required this.layerBuilder,
  });

  // from name function
  static ElementTypes fromName(String map) {
    return switch (map) {
      'box' => ElementTypes.box,
      'text' => ElementTypes.text,
      _ => throw Exception('Unknown element type: $map'),
    };
  }
}

class ElementModel {
  String id;
  ElementTypes type;
  double x;
  double y;
  double width;
  double height;
  Map<String, dynamic> properties;
  ElementModel({
    required this.id,
    required this.type,
    required this.x,
    required this.y,
    required this.width,
    required this.height,
    required this.properties,
  });

  T getProperties<T>() {
    return switch (type) {
          // ElementTypes.text => TextElementModel(properties),
          ElementTypes.box => BoxElementModel.fromJson(properties),
          ElementTypes.text => TextElementModel.fromJson(properties),
          // ElementTypes.image => ImageElementModel(properties),
          // ElementTypes.video => VideoElementModel(properties),
        }
        as T;
  }

  ElementModel copyWith({
    String? id,
    ElementTypes? type,
    double? x,
    double? y,
    double? width,
    double? height,
    Map<String, dynamic>? properties,
  }) {
    return ElementModel(
      id: id ?? this.id,
      type: type ?? this.type,
      x: x ?? this.x,
      y: y ?? this.y,
      width: width ?? this.width,
      height: height ?? this.height,
      properties: Map.from(properties ?? this.properties),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'type': type.name,
      'x': x,
      'y': y,
      'width': width,
      'height': height,
      'properties': properties,
    };
  }

  factory ElementModel.fromMap(Map<String, dynamic> map) {
    return ElementModel(
      id: map['id'] as String,
      type: ElementTypes.fromName(map['type'] as String),
      x: map['x'] as double,
      y: map['y'] as double,
      width: map['width'] as double,
      height: map['height'] as double,
      properties: Map<String, dynamic>.from(
        (map['properties'] as Map<String, dynamic>),
      ),
    );
  }

  @override
  String toString() {
    return 'ElementModel(id: $id, type: $type, x: $x, y: $y, width: $width, height: $height, properties: $properties)';
  }

  @override
  bool operator ==(covariant ElementModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.type == type &&
        other.x == x &&
        other.y == y &&
        other.width == width &&
        other.height == height &&
        mapEquals(other.properties, properties);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        type.hashCode ^
        x.hashCode ^
        y.hashCode ^
        width.hashCode ^
        height.hashCode ^
        properties.hashCode;
  }
}

final example = {
  "canvas": {"width": 1080, "height": 1920, "background_color": "#FFFFFF"},
  "elements": [
    {
      "id": "element_1",
      "type": "text",
      "x": 50,
      "y": 100,
      "width": 200,
      "height": 100,
      "z_index": 2,
      "properties": {
        "text": "Hello World!",
        "font_size": 24,
        "font_family": "Roboto",
        "color": "#000000",
        "font_weight": "bold",
        "text_align": "center",
        "rotation": 0,
      },
    },
    {
      "id": "element_2",
      "type": "container",
      "x": 150,
      "y": 300,
      "width": 300,
      "height": 200,
      "z_index": 1,
      "properties": {
        "background_color": "#FF0000",
        "border_radius": 10,
        "border_width": 2,
        "border_color": "#0000FF",
        "rotation": 0,
        "padding": [10, 10, 10, 10],
      },
    },
    {
      "id": "element_3",
      "type": "image",
      "x": 200,
      "y": 50,
      "width": 150,
      "height": 150,
      "z_index": 3,
      "properties": {
        "src": "https://example.com/image.jpg",
        "fit": "cover",
        "rotation": 45,
        "border_radius": 0,
      },
    },
    {
      "id": "element_4",
      "type": "video",
      "x": 400,
      "y": 400,
      "width": 320,
      "height": 180,
      "z_index": 2,
      "properties": {
        "src": "https://example.com/video.mp4",
        "autoplay": false,
        "loop": true,
        "controls": true,
        "muted": false,
        "rotation": 0,
      },
    },
  ],
};
