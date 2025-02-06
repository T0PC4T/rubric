// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:rubric/src/elements/box/box_elements.dart';
import 'package:rubric/src/elements/text/text_elements.dart';
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
  static ElementTypes fromName(String map) {
    return switch (map) {
      'box' => ElementTypes.box,
      'text' => ElementTypes.text,
      _ => throw Exception('Unknown element type: $map'),
    };
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
