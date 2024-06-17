import 'dart:io';
import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MF_WebViewLoginScreen extends StatefulWidget {
  String token;
  String urlRequest;
  MF_WebViewLoginScreen(this.urlRequest, this.token);

  @override
  createState() => MF_WebViewLoginScreenState();
}

class MF_WebViewLoginScreenState extends State<MF_WebViewLoginScreen> {
  WebViewController? webViewController;
  late final WebViewController controller;

  void initState() {
    // TODO: Change version to 4.8.0
    // if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            String f = progress.toString();
            printLog("PROGRESS------ $f");
            debugPrint('WebView is loading (progress : $progress%)');
          },
          onPageStarted: (String url) {
            debugPrint('Page started loading: $url');
          },
          onPageFinished: (String url) {
            debugPrint('Page finished loading: $url');
            if (url.contains('response')) {
              //TODO:
              // controller!.evaluateJavascript(
              //     "(function(){Flutter.postMessage(window.document.body.outerHTML)})();");
            }
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
          // onNavigationRequest: (NavigationRequest request) {
          //   if (request.url.startsWith('https://www.youtube.com/')) {
          //     return NavigationDecision.prevent;
          //   } else if (request.url.endsWith("succRes.jsp")) {
          //     Navigator.pop(context, "success");
          //     return NavigationDecision.prevent;
          //   } else if (request.url.endsWith("failRes.jsp")) {
          //     Navigator.pop(context, "fail");
          //     return NavigationDecision.prevent;
          //   }
          //   return NavigationDecision.navigate;
          // },
        ),
      )
      ..addJavaScriptChannel(
      'Flutter',
      onMessageReceived: (JavaScriptMessage message) {
        String pageBody = message.message;
        printLog('page body: $pageBody');
        if (pageBody.contains('Success')) {
          printLog("SUCCESS----------------------");
          FocusScope.of(context).unfocus();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DashBoard()));
        } else if (pageBody.contains('Something went wrong')) {
          FocusScope.of(context).unfocus();
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => DashBoard()));
          commonDialog(
              context,
              "Unfortunately, the lien request cannot be executed due to technical reasons. Please try again after sometime.",
              0);
        }
      },
      )
      ..loadRequest(Uri.parse(widget.urlRequest));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: getESignUrl());
  }

  Widget getESignUrl() {
    return WillPopScope(
      onWillPop: () async => false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0, left: 15),
            child: Column(
              children: <Widget>[
                Image.asset(AssetsImagePath.app_icon, width: 37, height: 37),
                //scripsNameText('CAMS LOGIN')
              ],
            ),
          ),
          Expanded(
            child: webViewRedirection(),
          ),
        ],
      ),
    );
  }

  webViewRedirection() {
    return WillPopScope(
      onWillPop: () async => false,
      child: WebViewWidget(controller: controller),
      // WebView(
      //   initialUrl: widget.urlRequest,
      //   javascriptMode: JavascriptMode.unrestricted,
      //   onWebViewCreated: (controller) {
      //     webViewController = controller;
      //   },
      //   javascriptChannels: <JavascriptChannel>[
      //     _extractDataJSChannel(context),
      //   ].toSet(),
      //   onProgress: (controller) {
      //     String f = controller.toString();
      //     printLog("PROGRESS------ $f");
      //   },
      //   onPageStarted: (String url) {
      //     printLog("ON PAGE------- $url");
      //   },
      //   onPageFinished: (String url) {
      //     printLog('Page finished loading: $url');
      //     if (url.contains('response')) {
      //       webViewController!.evaluateJavascript(
      //           "(function(){Flutter.postMessage(window.document.body.outerHTML)})();");
      //     }
      //   },
      // ),
    );
  }

  // JavascriptChannel _extractDataJSChannel(BuildContext context) {
  //   return JavascriptChannel(
  //     name: 'Flutter',
  //     onMessageReceived: (JavascriptMessage message) {
  //       String pageBody = message.message;
  //       printLog('page body: $pageBody');
  //       if (pageBody.contains('Success')) {
  //         printLog("SUCCESS----------------------");
  //         FocusScope.of(context).unfocus();
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => DashBoard()));
  //       } else if (pageBody.contains('Something went wrong')) {
  //         FocusScope.of(context).unfocus();
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => DashBoard()));
  //         commonDialog(
  //             context,
  //             "Unfortunately, the lien request cannot be executed due to technical reasons. Please try again after sometime.",
  //             0);
  //       }
  //     },
  //   );
  // }
}
