import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/youtube_video_player/presentation/controller/youtube_video_controller.dart';

class YoutubePlayerBinding extends Bindings {
  @override
  void dependencies() {

    Get.put<YoutubeVideoController>(YoutubeVideoController());

  }

}