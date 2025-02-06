import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rubric/src/rubric_editor/models/style.dart';

class PopupWidget<T> extends StatefulWidget {
  static List<OverlayEntry> currentPopup = [];

  static cleanOverlays() {
    while (currentPopup.isNotEmpty) {
      final popup = currentPopup.removeAt(0);
      popup.remove();
      popup.dispose();
    }
  }

  static Future<T?> showPopup<T>(
    BuildContext context,
    Widget Function(Function(T value) closeWith) builder,
  ) {
    cleanOverlays();
    final completer = Completer<T?>();

    final newPopup = OverlayEntry(
      builder: (context) {
        return PopupWidget(builder: builder, completer: completer);
      },
    );

    Overlay.of(context).insert(newPopup);
    currentPopup.add(newPopup);
    return completer.future;
  }

  final Widget Function(Function(T value) closeWith) builder;
  final Completer<T?> completer;
  const PopupWidget({
    super.key,
    required this.builder,
    required this.completer,
  });

  @override
  State<PopupWidget<T>> createState() => _PopupWidgetState<T>();
}

class _PopupWidgetState<T> extends State<PopupWidget<T>> {
  onCompleter(T value) {
    widget.completer.complete(value);
    PopupWidget.cleanOverlays();
  }

  @override
  Widget build(BuildContext context) {
    final style = RubricEditorStyle.of(context);
    return GestureDetector(
      onTap: () {
        widget.completer.complete(null);
        PopupWidget.cleanOverlays();
      },
      child: Container(
        color: style.dark.withAlpha(10),
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () => {},
          child: Container(
            padding: style.padding,
            decoration: BoxDecoration(
              color: style.light,
              borderRadius: style.borderRadius,
            ),
            child: SingleChildScrollView(child: widget.builder(onCompleter)),
          ),
        ),
      ),
    );
  }
}
