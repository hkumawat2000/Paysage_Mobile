import 'package:lms/all_loans_name/AllLoansNameBloc.dart';
import 'package:lms/common_widgets/ResusableIcon.dart';
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/increase_loan_limit/IncreaseLoanLimit.dart';
import 'package:lms/my_loan/MyLoansBloc.dart';
import 'package:lms/network/requestbean/SellCollateralRequestBean.dart';
import 'package:lms/network/requestbean/UnpledgeRequestBean.dart';
import 'package:lms/network/responsebean/MyPledgedSecuritiesDetailsRespones.dart';
import 'package:lms/pledged_securities/MyPledgedSecuritiesBloc.dart';
import 'package:lms/sell_collateral/MFInvokeScreen.dart';
import 'package:lms/sell_collateral/SellCollateralBloc.dart';
import 'package:lms/sell_collateral/SellCollateralscreen.dart';
import 'package:lms/pledged_securities/MyPledgeTransactionsScreen.dart';
import 'package:lms/unpledge/MFRevokeScreen.dart';
import 'package:lms/unpledge/UnpledgeBloc.dart';
import 'package:lms/unpledge/UnpledgeSharescreen.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../mf_increase_loan/MFIncreaseLoan.dart';
import '../network/responsebean/AuthResponse/LoanDetailsResponse.dart';

class MyPledgeSecurityScreen extends StatefulWidget {
  @override
  MyPledgeSecurityScreenState createState() => MyPledgeSecurityScreenState();

}

class MyPledgeSecurityScreenState extends State<MyPledgeSecurityScreen> {
  // bool pressDown = false;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final myPledgedSecuritiesBloc = MyPledgedSecuritiesBloc();
  final allLoansNameBloc = AllLoansNameBloc();
  final sellCollateralBloc = SellCollateralBloc();
  final unpledgeBloc = UnpledgeBloc();
  final myLoansBloc = MyLoansBloc();
  var loanName, totalValue, drawingPower, selectedScrips, loanBalance;
  String responseText = Strings.please_wait;
  MyPledgedSecuritiesDetailsRespones? pledgedResponse;
  List<AllPledgedSecurities> allPledgedSecurities = [];
  List<bool> pressDownList = [];
  List<SellList> sellList = [];
  List<UnPledgeList> unPledgeList = [];
  bool isIncreaseLoan = false;
  bool isUnpledge = false;
  bool isSellCollateral = false;
  bool isSellTriggered = false;
  var unPledgeMarginShortFallMsg;
  String? loanType;
  String? schemeType;

