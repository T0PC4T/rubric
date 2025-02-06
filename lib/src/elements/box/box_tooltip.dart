import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/components/atoms/popup.dart';
import 'package:rubric/src/components/molecules/color_picker.dart';
import 'package:rubric/src/components/organisms/border_radius_dropdown.dart';
import 'package:rubric/src/components/shared.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/models/elements.dart';

class BoxTooltipWidget extends StatelessWidget {
  final ElementModel element;
  const BoxTooltipWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);
    final properties = element.getProperties<BoxElementModel>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RubricIconTextButton(
          onTap: () async {
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
          text: "Colour",
        ),
        RubricBorderRadiusDropdown(
          radius: properties.borderRadius,
          onChanged: (value) {
            if (value case double newValue) {
              final newProperties = properties.copyWith(borderRadius: newValue);
              editorState.canvas.updateElement(element, newProperties.toJson());
            }
          },
        ),
      ],
    );
  }
}
