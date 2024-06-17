import 'dart:io';
import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:lms/util/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreenWidget extends StatefulWidget {
  final url, fileId, isComingFor;

  WebViewScreenWidget(this.url, this.fileId, this.isComingFor);

  @override
  createState() => _WebViewScreenWidgetState(this.url);
}

class _WebViewScreenWidgetState extends State<WebViewScreenWidget> {
  var _url;
  final _key = UniqueKey();

  _WebViewScreenWidgetState(this._url);

  // void initState() {
  //   if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  //   super.initState();
  // }

  late final WebViewController controller;

  @override
  void initState() {
    super.initState();

    //late final PlatformWebViewControllerCreationParams params;
    // if (WebViewPlatform.instance is WebKitWebViewPlatform) {
    //   params = WebKitWebViewControllerCreationParams(
    //     allowsInlineMediaPlayback: true,
    //     mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
    //   );
    // } else {
    //   params = const PlatformWebViewControllerCreationParams();
    // }

    // final WebViewController controller =
    //     WebViewController.fromPlatformCreationParams(params);

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
          onPageFinished: (String url) {
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
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            } else if (request.url.endsWith("succRes.jsp")) {
              Navigator.pop(context, "success");
              return NavigationDecision.prevent;
            } else if (request.url.endsWith("failRes.jsp")) {
              Navigator.pop(context, "fail");
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(_url);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
        body: widget.fileId != "" ? getESignUrl() : getTermsOfUseUrl(),
      ),
    );
  }

  Widget getESignUrl() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              Image.asset(AssetsImagePath.app_icon, width: 37, height: 37),
              scripsNameText('E-Sign')
            ],
          ),
        ),
        Expanded(
          child: WebViewWidget(controller: controller),
          // WebView(
          //   key: _key,
          //   javascriptMode: JavascriptMode.unrestricted,
          //   initialUrl: _url,

          //   navigationDelegate: (NavigationRequest request) {
          //     if (request.url.startsWith('https://www.youtube.com/')) {
          //       return NavigationDecision.prevent;
          //     } else if (request.url.endsWith("succRes.jsp")) {
          //       Navigator.pop(context, "success");
          //       return NavigationDecision.prevent;
          //     } else if (request.url.endsWith("failRes.jsp")) {
          //       Navigator.pop(context, "fail");
          //       return NavigationDecision.prevent;
          //     }
          //     return NavigationDecision.navigate;
          //   },
          // ),
        ),
      ],
    );
  }

  Widget getTermsOfUseUrl() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 40.0),
          child: Column(
            children: <Widget>[
              Image.asset(AssetsImagePath.app_icon, width: 37, height: 37),
              scripsNameText('Terms of Use and Privacy Policy')
            ],
          ),
        ),
        Expanded(
          child: WebViewWidget(controller: controller),
          // WebView(
          //   key: _key,
          //   javascriptMode: JavascriptMode.unrestricted,
          //   initialUrl: _url,
          //   navigationDelegate: (NavigationRequest request) {
          //     if (request.url.startsWith('https://www.youtube.com/')) {
          //       return NavigationDecision.prevent;
          //     } else if (request.url.endsWith("succRes.jsp")) {
          //       Navigator.pop(context, "success");
          //       return NavigationDecision.prevent;
          //     } else if (request.url.endsWith("failRes.jsp")) {
          //       Navigator.pop(context, "fail");
          //       return NavigationDecision.prevent;
          //     }
          //     return NavigationDecision.navigate;
          //   },
          // ),
        ),
      ],
    );
  }

  Future<bool> _onBackPressed() async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            padding: const EdgeInsets.all(4.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                    "Are you sure you want to cancel ?\nYou can complete E-sign from banner on the dashboard.",
                    style: regularTextStyle_16_dark),
                SizedBox(
                  height: 16,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        // width: 100,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                              side: BorderSide(color: red)),
                          elevation: 1.0,
                          color: colorWhite,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              Navigator.pop(context);
                            },
                            child: Text(
                              Strings.cancel,
                              style: buttonTextRed,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 6),
                    Expanded(
                      child: Container(
                        height: 40,
                        // width: 100,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          elevation: 1.0,
                          color: appTheme,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              Preferences preferences = Preferences();
                              String? mobile = await preferences.getMobile();
                              String email = await preferences.getEmail();
                              // Firebase Event
                              Map<String, dynamic> parameter =
                                  new Map<String, dynamic>();
                              parameter[Strings.mobile_no] = mobile;
                              parameter[Strings.email] = email;
                              parameter[Strings.error_message] =
                                  Strings.back_pressed;
                              parameter[Strings.date_time] =
                                  getCurrentDateAndTime();
                              if (widget.isComingFor == Strings.pledge) {
                                firebaseEvent(
                                    Strings.loan_e_sign_failed, parameter);
                              } else if (widget.isComingFor ==
                                  Strings.increase_loan) {
                                firebaseEvent(
                                    Strings.increase_loan_e_sign_failed,
                                    parameter);
                              } else if (widget.isComingFor == Strings.top_up) {
                                firebaseEvent(
                                    Strings.top_up_e_sign_failed, parameter);
                              }

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          DashBoard()));
                            },
                            child: Text(
                              "Okay",
                              style: buttonTextWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
