import 'package:flutter/material.dart';
import 'package:rubric/src/models/editor_models.dart';

class PagePadderWidget extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;
  final Function()? onTapBackground;
  const PagePadderWidget({
    super.key,
    required this.child,
    required this.backgroundColor,
    this.onTapBackground,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTapBackground,
      child: Container(
        color: backgroundColor,
        alignment: Alignment.center,
        constraints: BoxConstraints(maxWidth: GridSizes.pageSize + 40),
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: GestureDetector(
          behavior: HitTestBehavior.deferToChild,
          // ! this is a botch to ensure that any click on the widget below are properly handled.
          onTap: () {},
          child: child,
        ),
      ),
    );
  }
}
