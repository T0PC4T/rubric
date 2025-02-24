import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';
import 'package:rubric/src/components/atoms/popup.dart';
import 'package:rubric/src/components/molecules/color_picker.dart';
import 'package:rubric/src/components/shared.dart';
import 'package:rubric/src/models/editor_models.dart';

class Item {
  Item({
    required this.title,
    required this.icon,
    required this.bodyBuilder,
    this.isExpanded = false,
  });

  String title;
  IconData icon;
  WidgetBuilder bodyBuilder;
  bool isExpanded;
}

class GeneralSettingsPageWidget extends StatefulWidget {
  const GeneralSettingsPageWidget({super.key});

  @override
  State<GeneralSettingsPageWidget> createState() =>
      _GeneralSettingsPageWidgetState();
}

class _GeneralSettingsPageWidgetState extends State<GeneralSettingsPageWidget> {
  RubricEditorState? editorState;

  late List<Item> _data;
  @override
  void initState() {
    _data = [
      Item(
        title: "Details",
        icon: Icons.edit_document,
        isExpanded: false,
        bodyBuilder: (context) {
          final style = editorState!.style;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: editorState!.style.paddingNum,
            children: [
              ColorPickerSettingsWidget(
                title: "Grid Line Color",
                color: editorState!.canvas.value.settings.gridColor,
                onUpdate: (color) {
                  editorState!.canvas.updateSettings(
                    editorState!.canvas.value.settings.copyWith(
                      gridColor: color,
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: style.paddingNum),
                child: Row(
                  children: [
                    RubricText("Line Spacing: "),
                    RubricDropdown<GridSizes>(
                      value: editorState!.canvas.value.settings.gridSize,
                      items: [
                        for (var item in GridSizes.values)
                          DropdownMenuItem<GridSizes>(
                            value: item,
                            child: Text(item.pretty),
                          ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          editorState!.canvas.updateSettings(
                            editorState!.canvas.value.settings.copyWith(
                              gridSize: value,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      Item(
        title: "Grid",
        icon: Icons.grid_3x3,
        isExpanded: false,
        bodyBuilder: (context) {
          final style = editorState!.style;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: editorState!.style.paddingNum,
            children: [
              ColorPickerSettingsWidget(
                title: "Grid Line Color",
                color: editorState!.canvas.value.settings.gridColor,
                onUpdate: (color) {
                  editorState!.canvas.updateSettings(
                    editorState!.canvas.value.settings.copyWith(
                      gridColor: color,
                    ),
                  );
                },
              ),
              Padding(
                padding: EdgeInsets.only(left: style.paddingNum),
                child: Row(
                  children: [
                    RubricText("Line Spacing: "),
                    RubricDropdown<GridSizes>(
                      value: editorState!.canvas.value.settings.gridSize,
                      items: [
                        for (var item in GridSizes.values)
                          DropdownMenuItem<GridSizes>(
                            value: item,
                            child: Text(item.pretty),
                          ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          editorState!.canvas.updateSettings(
                            editorState!.canvas.value.settings.copyWith(
                              gridSize: value,
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      Item(
        title: "Background",
        icon: Icons.collections_sharp,
        isExpanded: false,
        bodyBuilder: (context) {
          return Column(
            spacing: editorState!.style.paddingNum,
            children: [
              ColorPickerSettingsWidget(
                title: "Canvas Color",
                color: editorState!.canvas.value.settings.canvasColor,
                onUpdate: (color) {
                  editorState!.canvas.updateSettings(
                    editorState!.canvas.value.settings.copyWith(
                      canvasColor: color,
                    ),
                  );
                },
              ),
              ColorPickerSettingsWidget(
                title: "Background Color",
                color: editorState!.canvas.value.settings.backgroundColor,
                onUpdate: (color) {
                  editorState!.canvas.updateSettings(
                    editorState!.canvas.value.settings.copyWith(
                      backgroundColor: color,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    editorState ??= RubricEditorState.of(context);
    final style = editorState!.style;
    // todo, make this listen to editor
    return SingleChildScrollView(
      child: ValueListenableBuilder(
        valueListenable: editorState!.canvas,
        builder: (context, canvas, child) {
          return ExpansionPanelList(
            elevation: 0,
            materialGapSize: 1,
            expandedHeaderPadding: EdgeInsets.zero,
            expansionCallback: (int index, bool isExpanded) {
              setState(() {
                _data[index].isExpanded = isExpanded;
              });
            },
            children: _data.map<ExpansionPanel>((Item item) {
              return ExpansionPanel(
                backgroundColor: style.light,
                highlightColor: style.light95,
                headerBuilder: (BuildContext context, bool isExpanded) {
                  return Padding(
                    padding: style.padding,
                    child: Row(
                      spacing: style.paddingNum,
                      children: [
                        Icon(item.icon, size: 20, color: style.light4),
                        RubricText(item.title),
                      ],
                    ),
                  );
                },
                body: Container(
                  color: style.light9,
                  padding: style.padding,
                  child: item.bodyBuilder(context),
                ),
                isExpanded: item.isExpanded,
              );
            }).toList(),
          );
        },
      ),
    );
  }
}

class ColorPickerSettingsWidget extends StatelessWidget {
  const ColorPickerSettingsWidget({
    super.key,
    required this.title,
    required this.onUpdate,
    required this.color,
  });

  final String title;
  final Color color;
  final Function(Color color) onUpdate;

  @override
  Widget build(BuildContext context) {
    final editorState = RubricEditorState.of(context);
    final canvas = editorState.canvas.value;
    return Row(
      children: [
        RubricColorButton(
          color: color,
          onTap: () async {
            final newColor = await PopupWidget.showPopup<Color>(context, (
              closeWith,
            ) {
              return RubricColorPicker(
                onComplete: closeWith,
                color: canvas.settings.backgroundColor,
              );
            });
            if (newColor == null) return;
            onUpdate(newColor);
          },
        ),
        RubricText(title),
      ],
    );
  }
}
