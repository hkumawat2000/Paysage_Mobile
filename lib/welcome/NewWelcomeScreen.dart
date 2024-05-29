import 'package:lms/complete_kyc/CompleteKYCScreen.dart';
import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';

class RegistrationSuccessfulScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return RegistrationSuccessfulScreenState();
  }
}

class RegistrationSuccessfulScreenState extends State<RegistrationSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
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
                        Strings.get_sparked,
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
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (BuildContext context) => DashBoard()));
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
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                            elevation: 1.0,
                            color: appTheme,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => CompleteKYCScreen()));
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

  Future<bool> _onBackPressed() async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) => onBackPressDialog(1, Strings.exit_app),
    ) ?? false;
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
            borderRadius: BorderRadius.all(Radius.circular(30.0)), // set rounded corner radius
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
