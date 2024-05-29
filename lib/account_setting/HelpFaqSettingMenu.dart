import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/webview/CommonWebViewScreen.dart';
import 'package:flutter/material.dart';

class HelpFaqSettingMenu extends StatefulWidget {
  const HelpFaqSettingMenu({Key? key}) : super(key: key);

  @override
  _HelpFaqSettingMenuState createState() => _HelpFaqSettingMenuState();
}

class _HelpFaqSettingMenuState extends State<HelpFaqSettingMenu> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(color: colorGrey),
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image(
                  image: AssetImage(AssetsImagePath.privacy_policy),
                  width: 23,
                  height: 23,
                  color: colorGreen,
                ),
                SizedBox(width: 10),
                Text(Strings.privacy_policy,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          onTap: () {
            Utility.isNetworkConnection().then((isNetwork) {
              if (isNetwork) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  // redirect user to webview screen
                            CommonWebViewScreen(
                                2, Strings.privacy_policy)));
              } else {
                Utility.showToastMessage(
                    Strings.no_internet_message);
              }
            });
          },
        ),
        Divider(color: colorGrey),
        GestureDetector(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Image(
                  image: AssetImage(AssetsImagePath.terms_of_use),
                  width: 23,
                  height: 23,
                  color: colorGreen,
                ),
                SizedBox(width: 10),
                Text(Strings.terms_of_use,
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          onTap: () {
            Utility.isNetworkConnection().then((isNetwork) {
              if (isNetwork) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>   // redirect user to Webview Screen
                            CommonWebViewScreen(
                                3, Strings.terms_of_use)));
              } else {
                Utility.showToastMessage(
                    Strings.no_internet_message);
              }
            });
          },
        ),
      ],
    );
  }
}
