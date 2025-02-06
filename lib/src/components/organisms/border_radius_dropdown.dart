import 'package:flutter/material.dart';
import 'package:rubric/src/components/molecules/dropdown.dart';
import 'package:rubric/src/elements/elements.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';
import 'package:rubric/src/rubric_editor/toolbar/element_toolbar.dart';

class RubricBorderRadiusDropdown extends StatelessWidget {
  final double radius;
  final Function(double?) onChanged;
  const RubricBorderRadiusDropdown({
    super.key,
    required this.radius,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);

    return Padding(
      padding: EdgeInsets.all(style.paddingUnit * 0.5),
      child: Row(
        spacing: style.paddingUnit,
        children: [
          Icon(
            Icons.signal_cellular_4_bar_rounded,
            size: ElementToolbarWidget.iconSize,
          ),
          RubricDropdown<double>(
            value: radius,
            items: [
              for (var value in BorderRadiusPresets.values)
                DropdownMenuItem(value: value.radius, child: Text(value.name)),
            ],
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
