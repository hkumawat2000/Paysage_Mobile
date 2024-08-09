
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/controllers/margin_shortfall_controller.dart';
import 'package:lms/common_widgets/ResusableIcon.dart';
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/strings.dart';
import 'package:flutter/material.dart';

///todo: while redirecting to MarginShortfallScreen, add MarginShortfallArguments
class MarginShortfallView extends GetView<MarginShortfallController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: controller.scaffoldKey,
      backgroundColor: colorBg,
      appBar: AppBar(
        leading: IconButton(
          icon: ArrowToolbarBackwardNavigation(),
          onPressed: () => Get.back(),
        ),
        backgroundColor: colorBg,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          controller.marginShortfallArguments.loanData!.loan!.name!,
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
                StockAtCart("Margin Shortfall", controller.marginShortfallArguments.pledgorBoid!),
                marginShortFall(
                    controller.marginShortfallArguments.loanData!.marginShortfall!.loanBalance,
                    controller.marginShortfallArguments.loanData!.marginShortfall!.shortfallC,
                    controller.marginShortfallArguments.loanData!.marginShortfall!.minimumCashAmount,
                    controller.marginShortfallArguments.loanData!.loan!.drawingPower,
                    AssetsImagePath.business_finance,
                    colorLightRed,
                    true, controller.marginShortfallArguments.loanData!.loan!.instrumentType!),
              ],
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              child: Text(controller.marginShortfallArguments.loanType == Strings.shares ?
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
                      onTap: ()=> controller.payAmountClicked(),
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
                      onTap: ()=>controller.pledgeMoreClicked(),
                    ),
                    SizedBox(width: 10),
                    GestureDetector(
                      child: ReusableIconTextContainerCard(
                        cardIcon: Image.asset(AssetsImagePath.sell_collateral, height: 36, width: 36,color: red),
                        cardText: controller.marginShortfallArguments.loanType == Strings.shares ? Strings.sell : Strings.invoke,
                        circleColor: colorLightRed,
                      ),
                      onTap: ()=>controller.sellOrInvokeClicked(),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Visibility(
              visible: controller.marginShortfallArguments.isRequestPending!,
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
                          onTap: ()=> commonDialog(controller.marginShortfallArguments.msg, 0),
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
}