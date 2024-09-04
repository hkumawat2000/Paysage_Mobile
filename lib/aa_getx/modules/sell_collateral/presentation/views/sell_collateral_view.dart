
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/controllers/sell_collateral_controller.dart';

class SellCollateralView extends GetView<SellCollateralController> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: controller.scaffoldKey,
        backgroundColor: colorBg,
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context),
        body: controller.isAPIRespond.value
            ? sellCollateralBody()
            : Center(child: Text(Strings.please_wait),
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

  Widget sellCollateralBody() {
    return ScrollConfiguration(
      behavior: new ScrollBehavior(),
      // ..buildViewportChrome(context, Container(), AxisDirection.down),
      child: NestedScrollView(
        physics: ScrollPhysics(),
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
                            child: headingText(Strings.sell_collateral),
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
                              controller.isMarginShortFall.value ? ReusableSellAmountText(
                                sellText: 'Margin shortfall',
                                loanType: controller.sellCollateralArguments.loanType,
                                sellAmount: controller.vlMarginShortFall! < 0
                                    ? negativeValue(controller.vlMarginShortFall!.value)
                                    : '₹${numberToString(controller.vlMarginShortFall!.value.toStringAsFixed(2))}',
                                sellAmountColor: red,
                                iIcon: false,
                              ) : SizedBox(height: 0),
                              ReusableSellAmountText(
                                sellText: 'Selected securities value',
                                sellAmount: controller.totalValue < 0
                                    ? negativeValue(controller.totalValue.value)
                                    : '₹${numberToString(controller.totalValue.toStringAsFixed(2))}',
                                sellAmountColor: colorGreen,
                                iIcon: false,
                              ),
                              controller.isMarginShortFall.value ?  ReusableSellAmountText(
                                sellText: 'Minimum desired value',
                                sellAmount: controller.vlDesiredValue! < 0
                                    ? negativeValue(controller.vlDesiredValue!.value)
                                    : '₹${numberToString(controller.vlDesiredValue!.toStringAsFixed(2))}',
                                sellAmountColor: red,
                                iIcon: false,
                              ): SizedBox(height: 0),
                              ReusableSellAmountText(
                                sellText: 'Remaining securities value',
                                sellAmount: (controller.totalCollateral! - double.parse(controller.totalValue.toStringAsFixed(2))) < 0
                                    ? negativeValue((controller.totalCollateral!.value - double.parse(controller.totalValue.toStringAsFixed(2))))
                                    : '₹${numberToString((controller.totalCollateral! - double.parse(controller.totalValue.toStringAsFixed(2))).toStringAsFixed(2))}',
                                sellAmountColor: colorDarkGray,
                                iIcon: false,
                              ),
                              ReusableSellAmountText(
                                sellText: 'Revised drawing power',
                                sellAmount: (controller.actualDrawingPower - controller.selectedSecurityEligibility!) < 0
                                    ? negativeValue((controller.actualDrawingPower.value - controller.selectedSecurityEligibility!))
                                    : '₹${numberToString((controller.actualDrawingPower - controller.selectedSecurityEligibility!).toStringAsFixed(2))}',
                                sellAmountColor: (controller.actualDrawingPower - controller.selectedSecurityEligibility!) < 0 ? colorGreen : colorDarkGray,
                                iIcon: false,
                              ),
                              ReusableSellAmountText(
                                sellText: 'Existing loan balance',
                                sellAmount: controller.loanData.value.balance! < 0
                                    ? negativeValue(controller.loanData.value.balance!)
                                    : '₹${numberToString(controller.loanData.value.balance!.toStringAsFixed(2))}',
                                sellAmountColor: controller.loanData.value.balance! < 0 ? colorGreen : colorDarkGray,
                                iIcon: false,
                              ),
                              ReusableSellAmountText(
                                sellText: 'Post sale loan balance',
                                sellAmount: (controller.loanData.value.balance! - double.parse(controller.totalValue.toStringAsFixed(2))) < 0
                                    ? negativeValue((controller.loanData.value.balance! - double.parse(controller.totalValue.toStringAsFixed(2))))
                                    : '₹${numberToString((controller.loanData.value.balance! - double.parse(controller.totalValue.toStringAsFixed(2))).toStringAsFixed(2))}',
                                sellAmountColor: (controller.loanData.value.balance! - double.parse(controller.totalValue.toStringAsFixed(2))) < 0 ? colorGreen : colorDarkGray,
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
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(child: scripsNameText('Select Securities for selling')),
                  Checkbox(
                    checkColor: Colors.white,
                    activeColor: colorGreen,
                    onChanged: (bool? newValue) {
                      Get.focusScope?.unfocus();
                      controller.alterCheckBox(newValue);
                    },
                    value: controller.checkBoxValue,
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
      padding: const EdgeInsets.only(left: 20, right: 16, bottom: 50),
      child: controller.myPledgedSecurityList.length == 0 ?
      Padding(padding: const EdgeInsets.only(top: 150.0), child: Center(child: Text(Strings.no_result_found))) :
      ListView.builder(
        key: Key(controller.myPledgedSecurityList.length.toString()),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.myPledgedSecurityList.length,
        itemBuilder: (context, index) {
          int actualIndex = controller.actualMyCartList.indexWhere((element) => element.securityName == controller.myPledgedSecurityList[index].securityName);
          String sellQty;
          if(controller.isAddBtnShow[actualIndex]){
            sellQty = 0.toString();
          } else {
            sellQty = controller.myPledgedSecurityList[index].pledgedQuantity!.toInt().toString().split('.')[0];
          }
          controller.myPledgedSecurityList[index].pledgedQuantity = double.parse(sellQty);
          if(index == controller.myPledgedSecurityList.length){
            setState(() {
            });
          }

          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 3.0),
              // set border width
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(controller.myPledgedSecurityList[index].securityName!, style: boldTextStyle_18),
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
                                  scripsValueText("₹${numberToString(controller.myPledgedSecurityList[index].price!.toStringAsFixed(2))}"),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(child: Text("${controller.actualQtyList[actualIndex].toString()} QTY", style: mediumTextStyle_12_gray)),
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
                            onPressed: ()=> controller.addButtonClicked(actualIndex,index),
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
                                onPressed: () async {
                                  Utility.isNetworkConnection().then((isNetwork) {
                                    if (isNetwork) {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        if(qtyControllers[actualIndex].text.isNotEmpty){
                                          int txt = int.parse(qtyControllers[actualIndex].text) - 1;
                                          if (txt != 0) {
                                            qtyControllers[actualIndex].text = txt.toString();
                                            myPledgedSecurityList[index].pledgedQuantity = txt.toDouble();
                                          } else {
                                            isAddBtnShow[actualIndex] = true;
                                            qtyControllers[actualIndex].text = "0";
                                            myPledgedSecurityList[index].pledgedQuantity = 0;
                                          }
                                        }
                                        sellCalculationHandling();
                                      });
                                    } else {
                                      Utility.showToastMessage(Strings.no_internet_message);
                                    }
                                  });
                                },
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
                                  onChanged: (value) {
                                    if (qtyControllers[actualIndex].text.isNotEmpty) {
                                      if (qtyControllers[actualIndex].text != "0") {
                                        if (int.parse(qtyControllers[actualIndex].text) < 1) {
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                          Utility.showToastMessage(Strings.zero_qty_validation);
                                        } else if (double.parse(qtyControllers[actualIndex].text) > actualQtyList[actualIndex].toDouble()) {
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                          Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${actualQtyList[index]} quantity.");
                                          setState(() {
                                            qtyControllers[actualIndex].text = myPledgedSecurityList[index].pledgedQuantity!.toInt().toString();
                                            myPledgedSecurityList[index].pledgedQuantity = double.parse(qtyControllers[actualIndex].text);
                                          });
                                        } else {
                                          setState(() {
                                            myPledgedSecurityList[index].pledgedQuantity = double.parse(qtyControllers[actualIndex].text);
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                          qtyControllers[actualIndex].text = "0";
                                          myPledgedSecurityList[index].pledgedQuantity = 0;
                                          isAddBtnShow[actualIndex] = true;
                                        });
                                      }
                                    } else {
                                      focusNode[actualIndex].addListener(() {
                                        if(!focusNode[actualIndex].hasFocus){
                                          if(qtyControllers[actualIndex].text.trim() == "" || qtyControllers[actualIndex].text.trim() == "0"){
                                            isAddBtnShow[actualIndex] = true;
                                            myPledgedSecurityList[index].pledgedQuantity = 0;
                                            qtyControllers[actualIndex].text = "0";
                                          }
                                        }
                                      });
                                    }
                                    sellCalculationHandling();
                                  },
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
                                onPressed: () async {
                                  Utility.isNetworkConnection().then((isNetwork) {
                                    if (isNetwork) {
                                      FocusScope.of(context).unfocus();
                                      if(qtyControllers[actualIndex].text.isNotEmpty){
                                        if (int.parse(qtyControllers[actualIndex].text) < actualQtyList[actualIndex]) {
                                          int txt = int.parse(qtyControllers[actualIndex].text) + 1;
                                          setState(() {
                                            qtyControllers[actualIndex].text = txt.toString();
                                            myPledgedSecurityList[index].pledgedQuantity = txt.toDouble();
                                          });
                                        } else {
                                          Utility.showToastMessage(Strings.check_quantity);
                                        }
                                      }
                                      sellCalculationHandling();
                                    } else {
                                      Utility.showToastMessage(Strings.no_internet_message);
                                    }
                                  });
                                },
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
                    Text(Strings.value + " : ${numberToString((controller.myPledgedSecurityList[index].price! * double.parse(controller.qtyControllers[actualIndex].text.isEmpty ? "0" : controller.qtyControllers[actualIndex].text.toString())).toStringAsFixed(2))}", style: mediumTextStyle_14_gray),
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
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
          ]),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 12),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 7,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(child: Text(Strings.security_value, style: mediumTextStyle_18_gray)),
                      Text(controller.totalValue < 0 ? negativeValue(controller.totalValue.value)
                          : '₹' + numberToString(controller.totalValue.toStringAsFixed(2)),
                        style: bottomSheetValueTextStyle,
                      )
                    ],
                  ),
                ],
              ),
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
                    color: controller.totalValue <= 0 ? colorLightGray : appTheme,
                    child: AbsorbPointer(
                      absorbing: controller.totalValue <= 0 ? true : false,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          Utility.isNetworkConnection().then((isNetwork) {
                            if (isNetwork) {
                              _handleSearchEnd();
                              sellCollateralDialogBox(context);
                            } else {
                              showSnackBar(_scaffoldKey);
                            }
                          });
                        },
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
    );
  }

  sellCollateralDialogBox(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ) ,
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(controller.sellCollateralArguments.loanType == Strings.shares ? Strings.sell_collateral_confirmation : Strings.invoke_confirmation, style: regularTextStyle_16_dark),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        Utility.isNetworkConnection().then((isNetwork) {
                          if (isNetwork) {
                            Navigator.pop(context);
                            requestSellCollateralOTP();
                          } else {
                            showSnackBar(_scaffoldKey);
                          }
                        });
                      },
                      child: Text('CONTINUE', style: buttonTextWhite),
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

class ReusableSellAmountText extends StatelessWidget {
  final String? sellText;
  final String? loanType;
  final String? sellAmount;
  final Color? sellAmountColor;
  final bool? iIcon;

  ReusableSellAmountText(
      {@required this.sellText,
        this.loanType,
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
                    Text(sellText!, style: kDefaultTextStyle.copyWith(
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
                    commonDialog(Strings.sell_collateral_i_info, 0);
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