import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';

class RegistrationSuccessfulView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (_) => OnBackPress.onBackPressDialog(1, Strings.exit_app),
      child: Scaffold(
        backgroundColor: colorBg,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 40.0),
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        Strings.get_lms,
                        style: extraBoldTextStyle_28,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image(
                    image: AssetImage(AssetsImagePath.tutorial_4),
                    width: 230,
                    height: 230,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 3.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(
                        Radius.circular(20.0),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: 12),
                        Text(
                          Strings.get_instant_loan,
                          style: extraBoldTextStyle_24,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            Strings.steps_to_complete_process,
                            style: mediumTextStyle_14_gray,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        ReusableLoanProcessListTile(
                          bulletNumber: '1',
                          listContent: Strings.loan_step1,
                        ),
                        ReusableLoanProcessListTile(
                          bulletNumber: '2',
                          listContent: Strings.loan_step2,
                        ),
                        ReusableLoanProcessListTile(
                          bulletNumber: '3',
                          listContent: Strings.loan_step3,
                        ),
                        ReusableLoanProcessListTile(
                          bulletNumber: '4',
                          listContent: Strings.loan_step4,
                        ),
                        SizedBox(height: 12),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 28.0,
                  ),
                  Row(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          height: 45,
                          // width: 140,
                          child: Material(
                            color: colorBg,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35),
                                side: BorderSide(color: red)),
                            elevation: 1.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  side: BorderSide(color: red)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                ///todo: DashBoard with toNamed after page is created and convert following code in getx
                                // Navigator.push(context, MaterialPageRoute(
                                //     builder: (BuildContext context) => DashBoard()));
                              },
                              child: Text(
                                Strings.home,
                                style: buttonTextRed,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 45,
                          // width: 140,
                          child: Material(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35)),
                            elevation: 1.0,
                            color: appTheme,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                Get.toNamed(kycView);
                              },
                              child: Text(
                                Strings.add_kyc,
                                style: buttonTextWhite,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ReusableLoanProcessListTile extends StatelessWidget {
  final String? bulletNumber;
  final String? listContent;

  ReusableLoanProcessListTile({this.bulletNumber, this.listContent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: ListTile(
        leading: Container(
          decoration: BoxDecoration(
            color: colorWhite,
            border: Border.all(color: appTheme, width: 1.0), // set border width
            borderRadius: BorderRadius.all(
                Radius.circular(30.0)), // set rounded corner radius
          ),
          child: CircleAvatar(
            radius: 12.0,
            backgroundColor: colorWhite,
            child: Text(
              bulletNumber!,
              style: boldTextStyle_14,
            ),
          ),
        ),
        title: Text(
          listContent!,
          style: mediumTextStyle_18_gray_dark,
        ),
      ),
    );
  }
}
