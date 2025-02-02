import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/box/focus_box.dart';
import 'package:rubric/src/models/elements.dart';

class FocusWidget extends StatelessWidget {
  final ElementModel element;
  const FocusWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final state = RubricEditorState.of(context);

    return Column(
      children: [
        Text(element.type.title),
        Container(
          padding: EdgeInsets.all(state.style.paddingUnit),
          child: switch (element.type) {
            ElementTypes.box => FocusBoxWidget(element: element),
          },
        ),
      ],
    );
  }
}
