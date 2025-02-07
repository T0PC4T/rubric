import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:rubric/src/components/shared.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';

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
      width: 650,
      height: 340,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          ColorPicker(
            pickerColor: color,
            onColorChanged: (value) {
              color = value;
            },
          ),
          RubricButton.light(
            style,
            height: 40,
            width: 150,
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
