import 'package:flutter/material.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';

class RubricDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>>? items;
  final DropdownButtonBuilder? selectedItemBuilder;
  final ValueChanged<T?>? onChanged;

  const RubricDropdown({
    this.items,
    this.selectedItemBuilder,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final styles = RubricEditorStyle.of(context);
    return DropdownButton<T>(
      isDense: true,
      borderRadius: BorderRadius.circular(styles.radius),
      items: items,
      selectedItemBuilder: selectedItemBuilder,
      onChanged: onChanged,
      dropdownColor: styles.light,
      style: TextStyle(color: styles.dark, fontSize: styles.fontSize),
    );
  }
}
