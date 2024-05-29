import 'package:lms/network/responsebean/DematAcResponse.dart';
import 'package:lms/network/responsebean/IsinDetailResponseBean.dart';
import 'package:lms/network/responsebean/SecuritiesResponseBean.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'ViewVaultDetailsViewScreen.dart';

class DetailViewDialog extends StatefulWidget {
  List<SecuritiesListData> selectedSecurityList = [];
  List<SecuritiesListData> holdingSecurityList = [];
  SecuritiesListData security;
  List<IsinDetails>? isinDetails;
  DematAc? selectedDematAccount;
  List<LenderInfo>? lenderInfo;
  String selectedQuantity;
  bool isToggleOn;

  DetailViewDialog(this.selectedSecurityList, this.holdingSecurityList, this.security, this.isinDetails, this.selectedDematAccount, this.lenderInfo, this.selectedQuantity, this.isToggleOn);

  @override
  DetailViewDialogState createState() => DetailViewDialogState();
}

class DetailViewDialogState extends State<DetailViewDialog> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool? isDefaultBottomDialog = true;
  bool? isEligibleBottomDialog = false;
  bool? isAddBtnSelected = true;
  bool? isAddQtyEnable = false;
  TextEditingController _controllers = TextEditingController();
  FocusNode focusNode = FocusNode();
  double? previousSecurityValue;
  double? previousEligibleLoan;
  double? selectedSecurityValue;
  double? selectedEligibleLoan;
  double? securityValue;
  double? eligibleLoan;
  double? eligibleLoanAmount;
  bool isSecuritySelect = false;

  @override
  void initState() {
    _controllers.text = widget.selectedQuantity;

    if (widget.security.quantity == null || widget.security.quantity == 0) {
      isAddBtnSelected = true;
      isAddQtyEnable = false;
    } else {
      isAddBtnSelected = false;
      isAddQtyEnable = true;
    }
    securityAndELValue();
    // selectedSecurityValue = widget.security.quantity! * widget.security.price!;
    // selectedEligibleLoan = selectedSecurityValue! * (widget.isinDetails![0].ltv! / 100);
    //
    // previousSecurityValue = widget.security.securityValue! - selectedSecurityValue!;
    // previousEligibleLoan = widget.security.eligibleLoan! - selectedEligibleLoan!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: Scaffold(
          backgroundColor: Colors.transparent,
          resizeToAvoidBottomInset: false,
          body: Column(
            children: <Widget>[
              GestureDetector(
                onTap: (){
                  FocusScope.of(context).unfocus();
                  Navigator.pop(context, widget.selectedSecurityList);
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
                        Navigator.pop(context, widget.selectedSecurityList);
                      },
                    ),
                  ),
                ),
              ),
              Expanded(child: getBottomSheet()),//Container
            ],
          )
      ),
    ); //Scaffold
  }

  Future<bool> _onBackPressed() async {
    Navigator.pop(context, widget.selectedSecurityList);
    return true;
  }

  Widget getBottomSheet() {
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
                                child: widget.security.amcImage != null && widget.security.amcImage!.isNotEmpty
                                    ? CircleAvatar(backgroundImage: NetworkImage(widget.security.amcImage!), backgroundColor: colorRed, radius: 50.0)
                                    : Text(getInitials(widget.security.scripName, 1), style: extraBoldTextStyle_30),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: Center(child: mediumHeadingText(Strings.cmp))),
                          Expanded(child: Center(child: mediumHeadingText("QUANTITY"))),
                          Expanded(child: Center(child: mediumHeadingText("VALUE"))),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: Center(child: scripsValueText("₹${widget.security.price!.toStringAsFixed(2)}"))),
                          Expanded(child: Center(child: isAddBtnSelected! ? addSecuritiesBtn() : increaseDecreaseSecurities())),
                          Expanded(child: Center(child: scripsValueText("₹${(widget.security.price! * (widget.security.quantity != null ? widget.security.quantity! : 0)).toStringAsFixed(2)}"))),
                        ],
                      ),
                      SizedBox(height: 20),
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
              isDefaultBottomDialog!
                  ? bottomSheetDialog()
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
              borderRadius: BorderRadius.all(
                  Radius.circular(10.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
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
                  mediumHeadingText("Min Limit"),
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

  Widget bottomSheetDialog() {
    setState(() {
      if(widget.selectedSecurityList.length != 0){
        isSecuritySelect = true;
      }else{
        isSecuritySelect = false;
      }
    });
    return Visibility(
        visible: isDefaultBottomDialog!,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 3.0),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
              ]),
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
                        AssetsImagePath.down_arrow_image,
                        height: 15,
                        width: 15,
                      ),
                      onPressed: () {
                        setState(() {
                          isDefaultBottomDialog = false;
                          isEligibleBottomDialog = true;
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            Strings.security_value,
                            style: mediumTextStyle_18_gray,
                          ),
                          Text(
                            "₹${numberToString(securityValue!.toStringAsFixed(2))}",
                            style: boldTextStyle_18_gray_dark,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(
                              child: Text(Strings.eligible_loan_amount_small,
                                style: mediumTextStyle_18_gray)),
                          Text("₹${numberToString(eligibleLoan!.toStringAsFixed(2))}", style: textStyleGreenStyle_18)
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
                      color: isSecuritySelect ? appTheme : colorLightGray,
                      child: AbsorbPointer(
                        absorbing: !isSecuritySelect ? true : false,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            Utility.isNetworkConnection().then((isNetwork) async {
                              if (isNetwork) {
                                FocusScope.of(context).unfocus();
                                if(widget.selectedSecurityList.length == 1 && (widget.security.iSIN == widget.selectedSecurityList[0].iSIN)){
                                    if(_controllers.text.isNotEmpty && _controllers.text !=" "){
                                      if(widget.selectedDematAccount != null){
                                        List<SecuritiesListData> securityList = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ViewVaultDetailsViewScreen(widget.selectedSecurityList, widget.holdingSecurityList, widget.selectedDematAccount, widget.lenderInfo, widget.isToggleOn)));
                                        setState(() {
                                          bool isExist = false;
                                          securityList.forEach((element) {
                                            if(element.iSIN == widget.security.iSIN){
                                              isExist = true;
                                            }
                                          });

                                          if(isExist){
                                            securityList.forEach((element) {
                                              if(element.iSIN == widget.security.iSIN){
                                                isExist = true;
                                              // } else {
                                                _controllers.text = element.quantity!.toInt().toString();
                                                widget.security.quantity = element.quantity!;
                                                if(element.quantity! == 0){
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
                                            widget.security.quantity = 0;
                                            isAddBtnSelected = true;
                                            isAddQtyEnable = false;
                                          }
                                          widget.selectedSecurityList.clear();
                                          widget.selectedSecurityList.addAll(securityList);

                                          securityAndELValue();
                                        });
                                      }else{
                                        commonDialog(context, "Please select a Demat Account Number", 0);
                                      }
                                    }

                                }else{
                                  if(widget.selectedDematAccount != null){
                                    List<SecuritiesListData> securityList = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ViewVaultDetailsViewScreen(widget.selectedSecurityList, widget.holdingSecurityList, widget.selectedDematAccount, widget.lenderInfo, widget.isToggleOn)));
                                    setState(() {
                                      bool isExist = false;
                                      securityList.forEach((element) {
                                        if(element.iSIN == widget.security.iSIN){
                                          isExist = true;
                                          print("helloo --> ${element.quantity.toString()}");
                                        }
                                      });

                                      if(isExist){
                                        securityList.forEach((element) {
                                          if(element.iSIN == widget.security.iSIN){
                                            isExist = true;
                                          // } else {
                                            _controllers.text = element.quantity!.toInt().toString();
                                            widget.security.quantity = element.quantity!;
                                            if(element.quantity! == 0){
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
                                        widget.security.quantity = 0;
                                        isAddBtnSelected = true;
                                        isAddQtyEnable = false;
                                      }
                                      widget.selectedSecurityList.clear();
                                      widget.selectedSecurityList.addAll(securityList);

                                      securityAndELValue();
                                    });
                                  }else{
                                    commonDialog(context, "Please select a Demat Account Number", 0);
                                  }
                                }
                              } else {
                                Utility.showToastMessage(Strings.no_internet_message);
                              }
                            });
                          },
                          child: Text(
                            "View Vault",
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
        ));
  }

  Widget eligibleLimitViewVaultdialog() {
    setState(() {
      if(widget.selectedSecurityList.length != 0){
        isSecuritySelect = true;
      }else{
        isSecuritySelect = false;
      }
    });
    return Visibility(
        visible: isEligibleBottomDialog!,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 3.0),
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0)),
              boxShadow: [
                BoxShadow(
                    blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
              ]),
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
                          isDefaultBottomDialog = true;
                          isEligibleBottomDialog = false;
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
                      Expanded(child: Row(
                        children: <Widget>[
                          Text("₹${numberToString(eligibleLoan!.toStringAsFixed(2))}", style: textStyleGreenStyle_18),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(child: Column(children: [
                            Text(
                              Strings.eligible_loan_amount_small,
                              style: mediumTextStyle_12_gray,
                            )
                          ],),),
                        ],
                      )),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Container(
                          height: 50,
                          width: 140,
                          child: Material(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                            elevation: 1.0,
                            color: isSecuritySelect ? appTheme : colorLightGray,
                            child: AbsorbPointer(
                              absorbing: !isSecuritySelect ? true : false,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) async {
                                    if (isNetwork) {
                                      FocusScope.of(context).unfocus();
                                      if(widget.selectedSecurityList.length == 1 && (widget.security.iSIN == widget.selectedSecurityList[0].iSIN)){
                                        if(_controllers.text.isNotEmpty && _controllers.text !=" "){
                                          if(widget.selectedDematAccount != null){
                                            List<SecuritiesListData> securityList = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ViewVaultDetailsViewScreen(widget.selectedSecurityList, widget.holdingSecurityList, widget.selectedDematAccount, widget.lenderInfo, widget.isToggleOn)));
                                            setState(() {
                                              bool isExist = false;
                                              securityList.forEach((element) {
                                                if(element.iSIN == widget.security.iSIN){
                                                  isExist = true;
                                                }
                                              });

                                              if(isExist){
                                                securityList.forEach((element) {
                                                  if(element.iSIN == widget.security.iSIN){
                                                    isExist = true;
                                                  // } else {
                                                    _controllers.text = element.quantity!.toInt().toString();
                                                    widget.security.quantity = element.quantity!;
                                                    if(element.quantity! == 0){
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
                                                widget.security.quantity = 0;
                                                isAddBtnSelected = true;
                                                isAddQtyEnable = false;
                                              }
                                              widget.selectedSecurityList.clear();
                                              widget.selectedSecurityList.addAll(securityList);

                                              securityAndELValue();
                                            });
                                          }else{
                                            commonDialog(context, "Please select a Demat Account Number", 0);
                                          }
                                        }

                                      }else{
                                        if(widget.selectedDematAccount != null){
                                          List<SecuritiesListData> securityList = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ViewVaultDetailsViewScreen(widget.selectedSecurityList, widget.holdingSecurityList, widget.selectedDematAccount, widget.lenderInfo, widget.isToggleOn)));
                                          setState(() {
                                            bool isExist = false;
                                            securityList.forEach((element) {
                                              if(element.iSIN == widget.security.iSIN){
                                                isExist = true;
                                              }
                                            });

                                            if(isExist){
                                              securityList.forEach((element) {
                                                if(element.iSIN == widget.security.iSIN){
                                                  isExist = true;
                                                // } else {
                                                  _controllers.text = element.quantity!.toInt().toString();
                                                  widget.security.quantity = element.quantity!;
                                                  if(element.quantity! == 0){
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
                                              widget.security.quantity = 0;
                                              isAddBtnSelected = true;
                                              isAddQtyEnable = false;
                                            }
                                            widget.selectedSecurityList.clear();
                                            widget.selectedSecurityList.addAll(securityList);

                                            securityAndELValue();
                                          });
                                        }else{
                                          commonDialog(context, "Please select a Demat Account Number", 0);
                                        }
                                      }
                                    } else {
                                      Utility.showToastMessage(Strings.no_internet_message);
                                    }
                                  });
                                },
                                child: Text(
                                  "View Vault",
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
        ));
  }

  Widget increaseDecreaseSecurities() {
    return Visibility(
        visible: isAddQtyEnable!,
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
                          borderRadius:
                          BorderRadius.circular(80),
                          border: Border.all(
                              width: 1, color: colorBlack)),
                      child: Icon(
                        Icons.remove,
                        color: colorBlack,
                        size: 18,
                      ),
                    ),
                    onPressed: () async {
                      Utility.isNetworkConnection()
                          .then((isNetwork) {
                        if (isNetwork) {
                          FocusScope.of(context).unfocus();
                          int txt = _controllers.text.isNotEmpty ? int.parse(_controllers.text) - 1 : 0;
                          _controllers.text = txt.toString();
                          setState(() {
                            if(int.parse(_controllers.text) >= 1){
                              _controllers.text = txt.toString();
                              isAddBtnSelected = false;
                              isAddQtyEnable = true;
                            }else{
                              widget.selectedSecurityList.removeWhere((element) => element.iSIN == widget.security.iSIN);
                              isAddBtnSelected = true;
                              isAddQtyEnable = false;
                              _controllers.text = "0";
                            }
                            securityAndELValue();
                          });
                        } else {
                          showSnackBar(_scaffoldKey);
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
                        focusNode: focusNode,
                        decoration: InputDecoration(
                            counterText: ""),
                        keyboardType:
                        TextInputType.numberWithOptions(
                            decimal: true),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp('[0-9]')),
                        ],
                        style: boldTextStyle_18,
                        onChanged: (value) {
                          setState(() {
                            if(_controllers.text.isNotEmpty){
                              if(int.parse(_controllers.text) >= 1){
                                if(widget.isToggleOn && int.parse(_controllers.text) > widget.security.totalQty!.toInt()){
                                  FocusScope.of(context).unfocus();
                                  Utility.showToastMessage("Please check your available quantity");
                                  _controllers.text = widget.security.totalQty!.toInt().toString();
                                  securityAndELValue();
                                }else{
                                  isAddBtnSelected = false;
                                  isAddQtyEnable = true;
                                  securityAndELValue();
                                }
                              }
                            }else if(_controllers.text.toString() == " " || _controllers.text.toString().isEmpty || int.parse(_controllers.text.toString()) < 1 ){
                              focusNode.addListener(() {
                                if(_controllers.text.toString() == " " || _controllers.text.toString().isEmpty || int.parse(_controllers.text.toString()) < 1 ){
                                  if(focusNode.hasFocus){
                                    focusNode.requestFocus();
                                  }else{
                                    FocusScope.of(context).unfocus();
                                    widget.selectedSecurityList.removeWhere((element) => element.iSIN == widget.security.iSIN);
                                    isAddBtnSelected = true;
                                    isAddQtyEnable = false;
                                    _controllers.text = "0";
                                    securityAndELValue();
                                    // widget.security.quantity = double.parse(_controllers.text);
                                  }
                                }
                              });
                              // isAddBtnSelected = true;
                              // isAddQtyEnable = false;
                              // _controllers.text = "0";
                              // widget.security.quantity = double.parse(_controllers.text);
                            }
                          });
                        }),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    iconSize: 20,
                    icon: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(80),
                          border: Border.all(
                              width: 1, color: colorBlack)),
                      child: Icon(
                        Icons.add,
                        color: colorBlack,
                        size: 18,
                      ),
                    ),
                    onPressed: () async {
                      Utility.isNetworkConnection()
                          .then((isNetwork) {
                        if (isNetwork) {
                          if (isNetwork) {
                            FocusScope.of(context).unfocus();
                            int txt;
                            setState(() {
                              if(_controllers.text.isNotEmpty && widget.isToggleOn && (double.parse(_controllers.text) >= widget.security.totalQty!)){
                                txt = int.parse(_controllers.text);
                                Utility.showToastMessage("Please check your available quantity");
                              }else{
                                txt = _controllers.text.isNotEmpty ? int.parse(_controllers.text) + 1 : 0;
                              }
                              _controllers.text = txt.toString();
                              securityAndELValue();
                            });
                          } else {
                            showSnackBar(_scaffoldKey);
                          }
                        } else {
                          showSnackBar(_scaffoldKey);
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

  securityAndELValue(){
    widget.security.quantity = _controllers.text.isEmpty ? 0 : double.parse(_controllers.text);
    securityValue = 0;
    eligibleLoan = 0;
    for (int i = 0; i < widget.selectedSecurityList.length; i++) {
      securityValue = securityValue! + (widget.selectedSecurityList[i].price! * widget.selectedSecurityList[i].quantity!);
      eligibleLoan = eligibleLoan! + (widget.selectedSecurityList[i].price! * widget.selectedSecurityList[i].quantity! *  widget.selectedSecurityList[i].eligiblePercentage!) / 100;
      if(widget.selectedSecurityList[i].iSIN == widget.security.iSIN){
        widget.selectedSecurityList[i].quantity = widget.security.quantity;
      }
    }
  }

  Widget addSecuritiesBtn() {
    return Visibility(
      visible: isAddBtnSelected!,
      child: Container(
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
            onPressed: () {
              Utility.isNetworkConnection().then((isNetwork) {
                if (isNetwork) {
                  setState(() {
                    FocusScope.of(context).unfocus();
                    isAddQtyEnable = true;
                    isAddBtnSelected = false;
                    _controllers.text ="1";
                    widget.selectedSecurityList.add(widget.security);
                    securityAndELValue();
                  });
                } else {
                  Utility.showToastMessage(Strings.no_internet_message);
                }
              });
            },
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
      ),
    );
  }
}
