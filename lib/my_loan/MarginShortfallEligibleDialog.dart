import 'dart:math';
import 'package:lms/shares/LoanApplicationBloc.dart';
import 'package:lms/shares/LoanOTPVerification.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'MarginShortfallPledgeOTP.dart';

class MarginShortfallEligibleDialog extends StatefulWidget {
  String cartName,fileId,pledgorBoid,loanName, loanType;
  double eligibleLoan, selectedSecuritiesValue;

  @override
  MarginShortfallEligibleDialogState createState() => new MarginShortfallEligibleDialogState();
  MarginShortfallEligibleDialog(this.eligibleLoan, this.cartName, this.fileId,this.pledgorBoid,this.loanName,this.selectedSecuritiesValue, this.loanType);
}

class MarginShortfallEligibleDialogState extends State<MarginShortfallEligibleDialog>
    with TickerProviderStateMixin {

  final loanApplicationBloc = LoanApplicationBloc();
  Preferences preferences = new Preferences();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();


  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var eligibleAmount = roundDouble(widget.eligibleLoan, 2);
    return new Scaffold(
        key: _scaffoldkey,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: AnimatedPadding(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              height: 272,
              width: 375,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 30),
                        child: widget.loanType == Strings.shares ? Text(
                         "You are about to pledge ${numberToString(widget.selectedSecuritiesValue.toStringAsFixed(2))} worth more securities to your loan account ${widget.loanName}.",
                          style: mediumTextStyle_16_gray,
                        ) : Text(
                          "You are about to lien ${numberToString(widget.selectedSecuritiesValue.toStringAsFixed(2))} worth more schemes to your loan account ${widget.loanName}.",
                          style: mediumTextStyle_16_gray,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  Strings.eligible_loan_small,
                                  style: textStyleAppThemeStyle,
                                ),
                                Text('₹'+ numberToString(eligibleAmount.toStringAsFixed(2)),
                                  style: textStyleGreenStyle,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
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
                                  color: widget.eligibleLoan == 0.0 ? colorLightGray : appTheme,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                    minWidth: MediaQuery.of(context).size.width,
                                    onPressed: () async {
                                      Utility.isNetworkConnection().then((isNetwork) {
                                        if (isNetwork) {
                                          if(widget.eligibleLoan != 0.0) {
                                            pledgeOTP();
                                          } else {
                                            Utility.showToastMessage('Eligible loan should not 0');
                                          }
                                        } else {
                                          Utility.showToastMessage(Strings.no_internet_message);
                                        }
                                      });

                                    },
                                    child: ArrowForwardNavigation(),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ]),
              )),
        ));
  }
  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }


  void pledgeOTP(){
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    String instrumentType = Strings.shares;
    loanApplicationBloc.pledgeOTP(widget.loanType).then((value){
      Navigator.pop(context);
      if(value.isSuccessFull!){
        Utility.showToastMessage(Strings.success_otp_sent);
        if(widget.loanType == Strings.shares){
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              builder: (BuildContext bc) {
                return MarginShortfallPledgeOTP(widget.cartName,widget.fileId,widget.pledgorBoid, widget.loanType);
              });
        }else{
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              builder: (BuildContext bc) {
                return LoanOTPVerification(widget.cartName,widget.fileId, "", widget.loanType, "", widget.loanName);
              });
        }
      }else{
        showErrorMessage(value.errorMessage!);
      }
    });
  }
  void showErrorMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
