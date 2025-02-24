// Automatic FlutterFlow imports
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';

import '/backend/backend.dart';
import '/backend/schema/enums/enums.dart';
import '/backend/schema/structs/index.dart';
import '/custom_code/actions/index.dart'; // Imports custom actions
import '/custom_code/widgets/index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';

class RubricLessonEditorWidget extends StatefulWidget {
  final String moduleID;
  final double? width;
  final double? height;
  const RubricLessonEditorWidget({
    super.key,
    this.width,
    this.height,
    required this.moduleID,
  });

  @override
  State<RubricLessonEditorWidget> createState() =>
      _RubricLessonEditorWidgetState();
}

class _RubricLessonEditorWidgetState extends State<RubricLessonEditorWidget> {
  Future<DocumentSnapshot<Map<String, dynamic>>>? future;

  @override
  void initState() {
    final firestore = FirebaseFirestore.instance;
    future = firestore.collection("modules").doc(widget.moduleID).get();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return SizedBox.shrink(child: Text("Loading..."));
        }
        final data = snapshot.data?.data();
        if (data case Map<String, dynamic> data) {
          return RubricEditor(
            canvas: CanvasModel.fromJson(data["lesson_data"]),
            onSave: (canvas) {},
            onLogoPressed: () {},
            bytesToURL: (Uint8List bytes, {String? name, String? type}) async {
              await Future.delayed(Duration(seconds: 2));
              return "https://images.rawpixel.com/image_png_800/czNmcy1wcml2YXRlL3Jhd3BpeGVsX2ltYWdlcy93ZWJzaXRlX2NvbnRlbnQvam9iNjc5LTEwMy1wLWwxNjd4ZGdvLnBuZw.png";
            },
            style: RubricEditorStyle(
              logoUrl: "https://t0pc4t.github.io/public/bleep_logo.webp",
            ),
          );
        } else {
          return SizedBox.shrink(child: Text("Unable to load data"));
        }
      },
    );
  }
}