  @override
  void initState() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        getAllLoansName();
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getAllLoansName() async{
    allLoansNameBloc.allLoansName().then((value){
      if(value.isSuccessFull!){
        if(value.data != null){
          setState(() {
            loanName = value.data![0].name;
          });
          getMyPledgedSecuritiesDetails(loanName);
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

  getMyPledgedSecuritiesDetails(loan_name) async {
    pledgedResponse = await myPledgedSecuritiesBloc.myPledgedSecuritiesDetails(loan_name);
    if(pledgedResponse!.isSuccessFull!){
      setState(() {
        loanType = pledgedResponse!.data!.instrumentType;
        schemeType = pledgedResponse!.data!.schemeType;
        totalValue = pledgedResponse!.data!.totalValue!;
        selectedScrips = pledgedResponse!.data!.numberOfScrips.toString();
        drawingPower = pledgedResponse!.data!.drawingPower;
        loanBalance = pledgedResponse!.data!.balance;
        // allPledgedSecurities = pledgedResponse.data.allPledgedSecurities;

        for(int i=0; i< pledgedResponse!.data!.allPledgedSecurities!.length; i++){
          if(pledgedResponse!.data!.instrumentType == Strings.shares) {
            if (pledgedResponse!.data!.allPledgedSecurities![i].pledgedQuantity!.toInt() != 0) {
              allPledgedSecurities.add(pledgedResponse!.data!.allPledgedSecurities![i]);
            }
          } else {
            if (pledgedResponse!.data!.allPledgedSecurities![i].pledgedQuantity! >= 0.001) {
              allPledgedSecurities.add(pledgedResponse!.data!.allPledgedSecurities![i]);
            }
          }
        }

        selectedScrips = allPledgedSecurities.length.toString();

        if(pledgedResponse!.data!.increaseLoan != null){
          isIncreaseLoan = true;
        } else {
          isIncreaseLoan = false;
        }

        if(pledgedResponse!.data!.unpledge != null){
          isUnpledge = true;
          if(pledgedResponse!.data!.unpledge!.unpledgeMsgWhileMarginShortfall != null) {
            unPledgeMarginShortFallMsg = pledgedResponse!.data!.unpledge!.unpledgeMsgWhileMarginShortfall;
          }
        } else {
          isUnpledge = false;
        }

        if(pledgedResponse!.data!.sellCollateral != null){
          isSellCollateral = true;
        } else {
          isSellCollateral = false;
        }
        if(pledgedResponse!.data!.isSellTriggered == 1){
          isSellTriggered = true;
        } else {
          isSellTriggered = false;
        }

      });
    } else if (pledgedResponse!.errorCode == 403) {
      commonDialog(context, Strings.session_timeout, 4);
      setState(() {
        responseText = Strings.session_timeout;
      });
    } else {
      Utility.showToastMessage(pledgedResponse!.errorMessage!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBg,
      appBar: AppBar(
        backgroundColor: colorBg,
        elevation: 0,
        centerTitle: true,
        title: Text(loanName != null ? loanName : "", style: mediumTextStyle_18_gray_dark),
      ),
      body: pledgedResponse != null ? myPledgedSecuritiesBody() : Center(child: Text(responseText)),
    );
  }

  Widget myPledgedSecuritiesBody() {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 15),
            child: Row(
              children: [
                Expanded(child: headingText(loanType == Strings.shares ? "My Pledged Securities" : "My Pledged Schemes")),
              ],
            ),
          ),
          myPledgedSecuritiesCard(),
          myPledgedSecuritiesOption(),
          Padding(
            padding: const EdgeInsets.fromLTRB(14, 20, 15, 8),
            child: Row(
              children: [
                Text(loanType == Strings.shares ? 'Security' : 'Schemes', style:boldTextStyle_18),
              ],
            ),
          ),
          myPledgedSecuritiesList(),
          SizedBox(height: 70)
        ],
      ),
    );
  }

  Widget myPledgedSecuritiesCard() {
    return Container(
      padding: const EdgeInsets.only(right: 15, left: 15),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 15.0),
        decoration: BoxDecoration(
          color: colorLightBlue,
          borderRadius: BorderRadius.all(
              Radius.circular(30.0)),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(totalValue < 0
                      ? negativeValue(totalValue)
                      : '₹${numberToString(totalValue.toStringAsFixed(2))}',
                      style: subHeadingValue),
                  // Text('₹${numberToString(totalValue.toStringAsFixed(2))}',
                  //     style: subHeadingValue),
                  Padding(
                    padding: const EdgeInsets.only(top: 3.0),
                    child: Text(Strings.total_value, style: subHeading),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(
                                selectedScrips,
                                style: subHeadingValue,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Text(loanType == Strings.shares ? Strings.scrips : Strings.schemes, style: subHeading),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 40.0,
                          width: 0.5,
                          color: Colors.grey,
                        ),
                        Expanded(
                          child: Column(
                            children: <Widget>[
                              Text(drawingPower < 0
                                  ? negativeValue(drawingPower)
                                  : '₹${numberToString(drawingPower.toStringAsFixed(2))}',
                                style: subHeadingValue,
                              ),
                              // Text('₹${numberToString(drawingPower.toStringAsFixed(2))}',
                              //   style: subHeadingValue,
                              // ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Text(Strings.drawing_power, style: subHeading),
                              ),
                            ],
                          ),
                        ),
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
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: appTheme, shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.only(
                                bottomLeft: Radius.circular(20.0),
                                bottomRight: Radius.circular(20.0))),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 18.0),
                        child: Text(
                          loanType == Strings.shares ?
                          Strings.pledged_securities_transaction : Strings.pledged_schemes_transaction,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: () {
                        Utility.isNetworkConnection().then((isNetwork) {
                          if (isNetwork) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) => MyPledgeTransactionScreen(loanName,
                                        loanBalance,
                                        drawingPower, loanType)));
                          } else {
                            Utility.showToastMessage(Strings.no_internet_message);
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget myPledgedSecuritiesOption() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: BouncingScrollPhysics(),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              child: ReusableIconTextContainerCard(
                cardIcon: Image.asset(AssetsImagePath.unpledge, height: 35, width: 35, color: colorGreen),
                cardText: loanType == Strings.shares ? Strings.unpledge : Strings.revoke,
                circleColor: colorLightGreen,
              ),
              onTap: (){
                Utility.isNetworkConnection().then((isNetwork) {
                  if (isNetwork) {
                    if(unPledgeMarginShortFallMsg == null){
                      if(isUnpledge){
                        if(loanType == Strings.shares) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) => UnpledgeSharesScreen(loanName, Strings.all, "", loanType!)));
                        } else {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (BuildContext context) =>
                                  MFRevokeScreen(loanName, Strings.all, "", "")));
                        }
                      } else {
                        commonDialog(context, loanType == Strings.shares ? Strings.unpledge_request_pending : Strings.revoke_request_pending, 0);
                      }
                    } else {
                      commonDialog(context, unPledgeMarginShortFallMsg.toString(), 0);
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
                color: colorWhite,
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
                        'Pledge More', style: subHeading
                      ),
                    ],
                  ),
                ),
              ),
              onTap: (){
                Utility.isNetworkConnection().then((isNetwork) {
                  if (isNetwork) {
                    if(loanType == Strings.mutual_fund){
                      if (isIncreaseLoan) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => MFIncreaseLoan(loanName, Strings.increase_loan, null, loanType!, schemeType!)));
                      } else {
                        commonDialog(context, Strings.increase_loan_request_pending, 0);
                      }
                    } else {
                      if(isIncreaseLoan){
                        if(pledgedResponse!.data!.topUpApplication == 1){
                          LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
                          myLoansBloc.getLoanDetails(loanName).then((value) {
                            Navigator.pop(context);
                            if (value.isSuccessFull!) {
                              if (value.data!.loan != null) {
                                if(value.data!.increaseLoan == 1){
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) => IncreaseLoanLimit(
                                              value.data!.loan!.drawingPower,
                                              value.data!.loan!.totalCollateralValue,
                                              value.data!.loan!.name,
                                              value.data!.loan!.drawingPowerStr,
                                              value.data!.loan!.totalCollateralValueStr,
                                              value.data!.pledgorBoid
                                          )));
                                } else {
                                  commonDialog(context, Strings.increase_loan_request_pending, 0);
                                }
                              } else {
                                commonDialog(context, 'Something went wrong! Try Again', 0);
                              }
                            } else if(value.errorCode == 403) {
                              commonDialog(context, Strings.session_timeout, 4);
                            } else {
                              commonDialog(context, value.errorMessage, 0);
                            }
                          });
                        }else{
                          commonDialog(context, "Your top-up application: ${pledgedResponse!.data!.topUpApplicationName} is pending", 0);
                        }
                      } else {
                        commonDialog(context, Strings.increase_loan_request_pending, 0);
                      }
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
                cardText: loanType == Strings.shares ? Strings.sell : Strings.invoke,
                circleColor: colorLightRed,
              ),
              onTap: (){
                Utility.isNetworkConnection().then((isNetwork) {
                  if (isNetwork) {
                    if(isSellCollateral){
                      if(!isSellTriggered){
                        if(loanType == Strings.shares){
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      SellCollateralScreen(loanName,
                                          Strings.all, "", loanType!)));
                        }else{
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MFInvokeScreen(loanName,
                                          Strings.all, "", "")));
                        }
                      } else {
                        commonDialog(context, Strings.sale_triggered_small, 0);
                      }
                    } else{
                      commonDialog(context, loanType == Strings.shares ? Strings.sell_collateral_request_pending : Strings.invoke_request_pending, 0);
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
    );
  }

  Widget myPledgedSecuritiesList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: allPledgedSecurities.length,
      itemBuilder: (context, index) {
        for(int i = 0; i<allPledgedSecurities.length; i++){
          pressDownList.add(false);
        }
        return Card(
          elevation: 2,
          color: colorWhite,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          margin: const EdgeInsets.fromLTRB(15, 2, 15, 10),
          child: Padding(
              padding: EdgeInsets.only(left: 20.0, top: 5, right: 20, bottom: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(loanType == Strings.shares
                                ? allPledgedSecurities[index].securityName!
                                : "${allPledgedSecurities[index].securityName!} [${allPledgedSecurities[index].folio}]",
                            style: TextStyle(
                                color: appTheme,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                              "${allPledgedSecurities[index].securityCategory!} (LTV: ${allPledgedSecurities[index].eligiblePercentage!.toStringAsFixed(2)}%)",
                              style: boldTextStyle_12_gray),
                        ],
                      ),
                    ),
                    allPledgedSecurities[index].pledgedQuantity! >= 0.001 &&
                            allPledgedSecurities[index].amount! >= 0.001
                        ? IconButton(
                            icon: Icon(
                              pressDownList[index] == true
                                  ? Icons.keyboard_arrow_up
                                  : Icons.keyboard_arrow_down,
                              size: 30.0,
                              color: colorGrey,
                            ),
                            padding: EdgeInsets.zero,
                            onPressed: () {
                              setState(() {
                                pressDownList[index] == true
                                    ? pressDownList[index] = false
                                    : pressDownList[index] = true;
                              });
                            },
                          )
                        : SizedBox(height: 40)
                  ],
                ),
                SizedBox(height: 4),
                // Padding(
                //   padding: const EdgeInsets.only(bottom: 4.0),
                //   child: Row(
                //     children: <Widget>[
                //       Icon(
                //         Icons.check_circle_outline,
                //         size: 20.0,
                //         color: Colors.green,
                //       ),
                //       Padding(
                //         padding: const EdgeInsets.only(left: 8.0),
                //         child: Text(
                //           allPledgedSecurities[index].securityCategory!,
                //           style: TextStyle(
                //               fontSize: 15.0,
                //               color: Colors.green,
                //               fontWeight: FontWeight.bold),
                //         ),
                //       ),
                //     ],
                //   ),
                // ),
                Table(children: [
                  TableRow(children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        scripsValueText(loanType == Strings.shares
                            ? allPledgedSecurities[index]
                                .pledgedQuantity!
                                .toInt()
                                .toString()
                            : allPledgedSecurities[index]
                                .pledgedQuantity!
                                .toString()),
                        SizedBox(
                          height: 5,
                        ),
                        mediumHeadingText(loanType == Strings.shares
                            ? Strings.qty
                            : Strings.units),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        scripsValueText(loanType == Strings.shares
                            ? allPledgedSecurities[index]
                                .price!
                                .toStringAsFixed(2)
                            : allPledgedSecurities[index].price!.toString()),
                        SizedBox(
                          height: 5,
                        ),
                        mediumHeadingText(loanType == Strings.shares
                            ? Strings.price
                            : Strings.nav),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        scripsValueText(loanType == Strings.shares
                            ? allPledgedSecurities[index]
                                .amount!
                                .toStringAsFixed(2)
                            : allPledgedSecurities[index].amount!.toString()),
                        SizedBox(
                          height: 5,
                        ),
                        mediumHeadingText(Strings.value),
                      ],
                    ),
                  ]),
                ]),
                Visibility(
                  visible: pressDownList[index],
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40.0),
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor: appTheme,
                            ),
                            child: Text(
                              loanType == Strings.shares
                                  ? 'Unpledge'
                                  : "Revoke",
                              style: TextStyle(fontSize: 12.0),
                            ),
                            onPressed: () {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  if (unPledgeMarginShortFallMsg == null) {
                                    if (isUnpledge) {
                                      if (loanType == Strings.shares) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    UnpledgeSharesScreen(
                                                        loanName,
                                                        Strings.single,
                                                        allPledgedSecurities[
                                                                index]
                                                            .isin!,
                                                        loanType!)));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    MFRevokeScreen(
                                                        loanName,
                                                        Strings.single,
                                                        allPledgedSecurities[
                                                                index]
                                                            .isin!,
                                                        allPledgedSecurities[
                                                                index]
                                                            .folio!)));
                                      }
                                    } else {
                                      commonDialog(
                                          context,
                                          loanType == Strings.shares
                                              ? Strings.unpledge_request_pending
                                              : Strings.revoke_request_pending,
                                          0);
                                    }
                                  } else {
                                    commonDialog(
                                        context,
                                        unPledgeMarginShortFallMsg.toString(),
                                        0);
                                  }
                                  // LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
                                  // unpledgeBloc.unpledgeDetails(loanName).then((value) {
                                  //   if(value.isSuccessFull){
                                  //     if(value.data.unpledge != null){
                                  //       unPledgeList.clear();
                                  //       unPledgeList.add(new UnPledgeList(
                                  //           isin: allPledgedSecurities[index].isin,
                                  //           quantity: double.parse(allPledgedSecurities[index].pledgedQuantity.toString())
                                  //       ));
                                  //       unpledgeBloc.requestUnpledgeOTP().then((value) {
                                  //         Navigator.pop(context);
                                  //         if (value.isSuccessFull) {
                                  //           Utility.showToastMessage(value.message);
                                  //           showModalBottomSheet(
                                  //               backgroundColor: Colors.transparent,
                                  //               context: context,
                                  //               isScrollControlled: true,
                                  //               isDismissible: false,
                                  //               enableDrag: false,
                                  //               builder: (BuildContext bc) {
                                  //                 return UnpledgeOTPVerificationScreen(unPledgeList, loanName);
                                  //               });
                                  //         } else {
                                  //           Utility.showToastMessage(value.errorMessage);
                                  //         }
                                  //       });
                                  //     } else {
                                  //       Navigator.pop(context);
                                  //       commonDialog(context, 'Previous Unpledge Request is pending. Please Try Again After Sometime.', 0);
                                  //     }
                                  //   } else {
                                  //     Navigator.pop(context);
                                  //     Utility.showToastMessage(value.errorMessage);
                                  //   }
                                  // });
                                } else {
                                  Utility.showToastMessage(
                                      Strings.no_internet_message);
                                }
                              });
                            },
                          ),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(40.0),
                              ),
                              foregroundColor: Colors.white,
                              backgroundColor: red,
                            ),
                            child: Text(
                              loanType == Strings.shares
                                  ? 'Sell'
                                  : Strings.invoke,
                              style: TextStyle(fontSize: 12.0),
                            ),
                            onPressed: () {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  if (isSellCollateral) {
                                    if (!isSellTriggered) {
                                      if (loanType == Strings.shares) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    SellCollateralScreen(
                                                        loanName,
                                                        Strings.single,
                                                        allPledgedSecurities[
                                                                index]
                                                            .isin!,
                                                        loanType!)));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContext
                                                        context) =>
                                                    MFInvokeScreen(
                                                        loanName,
                                                        Strings.single,
                                                        allPledgedSecurities[
                                                                index]
                                                            .isin!,
                                                        allPledgedSecurities[
                                                                index]
                                                            .folio!)));
                                      }
                                    } else {
                                      commonDialog(context,
                                          Strings.sale_triggered_small, 0);
                                    }
                                  } else {
                                    commonDialog(
                                        context,
                                        loanType == Strings.shares
                                            ? Strings
                                                .sell_collateral_request_pending
                                            : Strings.invoke_request_pending,
                                        0);
                                  }
                                  // LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
                                  // sellList.clear();
                                  // sellList.add(new SellList(
                                  //     isin: allPledgedSecurities[index].isin,
                                  //     quantity: double.parse(allPledgedSecurities[index].pledgedQuantity.toString())
                                  // ));
                                  // sellCollateralBloc.requestSellCollateralOTP().then((value) {
                                  //   Navigator.pop(context);
                                  //   if (value.isSuccessFull) {
                                  //     Utility.showToastMessage(Strings.enter_otp);
                                  //     showModalBottomSheet(
                                  //       backgroundColor: Colors.transparent,
                                  //       context: context,
                                  //       isScrollControlled: true,
                                  //       isDismissible: false,
                                  //       enableDrag: false,
                                  //       builder: (BuildContext bc) {
                                  //         return SellCollateralOTPScreen(loanName, sellList);
                                  //       },
                                  //     );
                                  //   } else {
                                  //     Utility.showToastMessage(value.errorMessage);
                                  //   }
                                  // });
                                } else {
                                  Utility.showToastMessage(
                                      Strings.no_internet_message);
                                }
                              });
                            },
                          ),
                        ),
                      ],
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
}
