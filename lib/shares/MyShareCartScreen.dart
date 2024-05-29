import 'package:lms/common_widgets/constants.dart';
import 'package:lms/network/requestbean/MyCartRequestBean.dart';
import 'package:lms/network/responsebean/ApprovedListResponseBean.dart';
import 'package:lms/network/responsebean/MyCartResponseBean.dart';
import 'package:lms/network/responsebean/SecuritiesResponseBean.dart';
import 'package:lms/shares/LoanApplicationBloc.dart';
import 'package:lms/terms_conditions/TermsConditions.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../my_loan/MarginShortfallEligibleDialog.dart';
import '../network/responsebean/AuthResponse/LoanDetailsResponse.dart';

class MyShareCartScreen extends StatefulWidget {
  String loanName;
  MarginShortfall? marginShortfall;
  String comingFrom;
  List<SecuritiesListData> selectedSecurityList = [];
  List<SecuritiesList> sharesList;
  String stockAt;
  List<LenderInfo>? lenderInfo;

  MyShareCartScreen(this.loanName, this.marginShortfall, this.comingFrom, this.selectedSecurityList, this.sharesList, this.stockAt, this.lenderInfo);

  @override
  MyShareCartScreenState createState() => MyShareCartScreenState();
}

class MyShareCartScreenState extends State<MyShareCartScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final loanApplicationBloc = LoanApplicationBloc();
  List<SecuritiesListData> selectedSecurityList = [];
  List<SecuritiesList> securitiesListItems = [];
  List<CartItems> myCartList = [];
  List<ShareListData> getSharesList = [];
  var selectedSecurities, totalCompany, fileId;
  double eligibleLoan = 0;
  double securityValue = 0;
  List<TextEditingController> pledgeController = [];
  Map<String, TextEditingController> pledgeController2 = {};
  Map<String, double> selectedValueInScrips = {};
  List<bool> pledgeControllerEnable = [];
  List<bool> pledgeControllerAutoFocus = [];
  List<bool> pledgeControllerShowCursor = [];
  List<FocusNode> myFocusNode = [];
  bool isEdit = false;
  Utility utility = Utility();
  Cart cartData = new Cart();
  MyCartData? myCartData;
  bool isScripsSelect = true;
  double? minSanctionedLimit, maxSanctionedLimit;
  String? cartName;
  List<CategoryWiseSecurityList> categoryWiseList = [];
  List<SecuritiesListData> catAList = [];
  List<SecuritiesListData> catBList = [];
  List<SecuritiesListData> catCList = [];
  List<SecuritiesListData> catDList = [];
  List<SecuritiesListData> superCatAList = [];
  List<Choice> cartViewList = [];
  bool hideSecurityValue = false;
  bool showSecurityValue = true;

  @override
  void initState() {
    reArrangeSecurity();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            key: _scaffoldKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: colorBg,
            appBar: AppBar(
              leading: IconButton(
                icon: ArrowToolbarBackwardNavigation(),
                onPressed: _onBackPressed,
              ),
              backgroundColor: colorBg,
              elevation: 0.0,
              centerTitle: true,
              title:  Text(
                Strings.my_vault,
                style: mediumTextStyle_18_gray_dark,
              ),
            ),
            body: selectedSecurityList.isNotEmpty ? allMyCartData() : Container()),
      ),
      onWillPop: _onBackPressed,
    );
  }

  Future<bool> _onBackPressed() async {
    Navigator.pop(context, selectedSecurityList);
    return true;
  }

  Widget allMyCartData() {
    return NestedScrollView(
      physics: NeverScrollableScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverList(
            delegate: SliverChildListDelegate(
              [
                SizedBox(
                    height : 0.5
                ),
              ],
            ),
          )
        ];
      },
      body: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: Text("${cartViewList[0].lender.toString()}",
                      style: boldTextStyle_18),
                ),
              ],
            ),
          ),
          Expanded(
            child: securitiesDetailsViewList(),
          ),
          showSecurityValue ? bottomSection() : bottomSectionEL(),
        ],
      ),
    );
  }

  Widget bottomSection() {
    if (eligibleLoan != 0.0) {
      if(widget.comingFrom == Strings.increase_loan) {
        if (eligibleLoan >= cartViewList[0].minLimit!) {
          isScripsSelect = false;
        } else {
          isScripsSelect = true;
        }
      }else if(widget.comingFrom == Strings.margin_shortfall){
        if (eligibleLoan >= 1000) {
          isScripsSelect = false;
        } else {
          isScripsSelect = true;
        }
      }
    } else {
      isScripsSelect = true;
    }
    return Visibility(
      visible: showSecurityValue,
      child: Container(
        // height: 130,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
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
                            hideSecurityValue = true;
                            showSecurityValue = false;
                          });
                        },
                      )
                    ],
                  ),
                  Padding(padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(child: Text(Strings.security_value, style: mediumTextStyle_18_gray)),
                            scripsValueText('₹' + numberToString(securityValue.toStringAsFixed(2))),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Text("Eligible Loan",
                                  style: mediumTextStyle_18_gray,),
                                GestureDetector(
                                  onTap: () {
                                    commonDialog(context, Strings.eligible_loan_txt, 0);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Image.asset(AssetsImagePath.info,
                                        height: 18.0, width: 18.0),
                                  ),
                                ),
                              ],
                            ),
                            Text(eligibleLoan >= cartViewList[0].maxLimit!
                                ? '₹' + numberToString(cartViewList[0].maxLimit!.toStringAsFixed(2))
                                : '₹' + numberToString(roundDownTo(eligibleLoan.toDouble())), style: textStyleGreenStyle_18),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        widget.comingFrom == Strings.margin_shortfall ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Required Drawing Power",
                                style: mediumTextStyle_18_gray,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.marginShortfall!.drawingPower! + widget.marginShortfall!.minimumCashAmount! < 0
                                  ? negativeValue(widget.marginShortfall!.drawingPower! + widget.marginShortfall!.minimumCashAmount!)
                                  : "₹${numberToString((widget.marginShortfall!.drawingPower! + widget.marginShortfall!.minimumCashAmount!).toStringAsFixed(2))}",
                              style: boldTextStyle_18_gray_dark,
                            ),
                          ],
                        ) : Container(),
                        SizedBox(
                          height: 10,
                        ),
                        widget.comingFrom == Strings.margin_shortfall ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(
                              child: Text(
                                "Existing Drawing Power",
                                style: mediumTextStyle_18_gray,
                              ),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              widget.marginShortfall!.drawingPower! < 0
                                  ? negativeValue(widget.marginShortfall!.drawingPower!)
                                  : "₹${numberToString(widget.marginShortfall!.drawingPower!.toStringAsFixed(2))}",
                              style: boldTextStyle_18_gray_dark,
                            ),
                          ],
                        ) : Container(),
                      ],
                    ),
                  )
                ]
            ),              // : SizedBox(),
            Container(
              height: 45,
              width: 100,
              child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                elevation: 1.0,
                color: isScripsSelect ? colorLightGray : appTheme,
                child: AbsorbPointer(
                  absorbing: isScripsSelect,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          // sendMyCart(true);
                          createAndProcessCart();
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                    child: Text(Strings.submit, style: buttonTextWhite),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget bottomSectionEL() {
    if (eligibleLoan != 0.0) {
      if(widget.comingFrom == Strings.increase_loan) {
        if (eligibleLoan >= cartViewList[0].minLimit!) {
          isScripsSelect = false;
        } else {
          isScripsSelect = true;
        }
      }else if(widget.comingFrom == Strings.margin_shortfall){
        if (eligibleLoan >= 1000) {
          isScripsSelect = false;
        } else {
          isScripsSelect = true;
        }
      }
    } else {
      isScripsSelect = true;
    }
    return Visibility(
      visible: hideSecurityValue,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
          boxShadow: [
            BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Column(
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
                            hideSecurityValue = false;
                            showSecurityValue = true;
                          });
                        },
                      )
                    ],
                  ),
                  Padding(padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Column(
                      children: [
                        widget.comingFrom == Strings.margin_shortfall ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text(
                              "Shortfall",
                              style: TextStyle(
                                  color: appTheme,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18),
                            ),
                            SizedBox(
                              width: 15,
                            ),
                            Text(
                              "Rs.${numberToString(widget.marginShortfall!.minimumCashAmount!.toStringAsFixed(2))}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: red),
                            ),
                          ],
                        ) : Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: [
                                Text("Eligible Loan",
                                  style: mediumTextStyle_18_gray,),
                                GestureDetector(
                                  onTap: () {
                                    commonDialog(context, Strings.eligible_loan_txt, 0);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 6),
                                    child: Image.asset(AssetsImagePath.info,
                                        height: 18.0, width: 18.0),
                                  ),
                                ),
                              ],
                            ),
                            Text(eligibleLoan.toDouble() >= cartViewList[0].maxLimit!
                                ? '₹' + numberToString(cartViewList[0].maxLimit!.toStringAsFixed(2))
                                : '₹' + numberToString(eligibleLoan.toDouble().toStringAsFixed(2)), style: textStyleGreenStyle_18)
                          ],
                        ),
                      ],
                    ),
                  )
                ]
            ),              // : SizedBox(),
            SizedBox(
              height: 14,
            ),
            Container(
              height: 45,
              width: 100,
              child: Material(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                elevation: 1.0,
                color: isScripsSelect ? colorLightGray : appTheme,
                child: AbsorbPointer(
                  absorbing: isScripsSelect,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          // sendMyCart(true);
                          createAndProcessCart();
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                    child: Text(Strings.submit, style: buttonTextWhite),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget pledgeCart(Cart cart) {
    eligibleLoan = roundDouble(cart.eligibleLoan!.toDouble(), 2);
    selectedSecurities = roundDouble(cart.totalCollateralValue!.toDouble(), 2);
    totalCompany = cart.items!.length.toString();

    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
      child: Container(
        decoration: BoxDecoration(
          color: colorLightBlue,
          border: Border.all(color: colorLightBlue, width: 3.0),
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            largeHeadingText(
                '₹' + numberToString(selectedSecurities.toStringAsFixed(2))),
            SizedBox(
              height: 2,
            ),
            Text(Strings.values_selected_securities, style: subHeading),
            SizedBox(
              height: 14,
            ),
            subHeadingText(totalCompany.toString()),
            SizedBox(
              height: 2,
            ),
            Text(Strings.scrips, style: subHeading),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  categoryWiseScheme(index){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: colorWhite,
        border: Border.all(color: colorWhite, width: 3.0),
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Column(
        children: [
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: Table(children: [
              TableRow(children: [
                Container(),
                Container(
                  decoration: BoxDecoration(
                    color: colorLightGray2,
                    borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  ),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Text(categoryWiseList[index].categoryName!,
                        style: mediumTextStyle_14_gray_dark,
                      ),
                    ),
                  ),
                ),
                Container()
              ]),
            ]),
          ),
          ListView.builder(
            key: Key(categoryWiseList[index].items!.length.toString()),
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: categoryWiseList[index].items!.length,
            itemBuilder: (context, i) {
              int actualIndex = selectedSecurityList.indexWhere((element) => element.iSIN == categoryWiseList[index].items![i].iSIN);
              String pledgeQty;
              pledgeQty = categoryWiseList[index].items![i].quantity!.toInt().toString();
              pledgeController.add(TextEditingController(text: pledgeQty));
              myFocusNode.add(FocusNode());
              return Column(
                children: [
                  Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(categoryWiseList[index].items![i].scripName!,
                          style: boldTextStyle_18,
                        ),
                        Text("${categoryWiseList[index].categoryName!} (LTV: ${categoryWiseList[index].items![i].eligiblePercentage!.toStringAsFixed(2)}%)",
                            style: boldTextStyle_12_gray),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Row(
                              children: [
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
                                        setState(() {
                                          FocusScope.of(context).unfocus();
                                          String fieldText = pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text.toString();
                                          if(fieldText.isEmpty || int.parse(fieldText) == 1 || int.parse(fieldText) == 0){
                                            Utility.showToastMessage(Strings.message_quantity_not_less_1);
                                            pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text = "1";
                                            categoryWiseList[index].items![i].quantity = double.parse(pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text);
                                          } else {
                                            int txt = fieldText.isNotEmpty ? int.parse(fieldText.toString()) - 1 : 0;
                                            pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text = txt.toString();
                                            categoryWiseList[index].items![i].quantity = double.parse(pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text);
                                          }
                                          calculationHandling();
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
                                    style: boldTextStyle_18_gray_dark,
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                    ],
                                    textAlign: TextAlign.center,
                                    enabled: true,
                                    controller: pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)],
                                    onChanged: (text) async {
                                      pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].selection = new TextSelection(
                                          baseOffset: text.length, extentOffset: text.length);
                                      Utility.isNetworkConnection().then((isNetwork) {
                                        if (isNetwork) {
                                          if (double.parse(pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text) < 1) {
                                            Utility.showToastMessage(Strings.message_quantity_not_less_1);
                                            pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text = pledgeQty;
                                          }
                                          if (double.parse(pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text) > selectedSecurityList[actualIndex].totalQty!) {
                                            Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${selectedSecurityList[actualIndex].totalQty!.toInt().toString()} quantity .");
                                            pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text = selectedSecurityList[actualIndex].totalQty!.toInt().toString();
                                          } else {
                                          }
                                          categoryWiseList[index].items![i].quantity = double.parse(pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text);
                                          calculationHandling();
                                        } else {
                                          showSnackBar(_scaffoldKey);
                                        }
                                      });
                                    },
                                  ),
                                ),
                                IconButton(
                                  iconSize: 20.0,
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
                                        setState(() {
                                          FocusScope.of(context).unfocus();
                                          String fieldText = pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text.toString();
                                          if(fieldText.isNotEmpty && (int.parse(fieldText) >= selectedSecurityList[actualIndex].totalQty!.toInt())){
                                            Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${selectedSecurityList[actualIndex].totalQty!.toInt().toString()} quantity.");
                                            pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text = selectedSecurityList[actualIndex].totalQty!.toInt().toString();
                                          }else{
                                            if(fieldText.isEmpty || int.parse(fieldText) == 0 || fieldText == " "){
                                              fieldText = "1";
                                              pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text = "1";
                                            }else{
                                              int txt = fieldText.isNotEmpty ? int.parse(fieldText.toString()) + 1 : 0;
                                              pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text = txt.toString();
                                            }
                                          }
                                          categoryWiseList[index].items![i].quantity = double.parse(pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text);
                                          calculationHandling();
                                        });
                                      } else {
                                        Utility.showToastMessage(Strings.no_internet_message);
                                      }
                                    });
                                  },
                                ),
                              ],
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.19,
                              child: IconButton(
                                iconSize: 20,
                                icon: Image.asset(
                                  AssetsImagePath.delete_icon_bg_red,
                                ),
                                onPressed: () async {
                                  Utility.isNetworkConnection().then((isNetwork) {
                                    if (isNetwork) {
                                      if (selectedSecurityList.length > 1) {
                                        deleteDialogBox(index, i, categoryWiseList[index].items![i].iSIN!);
                                      } else {
                                        Utility.showToastMessage(Strings.at_least_one_script);
                                      }
                                    } else {
                                      Utility.showToastMessage(Strings.no_internet_message);
                                    }
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  categoryWiseList[index].items!.length != i + 1
                      ? Divider(thickness: 0.2, color: colorBlack)
                      : SizedBox()
                ],
              );
            },
          )
        ],
      ),
    );
  }

  calculationHandling(){
    setState(() {
      securityValue = 0;
      eligibleLoan = 0;
      for(int i=0; i < selectedSecurityList.length; i++){
        securityValue +=  (selectedSecurityList[i].price! * selectedSecurityList[i].quantity!);
        eligibleLoan += (selectedSecurityList[i].price! * selectedSecurityList[i].quantity! * selectedSecurityList[i].eligiblePercentage!) / 100;
      }
    });
  }

  Widget securitiesDetailsViewList() {
    return Column(
      children: [
        Flexible(
          flex: 1,
          child: PageView.builder(
            itemCount: 1,
            itemBuilder: (context, position) {
              return Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Container(
                            child: ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: categoryWiseList.length,
                              itemBuilder: (context, index) {
                                if (categoryWiseList[index].items!.length == 0) {
                                  return Container();
                                } else {
                                  return categoryWiseScheme(index);
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.white, width: 3.0),
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(Strings.rate_of_interest,
                                    style: mediumTextStyle_18_gray,
                                  ),
                                ),
                                Text("${cartViewList[0].roi!.toStringAsFixed(2)}%",
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
                                Text(Strings.min_limit,
                                  style: mediumTextStyle_18_gray,
                                ),
                                Text("₹${numberToString(cartViewList[0].minLimit!.toStringAsFixed(2))}",
                                  style: boldTextStyle_18_gray_dark,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Expanded(
                                  child: Text(Strings.max_limit, style: mediumTextStyle_18_gray),
                                ),
                                Text("₹${numberToString(cartViewList[0].maxLimit!.toStringAsFixed(2))}",
                                    style: boldTextStyle_18_gray_dark)
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  getIndexOfSchemeUnit(String categoryName, int index){
    if(categoryName == Strings.cat_a.toLowerCase()){
      return index;
    } else if(categoryName == Strings.cat_b.toLowerCase()){
      return catAList.length + index;
    } else if(categoryName == Strings.cat_c.toLowerCase()){
      return catAList.length + catBList.length + index;
    } else if(categoryName == Strings.cat_d.toLowerCase()){
      return catAList.length + catBList.length+ catCList.length + index;
    } else {
      return catAList.length + catBList.length + catCList.length + catDList.length + index;
    }
  }

  reArrangeSecurity(){
    pledgeController.clear();
    selectedSecurityList.clear();
    catAList.clear();
    catBList.clear();
    catCList.clear();
    catDList.clear();
    superCatAList.clear();
    categoryWiseList.clear();
    selectedSecurityList.addAll(widget.selectedSecurityList);
    setState(() {
      cartViewList.add(Choice(widget.lenderInfo![0].name,
          widget.lenderInfo![0].rateOfInterest,
          widget.lenderInfo![0].minimumSanctionedLimit,
          widget.lenderInfo![0].maximumSanctionedLimit));
      for (int i = 0; i < selectedSecurityList.length; i++) {
        pledgeController.add(TextEditingController(text: selectedSecurityList[i].quantity.toString()));
        switch (selectedSecurityList[i].category!) {
          case Strings.cat_a:
            catAList.add(selectedSecurityList[i]);
            break;
          case Strings.cat_b:
            catBList.add(selectedSecurityList[i]);
            break;
          case Strings.cat_c:
            catCList.add(selectedSecurityList[i]);
            break;
          case Strings.cat_d:
            catDList.add(selectedSecurityList[i]);
            break;
          case Strings.super_cat_a:
            superCatAList.add(selectedSecurityList[i]);
            break;
        }
      }
      categoryWiseList.add(CategoryWiseSecurityList(Strings.cat_a, catAList));
      categoryWiseList.add(CategoryWiseSecurityList(Strings.cat_b, catBList));
      categoryWiseList.add(CategoryWiseSecurityList(Strings.cat_c, catCList));
      categoryWiseList.add(CategoryWiseSecurityList(Strings.cat_d, catDList));
      categoryWiseList.add(CategoryWiseSecurityList(Strings.super_cat_a, superCatAList));
      for(int i=0; i<catAList.length; i++){
        pledgeController[i].text = int.parse(catAList[i].quantity!.toString().split(".")[1]) == 0 ? catAList[i].quantity!.toString().split(".")[0] : catAList[i].quantity!.toString();
      }
      for(int i=0; i<catBList.length; i++){
        pledgeController[catAList.length + i].text = int.parse(catBList[i].quantity!.toString().split(".")[1]) == 0 ? catBList[i].quantity!.toString().split(".")[0] : catBList[i].quantity!.toString();
      }
      for(int i=0; i<catCList.length; i++){
        pledgeController[catAList.length + catBList.length + i].text = int.parse(catCList[i].quantity!.toString().split(".")[1]) == 0 ? catCList[i].quantity!.toString().split(".")[0] : catCList[i].quantity!.toString();
      }
      for(int i=0; i<catDList.length; i++){
        pledgeController[catAList.length + catBList.length + catCList.length + i].text = int.parse(catDList[i].quantity!.toString().split(".")[1]) == 0 ? catDList[i].quantity!.toString().split(".")[0] : catDList[i].quantity!.toString();
      }
      for(int i=0; i<superCatAList.length; i++){
        pledgeController[catAList.length + catBList.length + catCList.length+ catDList.length + i].text = int.parse(superCatAList[i].quantity!.toString().split(".")[1]) == 0 ? superCatAList[i].quantity!.toString().split(".")[0] : superCatAList[i].quantity!.toString();
      }
      calculationHandling();
    });
  }

  createAndProcessCart(){
    List<SecuritiesList> securitiesList = [];
    selectedSecurityList.forEach((element) {
      securitiesList.add(SecuritiesList(
          isin: element.iSIN,
          quantity: element.quantity,
          qty: element.totalQty,
          price: element.price
      ));
    });
    Securities securities = Securities(list: securitiesList);
    MyCartRequestBean cartRequestBean = MyCartRequestBean(
        cartName: "",
        instrumentType: Strings.shares,
        lender: widget.lenderInfo![0].name,
        loamName: widget.loanName,
        loan_margin_shortfall_name: widget.comingFrom == Strings.margin_shortfall ? widget.marginShortfall!.name : "",
        pledgor_boid: widget.stockAt,
        schemeType: "",
        securities: securities
    );

    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    loanApplicationBloc.myCart(cartRequestBean).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        if(widget.comingFrom == Strings.margin_shortfall){
          showModalBottomSheet(
              backgroundColor: Colors.transparent,
              context: context,
              isScrollControlled: true,
              builder: (BuildContext bc) {
                return MarginShortfallEligibleDialog(
                    value.data!.cart!.eligibleLoan!,
                    value.data!.cart!.name!,
                    "",
                    widget.stockAt,
                    value.data!.cart!.loan!,
                    value.data!.cart!.totalCollateralValue!,
                    Strings.shares
                );
              });
        }else{
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => TermsConditionsScreen(
                  roundDownTo(eligibleLoan).toString(), value.myCartData!.cart!.name!, widget.stockAt,
                  Strings.shares, "", "")));
        }
      } else if(value.errorCode == 403){
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  Future<void> deleteDialogBox(index, i, String isin) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: colorWhite,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Row(
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
          content: Container(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("Are you sure?", style: textStyleAppThemeStyle),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(Strings.valid_remove_selection,
                        style: mediumTextStyle_16_gray),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 45,
                  width: 100,
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    elevation: 1.0,
                    color: appTheme,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        Navigator.pop(context);
                        setState(() {
                          categoryWiseList[index].items!.removeAt(i);
                          widget.sharesList.removeWhere((element) => element.isin == isin);
                          selectedSecurityList.removeWhere((element) => element.iSIN == isin);
                          pledgeController.clear();
                          calculationHandling();
                        });
                      },
                      child: Text(
                        Strings.yes,
                        style: TextStyle(color: colorWhite,
                            fontWeight: FontWeight.bold),
                      ),
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

class ScripsData {
  Map<String, TextEditingController>? pledgeController = {};
  Map<String, double>? selectedValueInScrips = {};
  double? totalValueSecurity;
  double? eligibleLoan;

  ScripsData({this.pledgeController,
    this.selectedValueInScrips,
    this.totalValueSecurity,
    this.eligibleLoan});
}
class Choice {
  const Choice(this.lender, this.roi, this.minLimit, this.maxLimit);

  final String? lender;
  final double? roi;
  final double? minLimit;
  final double? maxLimit;
}