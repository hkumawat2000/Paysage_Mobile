import 'package:choice/login/LoginScreen.dart';
import 'package:choice/network/responsebean/OnboardingResponseBean.dart';
import 'package:choice/util/AssetsImagePath.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Preferences.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class TutorialScreen extends StatefulWidget {
  List<OnBoardingData>? tutorialData;

  TutorialScreen(this.tutorialData);

  @override
  TutorialScreenState createState() => TutorialScreenState();
}

class TutorialScreenState extends State<TutorialScreen> {
  final introKey = GlobalKey<IntroductionScreenState>();
  Preferences? preferences = new Preferences();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => LoginScreen()),
    );
  }

  Widget _buildImage(String assetName) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 50, right: 20),
          child: GestureDetector(
            onTap: () {
              preferences!.setIsVisitTutorial("true");
              _onIntroEnd(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(Strings.skip, style: regularTextStyle_14_gray),
              ],
            ),
          ),
        ),
        SizedBox(height: 20),
        Expanded(child: Image.asset(assetName, width: 300.0, height: 300.0)),
        SizedBox(height: 20),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 16.0, color: colorLightGray,
        fontWeight: FontWeight.w500);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w800,
          color: appTheme, fontFamily: "Gilroy"),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 10.0),
      pageColor: colorBg,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        for(int i=0; i<widget.tutorialData!.length; i++)
          PageViewModel(
           title: widget.tutorialData![i].title,
           body: widget.tutorialData![i].description,
           image: i == 0 ? _buildImage(AssetsImagePath.tutorial_1) :
           i == 1 ? _buildImage(AssetsImagePath.updateKyc) :
           i == 2 ? _buildImage(AssetsImagePath.tutorial_3) :
           i == 3 ? _buildImage(AssetsImagePath.tutorial_4) :
           i == 4 ? _buildImage(AssetsImagePath.tutorial_5) : _buildImage(AssetsImagePath.tutorial_1),
           decoration: pageDecoration,
         ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      // skipFlex: 0,
      skipOrBackFlex: 0,
      nextFlex: 2,
      dotsFlex: 1,
      skip: Text(''),
      next: Container(
        height: 40,
        width: 80,
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          color: appTheme,
          child: MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            onPressed: null,
            minWidth: MediaQuery.of(context).size.width,
            child: ArrowForwardNavigation(),
          ),
        ),
      ),
      done: Container(
        height: 40,
        width: 80,
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          elevation: 1.0,
          color: appTheme,
          child: MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () async {
              preferences!.setIsVisitTutorial("true");
              _onIntroEnd(context);
            },
            child: ArrowForwardNavigation(),
          ),
        ),
      ),
      dotsDecorator: const DotsDecorator(
        size: Size(5.0, 5.0),
        color: colorLightGray,
        activeSize: Size(10.0, 10.0),
        activeColor: appTheme,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
    );
  }
}
