import 'package:flutter/material.dart';
import 'package:rubric/src/models/editor_models.dart';

class PagePadderWidget extends StatelessWidget {
  final Widget child;
  final double? pageWidth;
  final double edgePadding;
  const PagePadderWidget({
    super.key,
    required this.child,
    this.pageWidth,
    this.edgePadding = 25,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: edgePadding,
        horizontal: edgePadding,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: (pageWidth ?? GridSizes.pageSize) + edgePadding * 2,
        ),
        child: child,
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Container(
  //     alignment: Alignment.center,
  //     constraints: BoxConstraints(
  //       maxWidth: (pageWidth ?? GridSizes.pageSize) + edgePadding * 2,
  //     ),
  //     padding: EdgeInsets.symmetric(
  //       vertical: edgePadding,
  //       horizontal: edgePadding,
  //     ),
  //     child: child,
  //   );
  // }
}
