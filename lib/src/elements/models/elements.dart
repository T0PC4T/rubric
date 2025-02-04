import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/elements/elements.dart';
import 'package:rubric/src/elements/text/text_elements.dart';
import 'package:rubric/src/elements/text/text_model.dart';

part 'elements.freezed.dart';
part 'elements.g.dart';

@unfreezed
class CanvasModel with _$CanvasModel {
  CanvasModel._();
  factory CanvasModel({
    // required Color backgroundColor,
    @Default([]) List<ElementModel> elements,
  }) = _CanvasModel;

  // ? Element are editable, they edit until a fixed point then the entire object is copied
  scaleElement(ElementModel element, Offset offset) {
    element.width = offset.dx;
    element.height = offset.dy;
  }

  moveElement(ElementModel element, Offset offset) {
    element.x = offset.dx;
    element.y = offset.dy;
  }

  updateElement(ElementModel element, Map<String, dynamic> properties) {
    element.properties = properties;
  }

  reorderElements(int oldIndex, int newIndex) {
    // ? I switched this around because the list is reverse beware.
    if (oldIndex > newIndex) {
      newIndex += 1;
    }
    final ElementModel item = elements.removeAt(oldIndex);
    elements.insert(newIndex, item);
  }

  deleteElement(ElementModel element) {
    elements.remove(element);
  }

  factory CanvasModel.fromJson(Map<String, dynamic> json) =>
      _$CanvasModelFromJson(json);
}

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
}

@unfreezed
class ElementModel with _$ElementModel {
  ElementModel._();
  factory ElementModel({
    required String id,
    required ElementTypes type,
    required double x,
    required double y,
    required double width,
    required double height,
    required Map<String, dynamic> properties,
  }) = _ElementModel;

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

  factory ElementModel.fromJson(Map<String, dynamic> json) =>
      _$ElementModelFromJson(json);
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
