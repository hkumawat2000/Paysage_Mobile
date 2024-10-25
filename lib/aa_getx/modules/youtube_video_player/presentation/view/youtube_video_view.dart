import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/youtube_video_player/presentation/controller/youtube_video_controller.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';


class YoutubeVideoPlayerView extends GetView<YoutubeVideoController>{

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
        onExitFullScreen: () {
          // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
          if (controller.youtubePlayerController!.value.isPlaying) {
            Future.delayed(const Duration(milliseconds: 500), () {
              controller.youtubePlayerController!.play();
            });
          } else if (!controller.youtubePlayerController!.value.isPlaying) {
            Future.delayed(const Duration(milliseconds: 500), () {
              controller.youtubePlayerController!.pause();
            });
          }
        },
        onEnterFullScreen: (){
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.landscapeLeft,
            DeviceOrientation.landscapeRight,
          ]);
          if (controller.youtubePlayerController!.value.isPlaying) {
            Future.delayed(const Duration(milliseconds: 500), () {
              controller.youtubePlayerController!.play();
            });
          } else if (!controller.youtubePlayerController!.value.isPlaying) {
            Future.delayed(const Duration(milliseconds: 500), () {
              controller.youtubePlayerController!.pause();
            });
          }
        },
        player: YoutubePlayer(
          controller: controller.youtubePlayerController!,
          showVideoProgressIndicator: true,
          aspectRatio: 16/8,
          progressIndicatorColor: Colors.red,
          actionsPadding: const EdgeInsets.all(0),
          bufferIndicator: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              color: colorBlack,
              child: Center(
                child: SizedBox(
                  height: 80,
                  width: 80,
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          ),
          bottomActions: [
            SizedBox(width: 8.0),
            CurrentPosition(),
            SizedBox(width: 6.0),
            ProgressBar(isExpanded: true),
            SizedBox(width: 6.0),
            RemainingDuration(),
            FullScreenButton(),
          ],
          topActions: <Widget>[
            SizedBox(width: 8.0),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 2, right: 4),
                child: Text(
                  controller.videoTitle!,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2),
              child: IconButton(
                icon: const Icon(
                  Icons.share,
                  color: Colors.white,
                  size: 20.0,
                ),
                onPressed: () {
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      Share.share('${controller.videoTitle}:\nhttps://youtu.be/${controller.playingVideoID}');
                    } else {
                      Utility.showToastMessage(Strings.no_internet_message);
                    }
                  });
                },
              ),
            ),
            SizedBox(width: 8.0),
          ],
          onReady: () {
          },
          thumbnail: Image.network(
              'https://i3.ytimg.com/vi/${controller.playingVideoID}/maxresdefault.jpg',
              // 'https://i.ytimg.com/vi/${playingVideoID}/hqdefault.jpg',
              // 'https://i3.ytimg.com/vi/${playingVideoID}/mqdefault.jpg'
              fit: BoxFit.fill),
          onEnded: (data) {
            controller.youtubePlayerController!.load(controller.youtubePlayerArgument.videoIDList[(controller.youtubePlayerArgument.videoIDList.indexOf(data.videoId) + 1) % controller.youtubePlayerArgument.videoIDList.length]);
            controller.playingVideoID = controller.youtubePlayerArgument.videoIDList[(controller.youtubePlayerArgument.videoIDList.indexOf(data.videoId) + 1) % controller.youtubePlayerArgument.videoIDList.length];
            controller.videoTitle = controller.youtubePlayerArgument.titleList[(controller.youtubePlayerArgument.videoIDList.indexOf(data.videoId) + 1) % controller.youtubePlayerArgument.videoIDList.length];
            printLog("Video end");
          },
          progressColors: ProgressBarColors(
            playedColor: Colors.red,
            handleColor: Colors.red,
          ),
        ),
        builder: (context, player) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: colorBg,
            body: ScrollConfiguration(
              behavior: new ScrollBehavior(),
              // ..buildViewportChrome(context, Container(), AxisDirection.down),
              child: NestedScrollView(
                physics: NeverScrollableScrollPhysics(),
                headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
                  return <Widget>[
                    SliverList(
                      delegate: SliverChildListDelegate([
                        SizedBox(height: 0.1),
                      ]),
                    )
                  ];
                },
                body: Column(
                  children: <Widget>[
                    SizedBox(height: 32),
                    appBar(),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                            height: 220,
                            child: player
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    titleOfVideo(),
                    SizedBox(height: 10),
                    divider(),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: NeverScrollableScrollPhysics(),
                        child: relatedVideo(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
    );
  }

  Widget appBar() {
    return Container(
      height: 50,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
            icon: ArrowToolbarBackwardNavigation(),
            onPressed: () => Get.back(),
          ),
          Text(
            Strings.understanding_lms,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: appTheme,
                fontFamily: 'Gilroy'),
          ),
        ],
      ),
    );
  }

  Widget titleOfVideo() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(child: Text(controller.videoTitle!, style: boldTextStyle_18)),
        ],
      ),
    );
  }

  Widget divider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Divider(
        thickness: 0.5,
      ),
    );
  }

  Widget relatedVideo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 14),
          Text(Strings.related_videos),
          // SizedBox(height: 10),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: controller.youtubePlayerArgument.videoIDList.length,
            itemBuilder: (BuildContext context, int index) {
              return relatedVideoListItem(controller.playingVideoID, controller.youtubePlayerArgument.videoIDList[index], controller.youtubePlayerArgument.titleList[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget relatedVideoListItem(playingVID, videoID, title) {
    return TextButton(
      onPressed: () {
        Utility.isNetworkConnection().then((isNetwork) {
          if (isNetwork) {
            controller.videoTitle = title;
            if (controller.youtubePlayerController!.metadata.videoId == videoID) {
              if (controller.youtubePlayerController!.value.isPlaying) {
                controller.youtubePlayerController!.pause();
              } else {
                controller.youtubePlayerController!.play();
              }
            } else {
              controller.youtubePlayerController!.load(videoID);
            }
            controller.playingVideoID = videoID;
          } else {
            Utility.showToastMessage(Strings.no_internet_message);
          }
        });
      },
      child: Container(
        height: 65,
        margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 50,
              width: 90,
              decoration: new BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                    'https://i3.ytimg.com/vi/${videoID}/maxresdefault.jpg',
                    // 'https://i.ytimg.com/vi/${videoID}/hqdefault.jpg',
                    // 'https://i3.ytimg.com/vi/${videoID}/mqdefault.jpg'
                  ),
                ),
                color: colorWhite,
                border: Border.all(color: appTheme, width: playingVID == videoID ? 4 : 0),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 2, 14, 2),
                child: Text(
                  title,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: controller.playingVideoID == videoID ? FontWeight.bold : FontWeight.normal,
                      color: controller.playingVideoID == videoID ? appTheme : colorBlack
                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                height: 24,
                width: 24,
                alignment: Alignment.center,
                padding: EdgeInsets.all(2),
                decoration: new BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                ),
                child: Icon(
                  controller.youtubePlayerController!.value.isPlaying
                      ?  controller.playingVideoID == videoID
                      ? Icons.pause
                      : Icons.play_arrow
                      : Icons.play_arrow,
                  color: colorWhite,
                  size: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}