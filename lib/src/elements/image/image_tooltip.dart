import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/toolbar/element_toolbar.dart';
import 'package:rubric/src/shared/shared.dart';

class ImageTooltipWidget extends StatelessWidget {
  final ElementModel element;
  const ImageTooltipWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RubricIconButton(
          size: ElementToolbarWidget.elementToolbarHeight,
          onTap: () async {},
          iconData: Icons.color_lens,
        ),
      ],
    );
  }
}
