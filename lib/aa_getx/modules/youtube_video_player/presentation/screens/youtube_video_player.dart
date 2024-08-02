// import 'package:get/get.dart';

// class YoutubeVideoPlayer extends GetView{
//   YoutubeVideoPlayer();


// }

import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoPlayer extends StatefulWidget {
  String videoID;
  String title;
  List<String> videoIDList;
  List<String> titleList;

  YoutubeVideoPlayer(this.videoID, this.title, this.videoIDList, this.titleList);

  @override
  _YoutubeVideoPlayerState createState() => _YoutubeVideoPlayerState();
}

class _YoutubeVideoPlayerState extends State<YoutubeVideoPlayer> {
  YoutubePlayerController? _controller;
  String? playingVideoID;
  String? videoTitle;

  @override
  void initState() {
    playingVideoID = widget.videoID;
    videoTitle = widget.title;
    _controller = YoutubePlayerController(
      initialVideoId: playingVideoID!,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        disableDragSeek: false,
        enableCaption: true,
        hideThumbnail: false,
        hideControls: false,
      ),
    )..addListener(listener);
    super.initState();
  }

  void listener() {
    setState(() {
    });
  }

  @override
  void deactivate() {
    _controller!.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    // SystemChrome.setPreferredOrientations([
    //   DeviceOrientation.portraitUp,
    //   DeviceOrientation.portraitDown,
    // ]);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return youtubeBuilder();
  }

  Widget youtubeBuilder(){
    return YoutubePlayerBuilder(
      onExitFullScreen: () {
        // SystemChrome.setPreferredOrientations(DeviceOrientation.values);
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
          DeviceOrientation.portraitDown,
        ]);
        if (_controller!.value.isPlaying) {
          Future.delayed(const Duration(milliseconds: 500), () {
            _controller!.play();
          });
        } else if (!_controller!.value.isPlaying) {
          Future.delayed(const Duration(milliseconds: 500), () {
            _controller!.pause();
          });
        }
      },
      onEnterFullScreen: (){
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
        if (_controller!.value.isPlaying) {
          Future.delayed(const Duration(milliseconds: 500), () {
            _controller!.play();
          });
        } else if (!_controller!.value.isPlaying) {
          Future.delayed(const Duration(milliseconds: 500), () {
            _controller!.pause();
          });
        }
      },
      player: YoutubePlayer(
        controller: _controller!,
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
                videoTitle!,
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
                    Share.share('$videoTitle:\nhttps://youtu.be/$playingVideoID');
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
          setState((){
          });
        },
        thumbnail: Image.network(
            'https://i3.ytimg.com/vi/${playingVideoID}/maxresdefault.jpg',
            // 'https://i.ytimg.com/vi/${playingVideoID}/hqdefault.jpg',
            // 'https://i3.ytimg.com/vi/${playingVideoID}/mqdefault.jpg'
            fit: BoxFit.fill),
        onEnded: (data) {
          setState((){
            _controller!.load(widget.videoIDList[(widget.videoIDList.indexOf(data.videoId) + 1) % widget.videoIDList.length]);
            playingVideoID = widget.videoIDList[(widget.videoIDList.indexOf(data.videoId) + 1) % widget.videoIDList.length];
            videoTitle = widget.titleList[(widget.videoIDList.indexOf(data.videoId) + 1) % widget.videoIDList.length];
            printLog("Video end");
          });
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
            onPressed: () {
              Navigator.pop(context);
            },
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
          Expanded(child: Text(videoTitle!, style: boldTextStyle_18)),
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
            itemCount: widget.videoIDList.length,
            itemBuilder: (BuildContext context, int index) {
              return relatedVideoListItem(playingVideoID, widget.videoIDList[index], widget.titleList[index]);
            },
          ),
        ],
      ),
    );
  }

  Widget relatedVideoListItem(playingVID, videoID, title) {
    return TextButton(
      //TODO:
      // shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(10)
      // ),
      onPressed: () {
        Utility.isNetworkConnection().then((isNetwork) {
          if (isNetwork) {
            setState(() {
              videoTitle = title;
              if (_controller!.metadata.videoId == videoID) {
                if (_controller!.value.isPlaying) {
                  _controller!.pause();
                } else {
                  _controller!.play();
                }
              } else {
                _controller!.load(videoID);
              }
              playingVideoID = videoID;
            });
          } else {
            Utility.showToastMessage(Strings.no_internet_message);
          }
        });
      },
      //TODO:
      // padding: EdgeInsets.all(0),
      // splashColor: Colors.transparent,
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
                  style: TextStyle(fontWeight: playingVideoID == videoID ? FontWeight.bold : FontWeight.normal,
                      color: playingVideoID == videoID ? appTheme : colorBlack
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
                  _controller!.value.isPlaying
                      ?  playingVideoID == videoID
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