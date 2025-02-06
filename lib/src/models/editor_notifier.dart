import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:rubric/src/models/canvas.dart';
import 'package:rubric/src/models/editor_models.dart';
import 'package:rubric/src/models/elements.dart';

class ElementNotifier extends ValueNotifier<ElementModel?> {
  ElementNotifier(super.value);
}

class EditorNotifier extends ValueNotifier<CanvasEditingModel> {
  final focusNotifier = ElementNotifier(null);
  final selectionNotifier = ElementNotifier(null);
  EditorNotifier(super.value);

  @override
  void dispose() {
    focusNotifier.dispose();
    super.dispose();
  }

  clear() {
    selectElement(null);
  }

  selectElement(ElementModel? element) {
    value = value.copyWith(selected: element, focused: null);
    selectionNotifier.value = element;
    focusNotifier.value = null;
  }

  focusElement(ElementModel element) {
    if (element.type.focusable) {
      value = value.copyWith(selected: null, focused: element);
      focusNotifier.value = element;
      selectionNotifier.value = null;
    }
  }

  saveStep(CanvasModel step) {
    value = value.copyWith(
      selected: value.selected,
      focused: value.focused,
      steps: [step, ...value.steps.sublist(0, math.min(value.steps.length, 3))],
    );
  }

  bool isFocused(ElementModel element) {
    return value.focused == element;
  }

  bool isSelected(ElementModel element) {
    return value.selected == element;
  }

  bool get canUndo => value.steps.length > 1;
  CanvasModel get lastStep => value.steps[1];
}
