import 'package:flutter/material.dart';
import 'package:rubric/src/elements/models/elements.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';

class ElementToolbarWidget extends StatelessWidget {
  final ElementModel element;
  static const double elementToolbarHeight = 30;
  const ElementToolbarWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);

    return Container(
      margin: EdgeInsets.all(style.paddingUnit * 2),
      padding: EdgeInsets.all(style.paddingUnit * 0.5),
      height: elementToolbarHeight + style.paddingUnit,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: style.borderRadius,
        boxShadow: [
          BoxShadow(
            color: style.dark.withAlpha(50),
            blurRadius: style.elevation,
            offset: Offset(0, style.elevation), // changes position of shadow
          ),
        ],
      ),
      child: element.type.toolbarBuilder(element: element),
    );
  }
}
