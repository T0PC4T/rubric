import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/box/box_model.dart';
import 'package:rubric/src/elements/models/elements.dart';

class FocusBoxWidget extends StatelessWidget {
  final ElementModel element;
  const FocusBoxWidget({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final state = RubricEditorState.of(context);
    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            final BoxElementModel boxProperties =
                element.getProperties<BoxElementModel>();
            state.changeProperties(
              element,
              boxProperties.copyWith(color: Colors.red).toJson(),
            );
          },
          child: Text("Change Color"),
        ),
      ],
    );
  }
}
