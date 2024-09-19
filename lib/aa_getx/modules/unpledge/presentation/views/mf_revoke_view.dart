
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/unpledge/presentation/controllers/mf_revoke_controller.dart';
import 'package:lms/common_widgets/ReusableAmountWithTextAndDivider.dart';

class MfRevokeView extends GetView<MfRevokeController>{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Obx(
        () => Scaffold(
            key: controller.scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: colorBg,
            appBar: buildBar(context),
            body: controller.unpledgeDetailsResponse != null
                ? controller.unpledgeDetailsResponse!.data!.unpledge != null
                    ? allUnpledgeData()
                    : Center(child: Text(Strings.no_loan))
                : Center(child: Text(Strings.please_wait))),
      ),
    );
  }

  Widget allUnpledgeData(){
    return ScrollConfiguration(
      behavior: new ScrollBehavior(),
      //..buildViewportChrome(context, Container(), AxisDirection.down),
      child: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 8.0),
                  child: Row(
                    children: <Widget>[
                      headingText(Strings.revoke_scheme),
                    ],
                  ),
                ),
                unpledgeCartDetails(),
              ]),
            ),
          ];
        },
        body: Column(
          children: <Widget>[
            controller.textController.text.isNotEmpty ? SizedBox() :Padding(
              padding: const EdgeInsets.only(left: 20, right: 20,top: 10,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: scripsNameText(Strings.select_scheme_to_revoke),
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: colorGreen,
                      onChanged: (bool? newValue) {
                        controller.altercheckBox(newValue);
                        controller.resetValue = newValue;
                      },
                      value: controller.checkBoxValue,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: unpledgeSecuritiesList(),
              ),
            ),
            unpledgeBottomSheet()
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget buildBar(BuildContext context) {
    final theme = Theme.of(context);
    return new AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: controller.appBarTitle,
      backgroundColor: colorBg,
      leading: IconButton(
        icon: ArrowToolbarBackwardNavigation(),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        Theme(
          data: theme.copyWith(primaryColor: Colors.white),
          child: new IconButton(
            icon: controller.actionIcon,
            onPressed: ()=> controller.actionIconPressed(),
          ),
        ),
      ],
    );
  }

  Widget unpledgeSecuritiesList(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 0, right: 20, bottom: 150),
      child: controller.unpledgeItemsList.length == 0
          ? Padding(padding: const EdgeInsets.only(top: 150.0), child: Center(child: Text(Strings.search_result_not_found))) :
      ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.unpledgeItemsList.length,
        key: Key(controller.unpledgeItemsList.length.toString()),
        itemBuilder: (context, index) {
          if(controller.pageArguments.isComingFor == Strings.single){
            if(controller.unpledgeItemsList[index].isin == controller.pageArguments.isin && controller.unpledgeItemsList[index].folio == controller.pageArguments.folio){
              controller.checkBoxValues.add(true);
              controller.isAddBtnShow.add(false);
              controller.unpledgeItemsList[index].check = true;
              controller.unpledgeData.loan!.totalCollateralValue = controller.selectedSecurityValue;
              controller.isScripsSelect = false;
              controller.isUnpledgeAlert = false;
            } else {
              controller.isAddBtnShow.add(true);
              controller.checkBoxValues.add(false);
              controller.unpledgeItemsList[index].check = false;
            }
          } else {
            controller.isAddBtnShow.add(true);
            controller.checkBoxValues.add(false);
            controller.unpledgeItemsList[index].check = false;
          }
          int actualIndex = controller.searchMyCartList.indexWhere((element) => element.isin == controller.unpledgeItemsList[index].isin && element.folio == controller.unpledgeItemsList[index].folio);
          String unpledgeQty;
          String strUnpledge = controller.unpledgeItemsList[index].pledgedQuantity!.toString();
          if(controller.isAddBtnShow[actualIndex]) {
            unpledgeQty = 0.toString();
          } else {
            unpledgeQty = strUnpledge;
          }
          controller.unpledgeItemsList[index].pledgedQuantity = double.parse(unpledgeQty);
          controller.controllers[actualIndex] = TextEditingController(text: controller.unitStringList[actualIndex]);
          controller.controllers[actualIndex].selection =TextSelection.fromPosition(TextPosition(offset: controller.controllers[actualIndex].text.length));
          controller.unPledgeControllerEnable.add(false);
          if(index + 1 == controller.unpledgeItemsList.length) {
            controller.calculatePercentage(false);
          }
          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 3.0), // set border width
              borderRadius: BorderRadius.all(Radius.circular(10.0)), // set rounded corner radius
              // make rounded corner of border
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("${controller.unpledgeItemsList[index].securityName!} [${controller.unpledgeItemsList[index].folio}]", style: boldTextStyle_18),
                SizedBox(height: 4),
                Text("${controller.unpledgeItemsList[index].securityCategory!} (LTV: ${controller.unpledgeItemsList[index].eligiblePercentage!.toStringAsFixed(2)}%)",
                    style: boldTextStyle_12_gray),
                SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: (MediaQuery.of(context).size.width - 150) / 3,
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  scripsValueText("₹${controller.unpledgeItemsList[index].price!.toStringAsFixed(2)}"),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(child: Text("${controller.actualQtyList![actualIndex].toString()} QTY", style: mediumTextStyle_12_gray)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      controller.isAddBtnShow[actualIndex] ?
                      Container(
                        height: 30,
                        width: 70,
                        child: Material(
                          color: appTheme,
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          elevation: 1.0,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: ()=>controller.addBtnClicked(index, actualIndex),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Add +",
                                  style: TextStyle(color: colorWhite, fontSize: 10, fontWeight: bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ):
                      Column(
                        children: [
                          Row(
                            children: <Widget>[
                              IconButton(
                                iconSize: 20.0,
                                icon: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(width: 1, color: colorBlack)),
                                  child: Icon(
                                    Icons.remove,
                                    color: colorBlack,
                                    size: 18,
                                  ),
                                ),
                                onPressed: ()=>controller.removeClicked(index, actualIndex),
                              ),
                              Container(
                                width: 60,
                                height: 65,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: controller.controllers[actualIndex],
                                  decoration: InputDecoration(counterText: ""),
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    DecimalTextInputFormatter(decimalRange: 3),
                                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,3}')),
                                  ],
                                  style: boldTextStyle_18,
                                  onChanged: (value)=>controller.textOnChanged(index, actualIndex),
                                ),
                              ),
                              IconButton(
                                iconSize: 20,
                                icon: Container(
                                  padding: EdgeInsets.all(2),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      border: Border.all(width: 1, color: colorBlack)),
                                  child: Icon(
                                    Icons.add,
                                    color: colorBlack,
                                    size: 18,
                                  ),
                                ),
                                onPressed: ()=> controller.addClicked(index, actualIndex),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Container(
                        width: 72,
                        height: 73,
                        child: Container(
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: colorRed,
                            borderRadius: BorderRadius.all(
                                Radius.circular(100.0)),
                          ),
                          child:Text(getInitials(controller.unpledgeItemsList[index].securityName, 1), style: extraBoldTextStyle_30),
                        ), //Container ,
                      ),
                    ],
                  ),
                ),
                !controller.isAddBtnShow[actualIndex] ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings.value + " : ${numberToString((controller.unpledgeItemsList[index].price! * double.parse(controller.controllers[actualIndex].text.isEmpty ? "0" : controller.controllers[actualIndex].text.toString())).toStringAsFixed(2))}", style: mediumTextStyle_14_gray),
                  ],
                ) : SizedBox(),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget unpledgeCartDetails(){
    return Container(
      margin: EdgeInsets.fromLTRB(20, 4, 20, 4),
      padding: EdgeInsets.symmetric(vertical: 15.0),
      decoration: BoxDecoration(
        color: colorLightBlue,
        border: Border.all(color: colorLightBlue, width: 3.0), // set border width
        borderRadius:
        BorderRadius.all(Radius.circular(10.0)), // set rounded corner radius
      ),
      child: Column(
        children: <Widget>[
          Stack(
            children: [
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(controller.loanBalance < 0 ? negativeValue(controller.loanBalance) : '₹${numberToString(controller.loanBalance.toStringAsFixed(2))}',
                        textAlign: TextAlign.center,
                        style: subHeadingValue.copyWith(
                            color: controller.loanBalance < 0 ? colorGreen : appTheme
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 3.0),
                        child: Text(
                          Strings.loan_balance, textAlign: TextAlign.center,
                          style: subHeading,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          ReusableAmountWithTextAndDivider(
            leftAmount: Strings.rupee + numberToString(controller.existingDrawingPower!.toStringAsFixed(2)),
            leftText: Strings.existing_drawing_power,
            rightAmount: '₹${numberToString((roundDouble(controller.revisedDrawingPower!, 2)).toStringAsFixed(2))}',
            rightText: Strings.revised_drawing_power,
          ),
          ReusableAmountWithTextAndDivider(
            leftAmount: Strings.rupee + numberToString(controller.existingCollateral.toStringAsFixed(2)),
            leftText:Strings.existing_collateral ,
            rightAmount: Strings.rupee + numberToString(roundDouble((controller.existingCollateral - controller.selectedSecurityValue), 2).toStringAsFixed(2)),
            rightText: Strings.remaining_collateral,
          ),
        ],
      ),
    );
  }

  Widget unpledgeBottomSheet(){
    if (controller.selectedScips != 0) {
      controller.isScripsSelect = false;
      controller.isUnpledgeAlert = false;
    } else {
      controller.isScripsSelect = true;
    }

    return Container(
      decoration: BoxDecoration(
          color: colorWhite,
          border: Border.all(color: colorWhite, width: 3.0), // set border width
          borderRadius:
          BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: colorLightGray, offset: Offset(1, 3))
          ]
      ),
      child: Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Visibility(
                visible: !controller.canUnpledge,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(Strings.revoke_alert_msg,
                    style: TextStyle(color: red, fontSize: 16),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Text(Strings.selected_schemes_value,
                      style: TextStyle(fontSize: 18.0, color: colorBlack),
                    ),
                  ),
                  Text(roundDouble(controller.selectedSecurityValue, 2) < 0
                      ? negativeValue(roundDouble(controller.selectedSecurityValue, 2))
                      : '₹' + numberToString(roundDouble(controller.selectedSecurityValue, 2).toStringAsFixed(2)),
                    style: bottomSheetValueTextStyle,
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Row(
                      children: [
                        Text(Strings.revocation_charges,
                          style: TextStyle(fontSize: 18.0, color: colorBlack),
                        ),
                        SizedBox(width: 2),
                        GestureDetector(
                          child: Image.asset(AssetsImagePath.info,
                              height: 16, width: 16),
                          onTap: () {
                            commonDialog( Strings.revocation_charges_info, 0);
                          },
                        ),
                      ],
                    ),
                  ),
                  controller.revocationChargeType == "Fix"
                      ? Text('₹${controller.revocationCharge.toStringAsFixed(2)}',
                    style: bottomSheetValueTextStyle,
                  )
                      : controller.selectedSecurityValue > 0 ? Text('₹${numberToString(controller.revocationCharge.toStringAsFixed(2))}',
                    style: bottomSheetValueTextStyle,
                  ):Text('₹0.00',
                    style: bottomSheetValueTextStyle,
                  )
                ],
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 45,
                    width: 100,
                    child: Material(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      elevation: 1.0,
                      color: controller.canUnpledge && controller.selectedScips != 0 ? appTheme : colorLightGray,
                      child: AbsorbPointer(
                        absorbing: controller.canUnpledge && controller.selectedScips != 0 ? false : true,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: Get.mediaQuery.size.width,
                          onPressed: ()=>controller.submitClicked(),
                          child: Text(Strings.submit, style: buttonTextWhite),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}