import 'package:flutter/material.dart';
import 'package:rubric/src/models/editor_models.dart';

class PagePadderWidget extends StatelessWidget {
  final Widget child;
  const PagePadderWidget({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(maxWidth: GridSizes.pageSize + 40),
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: child,
    );
  }
}
