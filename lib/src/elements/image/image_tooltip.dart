import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/components/organisms/border_radius_dropdown.dart';
import 'package:rubric/src/components/shared.dart';
import 'package:rubric/src/elements/image/image_model.dart';
import 'package:rubric/src/models/elements.dart';

class ImageTooltipWidget extends StatelessWidget {
  final ElementModel element;
  const ImageTooltipWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);
    final properties = element.getProperties<ImageElementModel>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RubricIconTextButton(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles();
            if (result case FilePickerResult result) {
              Uint8List? fileBytes = result.files.first.bytes;
              if (fileBytes != null) {
                final imageUrl = await editorState.widget.getImageURL(
                  fileBytes,
                );
                editorState.canvas.updateElement(
                  element,
                  properties.copyWith(imageUrl: imageUrl).toJson(),
                );
              }
            }
          },
          iconData: Icons.image,
          text: "Upload Image",
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
