import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/youtube_video_player/presentation/arguments/youtube_player_arguments.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoController extends GetxController {
  YoutubeVideoController();

  YoutubePlayerController? youtubePlayerController;
  String? playingVideoID;
  String? videoTitle;

  YoutubePlayerArgument youtubePlayerArgument = Get.arguments;

  @override
  void onInit() {
    playingVideoID = youtubePlayerArgument.videoID;
    videoTitle = youtubePlayerArgument.title;
    youtubePlayerController = YoutubePlayerController(
      initialVideoId: playingVideoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        disableDragSeek: false,
        enableCaption: true,
        hideThumbnail: false,
        hideControls: false,
      ),
    )..addListener(listener);
    super.onInit();
  }

  void listener() {
    // if (isPlayerReady && mounted && !youtubePlayerController!.value.isFullScreen) {
    //   setState(() {
    //     _playerState = youtubePlayerController.value.playerState;
    //     _videoMetaData = youtubePlayerController.metadata;
    //   });
    // }
  }
  
  @override
  void onClose() {
    youtubePlayerController!.dispose();
    super.onClose();
  }
}
