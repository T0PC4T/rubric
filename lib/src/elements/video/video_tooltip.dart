import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/components/shared.dart';
import 'package:rubric/src/elements/video/video_model.dart';
import 'package:rubric/src/models/elements.dart';

class VideoTooltipWidget extends StatelessWidget {
  final ElementModel element;
  const VideoTooltipWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);
    final properties = element.getProperties<VideoElementModel>();
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        RubricIconTextButton(
          onTap: () async {
            FilePickerResult? result = await FilePicker.platform.pickFiles(
              allowMultiple: false,
              type: FileType.video,
            );
            if (result case FilePickerResult result) {
              Uint8List? fileBytes = result.files.first.bytes;
              if (fileBytes != null) {
                final videoUrl = await editorState.widget.bytesToURL(
                  fileBytes,
                  name: result.files.first.name,
                );
                editorState.canvas.updateElement(
                  element,
                  properties.copyWith(videoUrl: videoUrl).toJson(),
                );
              }
            }
          },
          iconData: Icons.image,
          text: "Change Video",
        ),
      ],
    );
  }
}
