import 'package:flutter/material.dart';
import 'package:rubric/src/elements/models/elements.dart';
import 'package:rubric/src/rubric_editor/models/editor.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/rubric_editor/viewer/items/position.dart';

class ElementToolBarWidget extends StatelessWidget {
  final ElementModel element;
  static const double elementToolBarHeight = 25;
  const ElementToolBarWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);

    return RubricPositioned(
      key: ValueKey("toolbar"),
      height: ElementToolBarWidget.elementToolBarHeight,
      width: GridSizes.pageSize,
      x: element.x,
      y: element.y - style.paddingUnit,
      child: Container(color: style.light),
    );
  }
}
