import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebViewScreen extends StatefulWidget {
  int? redirectionNumber;
  String? title;

  @override
  createState() => CommonWebViewScreenState();

  CommonWebViewScreen(this.redirectionNumber, this.title);
}

class CommonWebViewScreenState extends State<CommonWebViewScreen> {
  String? _url;
  UniqueKey _key = UniqueKey();
  String? title;
  Preferences preferences = Preferences();
  WebViewController? _myController;
  String? baseURL;

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    String? baseUrl = await preferences.getBaseURL();
    setState(() {
      baseURL = baseUrl;
    });
  }


  Future<bool> _willPopCallback() async {
    Navigator.pop(context, "cancel");
    return true;
  }

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: ArrowToolbarBackwardNavigation(),
              onPressed: () => Navigator.pop(context, "cancel"),
          ),
          backgroundColor: colorBg,
          elevation: 0.0,
          centerTitle: true,
          title: Text(widget.title != null ? widget.title! : "", style: TextStyle(color: appTheme)),
        ),
        body: baseURL == null ? Center(child: Text(Strings.please_wait)) : getPrivacyPolicyUrl(),
      ),
    );
  }

  Widget getPrivacyPolicyUrl() {
    //1 = FAQ,
    //2 = Privacy Policy
    //3 = Terms of Use
    if(widget.redirectionNumber ==1){
      _url = baseURL! +'help?webview';
    } else if(widget.redirectionNumber ==2){
      _url = baseURL! +'privacy-policy?webview';
    } else if(widget.redirectionNumber ==3){
      _url = baseURL! +'terms-of-use?webview';
    } else {
      _url = "https://play.google.com/store/apps/details?id=com.choiceequitybroking.jiffy";
    }

    return Column(
      children: [
        Expanded(
          child: WebView(
            key: _key,
            javascriptMode: JavascriptMode.unrestricted,
            initialUrl: _url,
            onWebViewCreated: (controller) {
              _myController = controller;
            },
            onPageFinished: (url) async {
              if (_myController != null) {
                var title = await _myController!.getTitle();
                if (title!.isEmpty) {
                  _myController!.reload();
                }
              }
            },
            navigationDelegate: (action) {
              if (action.url.endsWith('.pdf') || action.url.startsWith('mailto:')) {
                _launchURL(Uri.parse(action.url));
                return NavigationDecision.prevent;
              }
              return NavigationDecision.navigate;
            },
          ),
        ),
      ],
    );
  }
}

_launchURL(Uri pathURL) async {
  if (await canLaunchUrl(pathURL)) {
    await launchUrl(pathURL);
  } else {
    throw 'Could not launch $pathURL';
  }
}