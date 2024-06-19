import 'dart:convert';
import 'dart:ui';

import 'package:lms/all_loans_name/AllLoansNameBloc.dart';
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/increase_loan_limit/IncreaseLoanLimit.dart';
import 'package:lms/interest/InterestScreen.dart';
import 'package:lms/loan_withdraw/LoanWithdrawScreen.dart';
import 'package:lms/my_loan/ApplicationTopUpSuccess.dart';
import 'package:lms/my_loan/MarginShortFallScreen.dart';
import 'package:lms/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:lms/payment/PaymentScreen.dart';
import 'package:lms/account_statement/LoanStatement.dart';
import 'package:lms/shares/LoanApplicationBloc.dart';
import 'package:lms/shares/webviewScreen.dart';
import 'package:lms/topup/top_up_loan/SubmitTopUP.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:cron/cron.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../mf_increase_loan/MFIncreaseLoan.dart';
import 'MyLoansBloc.dart';

class SingleMyActiveLoanScreen extends StatefulWidget {
  @override
  SingleMyActiveLoanScreenState createState() => SingleMyActiveLoanScreenState();
}

class SingleMyActiveLoanScreenState extends State<SingleMyActiveLoanScreen> {
  final loanApplicationBloc = LoanApplicationBloc();
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  var fileId;
  TargetPlatform? platform;
  var drawingPower, sanctionedValue, loanBalance, baseURL;
  Loan? loans;
  MarginShortfall? marginShortfall;
  Interest? interest;
  LoanDetailData? loanDetailData;
  final myLoansBloc = MyLoansBloc();
  final allLoansNameBloc = AllLoansNameBloc();
  Preferences preferences = new Preferences();
  var now = new DateTime.now();
  bool loanDialogVisibility = true;
  var loanNumber;
  String? interestDueDate;
  int? dpdText;
  bool isLoading = true;
  bool isSellCollateral = false;
  bool isIncreaseLoan = false;
  bool isPayment = false;
  bool isMarginShortFall = false;
  bool isTimerDone = false;
  bool isActionTaken = false;
  int hours = 0, min = 0, sec = 0;
  TextEditingController topUpAmountController = TextEditingController();
  String responseText = Strings.please_wait;
  LoanDetailsResponse? loanDetailsResponse;
  int isTodayHoliday = 0;
  var cron = new Cron();
  String? loanType;
  String? schemeType;

  @override
  void initState() {
    getData();
    runClone();
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        getLoanDetails();
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
    super.initState();
  }

