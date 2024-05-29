import 'dart:io';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Utility.dart';
import 'package:flutter/material.dart';
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class TermsConditionWebView extends StatefulWidget {
  String url;
  bool isForPrivacyPolity;
  String isComingFor;

  TermsConditionWebView(this.url, this.isForPrivacyPolity, this.isComingFor);

  @override
  State<StatefulWidget> createState() {
    return TermsConditionWebViewScreenState();
  }
}

class TermsConditionWebViewScreenState extends State<TermsConditionWebView> {
  var connectivity = true;
  PDFDocument? document;
  Preferences preferences = Preferences();
  String? privacyURL;

  @override
  void initState() {
    checkNetwork();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    super.initState();
  }

  void checkNetwork() async {
    var network = await Utility.isNetworkConnection();
    String url = await preferences.getPrivacyPolicyUrl();
    document = await PDFDocument.fromURL(widget.isForPrivacyPolity ? url : widget.url);
    setState(() {
      connectivity = network;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: Column(
        children: [
          SizedBox(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                icon: ArrowToolbarBackwardNavigation(),
                onPressed: () => Navigator.pop(context),
              ),
              Expanded(
                child: Center(
                  child: scripsNameText(widget.isComingFor)
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(4, 8, 4, 4),
                child: Image.asset(AssetsImagePath.app_icon, width: 37, height: 37),
              )
            ],
          ),
          Expanded(
            child: Container(
              child: widget.url != null
                  ? document != null
                    ? PDFViewer(document: document!, zoomSteps: 1, scrollDirection: Axis.vertical)
                    : Center(child: CircularProgressIndicator())
                  : Center(child: Text("No Data"))
            ),
          ),
        ],
      ),
    );
  }
}
