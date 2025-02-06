import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/elements/elements.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:rubric/src/rubric_editor/toolbar/element_toolbar.dart';
import 'package:rubric/src/shared/atoms/popup.dart';
import 'package:rubric/src/shared/molecules/color_picker.dart';
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
          onTap: () async {
            var properties = element.getProperties<BoxElementModel>();
            final newColor = await PopupWidget.showPopup<Color>(context, (
              closeWith,
            ) {
              return RubricColorPicker(
                onComplete: closeWith,
                color: properties.color,
              );
            });
            if (newColor != null) {
              editorState.canvas.updateElement(
                element,
                properties.copyWith(color: newColor).toJson(),
              );
            }
          },
          iconData: Icons.color_lens,
        ),
        RubricDropdown<double>(
          value: element.getProperties<BoxElementModel>().borderRadius,
          items: [
            for (var value in BorderRadiusPresets.values)
              DropdownMenuItem(value: value.radius, child: Text(value.name)),
          ],
          onChanged: (value) {
            if (value case double newValue) {
              final properties = element
                  .getProperties<BoxElementModel>()
                  .copyWith(borderRadius: newValue);
              editorState.canvas.updateElement(element, properties.toJson());
            }
          },
        ),
      ],
    );
  }
}
