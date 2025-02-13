import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/components/atoms/button.dart';

class RubricToolbarDropdown<T> extends StatefulWidget {
  final Widget child;
  final List<DropdownMenuItem<T>> items;
  final Function(T? value) onUpdate;
  const RubricToolbarDropdown({
    super.key,
    required this.child,
    required this.items,
    required this.onUpdate,
  });

  @override
  State<RubricToolbarDropdown> createState() => RubricToolbarDropdownState<T>();
}

// todo edit this.
class RubricToolbarDropdownState<T> extends State<RubricToolbarDropdown<T>> {
  bool bShowDropdown = false;
  Offset offset = Offset.zero;
  Size size = Size.zero;

  void showDropdown() {
    final editorState = RubricEditorState.of(context);
    final style = editorState.style;
    final box = (context.findRenderObject() as RenderBox);
    size = box.size;
    offset = box.localToGlobal(
      Offset(0, size.height - editorState.style.radius),
    );

    setState(() {
      bShowDropdown = !bShowDropdown;
    });

    if (bShowDropdown) {
      editorState.pushOverlay(
        removeToLength: 1,
        Positioned(
          left: offset.dx,
          top: offset.dy,
          child: Container(
            width: size.width,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: editorState.style.light,
              borderRadius: editorState.style.borderRadius,
              boxShadow: [
                BoxShadow(
                  color: style.dark.withAlpha(50),
                  blurRadius: style.elevation,
                  offset: Offset(
                    0,
                    style.elevation,
                  ), // changes position of shadow
                ),
              ],
            ),
            child: Column(
              children: [
                for (var item in widget.items)
                  RubricButton(
                    padding: editorState.style.padding,
                    backgroundColor: editorState.style.light,
                    hoverColor: editorState.style.light95,
                    onTap: () {
                      widget.onUpdate(item.value);
                      editorState.popOverlay();
                      setState(() {
                        bShowDropdown = false;
                      });
                    },
                    child: item.child,
                  ),
              ],
            ),
          ),
        ),
      );
    } else {
      editorState.popOverlay();
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);
    return RubricButton(
      padding: EdgeInsets.symmetric(
        horizontal: style.paddingD,
        vertical: style.paddingD * 0.5,
      ),
      onTap: showDropdown,
      backgroundColor: style.light,
      hoverColor: style.light,
      child: Row(
        spacing: style.paddingD,
        children: [
          widget.child,
          if (bShowDropdown)
            Icon(Icons.keyboard_arrow_up_rounded)
          else
            Icon(Icons.keyboard_arrow_down_rounded),
        ],
      ),
    );
  }
}
