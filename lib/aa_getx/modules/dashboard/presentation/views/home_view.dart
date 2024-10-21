import 'dart:io';
import 'package:another_flushbar/flushbar.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_controller.dart';
import 'package:lms/aa_getx/modules/cibil/presentation/controllers/cibil_result_controller.dart';
import 'package:lms/aa_getx/modules/dashboard/domain/entities/loan_summary_response_entity.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/controllers/home_controller.dart';
import 'package:shimmer/shimmer.dart';

class HomeView extends GetView<HomeController> {

  @override
  Widget build(BuildContext context) {
    return Obx(()=>Scaffold(
      backgroundColor: colorBg,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: controller.pullRefresh,
          child: SingleChildScrollView(
            // physics: BouncingScrollPhysics(),
            controller: controller.hideButtonController,
            physics: AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  userHeader(),
                  shimmerEffect(),
                  progressBarIndicator(),
                  verifyEmail(),
                  kycDetailsPendingCard(),
                  loanRenewalPendingCard(),
                  loanRenewalVerificationPending(),
                  tncPendingCard(),
                  loanRenewalTimer(),
                  kycDetailsVerificationPending(),
                  bankDetailsPendingCard(),
                  bankDetailsVerificationPending(),
                  marginShortFallCard(),
                  interestAmountCard(),
                  loanSummaryCard(),
                  pledgedESignCard(),
                  loanRenewalESignCard(),
                  increaseESignCard(),
                  topUpESignCard(),
                  topUpCard(),
                  //ToDo for time being we hide the graph card
                  // pledgePerformanceCard(),
                  categoryItemsCard(),
                  controller.isAPIResponded.value
                      ? controller.customer.value!.isEmailVerified == 1
                      ? controller.customer.value!.pledgeSecurities == 0
                      ? controller.isViewLoanSummaryCard == false
                      ? newLoanCard()
                      : SizedBox()
                      : SizedBox()
                      : SizedBox()
                      : SizedBox(),
                  youtubeVideoBanner(),
                  // playVideoCard(),
                  inviteCard(),
                  SizedBox(height: 50),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomSheet: Visibility(
        visible: controller.isUpdateFlushVisible.value,
        child: Padding(
          padding: EdgeInsets.only(left: 15, right: 15,
              bottom: Platform.isAndroid
                  ? MediaQuery.of(context).size.height * 0.1
                  : MediaQuery.of(context).size.height * 0.1 + 28),
          child: Flushbar(
            flushbarPosition: FlushbarPosition.BOTTOM,
            borderRadius: BorderRadius.all(Radius.circular(6)),
            backgroundColor: appTheme,
            mainButton: Padding(
              padding: const EdgeInsets.only(right: 4),
              child: MaterialButton(
                color: red,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                height: 25,
                minWidth: 10,
                child: Text("UPDATE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12)),
                onPressed: ()=>
                  Utility().forceUpdatePopUp( false, controller.storeURL!, controller.storeWhatsNew!),
              ),
            ),
            messageText: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("New app version available!",
                    style: TextStyle(color: colorWhite, fontWeight: FontWeight.w300)),
              ],
            ),

            // duration: Duration(seconds: 2),
          ),
        ),
      ),
    ));
  }

