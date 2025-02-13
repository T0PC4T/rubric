import 'package:flutter/material.dart';
import 'package:rubric/src/elements/base/states.dart';
import 'package:rubric/src/elements/video/video_model.dart';
import 'package:rubric/src/elements/video/video_toolbar.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:video_player/video_player.dart';

class VideoEditorElement extends StatefulWidget {
  final ElementModel element;
  const VideoEditorElement({super.key, required this.element});

  @override
  State<VideoEditorElement> createState() => VideoEditorElementState();
}

class VideoEditorElementState
    extends SelectableAndFocusableState<VideoEditorElement> {
  late VideoPlayerController controller;
  @override
  void initState() {
    final properties = widget.element.getProperties<VideoElementModel>();
    controller = VideoPlayerController.networkUrl(
        Uri.parse(properties.videoUrl),
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
      )
      ..initialize().then((_) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  ElementModel get element => widget.element;

  @override
  onSelect(bool selected) {
    if (selected) {
      editorState.showToolbar(
        widget.element,
        VideoTooltipWidget(element: widget.element),
      );
    }
  }

  @override
  onFocus(bool focused) {
    if (!focused) {
      controller.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller.value.isInitialized) {
      return GestureDetector(
        onTap: () {
          controller.value.isPlaying ? controller.pause() : controller.play();
        },
        child: AspectRatio(
          aspectRatio: controller.value.aspectRatio,
          child: AbsorbPointer(child: VideoPlayer(controller)),
        ),
      );
    } else {
      return SizedBox.expand();
    }
  }
}

class VideoLayerElement extends StatelessWidget {
  final ElementModel element;
  const VideoLayerElement({super.key, required this.element});

  @override
  Widget build(BuildContext context) {
    final imageProperties = element.getProperties<VideoElementModel>();
    return Icon(Icons.video_file);
  }
}

class VideoReaderElement extends StatefulWidget {
  final ElementModel element;
  const VideoReaderElement({super.key, required this.element});

  @override
  State<VideoReaderElement> createState() => VideoReaderElementState();
}

class VideoReaderElementState extends State<VideoReaderElement> {
  late VideoPlayerController controller;
  @override
  void initState() {
    final properties = widget.element.getProperties<VideoElementModel>();
    controller = VideoPlayerController.networkUrl(
        Uri.parse(properties.videoUrl),
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
      )
      ..initialize().then((_) {
        setState(() {});
      });
    super.initState();
  }

  @override
  void dispose() {
    controller.pause();
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (controller.value.isInitialized) {
      return GestureDetector(
        onTap: () {
          setState(() {
            controller.value.isPlaying ? controller.pause() : controller.play();
          });
        },
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            AspectRatio(
              aspectRatio: controller.value.aspectRatio,
              child: AbsorbPointer(child: VideoPlayer(controller)),
            ),
            if (!controller.value.isPlaying)
              Icon(Icons.play_arrow, size: 40, color: Colors.white),
          ],
        ),
      );
    } else {
      return SizedBox.expand();
    }
  }
}
