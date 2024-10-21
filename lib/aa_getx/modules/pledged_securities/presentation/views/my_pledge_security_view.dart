
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/pledged_securities/presentation/controllers/my_pledge_security_controller.dart';

class MyPledgeSecurityView extends GetView<MyPledgeSecurityController>{
  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          key: controller.scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBg,
      appBar: AppBar(
        backgroundColor: colorBg,
        elevation: 0,
        centerTitle: true,
        title: Text(controller.loanName.value, style: mediumTextStyle_18_gray_dark),
      ),
      body: myPledgedSecuritiesBody()
    ));
  }

  Widget myPledgedSecuritiesBody() {
    return RefreshIndicator(
      onRefresh: controller.pullRefresh,
      child: SingleChildScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        child: controller.pledgedResponse.value != null ? Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 15),
              child: Row(
                children: [
                  Expanded(child: headingText(controller.loanType == Strings.shares ? "My Pledged Securities" : "My Pledged Schemes")),
                ],
              ),
            ),
            myPledgedSecuritiesCard(),
            myPledgedSecuritiesOption(),
            Padding(
              padding: const EdgeInsets.fromLTRB(14, 20, 15, 8),
              child: Row(
                children: [
                  Text(controller.loanType == Strings.shares ? 'Security' : 'Schemes', style:boldTextStyle_18),
                ],
              ),
            ),
            myPledgedSecuritiesList(),
            SizedBox(height: 70)
          ],
        ) :
        Container(
          height: Get.height,
          width: Get.width,
          child: Column(
            children: [
              Expanded(child: Center(child: Text(controller.responseText.value))),
              SizedBox(
                height: 80,
              ),
            ],
          ),
        ),
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
                  Text(controller.totalValue < 0
                      ? negativeValue(controller.totalValue.value)
                      : '₹${numberToString(controller.totalValue.toStringAsFixed(2))}',
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
                                controller.selectedScrips.value,
                                style: subHeadingValue,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 3.0),
                                child: Text(controller.loanType == Strings.shares ? Strings.scrips : Strings.schemes, style: subHeading),
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
                              Text(controller.drawingPower < 0
                                  ? negativeValue(controller.drawingPower.value)
                                  : '₹${numberToString(controller.drawingPower.toStringAsFixed(2))}',
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
                          controller.loanType == Strings.shares ?
                          Strings.pledged_securities_transaction : Strings.pledged_schemes_transaction,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      onPressed: ()=>controller.pledgedSecuritiesOrSchemesTransactionsClicked(),
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
                cardText: controller.loanType == Strings.shares ? Strings.unpledge : Strings.revoke,
                circleColor: colorLightGreen,
              ),
              onTap: ()=>controller.unPledgeOrRevokeClicked(),
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
              onTap: ()=> controller.pledgeMoreClicked(),
            ),
            SizedBox(width: 10),
            GestureDetector(
              child: ReusableIconTextContainerCard(
                cardIcon: Image.asset(AssetsImagePath.sell_collateral, height: 36, width: 36,color: red),
                cardText: controller.loanType == Strings.shares ? Strings.sell : Strings.invoke,
                circleColor: colorLightRed,
              ),
              onTap: ()=> controller.sellOrInvokeClicked(),
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
      itemCount: controller.allPledgedSecurities.length,
      itemBuilder: (context, index) {
        for(int i = 0; i<controller.allPledgedSecurities.length; i++){
          controller.pressDownList.add(false);
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
                          Text(controller.loanType == Strings.shares
                              ? controller.allPledgedSecurities[index].securityName!
                              : "${controller.allPledgedSecurities[index].securityName!} [${controller.allPledgedSecurities[index].folio}]",
                            style: TextStyle(
                                color: appTheme,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 4),
                          Text(
                              "${controller.allPledgedSecurities[index].securityCategory!} (LTV: ${controller.allPledgedSecurities[index].eligiblePercentage!.toStringAsFixed(2)}%)",
                              style: boldTextStyle_12_gray),
                        ],
                      ),
                    ),
                    controller.allPledgedSecurities[index].pledgedQuantity! >= 0.001 &&
                        controller.allPledgedSecurities[index].amount! >= 0.001
                        ? IconButton(
                      icon: Icon(
                        controller.pressDownList[index] == true
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        size: 30.0,
                        color: colorGrey,
                      ),
                      padding: EdgeInsets.zero,
                      onPressed: () =>
                                controller.pressDownList[index] == true
                                    ? controller.pressDownList[index] = false
                                    : controller.pressDownList[index] = true,
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
                        scripsValueText(controller.loanType == Strings.shares
                            ? controller.allPledgedSecurities[index]
                            .pledgedQuantity!
                            .toInt()
                            .toString()
                            : controller.allPledgedSecurities[index]
                            .pledgedQuantity!
                            .toString()),
                        SizedBox(
                          height: 5,
                        ),
                        mediumHeadingText(controller.loanType == Strings.shares
                            ? Strings.qty
                            : Strings.units),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        scripsValueText(controller.loanType == Strings.shares
                            ? controller.allPledgedSecurities[index]
                            .price!
                            .toStringAsFixed(2)
                            : controller.allPledgedSecurities[index].price!.toString()),
                        SizedBox(
                          height: 5,
                        ),
                        mediumHeadingText(controller.loanType == Strings.shares
                            ? Strings.price
                            : Strings.nav),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        scripsValueText(controller.loanType == Strings.shares
                            ? controller.allPledgedSecurities[index]
                            .amount!
                            .toStringAsFixed(2)
                            : controller.allPledgedSecurities[index].amount!.toString()),
                        SizedBox(
                          height: 5,
                        ),
                        mediumHeadingText(Strings.value),
                      ],
                    ),
                  ]),
                ]),
                Obx(()=>
                Visibility(
                  visible: controller.pressDownList[index],
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
                              controller.loanType == Strings.shares
                                  ? 'Unpledge'
                                  : "Revoke",
                              style: TextStyle(fontSize: 12.0),
                            ),
                            onPressed: ()=>controller.pressDownUnpledgeOrRevokeClicked(),
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
                              controller.loanType == Strings.shares
                                  ? 'Sell'
                                  : Strings.invoke,
                              style: TextStyle(fontSize: 12.0),
                            ),
                            onPressed: ()=>controller.pressDownSellOrInvokeClicked(index),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),),
              ],
            ),
          ),
        );
      },
    );
  }

}