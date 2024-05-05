import 'package:choice/network/requestbean/MyCartRequestBean.dart';
import 'package:choice/network/responsebean/IsinDetailResponseBean.dart';
import 'package:choice/network/responsebean/MFSchemeResponse.dart';
import 'package:choice/util/AssetsImagePath.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/Utility.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'MF_ViewVaultDetailsViewScreen.dart';
import 'dart:math' as math;


class MF_DetailViewDialog extends StatefulWidget {
  List<SchemesList> selectedSchemeList = [];
  SchemesList scheme;
  List<IsinDetails>? isinDetails;
  String schemeType, lender, selectedUnit;
  List<SchemesList> schemeListItems;


  MF_DetailViewDialog(this.selectedSchemeList, this.scheme, this.isinDetails, this.schemeType,
      this.lender, this.schemeListItems, this.selectedUnit);

  @override
  MF_DetailViewDialogState createState() => MF_DetailViewDialogState();
}

class MF_DetailViewDialogState extends State<MF_DetailViewDialog> {
  bool isDefalutbottomDialog = true;
  bool isEligiblebottomDialog = false;
  bool isAddBtnSelected = true;
  bool isAddQtyEnable = false;
  TextEditingController _controllers = TextEditingController();
  double? schemeValue;
  double? eligibleLoanAmount;
  bool isSchemeSelect = true;
  List<SecuritiesList> securitiesListItems = [];
  FocusNode focusNode = FocusNode();
  double? previousSchemeValue;
  double? previousEligibleLoan;
  double? selectedSchemeValue;
  double? selectedEligibleLoan;
  @override
  void initState() {
    _controllers.text = widget.selectedUnit;
    if (widget.scheme.units == null || widget.scheme.units == 0) {
      isAddBtnSelected = true;
      isAddQtyEnable = false;
    } else {
      isAddBtnSelected = false;
      isAddQtyEnable = true;
    }
    updateSchemeAndELValue();

    super.initState();
  }

