// import 'package:get/get.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';

// class YoutubeVideoController extends GetxController {
//   YoutubeVideoController();

//   YoutubePlayerController? _controller;
//   String? playingVideoID;
//   String? videoTitle;

//   @override
//   void onInit() {
//     // TODO: implement onInit
//     playingVideoID = widget.videoID;
//     videoTitle = widget.title;
//     _controller = YoutubePlayerController(
//       initialVideoId: playingVideoID!,
//       flags: const YoutubePlayerFlags(
//         autoPlay: true,
//         disableDragSeek: false,
//         enableCaption: true,
//         hideThumbnail: false,
//         hideControls: false,
//       ),
//     )..addListener(listener);
//     super.onInit();
//   }

//   void listener() {
//     setState(() {});
//   }

  
//   @override
//   void onClose() {
//     // TODO: implement onClose
//     _controller!.dispose();
//     super.onClose();
//   }
// }
