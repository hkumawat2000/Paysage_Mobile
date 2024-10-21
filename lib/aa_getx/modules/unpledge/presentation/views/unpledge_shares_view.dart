
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/unpledge/presentation/controllers/unpledge_shares_controller.dart';
import 'package:lms/common_widgets/ReusableAmountWithTextAndDivider.dart';

class UnpledgeSharesView extends GetView<UnpledgeSharesController>{
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Obx(
        () => Scaffold(
            key: controller.scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: colorBg,
            appBar: buildBar(context),
            body: controller.isAPIRespond.isTrue
                ? allUnpledgeData()
                : Center(child: Text(Strings.please_wait)),
        ),
      ),
    );
  }

  Widget allUnpledgeData(){
    return ScrollConfiguration(
      behavior: new ScrollBehavior(),
      //..buildViewportChrome(context, Container(), AxisDirection.down),
      child: NestedScrollView(
        physics: AlwaysScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 8.0),
                  child: Row(
                    children: <Widget>[
                      headingText(controller.pageArguments.loanType == Strings.shares ? Strings.unpledge_security : Strings.revoke_scheme),
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
                    child: scripsNameText(controller.pageArguments.loanType == Strings.shares
                        ? Strings.select_securities_to_unpledge
                        : Strings.select_scheme_to_revoke),
                  ),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: colorGreen,
                      onChanged: (bool? newValue) {
                        Get.focusScope?.unfocus();
                        controller.alterCheckBox(newValue);
                        // resetValue = newValue;
                      },
                      value: controller.checkBoxValue.value,
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
            onPressed: ()=> controller.actionIconClicked(),
          ),
        ),
      ],
    );
  }

  Widget unpledgeSecuritiesList(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 0, right: 20, bottom: 10),
      child: controller.unpledgeItemsList.length == 0 ?
      Padding(padding: const EdgeInsets.only(top: 150.0), child: Center(child: Text(Strings.search_result_not_found))) :
      ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.unpledgeItemsList.length,
        key: Key(controller.unpledgeItemsList.length.toString()),
        itemBuilder: (context, index) {
          int actualIndex = controller.actualMyCartList.indexWhere((element) => element.securityName == controller.unpledgeItemsList[index].securityName);
          String unpledgeQty;
          if(controller.isAddBtnShow[actualIndex]){
            unpledgeQty = 0.toString();
          } else {
            unpledgeQty = controller.unpledgeItemsList[index].pledgedQuantity!.toInt().toString().split('.')[0];
          }
          controller.unpledgeItemsList[index].pledgedQuantity = double.parse(unpledgeQty);
          if(index == controller.unpledgeItemsList.length){
            // setState(() { ///Todo: setState
            // });
          }

          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(controller.unpledgeItemsList[index].securityName!, style: boldTextStyle_18),
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
                                      Expanded(child: Text("${controller.unpledgeQtyList![actualIndex].toInt().toString()} QTY", style: mediumTextStyle_12_gray)),
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
                            onPressed: ()=> controller.addButtonClicked(index, actualIndex),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Add +", style: TextStyle(color: colorWhite, fontSize: 10, fontWeight: bold))
                              ],
                            ),
                          ),
                        ),
                      ) :
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
                                onPressed: ()=> controller.removeClicked(index, actualIndex),
                              ),
                              Container(
                                width: 60,
                                height: 65,
                                child: TextField(
                                  textAlign: TextAlign.center,
                                  controller: controller.qtyControllers[actualIndex],
                                  focusNode: controller.focusNode[actualIndex],
                                  decoration: InputDecoration(counterText: ""),
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                  ],
                                  style: boldTextStyle_18,
                                  onChanged: (value)=> controller.onQtyChanged(index, actualIndex),
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
                    Text(Strings.value + " : ${(controller.actualMyCartList[actualIndex].price! * double.parse(controller.qtyControllers[actualIndex].text.isEmpty ? "0" : controller.qtyControllers[actualIndex].text.toString())).toStringAsFixed(2)}", style: mediumTextStyle_14_gray),
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
    // revisedDrawingPower = ((existingCollateral - totalValue)/2).toString();
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
                      Text(controller.loanBalance! < 0
                          ? negativeValue(controller.loanBalance!)
                          : '₹${numberToString(controller.loanBalance!.toStringAsFixed(2))}',
                        textAlign: TextAlign.center,
                        style: subHeadingValue.copyWith(
                            color: controller.loanBalance! < 0 ? colorGreen : appTheme
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
            leftAmount: Strings.rupee + numberToString(controller.existingCollateral!.toStringAsFixed(2)),
            leftText:Strings.existing_collateral ,
            rightAmount: Strings.rupee + numberToString(roundDouble((controller.existingCollateral! - controller.totalValue), 2).toStringAsFixed(2)),
            rightText: Strings.remaining_collateral,
          ),
        ],
      ),
    );
  }

  Widget unpledgeBottomSheet(){
    return Container(
      decoration: BoxDecoration(
          color: colorWhite,
          border: Border.all(color: colorWhite, width: 3.0),
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
                  child: Text(Strings.unpledge_alert_msg, style: TextStyle(color: red, fontSize: 16),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: Text(Strings.security_value, style: mediumTextStyle_18_gray)),
                  Text(controller.totalValue < 0 ? negativeValue(controller.totalValue)
                      : '₹' + numberToString(controller.totalValue.toStringAsFixed(2)),
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
                      color: controller.canUnpledge && controller.selectedScrips > 0 ? appTheme : colorLightGray,
                      child: AbsorbPointer(
                        absorbing: controller.canUnpledge && controller.selectedScrips > 0 ? false : true,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: Get.mediaQuery.size.width,
                          onPressed: ()=> controller.unpledgeRequestOTP(),
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

  Future<void> minimumValueDialog() {
    return Get.dialog<void>(
      barrierDismissible: true,
        AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: Container(
            width: 80,
            height: 80,
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
                      onTap: ()=> Get.back(),
                    ),
                  ],
                ),
                Center(
                  child: Container(
                    child: Column(
                      children: [
                        Text(Strings.minimum_value, style: regularTextStyle_14_gray),
                        SizedBox(height: 8),
                        Text(controller.unpledgeData.value.unpledge!.unpledgeValue!.minimumCollateralValue! < 0
                            ? negativeValue(controller.unpledgeData.value.unpledge!.unpledgeValue!.minimumCollateralValue!)
                            : Strings.rupee + numberToString(controller.unpledgeData.value.unpledge!.unpledgeValue!.minimumCollateralValue!.toStringAsFixed(2)),
                            style: boldTextStyle_18_gray_dark),
                      ],
                    ),
                  ), //
                ),
              ],
            ),
          ),
        ),
    );
  }
  
}