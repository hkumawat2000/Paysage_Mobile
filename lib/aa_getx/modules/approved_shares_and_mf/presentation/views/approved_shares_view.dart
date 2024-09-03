import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/approved_shares_and_mf/presentation/controllers/approved_shares_controller.dart';

class ApprovedSharesView extends GetView<ApprovedSharesController> {
  ApprovedSharesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: colorBg,
      body: Column(
        children: <Widget>[
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              IconButton(
                icon: ArrowToolbarBackwardNavigation(),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    headingText(Strings.pledge_securities),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        Strings.pledge_securities_sub_heading,
                        style: mediumTextStyle_16_gray,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: appTheme,
                          ),
                          width: 157,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 30.95, left: 20),
                                  child: Image.asset(
                                    AssetsImagePath.shares,
                                    width: 34.57,
                                    height: 52.51,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 20.0),
                                  child: Text(
                                    Strings.shares,
                                    style: extraBoldTextStyle_18_white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          controller.onSharesClick();
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: red,
                          ),
                          width: 157,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 34.0, left: 21.02),
                                  child: Image.asset(
                                    AssetsImagePath.mutual_fund,
                                    width: 48,
                                    height: 48.01,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, bottom: 20.0),
                                  child: Text(
                                    Strings.mutual_fund,
                                    style: extraBoldTextStyle_18_white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        onTap: () {
                          controller.onMutualFundClick();
                        },
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50),
                RichText(
                  text: TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        controller.handleClickForApprovedShares();
                      },
                    text: Strings.click_here,
                    style: TextStyle(color: Colors.blue),
                    children: [
                      TextSpan(
                        text: Strings.approved_text,
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
