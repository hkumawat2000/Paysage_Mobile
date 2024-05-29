import 'dart:convert';

import 'package:lms/shares/LoanApplicationBloc.dart';
import 'package:lms/shares/LoanOTPVerification.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class IncreaseLimitCDialog extends StatefulWidget {
  String eligibleLoan, cartName, existingOd, fileId,stockAt;

  @override
  IncreaseLimitCDialogState createState() => new IncreaseLimitCDialogState();

  IncreaseLimitCDialog(
      this.eligibleLoan, this.cartName, this.existingOd, this.fileId,this.stockAt);
}

class IncreaseLimitCDialogState extends State<IncreaseLimitCDialog>
    with TickerProviderStateMixin {
  final loanApplicationBloc = LoanApplicationBloc();
  Preferences preferences = new Preferences();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var val1 = double.parse(widget.existingOd);
    var val2 = double.parse(widget.eligibleLoan);
    var val3 = val1 + val2;
    printLog("val3:: $val3");

    var totalProposedLimit = val3;
    return new Scaffold(
        backgroundColor: Colors.transparent,
        bottomNavigationBar: AnimatedPadding(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              height: 401,
              width: 375,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  children: <Widget>[
                    SizedBox(
                      height: 38,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 40, right: 30),
                      child: new Text(
                          "You have successfully e-Signed the new loan agreement! You are one step away from increasing your loan limit. Please confirm to request OTP from CDSL.",
                          style: TextStyle(fontSize: 16, color: colorLightGray)),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Editional \nEligible Limit",
                                  style:
                                      TextStyle(color: appTheme, fontSize: 24,fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Rs. ${widget.eligibleLoan}",
                                  style: TextStyle(
                                      color: colorGreen,
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Divider(
                              thickness: 0.5,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Existing OD Limit",
                                  style: TextStyle(
                                      color: colorLightGray, fontSize: 18),
                                ),
                                Text(
                                  "Rs,${widget.existingOd}",
                                  style:
                                      TextStyle(color: colorDarkGray, fontSize: 18),
                                )
                              ],
                            ),
                            SizedBox(
                              height: 19,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Total Proposed Limit",
                                  style: TextStyle(
                                      color: colorLightGray, fontSize: 18),
                                ),
                                Text(
                                  "Rs. ${totalProposedLimit}",
                                  style:
                                      TextStyle(color: colorDarkGray, fontSize: 18),
                                )
                              ],
                            ),
                          ],
                        )),
                    SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        IconButton(
                          icon: ArrowBackwardNavigation(),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                        Container(
                          height: 45,
                          width: 100,
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
                                pledgeOTP();
                              },
                              child: ArrowForwardNavigation(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              )),
        ));
  }

  void pledgeOTP() {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    String instrumentType = Strings.shares;
    loanApplicationBloc.pledgeOTP(instrumentType).then((value) {
      printLog("valuessss:${json.encode(value)}");
     Navigator.pop(context);
      printLog("valuerrrr:${json.encode(value)}");
      if (value.isSuccessFull!) {
        Utility.showToastMessage(Strings.success_otp_sent);
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true,
            builder: (BuildContext bc) {
              return LoanOTPVerification(widget.cartName, widget.fileId, widget.stockAt, Strings.increase_loan, "", "");
            });
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }
}