  Widget shimmerEffect() {
    return Visibility(
      visible: !controller.isAPIResponded.value,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[400]!,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 14, 6, 14),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 80,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 150,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 120,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 120,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 120,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget userHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Container(
            decoration:
            BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(26.0)),
            ),
            child: CircleAvatar(
              backgroundColor: colorLightBlue,
              backgroundImage: controller.profilePhotoUrl.isNotEmpty ? NetworkImage(controller.profilePhotoUrl.value)
                  : AssetImage(AssetsImagePath.profile) as ImageProvider,
              radius: 26.0,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hello! ${controller.userFullName}',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: appTheme,
                      fontFamily: 'Gilroy'),
                ),
              ],
            ),
          ),
          GestureDetector(
            child: controller.notificationCount == 0
                ? Image.asset(AssetsImagePath.bell, width: 22.0, height: 22.0)
                : Image.asset(AssetsImagePath.notification_icon, width: 25.0, height: 25.0),
            onTap: ()=> controller.notificationIconClicked(),
          ),
          SizedBox(width: 4),
          GestureDetector(
            child: Image.asset(
              AssetsImagePath.manage_settings_icon,
              width: 22.0,
              height: 22.0,
              color: appTheme,
            ),
            onTap: ()=>controller.settingsClicked(),
          ),
        ],
      ),
    );
  }

  Widget progressBarIndicator() {
    return Visibility(
      visible: controller.isViewProgressBarIndicator.value,
      child: Column(
        children: [
          controller.customer.value!.loanOpen == 1
              ? Container(height: 0)
              : SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      controller.customer.value!.registeration == 1
                          ? checkedWidget()
                          : controller.customer.value!.registeration == 0
                          ? inProgressWidget()
                          : ReusableProcessBar(),
                      SizedBox(height: 5),
                      Text('${Strings.registration}\n',
                          style: statusBarText),
                    ],
                  ),
                  dottedLineWidget(),
                  Column(
                    children: <Widget>[
                      controller.customer.value!.kycUpdate == 1
                          ? checkedWidget()
                          : controller.customer.value!.kycUpdate == 0
                          ? inProgressWidget()
                          : ReusableProcessBar(),
                      SizedBox(height: 5),
                      Text('${Strings.add}\n${Strings.kyc}',
                          style: statusBarText),
                    ],
                  ),
                  dottedLineWidget(),
                  Column(
                    children: <Widget>[
                      controller.customer.value!.bankUpdate == 1
                          ? checkedWidget()
                          : controller.customer.value!.bankUpdate == 0
                          ? inProgressWidget()
                          : ReusableProcessBar(),
                      SizedBox(height: 5),
                      Text('${Strings.add}\n${Strings.bank}',
                          style: statusBarText),
                    ],
                  ),
                  dottedLineWidget(),
                  Column(
                    children: <Widget>[
                      controller.customer.value!.pledgeSecurities == 1
                          ? checkedWidget()
                          : controller.customer.value!.pledgeSecurities == 0
                          ? inProgressWidget()
                          : ReusableProcessBar(),
                      SizedBox(height: 5),
                      Text('${Strings.pledge}\n${Strings.securities}',
                          style: statusBarText),
                    ],
                  ),
                  dottedLineWidget(),
                  Column(
                    children: <Widget>[
                      controller.customer.value!.loanOpen == 1
                          ? checkedWidget()
                          : controller.customer.value!.loanOpen == 0
                          ? inProgressWidget()
                          : ReusableProcessBar(),
                      SizedBox(height: 5),
                      Text('${Strings.loan}\n${Strings.open}',
                          style: statusBarText),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget dottedLineWidget() {
    return Container(
      padding: EdgeInsets.only(top: 10),
      height: 50,
      child: DottedLine(
        lineLength: 30,
        dashColor: appTheme,
        dashLength: 0.8,
      ),
    );
  }

  Widget checkedWidget() {
    return ReusableProcessCheckedBar(
      processBarIcon: Icon(
        Icons.check,
        size: 18.0,
        color: appTheme,
      ),
    );
  }

  Widget inProgressWidget() {
    return ReusableProcessBar(
      processBarIcon: Icon(
        Icons.brightness_1,
        size: 10.0,
        color: appTheme,
      ),
    );
  }

  Widget verifyEmail() {
    return Visibility(
      visible: controller.viewEmailVisible.value,
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: <Widget>[
                        Text(
                          Strings.need_email_verification,
                          style: boldTextStyle_18,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          Strings.check_email,
                          style: mediumTextStyle_14_gray,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget marginShortFallCard() {
    return Visibility(
      visible: controller.isViewMarginShortFallCard.value,
      child: controller.marginShortfallList.length != 0 ? Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 35, width: 35, color: red),
                  SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.margin_shortfall,
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        Text(Strings.margin_shortfall_text1,
                            style: TextStyle(color: appTheme, fontSize: 10)),
                        Text(Strings.margin_shortfall_text2,
                            style: TextStyle(
                                color: appTheme,
                                fontSize: 10,
                                fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                  SizedBox(width: 6),
                  Container(
                    width: 75,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: appTheme,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: Column(
                        children: [
                          !controller.isTimerDone.value
                              ? controller.isTodayHoliday == 1
                              ? Column(
                            children: [
                              Text(Strings.time_remaining, style: TextStyle(fontSize: 9, color: Colors.indigo)),
                              Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 5),
                                  child: Text('${controller.marginShortfallList[0].deadline}', textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red))),],
                          )
                              : TweenAnimationBuilder<Duration>(
                              duration: Duration(hours: controller.shortFallHours.value, minutes: controller.shortFallMin.value, seconds: controller.shortFallSec.value),
                              tween: Tween(
                                  begin: Duration(hours: controller.shortFallHours.value, minutes: controller.shortFallMin.value, seconds: controller.shortFallSec.value),
                                  end: Duration.zero),
                              onEnd: ()=>
                                  controller.isTimerDone.value = true,
                              builder: (BuildContext context, Duration? value, Widget? child) {
                                final hours = (value!.inHours).toString();
                                final minutes = (value.inMinutes % 60).toString().padLeft(2, '0');
                                final seconds = (value.inSeconds % 60).toString().padLeft(2, '0');
                                String hour = '';
                                if (hours == '0') {
                                  hour = '';
                                } else {
                                  hour = '$hours:';
                                }
                                return Column(
                                  children: [
                                    Text(Strings.time_remaining,
                                        style: TextStyle(fontSize: 9, color: Colors.indigo)),
                                    Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: Text('$hour$minutes:$seconds', textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red))),
                                  ],
                                );
                              })
                              : controller.marginShortfallList[0].status == "Request Pending"
                              ? Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text('Action Taken',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12)),
                          )
                              : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(Strings.sale_triggered,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: red,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 11)),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    child: CircleAvatar(
                      backgroundColor: appTheme,
                      child: Image.asset(AssetsImagePath.right_arrow_icon,
                          color: colorWhite),
                      radius: 20.0,
                    ),
                    onTap: ()=> controller.marginShortfallClicked(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ) : SizedBox(),
    );
  }

  Widget interestAmountCard() {
    return Visibility(
      visible: controller.isViewInterestCard.value,
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: appTheme,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.percentage_icon,
                      height: 40, width: 30),
                  SizedBox(width: 6),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            Strings.interest_due,
                            style: TextStyle(
                                color: colorLightGreen,
                                fontSize: 12,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '₹${numberToString(controller.totalInterestAmount.value)}',
                          style: TextStyle(
                              color: colorWhite,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Days Past Due - ",
                              style: TextStyle(
                                  color: colorLightGreen,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text("${controller.dpdText}",
                              style: TextStyle(
                                  color: colorWhite,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 6),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: red,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8, right: 8, top: 4, bottom: 4),
                        child: Text(
                          Strings.pay_now,
                          style: TextStyle(
                              fontSize: 14,
                              color: colorWhite,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                    onTap: ()=> controller.goToInterestScreen(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget loanSummaryCard() {
    return Visibility(
      visible: controller.isViewLoanSummaryCard.value,
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      Text(Strings.loan_summary,
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: appTheme)),
                    ],
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount:
                      controller.sellCollateralTopUpAndUnpledgeList.length,
                      itemBuilder: (BuildContext context, int index) {
                        if (controller.sellCollateralTopUpAndUnpledgeList[index]
                            .unpledgeApplicationAvailable !=
                            null &&
                            controller.sellCollateralTopUpAndUnpledgeList[index]
                                .sellCollateralAvailable ==
                                null &&
                            controller.sellCollateralTopUpAndUnpledgeList[index]
                                .existingTopupApplication ==
                                null) {
                          return LoanSummaryTile(
                              acNo: controller.sellCollateralTopUpAndUnpledgeList[
                              index]
                                  .loanName!,
                              status: Strings.unpledge,
                              withdrawal:
                              controller.sellCollateralTopUpAndUnpledgeList[
                              index]
                                  .unpledgeApplicationAvailable!
                                  .workflowState!,
                              odBalance: '',
                              pendingUnPledge:
                              controller.sellCollateralTopUpAndUnpledgeList[
                              index]
                                  .unpledgeApplicationAvailable!,
                              loanType: controller.loanType.value,
                              controller: controller);
                        } else if (controller.sellCollateralTopUpAndUnpledgeList[
                        index]
                            .sellCollateralAvailable !=
                            null &&
                            controller.sellCollateralTopUpAndUnpledgeList[index]
                                .unpledgeApplicationAvailable ==
                                null &&
                            controller.sellCollateralTopUpAndUnpledgeList[index]
                                .existingTopupApplication ==
                                null) {
                          return LoanSummaryTile(
                            acNo: controller.sellCollateralTopUpAndUnpledgeList[
                            index]
                                .loanName!,
                            status: Strings.sell_collateral,
                            withdrawal:
                            controller.sellCollateralTopUpAndUnpledgeList[
                            index]
                                .sellCollateralAvailable!
                                .workflowState!,
                            odBalance: '',
                            pendingSellCollateral:
                            controller.sellCollateralTopUpAndUnpledgeList[
                            index]
                                .sellCollateralAvailable!,
                            loanType: controller.loanType.value,
                            controller: controller,
                          );
                        } else if (controller.sellCollateralTopUpAndUnpledgeList[
                        index]
                            .existingTopupApplication !=
                            null &&
                            controller.sellCollateralTopUpAndUnpledgeList[index]
                                .sellCollateralAvailable ==
                                null &&
                            controller.sellCollateralTopUpAndUnpledgeList[index]
                                .unpledgeApplicationAvailable ==
                                null) {
                          return LoanSummaryTile(
                            acNo: controller.sellCollateralTopUpAndUnpledgeList[
                            index]
                                .loanName!,
                            status: Strings.top_up,
                            withdrawal:
                            controller.sellCollateralTopUpAndUnpledgeList[
                            index]
                                .existingTopupApplication!
                                .workflowState!,
                            odBalance: '',
                            loanType: controller.loanType.value,
                            controller: controller,
                          );
                        } else {
                          return SizedBox();
                        }
                      }),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: controller.underProcessLoanList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return LoanSummaryTile(
                          acNo: controller.underProcessLoanList[index].name!,
                          status: Strings.under_process_loan,
                          withdrawal:
                          controller.underProcessLoanList[index].status!,
                          odBalance: '',
                          loanType: controller.loanType.value,
                          controller: controller,
                        );
                      }),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: controller.underProcessLoanRenewalList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return LoanSummaryTile(
                          acNo: controller.underProcessLoanRenewalList[index].name!,
                          status: Strings.loanRenewal,
                          withdrawal:
                          controller.underProcessLoanRenewalList[index].status!,
                          odBalance: '',
                          loanType: controller.loanType.value,
                          controller: controller,
                        );
                      }),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: controller.actionableLoanList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return LoanSummaryTile(
                          acNo: controller.actionableLoanList[index].name!,
                          status: Strings.actionable_loan,
                          withdrawal: numberToString(
                              controller.actionableLoanList[index]
                                  .drawingPower!
                                  .toStringAsFixed(2)),
                          odBalance: numberToString(
                              controller.actionableLoanList[index]
                                  .balance!
                                  .toStringAsFixed(2)),
                          odBalanceisNegative: (controller.actionableLoanList[index]
                              .balance! < 0.0) ? true : false,
                          loanType: controller.loanType.value,
                          controller: controller,
                        );
                      }),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: controller.activeLoanList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return LoanSummaryTile(
                          acNo: controller.activeLoanList[index].name!,
                          status: Strings.active_loan,
                          withdrawal: numberToString(
                              controller.activeLoanList[index]
                                  .drawingPower!
                                  .toStringAsFixed(2)),
                          odBalance: numberToString(
                              controller.activeLoanList[index]
                                  .balance!
                                  .toStringAsFixed(2)),
                          odBalanceisNegative: (controller.activeLoanList[index]
                              .balance! < 0) ? true : false,
                          loanType: controller.loanType.value,
                          controller: controller,
                        );

                      }),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  /*Widget loanSummaryCard() {
    return StreamBuilder(
      stream: controller.newDashboardBloc.listLoanSummary,
      builder: (context, AsyncSnapshot<LoanSummaryData> value) {
        if (value.hasData) {
          if (value.data == null) {
            return SizedBox(height: 0);
          } else {
            sellCollateralTopUpAndUnpledgeList.clear();
            actionableLoanList.clear();
            activeLoanList.clear();
            underProcessLoanList.clear();
            underProcessLoanRenewalList.clear();
            pendingSellCollateralList.clear();
            pendingUnPledgeList.clear();
            topUpList.clear();
            if (value.data!.sellCollateralTopupAndUnpledgeList!.length != 0) {
              value.data!.sellCollateralTopupAndUnpledgeList!.forEach((v) {
                sellCollateralTopUpAndUnpledgeList.add(v);
              });
            }

            if (value.data!.activeLoans!.length != 0 ||
                value.data!.actionableLoan!.length != 0 ||
                value.data!.underProcessLa!.length != 0 ||
                value.data!.underProcessLoanRenewalApp!.length != 0) {
              if (value.data!.actionableLoan!.length != 0) {
                value.data!.actionableLoan!.forEach((v) {
                  actionableLoanList.add(v);
                });
              }
              if (value.data!.activeLoans!.length != 0) {
                value.data!.activeLoans!.forEach((v) {
                  activeLoanList.add(v);
                });
              }
              if (value.data!.underProcessLa!.length != 0) {
                value.data!.underProcessLa!.forEach((v) {
                  underProcessLoanList.add(v);
                });
              }
              if (value.data!.underProcessLoanRenewalApp != null && value.data!.underProcessLoanRenewalApp!.length != 0) {
                value.data!.underProcessLoanRenewalApp!.forEach((v) {
                  underProcessLoanRenewalList.add(v);
                });
              }
              isViewLoanSummaryCard = true;
            }

            if (value.data!.activeLoans!.length == 0 &&
                value.data!.actionableLoan!.length == 0 &&
                value.data!.underProcessLa!.length == 0 &&
                value.data!.underProcessLoanRenewalApp!.length == 0) {
              isViewLoanSummaryCard = false;
            }

            if (value.data!.sellCollateralList!.length != 0) {
              for (int i = 0; i < value.data!.sellCollateralList!.length; i++) {
                if (value.data!.sellCollateralList![i].sellCollateralAvailable != null) {
                  pendingSellCollateralList.add(value.data!.sellCollateralList![i]);
                }
              }
              if (value.data!.sellCollateralList![0].sellCollateralAvailable == null) {
                isSellCollateral = true;
                loanName = value.data!.sellCollateralList![0].loanName!;
              } else {
                loanName = value.data!.sellCollateralList![0].loanName!;
                isSellCollateral = false;
              }
              if (value.data!.sellCollateralList![0].isSellTriggered == 1) {
                isSellTriggered = true;
              } else {
                isSellTriggered = false;
              }
            }
            if (value.data!.unpledgeList!.length != 0) {
              for (int i = 0; i < value.data!.unpledgeList!.length; i++) {
                if (value.data!.unpledgeList![i].unpledgeApplicationAvailable != null) {
                  pendingUnPledgeList.add(value.data!.unpledgeList![i]);
                }
              }
            }
            if (value.data!.topupList!.length != 0) {
              value.data!.topupList!.forEach((v) {
                topUpList.add(v);
              });
              isViewTopUpCard = true;
            } else {
              isViewTopUpCard = false;
            }

            if (value.data!.increaseLoanList!.length != 0) {
              if (value.data!.increaseLoanList![0].increaseLoanAvailable == 1) {
                isIncreaseLoan = true;
                loanName = value.data!.increaseLoanList![0].loanName!;
              } else {
                isIncreaseLoan = false;
              }
            }
            return Visibility(
              visible: isViewLoanSummaryCard,
              child: Column(
                children: [
                  Card(
                    elevation: 2.0,
                    color: colorLightBlue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Text(Strings.loan_summary,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: appTheme)),
                            ],
                          ),
                          SizedBox(height: 10),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount:
                              sellCollateralTopUpAndUnpledgeList.length,
                              itemBuilder: (BuildContext context, int index) {
                                if (sellCollateralTopUpAndUnpledgeList[index]
                                    .unpledgeApplicationAvailable !=
                                    null &&
                                    sellCollateralTopUpAndUnpledgeList[index]
                                        .sellCollateralAvailable ==
                                        null &&
                                    sellCollateralTopUpAndUnpledgeList[index]
                                        .existingTopupApplication ==
                                        null) {
                                  return LoanSummaryTile(
                                      acNo: sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .loanName!,
                                      status: Strings.unpledge,
                                      withdrawal:
                                      sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .unpledgeApplicationAvailable!
                                          .workflowState!,
                                      odBalance: '',
                                      pendingUnPledge:
                                      sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .unpledgeApplicationAvailable!,
                                      loanType: loanType,
                                    controller: controller);
                                } else if (sellCollateralTopUpAndUnpledgeList[
                                index]
                                    .sellCollateralAvailable !=
                                    null &&
                                    sellCollateralTopUpAndUnpledgeList[index]
                                        .unpledgeApplicationAvailable ==
                                        null &&
                                    sellCollateralTopUpAndUnpledgeList[index]
                                        .existingTopupApplication ==
                                        null) {
                                  return LoanSummaryTile(
                                      acNo: sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .loanName!,
                                      status: Strings.sell_collateral,
                                      withdrawal:
                                      sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .sellCollateralAvailable!
                                          .workflowState!,
                                      odBalance: '',
                                      pendingSellCollateral:
                                      sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .sellCollateralAvailable!,
                                      loanType: loanType,
                                    controller: controller,
                                  );
                                } else if (sellCollateralTopUpAndUnpledgeList[
                                index]
                                    .existingTopupApplication !=
                                    null &&
                                    sellCollateralTopUpAndUnpledgeList[index]
                                        .sellCollateralAvailable ==
                                        null &&
                                    sellCollateralTopUpAndUnpledgeList[index]
                                        .unpledgeApplicationAvailable ==
                                        null) {
                                  return LoanSummaryTile(
                                      acNo: sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .loanName!,
                                      status: Strings.top_up,
                                      withdrawal:
                                      sellCollateralTopUpAndUnpledgeList[
                                      index]
                                          .existingTopupApplication!
                                          .workflowState!,
                                      odBalance: '',
                                      loanType: loanType,
                                    controller: controller,
                                  );
                                } else {
                                  return SizedBox();
                                }
                              }),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: underProcessLoanList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return LoanSummaryTile(
                                    acNo: underProcessLoanList[index].name!,
                                    status: Strings.under_process_loan,
                                    withdrawal:
                                    underProcessLoanList[index].status!,
                                    odBalance: '',
                                    loanType: loanType,
                                  controller: controller,
                                );
                              }),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: underProcessLoanRenewalList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return LoanSummaryTile(
                                    acNo: underProcessLoanRenewalList[index].name!,
                                    status: Strings.loanRenewal,
                                    withdrawal:
                                    underProcessLoanRenewalList[index].status!,
                                    odBalance: '',
                                    loanType: loanType,
                                  controller: controller,
                                );
                              }),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: actionableLoanList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return LoanSummaryTile(
                                    acNo: actionableLoanList[index].name!,
                                    status: Strings.actionable_loan,
                                    withdrawal: numberToString(
                                        actionableLoanList[index]
                                            .drawingPower!
                                            .toStringAsFixed(2)),
                                    odBalance: numberToString(
                                        actionableLoanList[index]
                                            .balance!
                                            .toStringAsFixed(2)),
                                    odBalanceisNegative: (actionableLoanList[index]
                                        .balance! < 0.0) ? true : false,
                                    loanType: loanType,
                                  controller: controller,
                                );
                              }),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: activeLoanList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return LoanSummaryTile(
                                    acNo: activeLoanList[index].name!,
                                    status: Strings.active_loan,
                                    withdrawal: numberToString(
                                        activeLoanList[index]
                                            .drawingPower!
                                            .toStringAsFixed(2)),
                                    odBalance: numberToString(
                                        activeLoanList[index]
                                            .balance!
                                            .toStringAsFixed(2)),
                                    odBalanceisNegative: (activeLoanList[index]
                                        .balance! < 0) ? true : false,
                                    loanType: loanType,
                                    controller: controller,
                                );

                              }),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            );
          }
        } else if (value.hasError) {
          return ErrorMessageWidget(error: value.error.toString());
        } else {
          return SizedBox(height: 0);
        }
      },
    );
  }*/

  // Widget loanSummaryCard2() {
  //   return Visibility(
  //     visible: isViewLoanSummaryCard,
  //     child: Column(
  //       children: [
  //         Card(
  //           elevation: 6.0,
  //           color: colorlightBlue,
  //           shape: RoundedRectangleBorder(
  //             borderRadius: BorderRadius.all(Radius.circular(10)),
  //           ),
  //           child: Padding(
  //             padding: const EdgeInsets.fromLTRB(10, 16, 10, 16),
  //             child: Column(
  //               children: <Widget>[
  //                 Row(
  //                   children: <Widget>[
  //                     Text(Strings.loan_summary,
  //                         style: TextStyle(
  //                             fontWeight: FontWeight.bold, fontSize: 18, color: appTheme)),
  //                   ],
  //                 ),
  //                 SizedBox(height: 10),
  //                 ListView.builder(
  //                     scrollDirection: Axis.vertical,
  //                     shrinkWrap: true,
  //                     physics: ScrollPhysics(),
  //                     itemCount: pendingSellCollateralList.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return LoanSummaryTile(
  //                           acNo: pendingSellCollateralList[index].loanName,
  //                           status: Strings.sell_collateral,
  //                           withdrawal: pendingSellCollateralList[index].sellCollateralAvailable.workflowState,
  //                           odBalance: '',
  //                           pendingSellCollateral: pendingSellCollateralList[index]);
  //                     }),
  //                 ListView.builder(
  //                     scrollDirection: Axis.vertical,
  //                     shrinkWrap: true,
  //                     physics: ScrollPhysics(),
  //                     itemCount: pendingUnPledgeList.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return LoanSummaryTile(
  //                           acNo: pendingUnPledgeList[index].loanName,
  //                           status: Strings.unpledge,
  //                           withdrawal: pendingUnPledgeList[index].unpledgeApplicationAvailable.workflowState,
  //                           odBalance: '',
  //                           pendingUnPledge: pendingUnPledgeList[index]);
  //                     }),
  //                 ListView.builder(
  //                     scrollDirection: Axis.vertical,
  //                     shrinkWrap: true,
  //                     physics: ScrollPhysics(),
  //                     itemCount: underProcessLoanList.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return LoanSummaryTile(
  //                           acNo: underProcessLoanList[index].name,
  //                           status: Strings.under_process_loan,
  //                           withdrawal: underProcessLoanList[index].status,
  //                           odBalance: '');
  //                     }),
  //                 ListView.builder(
  //                     scrollDirection: Axis.vertical,
  //                     shrinkWrap: true,
  //                     physics: ScrollPhysics(),
  //                     itemCount: actionableLoanList.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return LoanSummaryTile(
  //                           acNo: actionableLoanList[index].loanName,
  //                           status: Strings.actionable_loan,
  //                           withdrawal: numberToString(actionableLoanList[index].drawingPower.toStringAsFixed(2)),
  //                           odBalance: numberToString(actionableLoanList[index].balance.toStringAsFixed(2)));
  //                     }),
  //                 ListView.builder(
  //                     scrollDirection: Axis.vertical,
  //                     shrinkWrap: true,
  //                     physics: ScrollPhysics(),
  //                     itemCount: activeLoanList.length,
  //                     itemBuilder: (BuildContext context, int index) {
  //                       return LoanSummaryTile(
  //                           acNo: activeLoanList[index].name,
  //                           status: Strings.active_loan,
  //                           withdrawal: numberToString(activeLoanList[index].drawingPower.toStringAsFixed(2)),
  //                           odBalance: numberToString(activeLoanList[index].balance.toStringAsFixed(2)));
  //                     }),
  //               ],
  //             ),
  //           ),
  //         ),
  //         SizedBox(height: 10),
  //       ],
  //     ),
  //   );
  // }

  Widget pledgedESignCard() {
    return Visibility(
      visible: controller.isViewPledgedESignCard.value,
      child: controller.eSignLoanList.length != 0
          ? Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 20.0, right: 20.0, bottom: 10),
                      decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)), //
                          boxShadow: [
                            BoxShadow(
                              color: colorGrey,
                              blurRadius: 1,
                              offset: Offset(1, 0),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: Text(Strings.sanction_letter, style: buttonTextRed,),
                                onTap: ()=> controller.sanctionLetterClicked(),
                              ),
                              GestureDetector(
                                child: Text(controller.loanType == Strings.shares ? Strings.pledged_security : "Lien Schemes",
                                  style: buttonTextRed,
                                ),
                                onTap: ()=> controller.goToPledgedSecuritiesListScreen(),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(controller.eSignLoanList[0].message!),
                          SizedBox(height: 5),
                          subHeadingText(
                              controller.eSignLoanList[0].loanApplication!.name!),
                          Text(Strings.loan_application_no,
                              style: subHeading),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    scripsNameText(
                                        '₹${numberToString(controller.eSignLoanList[0].loanApplication!.drawingPower!.toStringAsFixed(2))}'),
                                    Text(Strings.sanctioned_limit,
                                        style: subHeading),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    scripsNameText(
                                        '₹${numberToString(controller.eSignLoanList[0].loanApplication!.totalCollateralValue!.toStringAsFixed(2))}'),
                                    Text(Strings.total_collateral_value,
                                        style: subHeading),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight:
                                        Radius.circular(10.0))),
                                foregroundColor: Colors.white,
                                backgroundColor: appTheme,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  Strings.e_sign,
                                  style: buttonTextWhite,
                                ),
                              ),
                              onPressed: ()=>controller.eSignClicked(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      )
          : SizedBox(),
    );
  }

  Widget loanRenewalESignCard() {
    return Visibility(
      visible: controller.isViewLoanRenewalESignCard.value,
      child: controller.eSignLoanRenewalList.length != 0
          ? Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 20.0, right: 20.0, bottom: 10),
                      decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)), //
                          boxShadow: [
                            BoxShadow(
                              color: colorGrey,
                              blurRadius: 1,
                              offset: Offset(1, 0),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: Text(
                                  Strings.sanction_letter,
                                  style: buttonTextRed,
                                ),
                                onTap: ()=>
                                  controller.launchURL(controller.eSignLoanRenewalList[0]
                                      .sanctionLetter!
                                      .sanctionLetter) ,
                              ),
                              GestureDetector(
                                child: Text(
                                  Strings.loanRenewal,
                                  style: buttonTextRed,
                                ),
                                onTap: ()=> controller.loanRenewalClicked(),
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(controller.eSignLoanRenewalList[0].mess!),
                          SizedBox(height: 5),
                          subHeadingText(controller.eSignLoanRenewalList[0]
                              .loanRenewalApplicationDoc!
                              .name!),
                          Text(Strings.loan_renewal_application,
                              style: subHeading),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    scripsNameText(
                                        '₹${numberToString(controller.eSignLoanRenewalList[0].loanRenewalApplicationDoc!.drawingPower!.toStringAsFixed(2))}'),
                                    Text(Strings.sanctioned_limit,
                                        style: subHeading),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    scripsNameText(
                                        '₹${numberToString(controller.eSignLoanRenewalList[0].loanRenewalApplicationDoc!.totalCollateralValue!.toStringAsFixed(2))}'),
                                    Text(Strings.total_collateral_value,
                                        style: subHeading),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight:
                                        Radius.circular(10.0))),
                                foregroundColor: Colors.white,
                                backgroundColor: appTheme,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  Strings.e_sign,
                                  style: buttonTextWhite,
                                ),
                              ),
                              onPressed: ()=> controller.goToEsignConsentScreen() ,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      )
          : SizedBox(),
    );
  }

  Widget increaseESignCard() {
    return Visibility(
      visible: controller.isViewIncreaseESignCard.value,
      child: controller.eSignIncreaseLoanList.length != 0
          ? Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 20.0, right: 20.0, bottom: 10),
                      decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)), //
                          boxShadow: [
                            BoxShadow(
                              color: colorGrey,
                              blurRadius: 1,
                              offset: Offset(1, 0),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GestureDetector(
                                child: Text(Strings.sanction_letter, style: buttonTextRed,),
                                onTap: ()=> controller.launchURL(controller.eSignIncreaseLoanList[0].sanctionLetter!.sanctionLetter),
                              ),
                              GestureDetector(
                                child: Text(
                                  controller.loanType == Strings.shares ? Strings.pledged_security : "Pledged Scheme",
                                  style: buttonTextRed,
                                ),
                                onTap: ()=>controller.pledgedSecurityOrSchemeClicked() ,
                              )
                            ],
                          ),
                          SizedBox(height: 10),
                          Text(controller.eSignIncreaseLoanList[0].message!),
                          SizedBox(height: 5),
                          subHeadingText(controller.eSignIncreaseLoanList[0]
                              .loanApplication!
                              .name),
                          Text(Strings.loan_application_no,
                              style: subHeading),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    scripsNameText(
                                        '₹${numberToString(controller.eSignIncreaseLoanList[0].increaseLoanMessage!.existingLimit!.toStringAsFixed(2))}'),
                                    Text(Strings.existing_limit,
                                        style: subHeading),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    scripsNameText(
                                        '₹${numberToString(controller.eSignIncreaseLoanList[0].increaseLoanMessage!.newLimit!.toStringAsFixed(2))}'),
                                    Text(Strings.new_limit,
                                        style: subHeading),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    scripsNameText(
                                        '₹${numberToString(controller.eSignIncreaseLoanList[0].increaseLoanMessage!.existingCollateralValue!.toStringAsFixed(2))}'),
                                    Text(
                                        Strings.existing_collateral_value,
                                        style: subHeading),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: <Widget>[
                                    scripsNameText(
                                        '₹${numberToString(controller.eSignIncreaseLoanList[0].increaseLoanMessage!.newCollateralValue!.toStringAsFixed(2))}'),
                                    Text(Strings.new_collateral_value,
                                        style: subHeading),
                                  ],
                                ),
                              ),
                            ],
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
                                  Strings.e_sign,
                                  style: buttonTextWhite,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: appTheme,
                                shape: new RoundedRectangleBorder(
                                    borderRadius: new BorderRadius.only(
                                        bottomLeft: Radius.circular(10.0),
                                        bottomRight:
                                        Radius.circular(10.0))),
                                foregroundColor: Colors.white,
                              ),
                              onPressed: ()=> controller.eSignIncreaseLoanClicked() ,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      )
          : SizedBox(),
    );
  }

  Widget topUpESignCard() {
    return Visibility(
      visible: controller.isViewTopUpESignCard.value,
      child: controller.topUpESignLoanList.length != 0
          ? Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(
                          top: 15.0, left: 20.0, right: 20.0, bottom: 10),
                      decoration: BoxDecoration(
                          color: colorWhite,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)), //
                          boxShadow: [
                            BoxShadow(
                              color: colorGrey,
                              blurRadius: 1,
                              offset: Offset(1, 0),
                            )
                          ]),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              GestureDetector(
                                      child: Text(
                                        Strings.sanction_letter,
                                        style: buttonTextRed,
                                      ),
                                      onTap: () => controller.launchURL(
                                          controller.topUpESignLoanList[0]
                                              .sanctionLetter!.sanctionLetter),
                                    ),
                                  ],
                          ),
                          SizedBox(height: 10),
                          Text(controller.topUpESignLoanList[0].mess!),
                          SizedBox(height: 6),
                          subHeadingText(controller.topUpESignLoanList[0].topupApplicationDoc!.name),
                          Text(Strings.top_up_application_name, style: subHeading),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    scripsNameText('${controller.topUpESignLoanList[0].topupApplicationDoc!.loan}'),
                                    Text(Strings.loan_application_no, style: subHeading),
                                    // SizedBox(height: 10),
                                    // scripsNameText('${topUpESignLoanList[0].topupApplicationDoc!.loan}'),
                                    // Text(Strings.loan_application_no, style: subHeading),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    scripsNameText('₹${controller.topUpESignLoanList[0].topupApplicationDoc!.topUpAmount}'),
                                    Text(Strings.top_up_amount, style: subHeading),
                                  ],
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.only(
                                    bottomLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0),
                                  ),
                                ),
                                foregroundColor: Colors.white,
                                backgroundColor: appTheme,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15.0),
                                child: Text(
                                  Strings.e_sign,
                                  style: buttonTextWhite,
                                ),
                              ),
                              onPressed: ()=> controller.topUpESignClicked(),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      )
          : SizedBox(),
    );
  }

  Widget topUpCard() {
    return Visibility(
      visible: controller.isViewTopUpCard.value,
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              Strings.check_value_title,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: appTheme),
                            ),
                            SizedBox(height: 2),
                            Text(
                              Strings.check_value_subtitle,
                              style: TextStyle(fontSize: 12, color: appTheme),
                            ),
                            SizedBox(height: 10),
                            GestureDetector(
                              child: Container(
                                padding:
                                const EdgeInsets.fromLTRB(10, 6, 10, 6),
                                decoration: BoxDecoration(
                                    color: colorLightAppTheme,
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                                child: Text(
                                  Strings.check_value,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: colorWhite,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              onTap: ()=> controller.topUpLoanClicked(),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 120)
                    ],
                  ),
                ),
                Container(
                  width: 160,
                  height: 120,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(AssetsImagePath.top_up),
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  // Widget pledgePerformanceCard() {
  //   return StreamBuilder(
  //     stream: newDashboardBloc.listAllWeeklyPledged,
  //     builder: (context, AsyncSnapshot<List<WeeklyData>> snapshot) {
  //       if (snapshot.hasData) {
  //         if (snapshot.data == null && snapshot.data!.length == 0) {
  //           return SizedBox(height: 0);
  //         } else {
  //           return Column(
  //             children: [
  //               Card(
  //                 elevation: 2.0,
  //                 color: colorLightGreen,
  //                 shape: RoundedRectangleBorder(
  //                   borderRadius: BorderRadius.all(Radius.circular(10)),
  //                 ),
  //                 child: Padding(
  //                   padding: const EdgeInsets.fromLTRB(20, 16, 10, 16),
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       Container(
  //                         height: 200,
  //                         width: double.infinity,
  //                         child: new charts.LineChart(
  //                           _getSeriesData(snapshot.data!),
  //                           animate: true,
  //                         ),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Text(
  //                         '₹ ${numberToString(snapshot.data![0].weeklyAmountForAllLoans!.toStringAsFixed(2))}',
  //                         style: TextStyle(
  //                             fontSize: 22,
  //                             color: appTheme,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                       Row(
  //                         children: <Widget>[
  //                           Expanded(
  //                             child: Text(
  //                               Strings.pledged_text,
  //                               style: TextStyle(
  //                                   fontSize: 14,
  //                                   color: appTheme,
  //                                   fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                           GestureDetector(
  //                               child: Image.asset(
  //                                 AssetsImagePath.info,
  //                                 width: 16.0,
  //                                 height: 16.0,
  //                                 color: appTheme,
  //                               ),
  //                               onTap: () {
  //                                 minimumValueDialog();
  //                               })
  //                         ],
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: 10),
  //             ],
  //           );
  //         }
  //       } else if (snapshot.hasError) {
  //         return ErrorMessageWidget(error: snapshot.error.toString());
  //       } else {
  //         return SizedBox(height: 0);
  //       }
  //     },
  //   );
  // }
  ///Todo: unused widget
  Future<void> minimumValueDialog() {
    return showDialog<void>(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Container(
            // width: 80,
            // height: 80,
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
                        color: colorLightGray,
                        size: 20,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    child: Column(
                      children: [
                        Text('Graph Parameter', style: boldTextStyle_24),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('X Axis ➠ ', style: boldTextStyle_14),
                                Expanded(
                                    child: Text('Number of weeks',
                                        style: regularTextStyle_14)),
                              ],
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Y Axis ➠ ', style: boldTextStyle_14),
                                Expanded(
                                    child: Text('Total collateral value',
                                        style: regularTextStyle_14)),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ), //
                ),
              ],
            ),
          ),
        );
      },
    );
  }

