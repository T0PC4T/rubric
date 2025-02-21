import 'package:flutter/material.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';

enum TextType {
  title(1.3),
  big(1.2),
  paragraph(1),

  thick(1.1),

  small(0.9);

  final double sizeMultiplier;
  const TextType(this.sizeMultiplier);
}

class RubricText extends StatelessWidget {
  final String text;
  final TextType textType;
  final bool isDark;
  const RubricText(
    this.text, {
    super.key,
    this.textType = TextType.paragraph,
    this.isDark = false,
  });

  @override
  Widget build(BuildContext context) {
    final styles = RubricEditorStyle.of(context);
    return Text(
      text,
      style: TextStyle(
        color: isDark ? styles.light : styles.dark,
        fontSize: styles.fontSize * textType.sizeMultiplier,
        fontWeight:
            textType == TextType.thick ? FontWeight.w600 : FontWeight.normal,
      ),
    );
  }
}

class RubricTextField extends StatefulWidget {
  final String initialValue;
  final ValueChanged<String> onChanged;
  final double width;
  const RubricTextField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    this.width = 150,
  });

  @override
  State<RubricTextField> createState() => _RubricTextFieldState();
}

class _RubricTextFieldState extends State<RubricTextField> {
  String value = "";
  late FocusNode focusNode;
  @override
  void initState() {
    value = widget.initialValue;
    focusNode = FocusNode();
    focusNode.addListener(_l);
    super.initState();
  }

  _l() {
    if (!focusNode.hasFocus) {
      widget.onChanged(value);
    }
  }

  @override
  void dispose() {
    focusNode.removeListener(_l);
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);

    return Container(
      padding: EdgeInsets.symmetric(horizontal: style.paddingNum),
      width: widget.width,
      child: TextFormField(
        focusNode: focusNode,
        cursorColor: style.theme,
        decoration: InputDecoration(
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
        style: TextStyle(color: style.light, fontSize: 18),
        initialValue: widget.initialValue,
        onChanged: (nvalue) {
          value = nvalue;
        },
        onEditingComplete: () {
          widget.onChanged(value);
        },
      ),
    );
  }
}
