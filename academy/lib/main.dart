import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:rubric/rubric.dart';

const FirebaseOptions destination = FirebaseOptions(
  apiKey: "AIzaSyD2h1Xa3aT0b-FuxX1q54cAg6Ps4MnXR-E",
  authDomain: "academy-5q7q96.firebaseapp.com",
  projectId: "academy-5q7q96",
  storageBucket: "academy-5q7q96.firebasestorage.app",
  messagingSenderId: "492783007613",
  appId: "1:492783007613:web:16400f648afd47c338fe14",
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: destination);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        body: RubricLessonEditorWidget(moduleID: "n9OQvN72csbuJnDA3HZB"),
        // body: RubricLessonReaderWidget(moduleID: "n9OQvN72csbuJnDA3HZB"),
      ),
    );
  }
}

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
        if (snapshot case AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>(
          data: DocumentSnapshot<Map<String, dynamic>> data,
        )) {
          final map = data.data();
          return RubricEditor(
            canvas: CanvasModel.fromJson(map!["lesson_data"]),
            onSave: (canvas) {
              snapshot.data?.reference.update({
                "name": canvas.settings.name,
                "icon": canvas.settings.icon,
                "lesson_data": canvas.toJson(),
              });
            },
            onLogoPressed: () {},
            bytesToURL: (Uint8List bytes, {String? name, String? type}) async {
              final storage = FirebaseStorage.instance;
              // upload file to storage
              final ref = storage.ref().child(
                "lessons/${widget.moduleID}_${DateTime.now().millisecondsSinceEpoch}_$name",
              );
              // todo limit the size of files that can be uploaded!
              final uploadTask = ref.putData(bytes);
              final snapshot = await uploadTask.whenComplete(() {});
              final url = await snapshot.ref.getDownloadURL();
              return url;
            },

            style: RubricEditorStyle(
              logoUrl: "https://t0pc4t.github.io/public/bleep_logo.webp",
            ),
          );
        }
        return SizedBox.shrink(child: Text("Unable to load data"));
      },
    );
  }
}

class RubricLessonReaderWidget extends StatefulWidget {
  final String moduleID;
  final double? width;
  final double? height;
  const RubricLessonReaderWidget({
    super.key,
    this.width,
    this.height,
    required this.moduleID,
  });

  @override
  State<RubricLessonReaderWidget> createState() =>
      RubricLessonReaderWidgetState();
}

class RubricLessonReaderWidgetState extends State<RubricLessonReaderWidget> {
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
        if (snapshot case AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>(
          data: DocumentSnapshot<Map<String, dynamic>> data,
        )) {
          final map = data.data();
          return SizedBox.expand(
            child: RubricReader(
              canvasModel: CanvasModel.fromJson(map!["lesson_data"]),
            ),
          );
        }
        return SizedBox.shrink(child: Text("Loading..."));
      },
    );
  }
}