  void dispose(){
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                GestureDetector(
                  onTap: (){
                    FocusScope.of(context).unfocus();
                    focusNode.unfocus();
                    Navigator.pop(context, widget.selectedSchemeList);
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: 100,
                    alignment: Alignment.topCenter,
                    child: Center(
                      child: IconButton(
                        iconSize: 40,
                        icon: Image.asset(
                          AssetsImagePath.cross_icon,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          focusNode.unfocus();
                            Navigator.pop(context, widget.selectedSchemeList);
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(child: getBottomSheet()),
              ],
            )
        ),
      );
  }

  Future<bool> _onBackPressed() async {
    FocusScope.of(context).unfocus();
    focusNode.unfocus();
    Navigator.pop(context, widget.selectedSchemeList);
    return true;
  }

  Widget getBottomSheet() {
    if (widget.scheme.units == 0) {
      isAddBtnSelected = true;
      isAddQtyEnable = false;
    } else {
      isAddBtnSelected = false;
      isAddQtyEnable = true;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          height: MediaQuery.of(context).size.height - 100,
          decoration: new BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Container(
                                width: 70,
                                height: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: colorRed,
                                  borderRadius: BorderRadius.all(Radius.circular(100.0)),
                                ),
                                child: widget.scheme.amcImage != null && widget.scheme.amcImage!.isNotEmpty
                                    ? CircleAvatar(backgroundImage: NetworkImage(widget.scheme.amcImage!), backgroundColor: colorRed, radius: 50.0)
                                    : Text(getInitials( widget.scheme.schemeName, 1), style: extraBoldTextStyle_30),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: Center(child: mediumHeadingText(Strings.nav))),
                          Expanded(child: Center(child: mediumHeadingText("UNIT"))),
                          Expanded(child: Center(child: mediumHeadingText("VALUE"))),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: Center(child: scripsValueText("₹${widget.scheme.price!.toString()}"))),
                          Expanded(child: Center(child: isAddBtnSelected ? addSecuritiesBtn() : increaseDecreaseSecurities())),
                          Expanded(child: Center(child: scripsValueText("₹${(widget.scheme.price! * widget.scheme.units!).toStringAsFixed(3)}"))),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        child: Text(Strings.approving_lender, style: boldTextStyle_18),
                      ),
                      SizedBox(height: 10),
                      approvingLenderList(),
                    ],
                  ),
                ),
              ),
              isDefalutbottomDialog
                  ? bottomsheetdialog()
                  : eligibleLimitViewVaultdialog()
            ],
          ),
        ),
      ),

    );
  }


  Widget approvingLenderList() {
    return Container(
      height: 360.0,
        //width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: new ListView.builder(
        itemCount: widget.isinDetails!.length,
        itemBuilder: (context, index) {
          return new Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            width: (MediaQuery.of(context).size.width - 40) / 2,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    alignment: Alignment.center,
                    child: Text(
                      widget.isinDetails![index].name!,
                      style: boldTextStyle_18,
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  mediumHeadingText("CAT"),
                  SizedBox(
                    height: 5,
                  ),
                  scripsValueText(widget.isinDetails![index].category),
                  SizedBox(
                    height: 18,
                  ),
                  mediumHeadingText("LTV"),
                  SizedBox(
                    height: 5,
                  ),
                  scripsValueText("${widget.isinDetails![index].ltv!.toStringAsFixed(2)}%"),
                  SizedBox(
                    height: 18,
                  ),
                  mediumHeadingText("ROI (Per Month)"),
                  SizedBox(
                    height: 5,
                  ),
                  scripsValueText("${widget.isinDetails![index].rateOfInterest!.toStringAsFixed(2)}%"),
                  SizedBox(
                    height: 18,
                  ),
                  mediumHeadingText("MIN Limit"),
                  SizedBox(
                    height: 5,
                  ),
                  scripsValueText("₹${numberToString(widget.isinDetails![index].minimumSanctionedLimit!.toStringAsFixed(2))}"),
                  SizedBox(
                    height: 18,
                  ),
                  mediumHeadingText("MAX Limit"),
                  SizedBox(
                    height: 5,
                  ),
                  scripsValueText("₹${numberToString(widget.isinDetails![index].maximumSanctionedLimit!.toStringAsFixed(2))}"),
                ],
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget bottomsheetdialog() {
    setState(() {
      if (widget.selectedSchemeList.length != 0) {
        isSchemeSelect = false;
      } else {
        isSchemeSelect = true;
      }
    });
    return Visibility(
      visible: isDefalutbottomDialog,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
          ],
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset(AssetsImagePath.down_arrow_image, height: 15, width: 15),
                    onPressed: () {
                      setState(() {
                        isDefalutbottomDialog = false;
                        isEligiblebottomDialog = true;
                      });
                    },
                  )
                ],
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(Strings.selected_value, style: mediumTextStyle_18_gray),
                        ),
                        Text("₹${numberToString(schemeValue!.toStringAsFixed(2))}",
                          style: boldTextStyle_18_gray_dark,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(Strings.eligible_loan_amount_small, style: mediumTextStyle_18_gray),
                        ),
                        Text("₹${numberToString(eligibleLoanAmount!.toStringAsFixed(2))}",
                            style: textStyleGreenStyle_18)
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 50,
                  width: 140,
                  child: Material(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 1.0,
                    color: isSchemeSelect == false ? schemeValue! <= 999999999999 ? appTheme : colorLightGray : colorLightGray,
                    child: AbsorbPointer(
                      absorbing: isSchemeSelect,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          Utility.isNetworkConnection().then((isNetwork) async {
                            if (isNetwork) {
                              FocusScope.of(context).unfocus();
                              if(_controllers.text.isEmpty){
                                widget.selectedSchemeList.removeWhere((element) => element.isin == widget.scheme.isin);
                              }
                              Securities securities = Securities();
                              securitiesListItems.clear();
                              for (int i = 0; i < widget.selectedSchemeList.length; i++) {
                                if (widget.selectedSchemeList[i].units != null && widget.selectedSchemeList[i].units != 0) {
                                  securitiesListItems.add(new SecuritiesList(
                                      isin: widget.selectedSchemeList[i].isin,
                                      quantity: widget.selectedSchemeList[i].units),
                                  );
                                }
                              }
                              securities.list = securitiesListItems;
                              if(schemeValue! <= 999999999999){
                                MyCartRequestBean requestBean =
                                MyCartRequestBean(
                                    securities: securities,
                                    instrumentType: Strings.mutual_fund,
                                    schemeType: widget.schemeType,
                                    loan_margin_shortfall_name: "",
                                    pledgor_boid: "",
                                    cartName: "",
                                    loamName: "",
                                    lender: widget.lender);
                                if(widget.selectedSchemeList.length == 1 && (widget.scheme.isin == widget.selectedSchemeList[0].isin)) {
                                  if (_controllers.text.isNotEmpty && _controllers.text != " ") {
                                    List<SchemesList> securityList = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MF_ViewVaultDetailsViewScreen(requestBean, widget.selectedSchemeList)));
                                    setState(() {
                                      bool isExist = false;
                                      securityList.forEach((element) {
                                        if(element.isin == widget.scheme.isin){
                                          isExist = true;
                                        }
                                      });
                                      if(isExist){
                                        securityList.forEach((element) {
                                          if(element.isin == widget.scheme.isin){
                                            isExist = true;
                                            // } else {
                                            _controllers.text = element.units!.toString();
                                            widget.scheme.units = element.units!;
                                            if(element.units! == 0){
                                              isAddBtnSelected = true;
                                              isAddQtyEnable = false;
                                            } else {
                                              isAddBtnSelected = false;
                                              isAddQtyEnable = true;
                                            }
                                          }
                                        });
                                      } else {
                                        _controllers.text = "0";
                                        widget.scheme.units = 0;
                                        isAddBtnSelected = true;
                                        isAddQtyEnable = false;
                                      }
                                      widget.selectedSchemeList.clear();
                                      widget.selectedSchemeList.addAll(securityList);
                                      updateSchemeAndELValue();
                                    });
                                  }
                                }else{
                                  List<SchemesList> securityList = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MF_ViewVaultDetailsViewScreen(requestBean, widget.selectedSchemeList)));
                                  setState(() {
                                    bool isExist = false;
                                    securityList.forEach((element) {
                                      if(element.isin == widget.scheme.isin){
                                        isExist = true;
                                      }
                                    });
                                    if(isExist){
                                      securityList.forEach((element) {
                                        if(element.isin == widget.scheme.isin){
                                          isExist = true;
                                          var unitsDecimalCount;
                                          String str = element.units.toString();
                                          var qtyArray = str.split('.');
                                          unitsDecimalCount = qtyArray[1];
                                          if(unitsDecimalCount == "0"){
                                            _controllers.text = element.units!.toInt().toString();
                                            widget.scheme.units = element.units!;
                                          }else{
                                            _controllers.text = element.units!.toString();
                                            widget.scheme.units = element.units!;
                                          }

                                          if(element.units! == 0){
                                            isAddBtnSelected = true;
                                            isAddQtyEnable = false;
                                          } else {
                                            isAddBtnSelected = false;
                                            isAddQtyEnable = true;
                                          }
                                        }
                                      });
                                    } else {
                                      _controllers.text = "0";
                                      widget.scheme.units = 0;
                                      isAddBtnSelected = true;
                                      isAddQtyEnable = false;
                                    }
                                    widget.selectedSchemeList.clear();
                                    widget.selectedSchemeList.addAll(securityList);
                                    updateSchemeAndELValue();
                                  });
                                }
                              } else {
                                commonDialog(context, Strings.scheme_validation, 0);
                              }
                            } else {
                              Utility.showToastMessage(Strings.no_internet_message);
                            }
                          });
                        },
                        child: Text(Strings.view_vault, style: buttonTextWhite),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget eligibleLimitViewVaultdialog() {
    setState(() {
      if (widget.selectedSchemeList.length == 0) {
        isSchemeSelect = true;
      } else {
        isSchemeSelect = false;
      }
    });
    return Visibility(
      visible: isEligiblebottomDialog,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
          ],
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset(
                      AssetsImagePath.up_arrow,
                      height: 15,
                      width: 15,
                    ),
                    onPressed: () {
                      setState(() {
                        isDefalutbottomDialog = true;
                        isEligiblebottomDialog = false;
                      });
                    },
                  )
                ],
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                  "₹${numberToString(eligibleLoanAmount!.toStringAsFixed(2))}",
                                  style: textStyleGreenStyle_18),
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    Strings.eligible_loan_amount_small,
                                    style: mediumTextStyle_12_gray,
                                  )
                                ],
                              ),
                            ),
                          ],
                        )),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: 50,
                        width: 140,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          elevation: 1.0,
                          color: isSchemeSelect == false ? schemeValue! <= 999999999999 ? appTheme : colorLightGray : colorLightGray,
                          child: AbsorbPointer(
                            absorbing: isSchemeSelect,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                Utility.isNetworkConnection().then((isNetwork) async {
                                  if (isNetwork) {
                                    Securities securities = Securities();
                                    securitiesListItems.clear();
                                    for (int i = 0; i < widget.schemeListItems.length; i++) {
                                      if (widget.schemeListItems[i].units != null && widget.schemeListItems[i].units != 0) {
                                        securitiesListItems.add(new SecuritiesList(
                                            isin: widget.schemeListItems[i].isin,
                                            quantity: widget.schemeListItems[i].units),
                                        );
                                      }
                                    }
                                    final Map<String, SecuritiesList> schemeMap =
                                    new Map();
                                    securitiesListItems.forEach((item) {
                                      schemeMap[item.isin!] = item;
                                    });
                                    securities.list = securitiesListItems;
                                    if(schemeValue! <= 999999999999){
                                      MyCartRequestBean requestBean =
                                      MyCartRequestBean(
                                          securities: securities,
                                          instrumentType: Strings.mutual_fund,
                                          schemeType: widget.schemeType,
                                          loan_margin_shortfall_name: "",
                                          pledgor_boid: "",
                                          cartName: "",
                                          loamName: "",
                                          lender: widget.lender);
                                      if(widget.selectedSchemeList.length == 1 && (widget.scheme.isin == widget.selectedSchemeList[0].isin)) {
                                        if (_controllers.text.isNotEmpty && _controllers.text != " ") {
                                          List<SchemesList> securityList = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MF_ViewVaultDetailsViewScreen(requestBean, widget.selectedSchemeList)));
                                          setState(() {
                                            bool isExist = false;
                                            securityList.forEach((element) {
                                              if(element.isin == widget.scheme.isin){
                                                isExist = true;
                                                print("helloo --> ${element.units.toString()}");
                                              }
                                            });

                                            if(isExist){
                                              securityList.forEach((element) {
                                                if(element.isin == widget.scheme.isin){
                                                  isExist = true;
                                                  // } else {
                                                  _controllers.text = element.units!.toString();
                                                  widget.scheme.units = element.units!;
                                                  if(element.units! == 0){
                                                    isAddBtnSelected = true;
                                                    isAddQtyEnable = false;
                                                  } else {
                                                    isAddBtnSelected = false;
                                                    isAddQtyEnable = true;
                                                  }
                                                }
                                              });
                                            } else {
                                              _controllers.text = "0";
                                              widget.scheme.units = 0;
                                              isAddBtnSelected = true;
                                              isAddQtyEnable = false;
                                            }
                                            widget.selectedSchemeList.clear();
                                            widget.selectedSchemeList.addAll(securityList);
                                            updateSchemeAndELValue();
                                          });
                                        }
                                      }else{
                                        List<SchemesList> securityList = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MF_ViewVaultDetailsViewScreen(requestBean, widget.selectedSchemeList)));
                                        setState(() {
                                          bool isExist = false;
                                          securityList.forEach((element) {
                                            if(element.isin == widget.scheme.isin){
                                              isExist = true;
                                            }
                                          });
                                          if(isExist){
                                            securityList.forEach((element) {
                                              if(element.isin == widget.scheme.isin){
                                                isExist = true;
                                                _controllers.text = element.units!.toString();
                                                widget.scheme.units = element.units!;
                                                if(element.units! == 0){
                                                  isAddBtnSelected = true;
                                                  isAddQtyEnable = false;
                                                } else {
                                                  isAddBtnSelected = false;
                                                  isAddQtyEnable = true;
                                                }
                                              }
                                            });
                                          } else {
                                            _controllers.text = "0";
                                            widget.scheme.units = 0;
                                            isAddBtnSelected = true;
                                            isAddQtyEnable = false;
                                          }
                                          widget.selectedSchemeList.clear();
                                          widget.selectedSchemeList.addAll(securityList);
                                          updateSchemeAndELValue();
                                        });
                                      }
                                    } else {
                                      commonDialog(context, Strings.scheme_validation, 0);
                                    }
                                  } else {
                                    Utility.showToastMessage(Strings.no_internet_message);
                                  }
                                });
                              },
                              child: Text(Strings.view_vault,
                                style: buttonTextWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget increaseDecreaseSecurities() {
    if (widget.scheme.eligibleLoanAmount != 0.0) {
      isSchemeSelect = false;
    } else {
      isSchemeSelect = true;
    }
    return Visibility(
        visible: isAddQtyEnable,
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    iconSize: 20.0,
                    icon: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
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
                          var txt;
                          if(_controllers.text.toString().contains('.') && _controllers.text.toString().split(".")[1].length != 0) {
                            var unitsDecimalCount;
                            String str = _controllers.text.toString();
                            var qtyArray = str.split('.');
                            unitsDecimalCount = qtyArray[1];
                            if(int.parse(unitsDecimalCount) == 0){
                              txt = double.parse(_controllers.text) - 1;
                              _controllers.text = txt.toString();
                            }else{
                              if (unitsDecimalCount.toString().length == 1) {
                                txt = double.parse(_controllers.text) - .1;
                                _controllers.text = txt.toStringAsFixed(1);
                              } else if (unitsDecimalCount.toString().length == 2) {
                                txt = double.parse(_controllers.text) - .01;
                                _controllers.text = txt.toStringAsFixed(2);
                              } else{
                                txt = double.parse(_controllers.text) - .001;
                                _controllers.text = txt.toStringAsFixed(3);
                              }
                            }
                          } else {
                            focusNode.unfocus();
                            txt = _controllers.text.isNotEmpty ? int.parse(_controllers.text.toString().split(".")[0]) - 1 : 0;
                            _controllers.text = txt.toString();
                          }
                          // double txt = int.parse(_controllers.text) - 1;

                          widget.scheme.units = double.parse(_controllers.text);
                          setState(() {
                            if (txt >= 0.001) {
                              setState(() {
                                isAddBtnSelected = false;
                                isAddQtyEnable = true;
                                updateSchemeAndELValue();
                              });
                            } else {
                              setState(() {
                                widget.selectedSchemeList.removeWhere((element) => element.isin == widget.scheme.isin);
                                isAddBtnSelected = true;
                                isAddQtyEnable = false;
                                _controllers.text = "0";
                                updateSchemeAndELValue();
                              });
                            }
                          });
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 60,
                    height: 48,
                    child: TextField(
                        controller: _controllers,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(counterText: ""),
                        // maxLength: 6,
                        focusNode: focusNode,
                        showCursor: true,
                        keyboardType:
                        TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          DecimalTextInputFormatter(decimalRange: 3),
                          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,3}')),
                        ],
                        style: boldTextStyle_18,
                        onChanged: (value) {
                          if(!_controllers.text.toString().endsWith(".")){
                            if(value.isNotEmpty && double.parse(value.toString()) >= 0.001){
                              if(double.parse(_controllers.text) != 0){
                                setState(() {
                                  widget.scheme.units = double.parse(_controllers.text);
                                  isAddBtnSelected = false;
                                  isAddQtyEnable = true;
                                  updateSchemeAndELValue();
                                });
                              }else{
                                setState(() {
                                  widget.selectedSchemeList.removeWhere((element) => element.isin == widget.scheme.isin);
                                  isAddBtnSelected = true;
                                  isAddQtyEnable = false;
                                  _controllers.text = "0";
                                  updateSchemeAndELValue();
                                });
                              }
                            }else{
                              if(_controllers.text.isEmpty || _controllers.text == " " || _controllers.text == ".0" || _controllers.text == ".00" || _controllers.text == "0" || _controllers.text == "0." || _controllers.text == "0.0" || _controllers.text == "0.00"){
                                focusNode.addListener(() {
                                  if(_controllers.text.isEmpty || _controllers.text == " " || _controllers.text == ".0" || _controllers.text == ".00" || _controllers.text == "0" || _controllers.text == "0." || _controllers.text == "0.0" || _controllers.text == "0.00"){
                                    if(focusNode.hasFocus){
                                      focusNode.requestFocus();
                                    } else {
                                      widget.selectedSchemeList.removeWhere((element) => element.isin == widget.scheme.isin);
                                      isAddBtnSelected = true;
                                      isAddQtyEnable = false;
                                      _controllers.text = "0";
                                      updateSchemeAndELValue();
                                    }
                                  }
                                });
                              } else {
                                setState(() {
                                  FocusScope.of(context).unfocus();
                                  widget.selectedSchemeList.removeWhere((element) => element.isin == widget.scheme.isin);
                                  isAddBtnSelected = true;
                                  isAddQtyEnable = false;
                                  _controllers.text = "0";
                                  updateSchemeAndELValue();
                                });
                              }
                            }
                          }else{
                            var value;
                            value = _controllers.text;
                            focusNode.addListener(() {
                              if(_controllers.text.toString().endsWith('.')){
                                if(focusNode.hasFocus){
                                  focusNode.requestFocus();
                                }else {
                                  if(value.toString().split(".")[0].isEmpty){
                                    isAddBtnSelected = true;
                                    isAddQtyEnable = false;
                                    _controllers.text = "0";
                                    updateSchemeAndELValue();

                                  }else if(_controllers.text.toString().endsWith('.')){
                                    FocusScope.of(context).unfocus();
                                    value = int.parse(_controllers.text.toString().split(".")[0]);
                                    _controllers.text = value.toString();
                                  }
                                }
                              }
                            });

                          }
                        }),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    iconSize: 20,
                    icon: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
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
                          focusNode.unfocus();
                          var txt;
                          if(_controllers.text.toString().contains('.') && _controllers.text.toString().split(".")[1].length != 0) {
                            var unitsDecimalCount;
                            String str = _controllers.text.toString();
                            var qtyArray = str.split('.');
                            unitsDecimalCount = qtyArray[1];
                            if(int.parse(unitsDecimalCount) == 0){
                              txt = double.parse(_controllers.text) + 1;
                              _controllers.text = txt.toString();
                            }else{
                              if (unitsDecimalCount.toString().length == 1) {
                                txt = double.parse(_controllers.text) + .1;
                                _controllers.text = txt.toStringAsFixed(1);
                              } else if (unitsDecimalCount.toString().length == 2) {
                                txt = double.parse(_controllers.text) + .01;
                                _controllers.text = txt.toStringAsFixed(2);
                              } else {
                                txt = double.parse(_controllers.text) + .001;
                                _controllers.text = txt.toStringAsFixed(3);
                              }
                            }
                          }else{
                            txt = _controllers.text.isNotEmpty ? int.parse(_controllers.text.toString().split(".")[0]) + 1 : 0;
                            _controllers.text = txt.toString();
                          }
                          setState(() {
                            FocusScope.of(context).unfocus();
                            widget.scheme.units = double.parse(_controllers.text);
                            updateSchemeAndELValue();
                          });
                        } else {
                          FocusScope.of(context).unfocus();
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  updateSchemeAndELValue(){
    setState(() {
      widget.scheme.units = _controllers.text.isEmpty || _controllers.text == " " ? 0 : double.parse(_controllers.text);
      schemeValue = 0;
      eligibleLoanAmount= 0;
      for (int i = 0; i < widget.selectedSchemeList.length; i++) {
        schemeValue = schemeValue! + (widget.selectedSchemeList[i].price! * widget.selectedSchemeList[i].units!);
        eligibleLoanAmount = eligibleLoanAmount! + (widget.selectedSchemeList[i].price! * widget.selectedSchemeList[i].units! *  widget.selectedSchemeList[i].ltv!) / 100;
        if(widget.selectedSchemeList[i].isin == widget.scheme.isin){
          widget.selectedSchemeList[i].units = widget.scheme.units;
        }
      }
    });
  }

  Widget addSecuritiesBtn() {
    return Visibility(
        visible: isAddBtnSelected,
        child: Container(
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
              onPressed: () {
                Utility.isNetworkConnection().then((isNetwork) {
                  if (isNetwork) {
                    setState(() {
                      isAddQtyEnable = true;
                      isAddBtnSelected = false;
                      _controllers.text = "1";
                      widget.selectedSchemeList.add(widget.scheme);
                      updateSchemeAndELValue();
                    });
                  } else {
                    Utility.showToastMessage(Strings.no_internet_message);
                  }
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add +",
                    style: TextStyle(
                        color: colorWhite, fontSize: 10, fontWeight: bold),
                  )
                ],
              ),
            ),
          ),
        ));
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
