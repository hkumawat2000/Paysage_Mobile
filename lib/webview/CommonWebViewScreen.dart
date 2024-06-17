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
  late final WebViewController controller;

  @override
  void initState() {
    super.initState();
    getData();
    getURL();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) async {
            var title = await controller.getTitle();
            if (title!.isEmpty) {
              _myController!.reload();
            }

            debugPrint('Page finished loading: $url');
          },
          onWebResourceError: (WebResourceError error) {
            debugPrint('''
Page resource error:
  code: ${error.errorCode}
  description: ${error.description}
  errorType: ${error.errorType}
  isForMainFrame: ${error.isForMainFrame}
          ''');
          },
          onNavigationRequest: (NavigationRequest action) {
            if (action.url.endsWith('.pdf') ||
                action.url.startsWith('mailto:')) {
              _launchURL(Uri.parse(action.url));
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(_url ?? "https://play.google.com/store/apps/details?id=com.choiceequitybroking.jiffy" ));
  }

  Future<void> getData() async {
    String? baseUrl = await preferences.getBaseURL();
    setState(() {
      baseURL = baseUrl;
    });
  }

  Future<void> getURL() async {
    if (widget.redirectionNumber == 1) {
      _url = baseURL! + 'help?webview';
    } else if (widget.redirectionNumber == 2) {
      _url = baseURL! + 'privacy-policy?webview';
    } else if (widget.redirectionNumber == 3) {
      _url = baseURL! + 'terms-of-use?webview';
    } else {
      _url =
          "https://play.google.com/store/apps/details?id=com.choiceequitybroking.jiffy";
    }
  }

  Future<bool> _willPopCallback() async {
    Navigator.pop(context, "cancel");
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) {
        _willPopCallback();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: ArrowToolbarBackwardNavigation(),
            onPressed: () => Navigator.pop(context, "cancel"),
          ),
          backgroundColor: colorBg,
          elevation: 0.0,
          centerTitle: true,
          title: Text(widget.title != null ? widget.title! : "",
              style: TextStyle(color: appTheme)),
        ),
        body: baseURL == null
            ? Center(child: Text(Strings.please_wait))
            : getPrivacyPolicyUrl(),
      ),
    );
  }

  Widget getPrivacyPolicyUrl() {
    //1 = FAQ,
    //2 = Privacy Policy
    //3 = Terms of Use

    return Column(
      children: [
        Expanded(
          child: WebViewWidget(controller: controller),
          //  WebView(
          //   key: _key,
          //   javascriptMode: JavascriptMode.unrestricted,
          //   initialUrl: _url,
          //   onWebViewCreated: (controller) {
          //     _myController = controller;
          //   },
          //   onPageFinished: (url) async {
          //     if (_myController != null) {
          //       var title = await _myController!.getTitle();
          //       if (title!.isEmpty) {
          //         _myController!.reload();
          //       }
          //     }
          //   },
          //   navigationDelegate: (action) {
          //     if (action.url.endsWith('.pdf') ||
          //         action.url.startsWith('mailto:')) {
          //       _launchURL(Uri.parse(action.url));
          //       return NavigationDecision.prevent;
          //     }
          //     return NavigationDecision.navigate;
          //   },
          // ),
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
