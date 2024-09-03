import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/controllers/single_my_active_loan_controller.dart';
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class SingleMyActiveLoanView extends GetView<SingleMyActiveLoanController> {
  @override
  Widget build(BuildContext context) {
    // platform = Theme.of(context).platform;
    return Obx(() => Scaffold(
          key: controller.scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: colorBg,
          appBar: AppBar(
            backgroundColor: colorBg,
            elevation: 0,
            centerTitle: true,
            title: Text(controller.loanNumber.value,
                style: mediumTextStyle_18_gray_dark),
          ),
          body: controller.loanDetailData.isBlank == true
              ? Center(child: Text(controller.responseText.value))
              : myActiveLoans(),

          ///DC: already commented
          /* loanOpen == 1
            ? loanNumber != null
                ? loanDetailData != null
                    ? myActiveLoans(loanDetailData
                    : Center(child: Text(Strings.please_wait))
                : Center(child: Text(""))
            : Center(child: Text("Nothing here! Get your loan now!!"))*/
//        body: getMyLoansList()
        ));
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
                controller.transactionsList != null
                    ? scripsNameText(
                        controller.transactionsList.length !=
                                0
                            ? Strings.recent_transactions
                            : "")
                    : Container(),
              ],
            ),
          ),
          controller.transactionsList != null ? recentTransactionList() : Container(),
          SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }

  Widget activeLoanCard() {
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
                          topRight: Radius.circular(
                              15.0)), // set rounded corner radius
                    ),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 16.0, left: 22.0, right: 15.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                width: 100,
                                height: 30,
                                decoration: BoxDecoration(
                                  color: colorLightBlue,
                                  border: Border.all(color: appTheme, width: 1),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20.0)),
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
                                      _launchURL(controller.baseURL +
                                          controller.loanDetailData.value.loan!
                                              .loanAgreement!);
                                    },
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10.0, left: 20.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              subHeadingText(controller.sanctionedValue.value <
                                      0
                                  ? negativeValue(
                                      controller.sanctionedValue.value)
                                  : '₹${numberToString(controller.sanctionedValue.value.toStringAsFixed(2))}'),
                              // subHeadingText('₹$sanctionedValue'),
                              Padding(
                                padding: EdgeInsets.only(top: 3.0, left: 10.0),
                                child: Container(
                                  height: 40.0,
                                  width: 1.0,
                                  color: Colors.grey,
                                ),
                              ),
                              subHeadingText(controller.drawingPower.value < 0
                                  ? negativeValue(controller.drawingPower.value)
                                  : '₹${numberToString(controller.drawingPower.toStringAsFixed(2))}'),
                              // subHeadingText('₹$drawingPower'),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, bottom: 8.0, right: 20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(Strings.sanctioned_limit, style: subHeading),
                              Text(Strings.drawing_power, style: subHeading),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 20.0, bottom: 8.0, right: 20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              // subHeadingText('₹${numberToString(loanBalance.toStringAsFixed(2))}'),
                              Text(
                                controller.loanBalance.value < 0
                                    ? negativeValue(controller.loanBalance.value)
                                    : '₹${numberToString(controller.loanBalance.toStringAsFixed(2))}',
                                textAlign: TextAlign.center,
                                style: boldTextStyle_24.copyWith(
                                    color: controller.loanBalance.value < 0
                                        ? colorGreen
                                        : appTheme),
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
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: regular,
                                    color: colorWhite),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: appTheme,
                              foregroundColor: Colors.white,
                              shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.only(
                                      bottomLeft: Radius.circular(15.0),
                                      bottomRight: Radius.circular(15.0))),
                            ),
                            onPressed: () => controller.viewLoanStatement(),
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
    if (await canLaunchUrl(pathPDF)) {
      await launchUrl(pathPDF);
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
              onTap: () => controller.withdrawClicked(),
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
                        child: Image.asset(AssetsImagePath.atm,
                            height: 58, width: 58, fit: BoxFit.cover),
                      ),
                      Text(Strings.withdraw, style: subHeading),
                    ],
                  ),
                ),
              ),
            ),
            SizedBoxWidthWidget(10.0),
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
                        child: Image.asset(AssetsImagePath.increase_loan_icon,
                            height: 58, width: 58, fit: BoxFit.cover),
                      ),
                      Text(Strings.increase_loan, style: subHeading),
                    ],
                  ),
                ),
              ),
              onTap: () => controller.increaseLoanClicked(),
            ),
            SizedBoxWidthWidget(10.0),
            GestureDetector(
              onTap: () => controller.payNowClicked(),
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
                        child: Image.asset(AssetsImagePath.pay_now,
                            height: 58, width: 58, fit: BoxFit.cover),
                      ),
                      Text(Strings.pay_now, style: subHeading),
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
        controller.loanDetailData.value.topUp != null
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
                                      subHeadingText(controller
                                                  .loanDetailData.value.topUp! <
                                              0
                                          ? negativeValue(controller
                                              .loanDetailData.value.topUp!)
                                          : '₹${numberToString(controller.loanDetailData.value.topUp!.toStringAsFixed(2))}'),
                                      // subHeadingText('₹${numberToString(loanDetailData!.topUp!.toStringAsFixed(2))}'),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appTheme,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              onPressed: () => controller.addTopUpClicked(),
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
        controller.totalCollateralValue != null
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            // set rounded corner radius
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
                              Row(
                                children: <Widget>[
                                  Container(
                                    margin:
                                        EdgeInsets.symmetric(vertical: 10.0),
                                    padding: EdgeInsets.all(10.0),
                                    decoration: BoxDecoration(
                                      color: colorLightGreen,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(8.0)),
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      mediumHeadingText(
                                          Strings.collateral_value),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      subHeadingText(controller
                                                  .loanDetailData
                                                  .value
                                                  .loan!
                                                  .totalCollateralValue! <
                                              0
                                          ? negativeValue(controller
                                              .loanDetailData
                                              .value
                                              .loan!
                                              .totalCollateralValue!)
                                          : '₹${numberToString(controller.loanDetailData.value.loan!.totalCollateralValue!.toStringAsFixed(2))}'),
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
        controller.interest != null &&
                controller.interest.value!.totalInterestAmt != 0
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
                                          onTap: () => commonDialog(
                                              controller
                                                  .interest.value!.infoMsg,
                                              0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    subHeadingText(controller.interest.value!
                                                .totalInterestAmt !=
                                            null
                                        ? controller.interest.value!
                                                    .totalInterestAmt! <
                                                0
                                            ? negativeValue(controller.interest
                                                .value!.totalInterestAmt!)
                                            : '₹${numberToString(controller.interest.value!.totalInterestAmt!.toStringAsFixed(2))}'
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
                                          "${controller.dpdText}",
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
                                        backgroundColor: red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20),
                                        ),
                                      ),
                                      onPressed: () => controller
                                          .payNowInterestScreenClicked(),
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
        controller.marginShortfall.value != null
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
                              onTap: () => controller.openBottomSheet(),
                            )
                          ],
                        ),
                        SizedBox(height: 5),
                        controller.minimumCashAmount != null ?subHeadingText(controller.minimumCashAmount <
                            0
                            ? negativeValue(controller.minimumCashAmount)
                            : '₹${numberToString(controller.minimumCashAmount.toStringAsFixed(2))}')
                        : Container(),
                      ],
                    ),
                  ),
                  Column(children: [
                    controller.isActionTaken.value
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
                            !controller.isTimerDone.value
                                ? controller.isTodayHoliday == 1
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
                                      '${controller.marginShortfall.value.deadlineInHrs}',
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
                                    hours: controller
                                        .hours.value,
                                    minutes: controller
                                        .min.value,
                                    seconds: controller
                                        .sec.value),
                                tween: Tween(
                                    begin: Duration(
                                        hours: controller
                                            .hours.value,
                                        minutes: controller
                                            .min.value,
                                        seconds: controller
                                            .sec.value),
                                    end: Duration.zero),
                                onEnd: () => controller
                                    .isTimerDone
                                    .value = true,
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
                        backgroundColor: appTheme,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      onPressed: () =>
                          controller.actionTakenOrRequestPendingClicked(),
                      child: Text(
                        controller.marginShortfall.value.status ==
                            "Request Pending"
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
      itemCount: controller.transactionsList.length,
      itemBuilder: (context, index) {
        return recentTransactionItem(
            controller.transactionsList, index);
      },
    );
  }

  Widget recentTransactionItem(
      List<TransactionsEntity> transactionList, index) {
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
                          mediumHeadingText(
                              transactionList[index].transactionType)
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
                            child: Text(
                                double.parse(transactionList[index]
                                            .amount
                                            .toString()
                                            .replaceAll(",", "")) <
                                        0
                                    ? negativeValue(double.parse(
                                        transactionList[index]
                                            .amount
                                            .toString()
                                            .replaceAll(",", "")))
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
                                color: transactionList[index]
                                            .recordType
                                            .toString() ==
                                        "DR"
                                    ? colorLightRed
                                    : colorLightGreen,
                              ),
                              child: Text(transactionList[index].recordType!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: semiBold,
                                      color: transactionList[index]
                                                  .recordType
                                                  .toString() ==
                                              "DR"
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
}
