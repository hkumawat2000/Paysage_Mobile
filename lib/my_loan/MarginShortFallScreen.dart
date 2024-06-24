
import 'package:lms/common_widgets/ResusableIcon.dart';
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/increase_loan_limit/NewIncreaseLoan.dart';
import 'package:lms/lender/LenderBloc.dart';
import 'package:lms/network/requestbean/SecuritiesRequest.dart';
import 'package:lms/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:lms/network/responsebean/SecuritiesResponseBean.dart';
import 'package:lms/payment/PaymentScreen.dart';
import 'package:lms/sell_collateral/MFInvokeScreen.dart';
import 'package:lms/sell_collateral/SellCollateralscreen.dart';
import 'package:lms/shares/LoanApplicationBloc.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../mf_increase_loan/MFIncreaseLoan.dart';
import 'MarginShortFallPledgeScreen.dart';

class MarginShortfallScreen extends StatefulWidget {
  LoanDetailData loanData;
  String pledgorBoid;
  bool isSellCollateral;
  bool isSaleTriggered;
  bool isRequestPending;
  String msg;
  String loanType;
  String schemeType;

  @override
  MarginShortfallScreenState createState() => MarginShortfallScreenState();

  MarginShortfallScreen(this.loanData, this.pledgorBoid, this.isSellCollateral, this.isSaleTriggered, this.isRequestPending, this.msg, this.loanType, this.schemeType);
}

