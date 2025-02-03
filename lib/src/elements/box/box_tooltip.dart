import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/elements/models/elements.dart';
import 'package:rubric/src/rubric_editor/tab_bar/element_toolbar.dart';
import 'package:rubric/src/shared/molecules/icon_button.dart';

class BoxTooltipWidget extends StatelessWidget {
  final ElementModel element;
  const BoxTooltipWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);

    return Row(
      children: [
        RubricIconButton(
          size: ElementToolbarWidget.elementToolbarHeight,
          onTap: () {
            final properties = element
                .getProperties<BoxElementModel>()
                .copyWith(color: Colors.red);
            editorState.canvas.updateElement(element, properties.toJson());
            editorState.saveStep();
          },
          iconData: Icons.color_lens,
        ),
      ],
    );
  }
}
