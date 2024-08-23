import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/webview/presentation/arguments/common_webview_arguments.dart';

class HelpFaqSettingsMenuView extends StatefulWidget {
  const HelpFaqSettingsMenuView({super.key});

  @override
  State<HelpFaqSettingsMenuView> createState() => _HelpFaqSettingsMenuViewState();
}

class _HelpFaqSettingsMenuViewState extends State<HelpFaqSettingsMenuView> {
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
                Get.toNamed(
                  commonWebview,
                  arguments: CommonWebviewArguments(
                    redirectionNumber: 2,
                    title: Strings.privacy_policy,
                  ),
                );
              } else {
                Utility.showToastMessage(Strings.no_internet_message);
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
                Get.toNamed(
                  commonWebview,
                  arguments: CommonWebviewArguments(
                    redirectionNumber: 3,
                    title: Strings.terms_of_use,
                  ),
                );
              } else {
                Utility.showToastMessage(Strings.no_internet_message);
              }
            });
          },
        ),
      ],
    );
  }
}