class MarginShortfallScreenState extends State<MarginShortfallScreen> {
  final loanApplicationBloc = LoanApplicationBloc();
  List<SecuritiesListData> sharesList = [];
  // List<String>? stockAt;
  Preferences preferences = new Preferences();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<bool> selectedBoolLenderList = [];
  List<bool> selectedBoolLevelList = [];
  List<String> selectedLenderList = [];
  List<String> selectedLevelList = [];
  List<String> lenderList = [];
  List<String> levelList = [];
  List<LenderInfo> lenderInfo = [];
  final lenderBloc = LenderBloc();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: colorBg,
      appBar: AppBar(
        leading: IconButton(
          icon: ArrowToolbarBackwardNavigation(),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: colorBg,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          widget.loanData.loan!.name!,
          style: kDefaultTextStyle,
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                StockAtCart("Margin Shortfall", widget.pledgorBoid),
                marginShortFall(context,
                    widget.loanData.marginShortfall!.loanBalance,
                    widget.loanData.marginShortfall!.shortfallC,
                    widget.loanData.marginShortfall!.minimumCashAmount,
                    widget.loanData.loan!.drawingPower,
                    AssetsImagePath.business_finance,
                    colorLightRed,
                    true, widget.loanData.loan!.instrumentType!),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(widget.loanType == Strings.shares ?
                Strings.margin_shortfall_sub_heading : Strings.margin_shortfall_sub_heading_scheme,
                style: kNormalTextStyle.copyWith(height: 1.4, color: appTheme),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'What would you like to do?',
                    style: kDefaultTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: BouncingScrollPhysics(),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    GestureDetector(
                      child: ReusableIconTextContainerCard(
                        cardIcon: Image.asset(AssetsImagePath.bitcoin_red, height: 36, width: 36, color: colorGreen),
                        cardText: 'Pay Amount',
                        circleColor: colorLightGreen,
                      ),
                      onTap: () async {
                        String? mobile = await preferences.getMobile();
                        String email = await preferences.getEmail();
                        Utility.isNetworkConnection().then((isNetwork) {
                          if (isNetwork) {
                            if(!widget.isRequestPending) {
                              if(!widget.isSaleTriggered) {

                                // Firebase Event
                                Map<String, dynamic> parameter = new Map<String, dynamic>();
                                parameter[Strings.mobile_no] = mobile;
                                parameter[Strings.email] = email;
                                parameter[Strings.margin_shortfall_name] = widget.loanData.marginShortfall!.name;
                                parameter[Strings.loan_number] = widget.loanData.loan!.name;
                                parameter[Strings.margin_shortfall_status] = widget.loanData.marginShortfall!.status;
                                parameter[Strings.action_type] = 'Pay Amount';
                                parameter[Strings.date_time] = getCurrentDateAndTime();
                                firebaseEvent(Strings.margin_shortFall_action, parameter);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) => PaymentScreen(
                                            widget.loanData.loan!.name,
                                            true,
                                            widget.loanData.marginShortfall!.shortfallC,
                                            widget.loanData.marginShortfall!.minimumCollateralValue,
                                            widget.loanData.marginShortfall!.totalCollateralValue,
                                            widget.loanData.marginShortfall!.name,
                                            widget.loanData.marginShortfall!.minimumCashAmount!,0)));
                              } else {
                                commonDialog(context, Strings.sale_triggered_small, 0);
                              }
                            } else {
                              commonDialog(context, Strings.request_pending, 0);
                            }
                          } else {
                            Utility.showToastMessage(Strings.no_internet_message);
                          }
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      child: Card(
                        elevation: 1,
                        color: colorLightBlue,
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
                                'Pledge More',
                                style: subHeading
                              ),
                            ],
                          ),
                        ),
                      ),
                      onTap: () async {
                        Utility.isNetworkConnection().then((isNetwork) async {
                          if (isNetwork) {
                            if(!widget.isRequestPending) {
                              if(!widget.isSaleTriggered) {
                                String? mobile = await preferences.getMobile();
                                String email = await preferences.getEmail();
                                // Firebase Event
                                Map<String, dynamic> parameter = new Map<String, dynamic>();
                                parameter[Strings.mobile_no] = mobile;
                                parameter[Strings.email] = email;
                                parameter[Strings.margin_shortfall_name] = widget.loanData.marginShortfall!.name;
                                parameter[Strings.loan_number] = widget.loanData.loan!.name;
                                parameter[Strings.margin_shortfall_status] = widget.loanData.marginShortfall!.status;
                                parameter[Strings.action_type] = 'Pledge More';
                                parameter[Strings.date_time] = getCurrentDateAndTime();
                                firebaseEvent(Strings.margin_shortFall_action, parameter);

                                if(widget.loanType == Strings.mutual_fund){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) => MFIncreaseLoan(widget.loanData.loan!.name!,Strings.margin_shortfall, widget.loanData, widget.loanType, widget.schemeType)));
                                }else{
                                  getDetails();
                                }

                              } else {
                                commonDialog(context, Strings.sale_triggered_small, 0);
                              }
                            } else {
                              commonDialog(context, Strings.request_pending, 0);
                            }

                          } else {
                            Utility.showToastMessage(Strings.no_internet_message);
                          }
                        });
                      },
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      child: ReusableIconTextContainerCard(
                        cardIcon: Image.asset(AssetsImagePath.sell_collateral, height: 36, width: 36,color: red),
                        cardText: widget.loanType == Strings.shares ? Strings.sell : Strings.invoke,
                        circleColor: colorLightRed,
                      ),
                      onTap: () async {
                        String? mobile = await preferences.getMobile();
                        String email = await preferences.getEmail();
                        Utility.isNetworkConnection().then((isNetwork) {
                          if (isNetwork) {
                            if(!widget.isRequestPending) {
                              if(!widget.isSaleTriggered) {
                                if(!widget.isSellCollateral) {
                                  // Firebase Event
                                  Map<String, dynamic> parameter = new Map<String, dynamic>();
                                  parameter[Strings.mobile_no] = mobile;
                                  parameter[Strings.email] = email;
                                  parameter[Strings.margin_shortfall_name] = widget.loanData.marginShortfall!.name;
                                  parameter[Strings.loan_number] = widget.loanData.loan!.name;
                                  parameter[Strings.margin_shortfall_status] = widget.loanData.marginShortfall!.status;
                                  parameter[Strings.action_type] = 'Sell';
                                  parameter[Strings.date_time] = getCurrentDateAndTime();
                                  firebaseEvent(Strings.margin_shortFall_action, parameter);

                                  if(widget.loanType == Strings.shares){
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                SellCollateralScreen(widget.loanData.loan!.name!, Strings.all, "", widget.loanType)));
                                  }else{
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                MFInvokeScreen(widget.loanData.loan!.name!, Strings.all, "", "")));
                                  }
                                } else {
                                  commonDialog(context, widget.loanType == Strings.shares ? Strings.sell_collateral_request_pending : Strings.invoke_request_pending, 0);
                                }
                              } else {
                                commonDialog(context, Strings.sale_triggered_small, 0);
                              }
                            } else {
                              commonDialog(context, Strings.request_pending, 0);
                            }
                          } else {
                            Utility.showToastMessage(Strings.no_internet_message);
                          }
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: widget.isRequestPending,
              child: Column(
                children: [
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Text(
                          'Pending Process -',
                          style: kDefaultTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            commonDialog(context, widget.msg, 0);
                          },
                          child: ReusableIconTextContainerCard(
                            cardIcon: Image.asset(AssetsImagePath.history_grey, height: 36, width: 36, color: colorGreen),
                            cardText: 'Action Taken',
                            circleColor: colorLightGreen,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }

  void getDetails() async {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);

    lenderBloc.getLenders().then((value) {
      if (value.isSuccessFull!) {
        setState(() {
          selectedLenderList.clear();
          selectedLevelList.clear();
          for (int i = 0; i < value.lenderData!.length; i++) {
            lenderList.add(value.lenderData![i].name!);
            selectedLenderList.add(value.lenderData![i].name!);
            selectedBoolLenderList.add(true);
            levelList.addAll(value.lenderData![0].levels!);
            value.lenderData![0].levels!.forEach((element) {
              selectedLevelList.add(element.toString().split(" ")[1]);
              selectedBoolLevelList.add(true);
            });
          }
        });

        loanApplicationBloc.getSecurities(SecuritiesRequest(
            lender: selectedLenderList.join(","),
            level: selectedLevelList.join(","), demat: widget.pledgorBoid)).then((value) {
          Navigator.pop(context);
          if (value.isSuccessFull!) {
            sharesList = value.securityData!.securities!;
            List<SecuritiesListData> securities = [];
            for (var i = 0; i < sharesList.length; i++) {
              if (sharesList[i].isEligible == true && sharesList[i].quantity != 0
                  && sharesList[i].price != 0 && sharesList[i].stockAt == widget.pledgorBoid) {
                var temp = sharesList[i];
                // temp.quantity = temp.quantity;
                securities.add(sharesList[i]);
              }
            }
            lenderInfo.addAll(value.securityData!.lenderInfo!);
            // stockAt = List.generate(securities.length, (index) => securities[index].stockAt!).toSet().toList();
            if (securities.length != 0) {
              Navigator.push(context, MaterialPageRoute(
                builder: (BuildContext context) => NewIncreaseLoanScreen(widget.loanData.marginShortfall, Strings.margin_shortfall, securities, widget.pledgorBoid,
                  widget.loanData.loan!.name!,
                  lenderInfo,
                  lenderList,
                  levelList)));
            } else {
              commonDialog(context, Strings.not_fetch, 0);
            }
          } else if (value.errorCode == 403) {
            commonDialog(context, Strings.session_timeout, 4);
          } else if (value.errorCode == 404) {
            commonDialog(context, Strings.not_fetch, 0);
          } else {
            Utility.showToastMessage(value.errorMessage!);
          }
        });

      } else if (value.errorCode == 403) {
        Navigator.pop(context);
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Navigator.pop(context);
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }
}