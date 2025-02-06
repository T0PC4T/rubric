// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:rubric/src/elements/box/box_elements.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/elements/image/image_elements.dart';
import 'package:rubric/src/elements/image/image_model.dart';
import 'package:rubric/src/elements/text/text_elements.dart';
import 'package:rubric/src/elements/text/text_model.dart';
import 'package:rubric/src/models/elements.dart';

typedef ElementBuilderFunction =
    Widget Function({Key? key, required ElementModel element});

enum ElementTypes {
  box(
    "Box",
    Icons.check_box_outline_blank_rounded,
    editorBuilder: BoxEditorElement.new,
    layerBuilder: BoxEditorElement.new,
    readerBuilder: BoxEditorElement.new,
    focusable: false,
  ),
  text(
    "Text",
    Icons.text_snippet_outlined,
    editorBuilder: TextEditorElement.new,
    layerBuilder: TextLayerWidget.new,
    readerBuilder: TextEditorElement.new,
    focusable: true,
  ),

  image(
    "Image",
    Icons.image,
    editorBuilder: ImageEditorElement.new,
    layerBuilder: ImageLayerWidget.new,
    readerBuilder: ImageEditorElement.new,
    focusable: true,
  );

  final String title;
  final IconData icon;
  final ElementBuilderFunction editorBuilder;
  final ElementBuilderFunction layerBuilder;
  final ElementBuilderFunction readerBuilder;
  final bool focusable;
  const ElementTypes(
    this.title,
    this.icon, {
    required this.editorBuilder,
    required this.readerBuilder,
    required this.layerBuilder,
    required this.focusable,
  });

  // from name function
  static ElementTypes fromName(String name) {
    for (var el in ElementTypes.values) {
      if (el.name == name) {
        return el;
      }
    }
    throw Exception('Unknown element type: $name');
  }
}

enum BorderRadiusPresets {
  none(0),
  small(15),
  medium(30),
  large(45);

  final double radius;
  const BorderRadiusPresets(this.radius);
}

Map<String, dynamic> generateDefaultProperties(
  BuildContext context,
  ElementTypes elementType,
) {
  return switch (elementType) {
    ElementTypes.box =>
      BoxElementModel(color: Colors.green, borderRadius: 0).toJson(),
    ElementTypes.text =>
      TextElementModel(
        document: Document()..insert(0, "[Insert your text here]"),
      ).toJson(),
    ElementTypes.image =>
      ImageElementModel(
        borderRadius: 0,
        imageUrl:
            "https://mtek3d.com/wp-content/uploads/2018/01/image-placeholder-500x500.jpg",
      ).toJson(),
    _ => throw "Not implemented properties for this type",
  };
}
