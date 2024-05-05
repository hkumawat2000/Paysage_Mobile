import 'dart:math';
import 'package:choice/shares/LoanApplicationBloc.dart';
import 'package:choice/shares/LoanOTPVerification.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Preferences.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/Utility.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/LoadingDialogWidget.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EligibleCDialog extends StatefulWidget {
  String eligibleLoan, cartName, fileId, pledgorBoid, isComingFor;

  @override
  EligibleCDialogState createState() => new EligibleCDialogState();
  EligibleCDialog(this.eligibleLoan, this.cartName, this.fileId, this.pledgorBoid, this.isComingFor);
}

class EligibleCDialogState extends State<EligibleCDialog> with TickerProviderStateMixin {
  final loanApplicationBloc = LoanApplicationBloc();
  Preferences preferences = new Preferences();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    var eligibleAmount = roundDouble(double.parse(widget.eligibleLoan), 2);
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: AnimatedPadding(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding:
        EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Text(
                    Strings.eligible_loan_bottom_sheet1,
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
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
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
                            color: appTheme,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                Utility.isNetworkConnection().then((isNetwork) {
                                  if (isNetwork) {
                                    pledgeOTP();
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
              ],
            ),
          ),
        ),
      ),
    );
  }


  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }


  void pledgeOTP() async {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    Preferences preferences = Preferences();
    String? mobile = await preferences.getMobile();
    String? email = await preferences.getEmail();
    String? instrumentType;
    if(widget.isComingFor == Strings.mutual_fund || widget.isComingFor == Strings.mf_increase_loan){
      instrumentType = Strings.mutual_fund;
    }else{
      instrumentType = Strings.shares;
    }

    loanApplicationBloc.pledgeOTP(instrumentType).then((value){
      Navigator.pop(context);
      if(value.isSuccessFull!){
        Utility.showToastMessage(Strings.success_otp_sent);
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.cart_name] = widget.cartName;
        parameter[Strings.demat_ac_no] = widget.pledgorBoid;
        parameter[Strings.eligible_loan_prm] = widget.eligibleLoan;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        if(widget.isComingFor == Strings.loan) {
          firebaseEvent(Strings.pledge_otp_sent, parameter);
        } else if(widget.isComingFor == Strings.increase_loan || widget.isComingFor == Strings.mf_increase_loan) {
          firebaseEvent(Strings.increase_loan_otp_sent, parameter);
        }
        showModalBottomSheet(
            backgroundColor: Colors.transparent,
            context: context,
            isScrollControlled: true,
            builder: (BuildContext bc) {
              return LoanOTPVerification(widget.cartName,widget.fileId,widget.pledgorBoid, widget.isComingFor, "", "");
            });
      } else if (value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else{
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
      fontSize: 16.0,
    );
  }
}
