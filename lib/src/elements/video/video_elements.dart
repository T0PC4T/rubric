import 'package:flutter/material.dart';
import 'package:rubric/src/components/shared.dart';
import 'package:rubric/src/elements/base/states.dart';
import 'package:rubric/src/elements/video/video_model.dart';
import 'package:rubric/src/elements/video/video_rubric.dart';
import 'package:rubric/src/elements/video/video_toolbar.dart';
import 'package:rubric/src/models/elements.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_parser/youtube_parser.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoEditorElement extends StatefulWidget {
  final ElementModel element;
  const VideoEditorElement({super.key, required this.element});

  @override
  State<VideoEditorElement> createState() => VideoEditorElementState();
}

class VideoEditorElementState extends SelectableState<VideoEditorElement> {
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
  Widget build(BuildContext context) {
    final properties = widget.element.getProperties<VideoElementModel>();
    if (properties.isYoutube == false) {
      return Container(
        color: Colors.black,
        alignment: Alignment.center,
        child: FittedBox(
            child: Icon(
          Icons.video_file,
          color: Colors.white,
          size: 50,
        )),
      );
    } else {
      // return thumbnail
      final youtubeID = getIdFromUrl(properties.videoUrl) ?? "c21QZnQtGqo";
      return Image.network(
        "https://img.youtube.com/vi/$youtubeID/sddefault.jpg",
        fit: BoxFit.cover,
      );
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
  VideoPlayerController? controller;
  YoutubePlayerController? utubeController;

  @override
  void initState() {
    setOrUpdateControllers();
    super.initState();
  }

  setOrUpdateControllers() {
    final properties = widget.element.getProperties<VideoElementModel>();

    if (properties.isYoutube) {
      final youtubeID = getIdFromUrl(properties.videoUrl) ?? "c21QZnQtGqo";
      utubeController ??= YoutubePlayerController(
        params: YoutubePlayerParams(
          mute: false,
          showControls: true,
          showFullscreenButton: true,
        ),
      );
      utubeController!.cueVideoById(videoId: youtubeID);
    } else {
      controller ??= VideoPlayerController.networkUrl(
        Uri.parse(properties.videoUrl),
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: true),
      )..initialize().then(
          (_) {
            setState(() {});
          },
        );
    }
  }

  @override
  void didUpdateWidget(VideoReaderElement oldWidget) {
    setOrUpdateControllers();
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller?.dispose();
    utubeController?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // todo add youtube support to player
    final properties = widget.element.getProperties<VideoElementModel>();

    if (controller case VideoPlayerController controller
        when controller.value.isInitialized && properties.isYoutube == false) {
      return RubricVideoPlayer(controller: controller);
    }
    if (utubeController case YoutubePlayerController utubeController
        when properties.isYoutube == true) {
      return LayoutBuilder(
        builder: (context, constraints) {
          return YoutubePlayer(
            controller: utubeController,
            aspectRatio: constraints.maxWidth / constraints.maxHeight,
          );
        },
      );
    }

    return SizedBox.expand(
      child: RubricText("Something went wrong"),
    );
  }
}
