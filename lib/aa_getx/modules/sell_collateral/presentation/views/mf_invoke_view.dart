import 'dart:ffi';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/controllers/mf_invoke_controller.dart';

class MfInvokeView extends GetView<MfInvokeController>{

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Obx(()=>Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: colorBg,
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context),
        body: controller.isAPIRespond.value
            ? sellCollateralBody()
            : Center(child: Text(Strings.please_wait),
        ),
      ),
     ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    final theme = Theme.of(context);
    return new AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: controller.appBarTitle,
      backgroundColor: colorBg,
      leading: IconButton(
        icon: ArrowToolbarBackwardNavigation(),
        onPressed: ()=> Get.back(),
      ),
      actions: <Widget>[
        Theme(
          data: theme.copyWith(primaryColor: Colors.white),
          child: new IconButton(
            icon: controller.actionIcon.value,
            onPressed: ()=> controller.actionIconClicked(),
          ),
        ),
      ],
    );
  }

  Widget sellCollateralBody() {
    double postSaleLoanBL = 0;
    if(controller.invokeChargeData.value.invokeInitiateChargeType == 'Fix'  && controller.totalValue.value <= 0){
      postSaleLoanBL = controller.loanData.value.balance! - controller.totalValue.value;
    } else {
      postSaleLoanBL = controller.loanData.value.balance! - controller.totalValue.value + controller.invokeCharge!.value;
    }

    return ScrollConfiguration(
      behavior: new ScrollBehavior(),
      // ..buildViewportChrome(context, Container(), AxisDirection.down),
      child: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 6),
                            child: headingText(Strings.invoke_scheme),
                          ),
                        ],
                      ),
                      Card(
                        elevation: 0.0,
                        color: colorWhite,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              controller.isMarginShortFall.value
                                  ? ReusableSellAmountText(
                                sellText: 'Margin shortfall',
                                sellAmount: controller.vlMarginShortFall.value < 0
                                    ? negativeValue(controller.vlMarginShortFall.value)
                                    : '₹${numberToString(controller.vlMarginShortFall.value.toStringAsFixed(2))}',
                                sellAmountColor: red,
                                iIcon: false,
                              )
                                  : SizedBox(height: 0),
                              ReusableSellAmountText(
                                sellText:'Selected schemes value',
                                sellAmount: controller.totalValue.value < 0
                                    ? negativeValue(controller.totalValue.value)
                                    : '₹${numberToString(controller.totalValue.value.toStringAsFixed(2))}',
                                sellAmountColor: colorGreen,
                                iIcon: false,
                              ),
                              controller.isMarginShortFall.value
                                  ?  ReusableSellAmountText(
                                sellText: 'Minimum desired value',
                                sellAmount: controller.vlDesiredValue.value < 0
                                    ? negativeValue(controller.vlDesiredValue.value)
                                    : '₹${numberToString(controller.vlDesiredValue.value.toStringAsFixed(2))}',
                                sellAmountColor: red,
                                iIcon: false,
                              ): SizedBox(height: 0),
                              ReusableSellAmountText(
                                sellText: 'Remaining schemes value',
                                sellAmount: (double.parse(controller.totalCollateral.value.toStringAsFixed(2)) - double.parse(controller.totalValue.value.toStringAsFixed(2))) < 0
                                    ? negativeValue((double.parse(controller.totalCollateral.value.toStringAsFixed(2))  - double.parse(controller.totalValue.value.toStringAsFixed(2))))
                                    : '₹${numberToString((double.parse(controller.totalCollateral.value.toStringAsFixed(2))  - double.parse(controller.totalValue.value.toStringAsFixed(2))).toStringAsFixed(2))}',
                                sellAmountColor: colorDarkGray,
                                iIcon: false /*true*/,
                              ),
                              ReusableSellAmountText(
                                sellText: 'Revised drawing power',
                                sellAmount: (controller.actualDrawingPower.value - controller.selectedSchemeEligibility!.value) < 0
                                    ? negativeValue((controller.actualDrawingPower.value - controller.selectedSchemeEligibility!.value))
                                    : '₹${numberToString((controller.actualDrawingPower.value - controller.selectedSchemeEligibility!.value).toStringAsFixed(2))}',
                                sellAmountColor: (controller.actualDrawingPower.value - controller.selectedSchemeEligibility!.value) < 0 ? colorGreen : colorDarkGray,
                                iIcon: false,
                              ),
                              ReusableSellAmountText(
                                sellText: 'Existing loan balance',
                                sellAmount: controller.loanData.value.balance! < 0
                                    ? negativeValue(controller.loanData.value.balance!)
                                    : '₹${numberToString(controller.loanData.value.balance!.toStringAsFixed(2))}',
                                sellAmountColor: controller.loanData.value.balance! < 0 ? colorGreen : colorDarkGray,
                                iIcon: false,
                              ),ReusableSellAmountText(
                                sellText: 'Invocation Charges',
                                sellAmount: controller.invokeChargeData.value.invokeInitiateChargeType == 'Fix'
                                    ? controller.invokeCharge!.value < 0 ? negativeValue(controller.invokeCharge!.value) : '₹${numberToString(controller.invokeCharge!.value.toStringAsFixed(2))}'
                                    : controller.totalValue.value > 0 ? '₹${numberToString(controller.invokeCharge!.value.toStringAsFixed(2))}' : '₹0.00',
                                sellAmountColor: controller.invokeCharge!.value < 0 ? colorGreen : colorDarkGray,
                                iIcon: true,
                              ),
                              ReusableSellAmountText(
                                sellText: 'Post sale loan balance',
                                sellAmount: postSaleLoanBL < 0
                                    ? negativeValue(postSaleLoanBL)
                                    : '₹${numberToString(postSaleLoanBL.toStringAsFixed(2))}',
                                sellAmountColor: postSaleLoanBL < 0 ? colorGreen : colorDarkGray,
                                iIcon: true,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
              ),
            )
          ];
        },
        body: Column(
          children: <Widget>[
            controller.textController.text.isNotEmpty ? SizedBox() : Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: scripsNameText('Select Schemes to Invoke')),
                  SizedBox(
                    width: 20,
                    height: 20,
                    child: Checkbox(
                      checkColor: Colors.white,
                      activeColor: colorGreen,
                      onChanged: (bool? newValue) {
                        controller.alterCheckBox(newValue);
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
                child: sellCollateralList(),
              ),
            ),
            bottomSectionNavigator(),
          ],
        ),
      ),
    );
  }

  Widget sellCollateralList() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 16, bottom: 150),
      child: controller.myPledgedSecurityList.length == 0
          ? Padding(padding: const EdgeInsets.only(top: 150.0), child: Center(child: Text(Strings.no_result_found))) :
      ListView.builder(
        key: Key(controller.myPledgedSecurityList.length.toString()),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.myPledgedSecurityList.length,
        itemBuilder: (context, index) {

          if(controller.mfInvokeArguments.isComingFor == Strings.single){
            if(controller.myPledgedSecurityList[index].isin == controller.mfInvokeArguments.isin && controller.myPledgedSecurityList[index].folio == controller.mfInvokeArguments.folio){
              controller.isAddBtnShow.add(false);
              controller.controllers2[index].text = controller.myPledgedSecurityList[index].pledgedQuantity!.toInt().toString();
              controller.checkBoxValues.add(true);
              controller.myPledgedSecurityList[index].check = true;
              controller.loanData.value.totalCollateralValue = controller.totalValue.value;
              controller.isScripsSelect.value = false;
            } else {
              controller.isAddBtnShow.add(true);
              controller.checkBoxValues.add(false);
              controller.myPledgedSecurityList[index].check = false;
            }
          } else {
            controller.isAddBtnShow.add(true);
            controller.checkBoxValues.add(false);
            controller.myPledgedSecurityList[index].check = false;
          }

          int actualIndex = controller.searchMyCartList.indexWhere((element) => element.isin == controller.myPledgedSecurityList[index].isin && element.folio == controller.myPledgedSecurityList[index].folio);

          String pledgeQty = controller.myPledgedSecurityList[index].pledgedQuantity!.toString();
          String sellQty;
          if(controller.isAddBtnShow[actualIndex]){
            sellQty = 0.toString();
          } else {
            sellQty = pledgeQty;
          }
          controller.myPledgedSecurityList[index].pledgedQuantity = double.parse(sellQty);
          controller.searchMyCartList[actualIndex].pledgedQuantity = controller.myPledgedSecurityList[index].pledgedQuantity;
          controller.pledgeControllerEnable.add(false);
          controller.controllers2[actualIndex] = TextEditingController(text: controller.unitStringList[actualIndex]);
          controller.controllers2[actualIndex].selection = TextSelection.fromPosition(TextPosition(offset: controller.controllers2[actualIndex].text.length));
          if(index == controller.myPledgedSecurityList.length){
           //ToDo: check the behaviour in previous code setState(() {});
          }
          controller.invokeAndEligibility();

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
                Text("${controller.myPledgedSecurityList[index].securityName!} [${controller.myPledgedSecurityList[index].folio}]", style: boldTextStyle_18),
                SizedBox(height: 4),
                Text("${controller.myPledgedSecurityList[index].securityCategory!} (LTV: ${controller.myPledgedSecurityList[index].eligiblePercentage!.toStringAsFixed(2)}%)",
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
                                  scripsValueText("₹${controller.myPledgedSecurityList[index].price!.toStringAsFixed(2)}"),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(child: Text("${controller.actualQtyList[actualIndex].toStringAsFixed(3)} QTY", style: mediumTextStyle_12_gray)),
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
                            shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
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
                                  controller: controller.controllers2[actualIndex],
                                  decoration: InputDecoration(counterText: ""),
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    DecimalTextInputFormatter(decimalRange: 3),
                                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,3}')),
                                  ],
                                  style: boldTextStyle_18,
                                  onChanged: (value)=> controller.textFieldOnChanged(index, actualIndex) ,
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
                          child:Text(getInitials(controller.myPledgedSecurityList[index].securityName, 1), style: extraBoldTextStyle_30),
                        ), //Container ,
                      ),
                    ],
                  ),
                ),
                !controller.isAddBtnShow[actualIndex] ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings.value + " : ${numberToString((controller.myPledgedSecurityList[index].price! * double.parse(controller.controllers2[actualIndex].text.isEmpty ? "0" : controller.controllers2[actualIndex].text.toString())).toStringAsFixed(2))}", style: mediumTextStyle_14_gray),
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

  Widget bottomSectionNavigator() {
    if (controller.totalSelectedScrips != 0) {
      controller.isScripsSelect.value = false;
    } else {
      controller.isScripsSelect.value = true;
    }
    return Visibility(
      visible : controller.showSecurityValue,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 3.0),
            borderRadius:
            BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
            boxShadow: [
              BoxShadow(blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
            ] // make rounded corner of border
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Column(
                children: <Widget>[
                  SizedBox(
                    height: 13,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(child: Text(Strings.selected_schemes_value,
                              style: TextStyle(fontSize: 18.0, color: colorBlack),
                            )),
                            scripsValueText( controller.totalValue < 0
                                ? negativeValue(controller.totalValue.value)
                                : '₹${numberToString(controller.totalValue.value.toStringAsFixed(2))}')
                          ],
                        ),
                        SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: 45,
                    width: 100,
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      elevation: 1.0,
                      color:
                      controller.isScripsSelect.value == true ? colorLightGray : appTheme,
                      child: AbsorbPointer(
                        absorbing: controller.isScripsSelect.value,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: Get.mediaQuery.size.width,
                          onPressed: ()=> controller.submitBtnClicked(),
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

sellCollateralDialogBox(MfInvokeController controller) {
  return Get.dialog(
    AlertDialog(
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
                    color: colorLightGray,
                    size: 20,
                  ),
                  onTap: ()=> Get.back(),
                ),
              ],
            ) ,
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: new Text(Strings.invoke_confirmation, style: regularTextStyle_16_dark),
              ), //
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 45,
              width: 120,
              child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                elevation: 1.0,
                color: appTheme,
                child: MaterialButton(
                  minWidth: Get.mediaQuery.size.width,
                  onPressed: ()=>controller.continueClicked(),
                  child: Text(Strings.continue_cap, style: buttonTextWhite),
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

class ReusableSellAmountText extends StatelessWidget {
  final String? sellText;
  final String? sellAmount;
  final Color? sellAmountColor;
  final bool? iIcon;

  ReusableSellAmountText(
      {@required this.sellText,
        this.sellAmount,
        this.sellAmountColor,
        this.iIcon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          iIcon! ? Expanded(
            child: Row(
              children: [
                Row(
                  children: [
                    Text(
                      sellText!,
                      style: kDefaultTextStyle.copyWith(
                          color: colorLightGray,
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                GestureDetector(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Image.asset(AssetsImagePath.info,
                        height: 16, width: 16),
                  ),
                  onTap: () {
                    if(sellText == "Invocation Charges") {
                      commonDialog( Strings.invocation_charges_info, 0);
                    }else {
                      commonDialog( Strings.invoke_i_info, 0);
                    }
                  },
                ),
              ],
            ),
          ) : Expanded(
            child: Text(
              sellText!,
              style: kDefaultTextStyle.copyWith(
                  color: colorLightGray,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(width: 5),
          Text(
            sellAmount!,
            style: kDefaultTextStyle.copyWith(
                fontWeight: FontWeight.bold,
                color: sellAmountColor,
                fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, // unused.
      TextEditingValue newValue,
      ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}