import 'package:flutter/material.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';

class RubricDropdown<T> extends StatefulWidget {
  final List<DropdownMenuItem<T>>? items;
  final DropdownButtonBuilder? selectedItemBuilder;
  final ValueChanged<T?>? onChanged;
  final T? value;

  const RubricDropdown({
    this.items,
    this.selectedItemBuilder,
    this.onChanged,
    this.value,
    super.key,
  });

  @override
  State<RubricDropdown<T>> createState() => RubricDropdownState<T>();
}

class RubricDropdownState<T> extends State<RubricDropdown<T>> {
  T? value;
  @override
  Widget build(BuildContext context) {
    final styles = RubricEditorStyle.of(context);
    return DropdownButton<T>(
      padding: EdgeInsets.all(styles.paddingUnit * 0.5),
      underline: SizedBox(),
      isDense: true,
      value: value ?? widget.value,
      borderRadius: BorderRadius.circular(styles.radius),
      items: widget.items,
      selectedItemBuilder: widget.selectedItemBuilder,
      onChanged: (newValue) {
        if (widget.onChanged case ValueChanged<T?> onChanged) {
          onChanged(newValue);
        }
        setState(() {
          value = newValue;
        });
      },
      dropdownColor: styles.light,

      style: TextStyle(color: styles.dark, fontSize: styles.fontSize),
    );
  }
}
