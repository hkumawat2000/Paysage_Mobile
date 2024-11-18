import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/core/widgets/common_widgets.dart';
import 'package:lms/aa_getx/modules/additional_account_details/presentation/arguments/additional_account_details_arguments.dart';
import 'package:lms/aa_getx/modules/additional_account_details/presentation/controllers/additional_account_details_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class AdditionalAccountDetailsView extends GetView<AdditionalAccountDetailsController> {
  AdditionalAccountDetailsView();

  AdditionalAccountDetailsArguments arguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          if (arguments.isSkip == 2) {
            return false;
          } else {
            // commonDialog(context, "If you skip you'll redirected to dashboard", 5);
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: colorBg,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: colorBg,
            leading: arguments.isSkip == 4 || arguments.isSkip == 3
                ? IconButton(
                    icon: ArrowToolbarBackwardNavigation(),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  )
                : Container(),
            actions: [
              arguments.isSkip == 4 || arguments.isSkip == 3
                  ? Container()
                  : Material(
                      child: MaterialButton(
                        onPressed: () {
                          Get.toNamed(dashboardView);
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)),
                        elevation: 1.0,
                        child: Text("Skip",
                            style: TextStyle(color: appTheme, fontSize: 17)),
                      ),
                    )
            ],
          ),
          body: Theme(
            data: theme.copyWith(primaryColor: appTheme),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8),
                      subHeadingText(Strings.additional_account_detail_2),
                      SizedBox(height: 30),
                      TextField(
                        controller: controller.camsEmailController,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: controller.isReadOnly.value,
                        focusNode: controller.focusNode,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[a-zA-Z0-9-.@_]')),
                        ],
                        decoration: new InputDecoration(
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(color: appTheme)),
                          errorBorder: new OutlineInputBorder(
                            borderSide:
                                new BorderSide(color: Colors.red, width: 0.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            ),
                          ),
                          hintStyle: TextStyle(color: colorGrey),
                          labelStyle: TextStyle(color: appTheme),
                          hintText: Strings.cams_email,
                          labelText: Strings.cams_email,
                          errorText:
                           controller.camsEmailValidator.value ? null : Strings.enter_email,
                        ),
                        onChanged: (value) {
                          // setState(() {
                            if (controller.camsEmailController.text.isNotEmpty) {
                             controller.camsEmailValidator.value = true;
                            } else {
                             controller.camsEmailValidator.value = false;
                            }
                          // });
                        },
                        onTap: () {
                          if (controller.isReadOnly.isTrue) {
                            if (arguments.loanApplicationStatus == "Approved") {
                              Utility.showToastMessage(
                                  "Your loan account ${arguments.loanName} is active");
                            } else if (arguments.loanApplicationStatus ==
                                "Pending") {
                              Utility.showToastMessage(
                                  "You have a pending loan application");
                            }
                          }
                        },
                      ),
                      SizedBox(height: 25),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: Strings.note,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15)),
                          TextSpan(
                            text: Strings.mandatory_note_for_cams1,
                            style: regularTextStyle_14_gray_dark,
                          ),
                          TextSpan(
                              text: Strings.mandatory_note_for_cams2,
                              style: regularTextStyle_14_blue,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  if (await canLaunchUrl(Uri.parse(
                                          "https://mycams.camsonline.com/")) ==
                                      true) {
                                    launchUrl(Uri.parse( "https://mycams.camsonline.com/"));
                                  } else {
                                    printLog(Strings.cant_launch_url);
                                  }
                                }),
                          TextSpan(
                            text: Strings.mandatory_note_for_cams3,
                            style: regularTextStyle_14_gray_dark,
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: AbsorbPointer(
                          absorbing: !controller.isReadOnly.value
                              ? controller.camsEmailValidator.isTrue
                                  ? false
                                  : true
                              : true,
                          child: Container(
                            height: 45,
                            width: 100,
                            child: Material(
                              color: !controller.isReadOnly.value
                                  ? controller.camsEmailValidator.isTrue
                                      ? appTheme
                                      : colorLightGray
                                  : colorLightGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45)),
                              elevation: 1.0,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45)),
                                onPressed: () {
                                  // setState(() {
                                    if (controller.emailRegex
                                        .hasMatch(controller.camsEmailController.text)) {
                                     controller.myCamsAccountDetail(
                                         controller.camsEmailController.text);
                                    } else {
                                      //camsEmailSyntaxValidator = false;
                                      Utility.showToastMessage(
                                          Strings.message_valid_mail);
                                    }
                                  // });
                                },
                                child: Text(
                                  Strings.submit,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
