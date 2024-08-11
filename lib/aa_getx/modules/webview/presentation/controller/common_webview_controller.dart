import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/modules/webview/presentation/arguments/common_webview_arguments.dart';
import 'package:lms/util/Preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CommonWebviewController extends GetxController {
  CommonWebviewController();

  RxString url = "".obs;
  RxString title = "".obs;
  RxString baseUrlString = "".obs;

  WebViewController? mycontroller;
  late final WebViewController controller;

  Preferences preferences = Preferences();
  UniqueKey _key = UniqueKey();

  CommonWebviewArguments commonWebviewArguments = Get.arguments;

  @override
  void onInit() {
    // TODO: implement onInit
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
              mycontroller!.reload();
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
      ..loadRequest(Uri.parse(url.value ??
          "https://play.google.com/store/apps/details?id=com.choiceequitybroking.jiffy"));
    super.onInit();
  }

  Future<void> getData() async {
    String? baseUrl = await preferences.getBaseURL();
    baseUrlString.value = baseUrl!;
  }

  Future<void> getURL() async {
    if (commonWebviewArguments.redirectionNumber == 1) {
      url.value = baseUrlString! + 'help?webview';
    } else if (commonWebviewArguments.redirectionNumber == 2) {
      url.value = baseUrlString! + 'privacy-policy?webview';
    } else if (commonWebviewArguments.redirectionNumber == 3) {
      url.value = baseUrlString! + 'terms-of-use?webview';
    } else {
      url.value =
          "https://play.google.com/store/apps/details?id=com.choiceequitybroking.jiffy";
    }
  }

  Future<bool> willPopCallback() async {
    Get.back(result: "cancel",canPop: true);
    return true;
  }

  _launchURL(Uri pathURL) async {
  if (await canLaunchUrl(pathURL)) {
    await launchUrl(pathURL);
  } else {
    throw 'Could not launch $pathURL';
  }
}
}
