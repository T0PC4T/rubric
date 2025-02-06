import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/toolbar/element_toolbar.dart';
import 'package:rubric/src/shared/shared.dart';

class BoxTooltipWidget extends StatelessWidget {
  final ElementModel element;
  const BoxTooltipWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RubricIconButton(
          size: ElementToolbarWidget.elementToolbarHeight,
          onTap: () {
            final properties = element
                .getProperties<BoxElementModel>()
                .copyWith(
                  color: Color.fromARGB(255, element.x.toInt(), 41, 26),
                );
            editorState.canvas.updateElement(element, properties.toJson());
          },
          iconData: Icons.color_lens,
        ),
      ],
    );
  }
}
