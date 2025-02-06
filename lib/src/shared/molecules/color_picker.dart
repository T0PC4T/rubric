import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/shared/shared.dart';

class RubricColorPicker extends StatefulWidget {
  final Function(Color) onComplete;
  final Color color;
  const RubricColorPicker({
    super.key,
    required this.onComplete,
    required this.color,
  });

  @override
  State<RubricColorPicker> createState() => RubricColorPickerState();
}

class RubricColorPickerState extends State<RubricColorPicker> {
  late Color color;
  @override
  void initState() {
    color = widget.color;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);

    return SizedBox(
      width: 680,
      height: 320,
      child: Column(
        children: [
          ColorPicker(
            pickerColor: style.theme,
            onColorChanged: (value) {
              color = value;
            },
          ),
          RubricButton(
            child: RubricText("Complete"),
            onTap: () {
              widget.onComplete(color);
            },
          ),
        ],
      ),
    );
  }
}
