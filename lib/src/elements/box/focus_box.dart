import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/elements/box/model_box.dart';
import 'package:rubric/src/models/elements.dart';

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