//   _getSeriesData(List<WeeklyData> weeklyListData) {
// //    var sort = List.generate(
// //        weeklyListData.length, (index) => weeklyListData[index].week)
// //        .toSet()
// //        .toList();
// //    sort.sort((b, a) => a.compareTo(b));
// //    printLog("sort${sort}");
//     List<charts.Series<WeeklyData, int>> security = [
//       charts.Series(
//         id: "Security",
//         data: weeklyListData,
//         domainFn: (WeeklyData security, _) => security.week!,
//         measureFn: (WeeklyData security, _) => security.weeklyAmountForAllLoans,
//         colorFn: (WeeklyData security, _) =>
//             charts.MaterialPalette.blue.shadeDefault,
//         domainUpperBoundFn: (WeeklyData security, _) => 0,
//         domainLowerBoundFn: (WeeklyData security, _) => 60,
//       )
//     ];
//     return security;
//   }

  Widget categoryItemsCard() {
    return Visibility(
      visible: controller.isViewCategoryItem.value,
      child: controller.customer.value!.loanOpen != null && controller.customer.value!.loanOpen == 1
          ? Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(6, 16, 6, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Image.asset(AssetsImagePath.increase_limit,
                              width: 30, height: 30, color: red),
                          SizedBox(height: 5),
                          Text(Strings.increase_loan,
                              style: TextStyle(
                                  color: appTheme,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      ),
                      onTap: ()=>controller.increaseLoanClicked() ,
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Image.asset(AssetsImagePath.credit_score_icon,
                              width: 30, height: 30, color: red),
                          SizedBox(height: 5),
                          Text(Strings.check_your_credit_score,
                              style: TextStyle(
                                  color: appTheme,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      ),
                      onTap: ()  => controller.creditCheckClick(),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Image.asset(AssetsImagePath.check_demat_account,
                              width: 30, height: 30, color: red),
                          SizedBox(height: 5),
                          Text(Strings.check_risk_profile,
                              style: TextStyle(
                                  color: appTheme,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      ),
                      onTap: ()  => controller.checkRiskProfile(),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      child: Column(
                        children: [
                          Image.asset(AssetsImagePath.sell_collateral,
                              width: 30, height: 30, color: red),
                          SizedBox(height: 5),
                          Text(controller.loanType == Strings.shares ? Strings.sell_securities : Strings.invoke,
                              style: TextStyle(
                                  color: appTheme,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center),
                        ],
                      ),
                      onTap: ()=> controller.sellSecuritiesOrInvokeClicked(),
                    ),
                  ),
                  // Expanded(
                  //   child: GestureDetector(
                  //     child: Column(
                  //       children: [
                  //         Image.asset(AssetsImagePath.reminder, width: 30, height: 30, color: red),
                  //         SizedBox(height: 5),
                  //         Text(Strings.add_payment_reminder,
                  //             style: TextStyle(
                  //                 color: appTheme, fontSize: 12, fontWeight: FontWeight.bold),
                  //             textAlign: TextAlign.center),
                  //       ],
                  //     ),
                  //     onTap: (){
                  //       Utility.isNetworkConnection().then((isNetwork) {
                  //         if (isNetwork) {
                  //           commonDialog(context, Strings.coming_soon, 0);
                  //         } else {
                  //           Utility.showToastMessage(Strings.no_internet_message);
                  //         }
                  //       });
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      )
          : SizedBox(),
    );
  }

  Widget youtubeVideoBanner() {
    return controller.videoIDList.length != 0
        ? Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child:
          Text(Strings.understanding_lms, style: boldTextStyle_18),
        ),
        SizedBox(height: 6),
        Container(
          height: 180,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: controller.videoIDList.length,
            itemBuilder: (BuildContext context, int index) {
              return VideoCard(
                title: controller.videoNameList[index].isNotEmpty
                    ? controller.videoNameList[index]
                    : "",
                videoID: controller.videoIDList[index],
                videoIDList: controller.videoIDList,
                titleList: controller.videoNameList,
                controller: controller,
              );
            },
          ),
        ),
        SizedBox(height: 10),
      ],
    )
        : SizedBox();
  }

  ///Todo: unused widget
  Widget playVideoCard() {
    return Visibility(
      visible: controller.isViewPlayVideoCard.value,
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightRed,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 10, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(width: 120),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Strings.lms_title,
                          style: TextStyle(
                              fontSize: 22,
                              color: appTheme,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          Strings.lms_subtitle,
                          style: TextStyle(
                              fontSize: 14,
                              color: appTheme,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        GestureDetector(
                          child: Container(
                            decoration: BoxDecoration(
                                color: red,
                                borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 8, 10, 8),
                              child: Text(
                                Strings.play_video,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colorWhite,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy'),
                              ),
                            ),
                          ),
                          onTap: () {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                // Navigator.push(
                                //     context,
                                //     MaterialPageRoute(
                                //         builder: (BuildContext context) =>
                                //             PlayVideoScreen()));
                              } else {
                                Utility.showToastMessage(
                                    Strings.no_internet_message);
                              }
                            });
                          },
                        ),
                        // SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget inviteCard() {
    return Visibility(
      visible: controller.isViewInviteCard.value,
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightBlue,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 16, 10, 16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              Strings.referral,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: appTheme,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              Strings.rewards,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: red,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          Strings.referral_subtitle,
                          style: TextStyle(
                              fontSize: 14,
                              color: appTheme,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Container(
                          height: 32,
                          width: 115,
                          child: Material(
                            color: appTheme,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            elevation: 1.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              minWidth: Get.width,
                              onPressed: ()=>commonDialog(Strings.coming_soon, 0),
                              child: Text(
                                Strings.invite_friend,
                                style: TextStyle(
                                    fontSize: 14,
                                    color: colorWhite,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Gilroy'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(AssetsImagePath.rewards_icon,
                      width: 60, height: 60, color: red),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget newLoanCard() {
    return Visibility(
      visible: controller.customer.value!.bankUpdate == 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 30),
          largeHeadingText(Strings.get_your_loan),
          SizedBox(height: 10),
          Center(
            child: Text(
              Strings.financial_needs,
              textAlign: TextAlign.center,
              style: mediumTextStyle_16_gray,
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 45,
            width: 130,
            child: Material(
              color: colorBg,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35),
                  side: BorderSide(color: red)),
              elevation: 1.0,
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                minWidth: Get.width,
                onPressed: ()=> controller.newLoanClicked(),
                child: Text(
                  Strings.new_loan,
                  style: buttonTextRed,
                ),
              ),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget kycDetailsPendingCard() {
    return Visibility(
      visible: controller.kycStatus == "New" || controller.kycStatus == "Rejected",
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.kycStatus == "Rejected"
                            ? Strings.kyc_details_rejected : Strings.kyc_details_pending,
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        SizedBox(width: 4),
                        Text(controller.kycStatus == "Rejected"
                            ? Strings.update_kyc_again : Strings.kyc_details_text,
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    height: 24,
                    width: 82,
                    child: Material(
                      color: appTheme,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 1.0,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        minWidth: Get.width,
                        onPressed: ()=> controller.goToCompleteKYCScreen(),
                        child: Text(controller.kycStatus == "Rejected" ?
                        Strings.update_kyc : Strings.add_kyc,
                          style: TextStyle(
                              fontSize: 12,
                              color: colorWhite,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget kycDetailsVerificationPending() {
    return Visibility(
      visible: controller.kycStatus == "Pending",
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.kyc_verification_pending,
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        SizedBox(width: 4),
                        Text(
                          Strings.kyc_verification_process,
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget bankDetailsPendingCard() {
    return Visibility(
      visible: controller.customer.value!.kycUpdate == 1 && (controller.bankStatus.value == "New" || controller.bankStatus.value == "Rejected"),
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.bankStatus == "Rejected" ? Strings.bank_details_rejected : Strings.bank_details_pending,
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        SizedBox(width: 4),
                        Text( controller.bankStatus == "Rejected" ? Strings.update_bank_again : Strings.bank_details_text,
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                  Container(
                    height: 24,
                    width: 86,
                    child: Material(
                      color: appTheme,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                      elevation: 1.0,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        minWidth: Get.width,
                        onPressed: ()=> controller.goToBankDetailScreen(),
                        child: Text(controller.bankStatus == "Rejected" ?
                        Strings.update_bank : Strings.add_bank,
                          style: TextStyle(
                              fontSize: 12,
                              color: colorWhite,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget bankDetailsVerificationPending() {
    return Visibility(
      visible: controller.customer.value!.kycUpdate == 1 && controller.bankStatus == "Pending",
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Strings.bank_verification_pending,
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        SizedBox(width: 4),
                        Text(
                          Strings.bank_verification_process,
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget loanRenewalTimer() {
    return Visibility(
        visible: controller.loanRenewal != null && controller.loanRenewal!.isNotEmpty && controller.isExpired.value && controller.loanRenewal![0].status! == "Pending" && controller.loanRenewal![0].timeRemaining != "0D:00h:00m:00s",
        child: Column(
          children: [
            Card(
              elevation: 2.0,
              color: colorLightYellow,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(AssetsImagePath.warning_icon,
                        height: 35, width: 35, color: red),
                    SizedBox(width: 6),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("TIME IS TICKING⏰",
                              style: TextStyle(
                                  color: red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14)),
                          Text("Hurry! Renew Your Loan Before It Expires!",
                              style: TextStyle(color: appTheme, fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(width: 6),
                    Container(
                      width: 90,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: appTheme,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(6))),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Column(
                          children: [
                            controller.isTimerShow.value
                                ?  TweenAnimationBuilder<Duration>(
                                duration: Duration(days: controller.timerDays.value, hours: controller.timerHours.value, minutes: controller.timerMin.value, seconds: controller.timerSec.value),
                                tween: Tween(
                                    begin: Duration(days: controller.timerDays.value,hours: controller.timerHours.value, minutes: controller.timerMin.value, seconds: controller.timerSec.value),
                                    end: Duration.zero),
                                // onEnd: () {
                                //   setState(() {
                                //     ///DC: already commented
                                //     // isTimerDone = true;
                                //   });
                                // },
                                builder: (BuildContext context, Duration? value, Widget? child) {
                                  final days = (value!.inDays).toString();
                                  final hours = (value.inHours % 24).toString().padLeft(2, '0');
                                  final minutes = (value.inMinutes % 60).toString().padLeft(2, '0');
                                  final seconds = (value.inSeconds % 60).toString().padLeft(2, '0');
                                  String hour = '';
                                  String day = '';
                                  if (hours == '0') {
                                    hour = '';
                                  } else {
                                    hour = '$hours';
                                  }
                                  if (days == '0') {
                                    day = '';
                                  } else {
                                    day = '$days';
                                  }
                                  return Column(
                                    children: [
                                      Text(Strings.time_remaining,
                                          style: TextStyle(fontSize: 9, color: Colors.indigo)),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(vertical: 5),
                                        child: controller.timerDays < 1 ? Text('$hour:$minutes:$seconds', textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red)) :
                                        controller.timerDays == 1 ? Text('$day Day $hour Hour', textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red)) :
                                        controller.timerDays > 1 ? Text('$day Days $hour Hour', textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red)) : SizedBox(),
                                      ),
                                    ],
                                  );
                                })
                                : Padding(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text('Action Taken',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: red,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        )
    );
  }

  Widget loanRenewalPendingCard() {
    return Visibility(
      visible: controller.loanRenewal != null && controller.loanRenewal!.isNotEmpty && controller.loanRenewal![0].tncComplete != 1 && controller.loanRenewal![0].updatedKycStatus != "Pending" && controller.loanRenewal![0].updatedKycStatus! != "Approved" &&  controller.loanRenewal![0].status != "Rejected",
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        controller.loanRenewal!.length != 0 ? Text("Loan Renewal Pending!",
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)) : Container(),
                        SizedBox(width: 4),
                        controller.loanRenewal!.length != 0 ? controller.loanRenewal![0].isExpired == 0 ? Text("Your loan account number ${controller.loanRenewal![0].loan} is due for renewal. Please renew before the expiry date, ${controller.loanRenewal![0].expiryDate}.",
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ) : Text("Your loan account ${controller.loanRenewal![0].loan} is due for renewal. Please RENEW before the time RUNS OUT!",
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ) : Container(),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: appTheme,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Text("Renew Loan",
                          style: TextStyle(
                              fontSize: 12,
                              color: colorWhite,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                    onTap: ()=>controller.goToKycUpdateScreen(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget tncPendingCard() {
    return Visibility(
      visible: controller.loanRenewal!.length != 0 && controller.loanRenewal != null && controller.loanRenewal.toString().isNotEmpty && controller.loanRenewal![0].tncComplete != 1 && controller.loanRenewal![0].updatedKycStatus == "Approved" && controller.loanRenewal![0].updatedKycStatus != "" && controller.loanRenewal![0].status != "Rejected" && controller.loanRenewal![0].tncShow == 0,
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Terms and Conditions",
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        SizedBox(width: 4),
                        Text("Please refer and accept the terms and conditions to proceed with the Loan Renew journey",
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                  GestureDetector(
                    child: Container(
                      decoration: BoxDecoration(
                          color: appTheme,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 5),
                        child: Text("Click Here",
                          style: TextStyle(
                              fontSize: 12,
                              color: colorWhite,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Gilroy'),
                        ),
                      ),
                    ),
                    onTap: ()=>controller.goToLoanSummaryScreen(),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget loanRenewalVerificationPending() {
    return Visibility(
      visible: controller.loanRenewal!.length != 0 && controller.loanRenewal != null && controller.loanRenewal![0].updatedKycStatus! == "Pending" && controller.loanRenewal![0].tncComplete! == 0 && controller.loanRenewal![0].status != "Rejected",
      child: Column(
        children: [
          Card(
            elevation: 2.0,
            color: colorLightYellow,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 14, 10, 14),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(AssetsImagePath.warning_icon,
                      height: 28, width: 28, color: appTheme),
                  SizedBox(width: 4),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("KYC Verification pending",
                            style: TextStyle(
                                color: red,
                                fontWeight: FontWeight.bold,
                                fontSize: 14)),
                        SizedBox(width: 4),
                        Text(
                          "Your KYC verification is in process, please wait for the approval.",
                          style: TextStyle(
                              color: appTheme,
                              fontSize: 10,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 4),
                ],
              ),
            ),
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

}

void feedbackDialog() {
  ///todo: after FeedbackDialog is developed uncomment below code
  //  Get.dialog<void>(
  //   barrierDismissible: false,
  //   FeedbackDialog(),
  // );
}

class LoanSummaryTile extends StatelessWidget {
  final String? acNo;
  final String? status;
  final String? withdrawal;
  final String? odBalance;
  final SellCollateralAvailableEntity? pendingSellCollateral;
  final UnpledgeApplicationAvailableEntity? pendingUnPledge;
  final bool? odBalanceisNegative;
  final String? loanType;
  final HomeController controller;

  const LoanSummaryTile(
      {Key? key,
        this.acNo,
        this.status,
        this.withdrawal,
        this.odBalance,
        this.pendingSellCollateral,
        this.pendingUnPledge,
        this.odBalanceisNegative = false,
        this.loanType,
        required this.controller
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(0, 3, 0, 3),
      decoration: new BoxDecoration(
          color: colorWhite,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.all(Radius.circular(10)),
      // ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 12, 10, 12),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(Strings.loan_no,
                    style: TextStyle(fontSize: 10, color: colorLightAppTheme)),
                SizedBox(height: 3),
                Text('$acNo',
                    style: TextStyle(
                        fontSize: 12,
                        color: appTheme,
                        fontWeight: FontWeight.bold)),
              ],
            ),
            SizedBox(width: 12),
            if (status == Strings.active_loan)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.drawing_power,
                              style: TextStyle(
                                  fontSize: 10, color: colorLightAppTheme)),
                          SizedBox(height: 3),
                          Text('₹$withdrawal',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: appTheme,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.loan_balance,
                              style: TextStyle(
                                  fontSize: 10, color: colorLightAppTheme)),
                          SizedBox(height: 3),
                          Text(odBalanceisNegative! ? negativeValue(double.parse(odBalance!.replaceAll(",", ""))) : '₹$odBalance',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: odBalanceisNegative! ? colorGreen : appTheme,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    // Spacer(),
                    SizedBox(
                      width: 4,
                    ),
                    Image.asset(AssetsImagePath.active_loan_icon,
                        height: 20, width: 20, color: colorGreen),
                    // SizedBox(width: 2),
                    // Image.asset(AssetsImagePath.document,
                    //     height: 20, width: 20, color: appTheme),
                  ],
                ),
              )
            else if (status == Strings.actionable_loan)
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.drawing_power,
                              style: TextStyle(
                                  fontSize: 10, color: colorLightAppTheme)),
                          SizedBox(height: 3),
                          Text('₹$withdrawal',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: appTheme,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(Strings.loan_balance,
                              style: TextStyle(
                                  fontSize: 10, color: colorLightAppTheme)),
                          SizedBox(height: 3),
                          Text(odBalanceisNegative! ? negativeValue(double.parse(odBalance!.replaceAll(",", ""))) : '₹$odBalance',
                              style: TextStyle(
                                  fontSize: 12,
                                  color: odBalanceisNegative! ? colorGreen : appTheme,
                                  fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    // Spacer(),
                    SizedBox(
                      width: 4,
                    ),
                    Image.asset(AssetsImagePath.warning_icon,
                        height: 20, width: 20, color: red),
                    // SizedBox(width: 2),
                    // Image.asset(AssetsImagePath.document,
                    //     height: 20, width: 20, color: appTheme),
                  ],
                ),
              )
            else if (status == Strings.under_process_loan)
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(Strings.new_loan,
                              style: TextStyle(
                                  fontSize: 10,
                                  color: red,
                                  fontWeight: FontWeight.bold)),
                          SizedBox(width: 2),
                          Text('Status',
                              style: TextStyle(fontSize: 10, color: appTheme)),
                        ],
                      ),
                      SizedBox(height: 3),
                      Text(
                        withdrawal!,
                        style: TextStyle(
                            fontSize: 12,
                            color: appTheme,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                )
              else if (status == Strings.loanRenewal)
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(Strings.loanRenewal,
                                style: TextStyle(
                                    fontSize: 10,
                                    color: red,
                                    fontWeight: FontWeight.bold)),
                            SizedBox(width: 2),
                            Text('Status',
                                style: TextStyle(fontSize: 10, color: appTheme)),
                          ],
                        ),
                        SizedBox(height: 3),
                        Text(
                          withdrawal!,
                          style: TextStyle(
                              fontSize: 12,
                              color: appTheme,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                else if (status == Strings.sell_collateral)
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(loanType == Strings.shares ? Strings.sell_collateral : Strings.invoke,
                                        style: TextStyle(
                                            fontSize: 10,
                                            color: red,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(width: 2),
                                    Text('Status',
                                        style:
                                        TextStyle(fontSize: 10, color: appTheme)),
                                  ],
                                ),
                                SizedBox(height: 3),
                                Text(
                                  withdrawal!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: appTheme,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          GestureDetector(
                            child: Image.asset(AssetsImagePath.info,
                                height: 20, width: 20),
                            onTap: ()=> controller.gotoPendingRequestSummarySellCollateral(pendingSellCollateral,loanType) ,
                          ),
                        ],
                      ),
                    )
                  else if (status == Strings.unpledge)
                      Expanded(
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(loanType == Strings.shares ? Strings.unpledge : Strings.revoke,
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: red,
                                              fontWeight: FontWeight.bold)),
                                      SizedBox(width: 2),
                                      Text('Status',
                                          style:
                                          TextStyle(fontSize: 10, color: appTheme)),
                                    ],
                                  ),
                                  SizedBox(height: 3),
                                  Text(
                                    withdrawal!,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: appTheme,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              child: Image.asset(AssetsImagePath.info,
                                  height: 20, width: 20),
                              onTap: ()=>controller.gotoPendingRequestSummaryUnpledgeRevoke(pendingUnPledge,loanType),
                            ),
                          ],
                        ),
                      )
                    else if (status == Strings.top_up)
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(Strings.top_up,
                                      style: TextStyle(
                                          fontSize: 10,
                                          color: red,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(width: 2),
                                  Text('Status',
                                      style: TextStyle(fontSize: 10, color: appTheme)),
                                ],
                              ),
                              SizedBox(height: 3),
                              Text(withdrawal!,
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: appTheme,
                                      fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
          ],
        ),
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String? videoID;
  final String? title;
  final List<String>? videoIDList;
  final List<String>? titleList;
  final HomeController? controller;

  const VideoCard(
      {Key? key, this.videoID, this.title, this.videoIDList, this.titleList, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Card(
        elevation: 2.0,
        color: colorLightGray,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Container(
          height: 180,
          width: 300,
          decoration: new BoxDecoration(
            color: colorLightGray,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Stack(children: <Widget>[
            Container(
              height: 180,
              width: 300,
              decoration: new BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage('https://i3.ytimg.com/vi/${videoID}/maxresdefault.jpg'
                  ),
                ),
                color: colorWhite,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 6),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(
                        title!,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          color: appTheme,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Image.asset(AssetsImagePath.youtube,
                        height: 30, width: 40, fit: BoxFit.cover),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: ()=> controller!.goToYoutubeVideoPlayer(videoID!, title!),
              child: Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class ReusableProcessBar extends StatefulWidget {
  final Icon? processBarIcon;

  ReusableProcessBar({this.processBarIcon});

  @override
  _ReusableProcessBarState createState() => _ReusableProcessBarState();
}

class _ReusableProcessBarState extends State<ReusableProcessBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    // set border width
                    borderRadius: BorderRadius.all(
                        Radius.circular(30.0)) // set rounded corner radius
                ),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 15.0,
                    child: widget.processBarIcon)),
          ],
        ),
      ],
    );
  }
}

class ReusableProcessCheckedBar extends StatefulWidget {
  final Icon? processBarIcon;

  ReusableProcessCheckedBar({this.processBarIcon});

  @override
  _ReusableProcessCheckedBarState createState() =>
      _ReusableProcessCheckedBarState();
}

class _ReusableProcessCheckedBarState extends State<ReusableProcessCheckedBar> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 10.0, top: 10.0),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(
                        Radius.circular(30.0)) // set rounded corner radius
                ),
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 18.0,
                    child: widget.processBarIcon)),
          ],
        ),
      ],
    );
  }
}

