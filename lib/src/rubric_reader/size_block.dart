import 'package:flutter/material.dart';

class SizeBlockerWidget extends StatelessWidget {
  final Widget child;
  final double minSize;
  const SizeBlockerWidget(
      {super.key, required this.child, this.minSize = 1000});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < minSize) {
          return TooSmallWidget();
        } else {
          return child;
        }
      },
    );
  }
}

class TooSmallWidget extends StatelessWidget {
  const TooSmallWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: FittedBox(
        fit: BoxFit.fitWidth,
        child: Padding(
          padding: EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            spacing: 10,
            children: [
              Icon(Icons.close, color: Colors.red),
              Text("Window is too small!", style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ),
    );
  }
}