  runClone(){
    cron.schedule(new Schedule.parse('0 0 * * *'), () async {
      getLoanDetails();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }


  void getLoanDetails() async {
    allLoansNameBloc.allLoansName().then((value){
      if(value.isSuccessFull!){
        if(value.data != null){
          setState(() {
            loanNumber = value.data![0].name;
          });
          getSingleLoanData(loanNumber);
        } else {
          setState(() {
            responseText = Strings.no_loan;
          });
        }
      } else if (value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
        setState(() {
          responseText = Strings.session_timeout;
        });
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  void getData() async {
    var base_url = await preferences.getBaseURL();
    setState(() {
      baseURL = base_url;
    });
  }

  void getSingleLoanData(loanName) async {
    loanDetailsResponse = await myLoansBloc.getLoanDetails(loanName);
    if (loanDetailsResponse!.data!.loan != null) {
      setState(() {
        loanDetailData = loanDetailsResponse!.data;
        loans = loanDetailsResponse!.data!.loan;
        loanNumber = loanDetailsResponse!.data!.loan!.name;
        loanType = loanDetailsResponse!.data!.loan!.instrumentType;
        schemeType = loanDetailsResponse!.data!.loan!.schemeType;
        if (loanDetailsResponse!.data!.marginShortfall != null) {
          isMarginShortFall = true;
          marginShortfall = loanDetailsResponse!.data!.marginShortfall;
          if(loanDetailsResponse!.data!.marginShortfall!.deadlineInHrs != null) {
            if(loanDetailsResponse!.data!.marginShortfall!.deadlineInHrs == "00:00:00"){
              isTimerDone = true;
            }
            if(loanDetailsResponse!.data!.marginShortfall!.status == "Request Pending"){
              isActionTaken = true;
            }

            hours = int.parse(loanDetailsResponse!.data!.marginShortfall!.deadlineInHrs!.split(":")[0]);
            min = int.parse(loanDetailsResponse!.data!.marginShortfall!.deadlineInHrs!.split(":")[1]);
            sec = int.parse(loanDetailsResponse!.data!.marginShortfall!.deadlineInHrs!.split(":")[2]);
            isTodayHoliday = loanDetailsResponse!.data!.marginShortfall!.isTodayHoliday!;
          } else {
            isActionTaken = true;
            isTimerDone = true;
          }
        }
        if (loanDetailsResponse!.data!.interest != null) {
          interest = loanDetailsResponse!.data!.interest;
          interestDueDate = interest!.dueDate;
          dpdText = interest!.dpdText;
        }
        if(loanDetailsResponse!.data!.sellCollateral == null){
          isSellCollateral = true;
        } else {
          isSellCollateral = false;
        }
        if(loanDetailsResponse!.data!.increaseLoan != null){
          isIncreaseLoan = true;
        } else {
          isIncreaseLoan = false;
        }

        if(loanDetailsResponse!.data!.paymentAlreadyInProcess != null){
          isPayment = true;
        }else{
          isPayment = false;
        }
        // preferences. setDrawingPower(loanDetailsResponse!.data!.loan!.drawingPowerStr!);
        // preferences.setSanctionedLimit(loanDetailsResponse!.data!.loan!.sanctionedLimitStr!);
      });
    } else if (loanDetailsResponse!.errorCode == 403) {
      commonDialog(context, Strings.session_timeout, 4);
      setState(() {
        responseText = Strings.session_timeout;
      });
    } else {
      Utility.showToastMessage(loanDetailsResponse!.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    platform = Theme.of(context).platform;
    return Scaffold(
        key: _scaffoldkey,
      resizeToAvoidBottomInset: false,
        backgroundColor: colorBg,
        appBar: AppBar(
          backgroundColor: colorBg,
          elevation: 0,
          centerTitle: true,
          title: Text(loanNumber != null ? loanNumber : "", style: mediumTextStyle_18_gray_dark),
        ),
        body: loanDetailsResponse != null
            ? myActiveLoans()
            : Center(child: Text(responseText)),
      /* loanOpen == 1
            ? loanNumber != null
                ? loanDetailData != null
                    ? myActiveLoans(loanDetailData
                    : Center(child: Text(Strings.please_wait))
                : Center(child: Text(""))
            : Center(child: Text("Nothing here! Get your loan now!!"))*/
//        body: getMyLoansList()
    );
  }

  Widget myActiveLoans() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: <Widget>[
          activeLoanCard(),
          SizedBox(
            height: 10,
          ),
          loanOption(),
          SizedBox(
            height: 10,
          ),
          activeLoanItem(),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, top: 15),
            child: Row(
              children: <Widget>[
                scripsNameText(loanDetailData!.transactions!.length != 0 ? Strings.recent_transactions : "")
              ],
            ),
          ),
          recentTransactionList(),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget noLoan() {
    return Visibility(
      visible: loanDialogVisibility,
      child: AlertDialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
        content: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.cancel,
                      color: Colors.grey,
                      size: 20,
                    ),
                    onTap: () {
                      setState(() {
                        loanDialogVisibility = false;
                      });
                    },
                  ),
                ],
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(Strings.no_loan_found,
                      style: TextStyle(fontSize: 16.0, color: colorDarkGray)),
                ), //
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                height: 40,
                width: 100,
                child: Material(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                  elevation: 1.0,
                  color: appTheme,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {
                      setState(() {
                        loanDialogVisibility = false;
                      });
                    },
                    child: Text(
                      Strings.ok,
                      style:
                      TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget activeLoanCard() {
    drawingPower = loanDetailData!.loan!.drawingPower;
    sanctionedValue = loanDetailData!.loan!.sanctionedLimit;
    loanBalance = loanDetailData!.loan!.balance;
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: 10, right: 15, left: 15),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Column(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      color: colorLightBlue,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15.0),
                          topRight: Radius.circular(15.0)), // set rounded corner radius
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 16.0, left: 22.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: colorLightBlue,
                                  border: Border.all(color: appTheme, width: 1),
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(20.0)),
                                ),
                                child: MaterialButton(
                                  onPressed: null,
                                  child: Text(
                                    Strings.active_loan,
                                    style: mediumTextStyle_12,
                                  ),
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: Strings.loan_agreement,
                                  style: boldTextStyle_14,
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      _launchURL(loanDetailData!.loan!.loanAgreement!);
                                    },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10.0, left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subHeadingText(sanctionedValue < 0
                                  ? negativeValue(sanctionedValue)
                                  : '₹${numberToString(sanctionedValue.toStringAsFixed(2))}'),
                              // subHeadingText('₹$sanctionedValue'),
                              Padding(
                                padding: EdgeInsets.only(top: 3.0, left: 10.0),
                                child: Container(
                                  height: 40.0,
                                  width: 1.0,
                                  color: Colors.grey,
                                ),
                              ),
                              subHeadingText(drawingPower < 0
                                  ? negativeValue(drawingPower)
                                  : '₹${numberToString(drawingPower.toStringAsFixed(2))}'),
                              // subHeadingText('₹$drawingPower'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, bottom: 8.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(Strings.sanctioned_limit, style: subHeading),
                              Text(Strings.drawing_power, style: subHeading),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0, bottom: 8.0, right: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // subHeadingText('₹${numberToString(loanBalance.toStringAsFixed(2))}'),
                              Text(loanBalance < 0
                                  ? negativeValue(loanBalance)
                                  : '₹${numberToString(loanBalance.toStringAsFixed(2))}',
                                textAlign: TextAlign.center,
                                style: boldTextStyle_24.copyWith(
                                    color: loanBalance < 0 ? colorGreen : appTheme
                                ),
                              ),
                              Text(Strings.loan_balance, style: subHeading),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Text(
                                Strings.view_statement,
                                style:
                                TextStyle(fontSize: 12, fontWeight: regular, color: colorWhite),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: appTheme,
                              onPrimary: Colors.white,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0))),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) => LoanStatementScreen(loanNumber,
                                          loanDetailData!.loan!.balance, loanDetailData!.loan!.drawingPower, loanType)));
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  _launchURL(pathPDF) async {
    // String dummy = pathPDF;
    // print("pathPDF ==> $pathPDF");
    // String loan_agreementStr =  pathPDF;
    // var loan_agreementArray = loan_agreementStr.split('//');
    // var loan_agreement =loan_agreementArray[0] + "//" + loan_agreementArray[1] + "/" + loan_agreementArray[2];
    if (await canLaunch(pathPDF)) {
      await launch(pathPDF);
    } else {
      throw 'Could not launch $pathPDF';
    }
  }

  Widget loanOption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: (){
                if (loanDetailData!.loan!.balance! <= loanDetailData!.loan!.drawingPower!) {
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      if(loanDetailData!.loanRenewalIsExpired == 1 && loanDetailData!.loan!.balance! > 0){
                        commonDialog(context, "Account debit freeze\nWithdrawal disabled", 0);
                      }else{
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext contex) => LoanWithdrawScreen(loanNumber)));
                      }
                    } else {
                      Utility.showToastMessage(Strings.no_internet_message);
                    }
                  });
                } else {
                  Utility.showToastMessage(Strings.withdraw_amount_message);
                }
              },
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10.0),
                        // padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorWhite,
                        ),
                        child: Image.asset(AssetsImagePath.atm, height: 58, width: 58, fit: BoxFit.cover),
                      ),
                      Text(
                        Strings.withdraw,
                        style: subHeading
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBoxWidthWidget(10.0),
            GestureDetector(
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                  child: Column(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.all(10.0),
                        // padding: EdgeInsets.all(15.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: colorWhite,
                        ),
                        child: Image.asset(AssetsImagePath.increase_loan_icon, height: 58, width: 58, fit: BoxFit.cover),
                      ),
                      Text(
                        Strings.increase_loan,
                        style: subHeading
                      ),
                    ],
                  ),
                ),
              ),
              onTap: () {
                Utility.isNetworkConnection().then((isNetwork) {
                  if (isNetwork) {
                    if(loanType == Strings.mutual_fund){
                      if (isIncreaseLoan) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => MFIncreaseLoan(loanNumber, Strings.increase_loan, null, loanType!, schemeType!)));
                      } else {
                        commonDialog(context, Strings.increase_loan_request_pending, 0);
                      }
                    } else {
                      if(isIncreaseLoan) {
                        if(loanDetailsResponse!.data!.topUpApplication == 1){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      IncreaseLoanLimit(
                                          loanDetailData!.loan!.drawingPower,
                                          loanDetailData!.loan!.totalCollateralValue,
                                          loanDetailData!.loan!.name,
                                          loanDetailData!.loan!.drawingPowerStr,
                                          loanDetailData!.loan!.totalCollateralValueStr,
                                          loanDetailData!.pledgorBoid)));
                          printLog("loanDetailData!.pledgorBoid${loanDetailData!.pledgorBoid}");
                        }else{
                          commonDialog(context, "Your top-up application: ${loanDetailsResponse!.data!.topUpApplicationName} is pending", 0);
                        }
                      } else {
                        commonDialog(context, Strings.pending_increase_loan, 0);
                      }
                    }
                  } else {
                    Utility.showToastMessage(Strings.no_internet_message);
                  }
                });
              },
            ),
            SizedBoxWidthWidget(10.0),
            GestureDetector(
                onTap: () {
                  // if (loanDetailData!.loan!.balance == 0.0) {
                  //   paaymentDialog();
                  // } else {
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      printLog("interest${jsonEncode(interest)}");

                      if(loanDetailData!.paymentAlreadyInProcess == 0){
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext contex) =>
                                    PaymentScreen(loanNumber,
                                        // isMarginShortFall,
                                        marginShortfall != null ? marginShortfall!.status == "Pending" ? true : false : false,
                                        marginShortfall != null ? marginShortfall!.shortfallC : "",
                                        marginShortfall != null ? marginShortfall!.minimumCollateralValue : "",
                                        marginShortfall != null ? marginShortfall!.totalCollateralValue : "",
                                        marginShortfall != null
                                            && marginShortfall!.status != "Sell Triggered"
                                            && marginShortfall!.status != "Request Pending" ? marginShortfall!.name : "",
                                        marginShortfall != null ? marginShortfall!.minimumCashAmount! : 0.0, interest != null ? 1: 0)));
                      }else{
                        commonDialog(context, Strings.pending_payment, 0);
                      }

                    } else {
                      Utility.showToastMessage(Strings.no_internet_message);
                    }
                  });
                  // }
                },
                child: Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.all(10.0),
                          // padding: EdgeInsets.all(15.0),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: colorWhite,
                          ),
                          child: Image.asset(AssetsImagePath.pay_now, height: 58, width: 58, fit: BoxFit.cover),
                        ),
                        Text(
                          Strings.pay_now,
                          style: subHeading
                        ),
                      ],
                    ),
                  ),
                ),
            ),
          ],
        ),
      ),
    );
  }

  Widget activeLoanItem() {
    return Column(
      children: <Widget>[
        loanDetailData!.topUp != null
            ? Padding(
                padding:
                    const EdgeInsets.only(top: 15.0, left: 12.0, right: 12.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(
                              Strings.top_up_message,
                              style: TextStyle(
                                  color: appTheme,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Card(
                      elevation: 3,
                      child: Container(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 3.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 10,
                                color: Colors.white,
                                offset: Offset(1, 3))
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: colorLightYellow,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(8.0)),
                                // set rounded corner radius
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.white,
                                      offset: Offset(1, 3))
                                ], // make rounded corner of border
                              ),
                              child: Image.asset(
                                AssetsImagePath.top_up_icon,
                                height: 40.04,
                                width: 40.2,
                              ),
                            ),
                            SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  mediumHeadingText(Strings.available_top),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      subHeadingText(loanDetailData!.topUp! < 0
                                          ? negativeValue(
                                              loanDetailData!.topUp!)
                                          : '₹${numberToString(loanDetailData!.topUp!.toStringAsFixed(2))}'),
                                      // subHeadingText('₹${numberToString(loanDetailData!.topUp!.toStringAsFixed(2))}'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: appTheme,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () {
                                Utility.isNetworkConnection().then((isNetwork) {
                                  if (isNetwork) {
                                    if (loanDetailsResponse!
                                            .data!.increaseLoan ==
                                        1) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  SubmitTopUP(
                                                      loanDetailData!.topUp,
                                                      loanNumber)));
                                    } else {
                                      commonDialog(
                                          context,
                                          "Your increase loan application: ${loanDetailsResponse!.data!.increaseLoanName.toString()} is pending",
                                          0);
                                    }
                                  } else {
                                    Utility.showToastMessage(
                                        Strings.no_internet_message);
                                  }
                                });
                              },
                              child: Text(
                                Strings.add_top_up,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
        loanDetailData!.loan!.totalCollateralValue != null
            ? Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 12.0),
          child: Row(
            children: <Widget>[
              Flexible(
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 3.0),
                      // set border width
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      // set rounded corner radius
                      boxShadow: [
                        BoxShadow(blurRadius: 10, color: Colors.white, offset: Offset(1, 3))
                      ], // make rounded corner of border
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              padding: EdgeInsets.all(10.0),
                              decoration: BoxDecoration(
                                color: colorLightGreen,
                                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                // set rounded corner radius
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      color: Colors.white,
                                      offset: Offset(1, 3))
                                ], // make rounded corner of border
                              ),
                              child: Image.asset(
                                AssetsImagePath.bitcoin_green,
                                height: 35.04,
                                width: 35.2,
                              ),
                            ),
                            SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                mediumHeadingText(Strings.collateral_value),
                                SizedBox(
                                  height: 5,
                                ),
                                subHeadingText(loanDetailData!.loan!.totalCollateralValue! < 0
                                    ? negativeValue(loanDetailData!.loan!.totalCollateralValue!)
                                    : '₹${numberToString(loanDetailData!.loan!.totalCollateralValue!.toStringAsFixed(2))}'),
                                // subHeadingText('₹${loanDetailData!.loan!.totalCollateralValueStr}'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        )
            : Container(),
        interest != null && interest!.totalInterestAmt != 0
            ? Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Card(
                        elevation: 3,
                        child: Container(
                          padding: const EdgeInsets.only(left: 10, right: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white, width: 3.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.white,
                                  offset: Offset(1, 3))
                            ],
                          ),
                          child: Row(
                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.symmetric(vertical: 10.0),
                                // padding: EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  color: colorLightRed,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8.0)),
                                  boxShadow: [
                                    BoxShadow(
                                        blurRadius: 10,
                                        color: Colors.white,
                                        offset: Offset(1, 3))
                                  ],
                                ),
                                child: Image.asset(
                                  AssetsImagePath.pay_now,
                                  height: 56,
                                  width: 56,
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        mediumHeadingText(Strings.interest_due),
                                        SizedBox(width: 10),
                                        GestureDetector(
                                          child: Image.asset(
                                              AssetsImagePath.info,
                                              height: 12,
                                              width: 12),
                                          onTap: () {
                                            commonDialog(
                                                context, interest!.infoMsg, 0);
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    subHeadingText(interest!.totalInterestAmt !=
                                            null
                                        ? interest!.totalInterestAmt! < 0
                                            ? negativeValue(
                                                interest!.totalInterestAmt!)
                                            : '₹${numberToString(interest!.totalInterestAmt!.toStringAsFixed(2))}'
                                        : ""),
                                    // subHeadingText(interest!.totalInterestAmt != null
                                    //     ? '₹${numberToString(interest!.totalInterestAmt!.toStringAsFixed(2))}'
                                    //     : ""),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        mediumHeadingText("Days Past Due - "),
                                        Text(
                                          "$dpdText",
                                          style: TextStyle(
                                              color: appTheme,
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                children: <Widget>[
                                  // FittedBox(
                                  //     fit: BoxFit.fitWidth,
                                  //     child: Text("${interestDueDate}",
                                  //         style: TextStyle(fontSize: 10))),
                                  SizedBox(
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    InterestScreen(
                                                        interest!
                                                            .totalInterestAmt!,
                                                        loanDetailData!
                                                            .loan!.name!,
                                                        loanDetailData!
                                                            .loan!.balance!,
                                                        interestDueDate!)));
                                      },
                                      child: FittedBox(
                                        fit: BoxFit.fitWidth,
                                        child: Text(
                                          Strings.pay_now,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: colorWhite,
                                              fontWeight: semiBold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container(),
        marginShortfall != null
            ? Padding(
                padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.white, width: 3.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 10,
                            color: Colors.white,
                            offset: Offset(1, 3))
                      ], // make rounded corner of border
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10.0),
                          padding: EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: colorLightRed,
                            borderRadius:
                                BorderRadius.all(Radius.circular(8.0)),
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 10,
                                  color: Colors.white,
                                  offset: Offset(1, 3))
                            ], // make rounded corner of border
                          ),
                          child: Image.asset(
                            AssetsImagePath.business_finance,
                            height: 35.04,
                            width: 35.2,
                            color: red,
                          ),
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: [
                                  mediumHeadingText(Strings.margin_shortfall),
                                  SizedBox(width: 05),
                                  GestureDetector(
                                    child: Image.asset(AssetsImagePath.info,
                                        height: 12, width: 12),
                                    onTap: () {
                                      printLog(
                                          "shortfall__${jsonEncode(marginShortfall)}");
                                      showModalBottomSheet(
                                          backgroundColor: Colors.transparent,
                                          context: context,
                                          isScrollControlled: true,
                                          builder: (BuildContext bc) {
                                            return marginShortfallInfo(
                                                context,
                                                marginShortfall!.loanBalance,
                                                marginShortfall!
                                                    .minimumCashAmount,
                                                drawingPower,
                                                marginShortfall!.shortfallC,
                                                loanType);
                                          });
                                    },
                                  )
                                ],
                              ),
                              SizedBox(height: 5),
                              subHeadingText(marginShortfall!
                                          .minimumCashAmount! <
                                      0
                                  ? negativeValue(
                                      marginShortfall!.minimumCashAmount!)
                                  : '₹${numberToString(marginShortfall!.minimumCashAmount!.toStringAsFixed(2))}'),
                            ],
                          ),
                        ),
                        Column(children: [
                          isActionTaken
                              ? SizedBox()
                              : Container(
                                  width: 75,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: appTheme,
                                      ),
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(6))),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.0),
                                    child: Column(
                                      children: [
                                        !isTimerDone
                                            ? isTodayHoliday == 1
                                                ? Column(children: [
                                                    Text(Strings.time_remaining,
                                                        style: TextStyle(
                                                            fontSize: 9,
                                                            color:
                                                                Colors.indigo)),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 5),
                                                        child: Text(
                                                            '${marginShortfall!.deadlineInHrs}',
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .red))),
                                                  ])
                                                : TweenAnimationBuilder<
                                                        Duration>(
                                                    duration: Duration(
                                                        hours: hours,
                                                        minutes: min,
                                                        seconds: sec),
                                                    tween: Tween(
                                                        begin: Duration(
                                                            hours: hours,
                                                            minutes: min,
                                                            seconds: sec),
                                                        end: Duration.zero),
                                                    onEnd: () {
                                                      setState(() {
                                                        isTimerDone = true;
                                                      });
                                                    },
                                                    builder:
                                                        (BuildContext context,
                                                            Duration? value,
                                                            Widget? child) {
                                                      final hours =
                                                          (value!.inHours)
                                                              .toString();
                                                      final minutes =
                                                          (value.inMinutes % 60)
                                                              .toString()
                                                              .padLeft(2, '0');
                                                      final seconds =
                                                          (value.inSeconds % 60)
                                                              .toString()
                                                              .padLeft(2, '0');
                                                      String hour = '';
                                                      if (hours == '0') {
                                                        hour = '';
                                                      } else {
                                                        hour = '$hours:';
                                                      }
                                                      return Column(
                                                        children: [
                                                          Text(
                                                              Strings
                                                                  .time_remaining,
                                                              style: TextStyle(
                                                                  fontSize: 8,
                                                                  color: Colors
                                                                      .indigo)),
                                                          Padding(
                                                              padding: const EdgeInsets
                                                                  .symmetric(
                                                                  vertical: 5),
                                                              child: Text(
                                                                  '$hour$minutes:$seconds',
                                                                  textAlign:
                                                                      TextAlign
                                                                          .center,
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          12,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: Colors
                                                                          .red))),
                                                        ],
                                                      );
                                                    })
                                            : Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 5),
                                                child: Text(
                                                    Strings.sale_triggered,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                        color: red,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 11)),
                                              ),
                                      ],
                                    ),
                                  ),
                                ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: appTheme,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            onPressed: () async {
                              String? mobile = await preferences.getMobile();
                              String email = await preferences.getEmail();

                            // Firebase Event
                            Map<String, dynamic> parameter = new Map<String, dynamic>();
                            parameter[Strings.mobile_no] = mobile;
                            parameter[Strings.email] = email;
                            parameter[Strings.margin_shortfall_name] = marginShortfall!.name;
                            parameter[Strings.loan_number] = loanDetailData!.loan!.name;
                            parameter[Strings.margin_shortfall_status] = marginShortfall!.status;
                            parameter[Strings.date_time] = getCurrentDateAndTime();
                            firebaseEvent(Strings.margin_shortFall_click, parameter);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          MarginShortfallScreen(
                                              loanDetailData!,
                                              loanDetailData!.pledgorBoid!,
                                              isSellCollateral,
                                              isTimerDone,
                                              marginShortfall!.status ==
                                                      "Request Pending"
                                                  ? true
                                                  : false,
                                              marginShortfall!.actionTakenMsg ??
                                                  "",
                                              loanType!,
                                              schemeType!)));
                            },
                            child: Text(
                              marginShortfall!.status == "Request Pending"
                                  ? "Action Taken"
                                  : Strings.take_action,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: colorWhite,
                                  fontWeight: semiBold),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget recentTransactionList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: loanDetailData!.transactions!.length,
      itemBuilder: (context, index) {
        return recentTransactionItem(loanDetailData!.transactions!, index);
      },
    );
  }

  Widget recentTransactionItem(List<Transactions> transactionList, index) {
    var displayDate = transactionList[index].time;
    var displayDateFormatter = new DateFormat.yMMMd();
    var date = DateTime.parse(displayDate!);
    String formattedDate = displayDateFormatter.format(date);
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, right: 12.0),
      child: Row(
        children: <Widget>[
          Flexible(
            child: Card(
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              color: colorWhite,
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            formattedDate,
                            style: semiBoldTextStyle_18,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          mediumHeadingText(transactionList[index].transactionType)
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Flexible(
                            // child: Text('₹${transactionList[index].amount.toString()}',
                            //     style: extraBoldTextStyle_18_gray_dark),
                            child: Text(double.parse(transactionList[index].amount.toString().replaceAll(",", "")) < 0
                                ? negativeValue(double.parse(transactionList[index].amount.toString().replaceAll(",", "")))
                                : '₹${transactionList[index].amount.toString()}',
                                style: extraBoldTextStyle_18_gray_dark),
                          ),
                          SizedBox(width: 5),

                          Container(
                              alignment: Alignment.center,
                              height: 26,
                              width: 26,
                              padding: EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: transactionList[index].recordType.toString() == "DR"
                                    ? colorLightRed
                                    : colorLightGreen,
                              ),
                              child: Text(transactionList[index].recordType!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: semiBold,
                                      color: transactionList[index].recordType.toString() == "DR"
                                          ? red
                                          : colorGreen))),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  termsCondition(BuildContext context, GlobalKey<ScaffoldState> _scaffoldkey) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    child: Icon(
                      Icons.close,
                      color: Colors.grey,
                      size: 23,
                    ),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shrinkWrap: true,
                  children: <Widget>[
                    Text(Strings.terms_condition,
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(color: appTheme, fontSize: 20, fontWeight: FontWeight.bold)),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new Text(Strings.terms1,
                            style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600))),
                    Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: new Text(Strings.terms2,
                            style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600))),
                    Padding(
                        padding: const EdgeInsets.all(10),
                        child: new Text(Strings.terms3,
                            style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600))),
                    CheckboxListTile(
                      controlAffinity: ListTileControlAffinity.leading,
                      checkColor: Colors.white,
                      activeColor: appTheme,
                      title: Text(Strings.accept_terms_condition,
                          style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600)),
                      value: true,
                      onChanged: (val) {},
                    )
                  ],
                ),
              ),
              Container(
                height: 40,
                width: 100,
                child: Material(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                  elevation: 1.0,
                  color: appTheme,
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          eSignVerification();
                        } else {
                          showSnackBar(_scaffoldkey);
                        }
                      });
                    },
                    child: Text(
                      Strings.accept,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void eSignVerification() {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    loanApplicationBloc.esignVerification(loans!.name).then((value) async {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        Utility.showToastMessage(value.message!);
        eSignProcess(value, value.data!.fileId!);
      } else if (value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      }
    });
  }

  eSignProcess(value, fileId) async {
    String result = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => WebViewScreenWidget(value.message.data.esignUrl, fileId, "")));
    if (result == Strings.success) {
      Navigator.pop(context);
      _showSuccessDialog(value, fileId);
    } else if (result == Strings.fail) {
      Navigator.pop(context);
      _showFailDialog(value);
    } else if (result == Strings.cancel) {
      Navigator.pop(context);
      _showCancelDialog(value);
    } else {
      Utility.showToastMessage(value.message.message);
    }
  }

  Future<void> _showCancelDialog(value) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.e_sign_cancelled),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(Strings.e_sign_cancelled),
                Text(Strings.try_again),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Strings.no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(Strings.ok),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showSuccessDialog(value, fileId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.e_sign_successful),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(''),
                Text(''),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Strings.ok),
              onPressed: () {
                Navigator.pop(context);
                createTopUp();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showFailDialog(value) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(Strings.e_sign_failed),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(Strings.e_sign_failed),
                Text(Strings.try_again),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(Strings.no),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(Strings.yes),
              onPressed: () {
                Navigator.pop(context);
                eSignProcess(value, fileId);
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> withdrawalDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorWhite,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(Strings.withdraw_exhausted,
                        style: TextStyle(fontSize: 16.0, color: colorDarkGray)),
                  ), //
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 100,
                  child: Material(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 1.0,
                    color: appTheme,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text(
                        Strings.ok,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> paaymentDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorWhite,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(Strings.payable_message,
                        style: TextStyle(fontSize: 16.0, color: colorDarkGray)),
                  ), //
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 100,
                  child: Material(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 1.0,
                    color: appTheme,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text(
                        Strings.ok,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget topupAction(TopUp topUp) {
    return new Scaffold(
      backgroundColor: Colors.transparent,
      bottomNavigationBar: AnimatedPadding(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          height: 250,
          width: 375,
          decoration: new BoxDecoration(
            color: colorWhite,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(25.0),
              topRight: const Radius.circular(25.0),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: TextField(
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(counterText: ""),
                    maxLength: 10,
                    controller: topUpAmountController,
                    keyboardType: TextInputType.number,
                    cursorColor: appTheme,
                    style: TextStyle(
                      color: colorDarkGray,
                      fontSize: 18,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  height: 45,
                  width: 100,
                  child: Material(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 1.0,
                    color: appTheme,
                    child: MaterialButton(
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        Navigator.pop(context);
                        termsCondition(context, _scaffoldkey);
                      },
                      child: Text(
                        "Proceed",
                        style:
                        TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold),
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
    );
  }

  void createTopUp() {
    loanApplicationBloc.createTopUp(loans!.name, fileId).then((value) {
      if (value.isSuccessFull!) {
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => ApplicationTopUpSuccess()));
      } else if (value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }
}
