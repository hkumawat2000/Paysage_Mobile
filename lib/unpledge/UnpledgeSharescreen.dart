import 'package:lms/all_loans_name/AllLoansNameBloc.dart';
import 'package:lms/common_widgets/ReusableAmountWithTextAndDivider.dart';
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/network/requestbean/UnpledgeRequestBean.dart';
import 'package:lms/network/responsebean/UnpledgeDetailsResponse.dart';
import 'package:lms/unpledge/UnpledgeBloc.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'UnpledgeOTPVerificationScreen.dart';

class UnpledgeSharesScreen extends StatefulWidget {
  String loanName;
  String isComingFor;
  String isin;
  String loanType;
  @override
  _UnpledgeQuantityState createState() => _UnpledgeQuantityState();

  UnpledgeSharesScreen(this.loanName, this.isComingFor, this.isin, this.loanType);
}

class _UnpledgeQuantityState extends State<UnpledgeSharesScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Preferences preferences = new Preferences();
  final unpledgeBloc = UnpledgeBloc();
  final allLoansNameBloc = AllLoansNameBloc();
  double? loanBalance, existingDrawingPower, existingCollateral, maxAllowableValue;
  int selectedScrips = 0;
  var selectedSecurityValue;
  double actualDrawingPower = 0;
  double? revisedDrawingPower;
  bool canUnpledge = true;
  double totalValue = 0;
  List<UnpledgeItems> unpledgeItemsList = [];
  List<UnpledgeItems> actualMyCartList = [];
  UnpledgeData unpledgeData = new UnpledgeData();
  List<double>? unpledgeQtyList;
  UnpledgeDetailsResponse? unpledgeDetailsResponse;
  bool checkBoxValue = false;
  Widget appBarTitle = new Text("", style: new TextStyle(color: Colors.white));
  Icon actionIcon = new Icon(Icons.search, color: appTheme, size: 25);
  TextEditingController _textController = TextEditingController();
  List<TextEditingController> qtyControllers = [];
  List<bool> isAddBtnShow = [];
  List<FocusNode> focusNode = [];

  FocusNode focusNodes = FocusNode();

  @override
  void initState() {
    appBarTitle = Text(
      widget.loanName,
      style: TextStyle(color: appTheme),
    );
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        getUnpledgeDetails(widget.loanName);
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: colorBg,
          appBar: buildBar(context),
          body: unpledgeDetailsResponse != null
              ? unpledgeDetailsResponse!.data!.unpledge != null
              ? allUnpledgeData()
              : Center(child: Text(Strings.no_loan))
              : Center(child: Text(Strings.please_wait))
      ),
    );
  }

   getUnpledgeDetails(loan_name) async{
    unpledgeDetailsResponse = await unpledgeBloc.unpledgeDetails(loan_name);
    if(unpledgeDetailsResponse!.isSuccessFull!){
      if(unpledgeDetailsResponse!.data!.unpledge != null) {
        setState(() {
          unpledgeData = unpledgeDetailsResponse!.data!;
          for (int i = 0; i < unpledgeData.loan!.items!.length; i++) {
            actualDrawingPower = actualDrawingPower + ((unpledgeData.loan!.items![i].price! * unpledgeData.loan!.items![i].pledgedQuantity!) *
                (unpledgeData.loan!.items![i].eligiblePercentage! / 100));
            qtyControllers.add(TextEditingController());
            focusNode.add(FocusNode());
            if (unpledgeData.loan!.items![i].amount != 0.0) {
              unpledgeItemsList.add(unpledgeData.loan!.items![i]);
              if (widget.isComingFor == Strings.single && unpledgeData.loan!.items![i].isin == widget.isin) {
                selectedScrips = 1;
                isAddBtnShow.add(false);
                qtyControllers[i].text = unpledgeItemsList[i].pledgedQuantity!.toInt().toString();
              } else {
                isAddBtnShow.add(true);
              }
          }
          }
          loanBalance = unpledgeDetailsResponse!.data!.loan!.balance;
          maxAllowableValue = 0;
          unpledgeData.loan!.existingdrawingPower = unpledgeData.loan!.drawingPower;
          unpledgeData.loan!.existingtotalCollateralValue = unpledgeData.loan!.totalCollateralValue;
          existingDrawingPower = unpledgeData.loan!.existingdrawingPower;
          existingCollateral = unpledgeData.loan!.existingtotalCollateralValue;
          if(widget.isComingFor == Strings.all) {
            selectedSecurityValue = 0.0;
            selectedScrips = 0;
          }
          actualMyCartList.addAll(unpledgeItemsList);
          unpledgeQtyList = List.generate(unpledgeItemsList.length, (index) => unpledgeItemsList[index].pledgedQuantity!);
          unpledgeCalculationHandling();
        });
      }
    } else if (unpledgeDetailsResponse!.errorCode == 403) {
      commonDialog(context, Strings.session_timeout, 4);
    } else{
      Navigator.pop(context);
      Utility.showToastMessage(unpledgeDetailsResponse!.errorMessage!);
    }
  }

  void searchResults(String query) {
    List<UnpledgeItems> dummySearchList = <UnpledgeItems>[];
    dummySearchList.addAll(actualMyCartList);
    if (query.isNotEmpty) {
      List<UnpledgeItems> dummyListData = <UnpledgeItems>[];
      dummySearchList.forEach((item) {
        if (item.securityName!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        unpledgeItemsList.clear();
        unpledgeItemsList.addAll(dummyListData);
      });
    } else {
      setState(() {
        unpledgeItemsList.clear();
        unpledgeItemsList.addAll(actualMyCartList);
      });
    }
  }

  void _handleSearchEnd() {
    setState(() {
      focusNodes.unfocus();
      this.actionIcon = Icon(Icons.search, color: appTheme, size: 25);
      this.appBarTitle = Text(
        widget.loanName,
        style: TextStyle(color: appTheme),
      );
      _textController.clear();
      unpledgeItemsList.clear();
      unpledgeItemsList.addAll(actualMyCartList);
    });
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
                      headingText(widget.loanType == Strings.shares ? Strings.unpledge_security : Strings.revoke_scheme),
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
            _textController.text.isNotEmpty ? SizedBox() :Padding(
              padding: const EdgeInsets.only(left: 20, right: 20,top: 10,bottom: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                      child: scripsNameText(widget.loanType == Strings.shares
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
                        FocusScope.of(context).unfocus();
                        alterCheckBox(newValue);
                        // resetValue = newValue;
                      },
                      value: checkBoxValue,
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
      title: appBarTitle,
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
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(
                    Icons.close,
                    color: appTheme,
                    size: 25,
                  );
                  this.appBarTitle = new TextField(
                    controller: _textController,
                    style: new TextStyle(
                      color: appTheme,
                    ),
                    cursorColor: appTheme,
                    decoration: new InputDecoration(
                        prefixIcon: new Icon(
                          Icons.search,
                          color: appTheme,
                          size: 25,
                        ),
                        hintText: Strings.search,
                        focusColor: appTheme,
                        border: InputBorder.none,
                        hintStyle: new TextStyle(color: appTheme)),
                    onChanged: (value) => searchResults(value),
                  );
                  focusNodes.requestFocus();
                } else {
                  _handleSearchEnd();
                }
              });
            },
          ),
        ),
      ],
    );
  }

  Widget unpledgeSecuritiesList(){
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 0, right: 20, bottom: 10),
      child: unpledgeItemsList.length == 0 ?
      Padding(padding: const EdgeInsets.only(top: 150.0), child: Center(child: Text(Strings.search_result_not_found))) :
      ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: unpledgeItemsList.length,
        key: Key(unpledgeItemsList.length.toString()),
        itemBuilder: (context, index) {
          int actualIndex = actualMyCartList.indexWhere((element) => element.securityName == unpledgeItemsList[index].securityName);
          String unpledgeQty;
          if(isAddBtnShow[actualIndex]){
            unpledgeQty = 0.toString();
          } else {
            unpledgeQty = unpledgeItemsList[index].pledgedQuantity!.toInt().toString().split('.')[0];
          }
          unpledgeItemsList[index].pledgedQuantity = double.parse(unpledgeQty);
          if(index == unpledgeItemsList.length){
            setState(() {
            });
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
                Text(unpledgeItemsList[index].securityName!, style: boldTextStyle_18),
                SizedBox(height: 4),
                Text("${unpledgeItemsList[index].securityCategory!} (LTV: ${unpledgeItemsList[index].eligiblePercentage!.toStringAsFixed(2)}%)",
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
                                  scripsValueText("₹${unpledgeItemsList[index].price!.toStringAsFixed(2)}"),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(child: Text("${unpledgeQtyList![actualIndex].toInt().toString()} QTY", style: mediumTextStyle_12_gray)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      isAddBtnShow[actualIndex] ?
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
                            onPressed: () {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                    isAddBtnShow[actualIndex] = false;
                                    qtyControllers[actualIndex].text = "1";
                                    unpledgeItemsList[index].pledgedQuantity = 1.0;
                                    selectedScrips = selectedScrips + 1;
                                    unpledgeCalculationHandling();
                                  });
                                } else {
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
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
                                onPressed: () async {
                                  Utility.isNetworkConnection().then((isNetwork) {
                                    if (isNetwork) {
                                      FocusScope.of(context).unfocus();
                                      setState(() {
                                        if(qtyControllers[actualIndex].text.isNotEmpty){
                                          int txt = int.parse(qtyControllers[actualIndex].text) - 1;
                                          if (txt != 0) {
                                            qtyControllers[actualIndex].text = txt.toString();
                                            unpledgeItemsList[index].pledgedQuantity = txt.toDouble();
                                          } else {
                                            isAddBtnShow[actualIndex] = true;
                                            qtyControllers[actualIndex].text = "0";
                                            unpledgeItemsList[index].pledgedQuantity = 0;
                                            selectedScrips = selectedScrips - 1;
                                          }
                                        }
                                        unpledgeCalculationHandling();
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
                                  controller: qtyControllers[actualIndex],
                                  focusNode: focusNode[actualIndex],
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
                                        } else if (double.parse(qtyControllers[actualIndex].text) > unpledgeQtyList![actualIndex]) {
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                          Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${unpledgeQtyList![actualIndex]} quantity.");
                                          setState(() {
                                            qtyControllers[actualIndex].text = unpledgeItemsList[index].pledgedQuantity!.toInt().toString();
                                            unpledgeItemsList[index].pledgedQuantity = double.parse(qtyControllers[actualIndex].text);
                                          });
                                        } else {
                                          setState(() {
                                            unpledgeItemsList[index].pledgedQuantity = double.parse(qtyControllers[actualIndex].text);
                                          });
                                        }
                                      } else {
                                        setState(() {
                                          FocusScope.of(context).requestFocus(new FocusNode());
                                          qtyControllers[actualIndex].text = "0";
                                          unpledgeItemsList[index].pledgedQuantity = 0;
                                          isAddBtnShow[actualIndex] = true;
                                          selectedScrips = selectedScrips - 1;
                                          checkBoxValue = false;
                                        });
                                      }
                                    } else {
                                      focusNode[actualIndex].addListener(() {
                                        if(!focusNode[actualIndex].hasFocus){
                                          if(qtyControllers[actualIndex].text.trim() == "" || qtyControllers[actualIndex].text.trim() == "0"){
                                            isAddBtnShow[actualIndex] = true;
                                            unpledgeItemsList[index].pledgedQuantity = 0;
                                            qtyControllers[actualIndex].text = "0";
                                            selectedScrips = selectedScrips - 1;
                                            checkBoxValue = false;
                                          }
                                        }
                                      });
                                    }
                                    unpledgeCalculationHandling();
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
                                        if (int.parse(qtyControllers[actualIndex].text) < unpledgeQtyList![actualIndex]) {
                                          int txt = int.parse(qtyControllers[actualIndex].text) + 1;
                                          setState(() {
                                            qtyControllers[actualIndex].text = txt.toString();
                                            unpledgeItemsList[index].pledgedQuantity = txt.toDouble();
                                          });
                                        } else {
                                          Utility.showToastMessage(Strings.check_quantity);
                                        }
                                      }
                                      unpledgeCalculationHandling();
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
                          child:Text(getInitials(unpledgeItemsList[index].securityName, 1), style: extraBoldTextStyle_30),
                        ), //Container ,
                      ),
                    ],
                  ),
                ),
                !isAddBtnShow[actualIndex] ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings.value + " : ${(actualMyCartList[actualIndex].price! * double.parse(qtyControllers[actualIndex].text.isEmpty ? "0" : qtyControllers[actualIndex].text.toString())).toStringAsFixed(2)}", style: mediumTextStyle_14_gray),
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

  unpledgeCalculationHandling(){
    setState(() {
      if(!isAddBtnShow.contains(true)){
        checkBoxValue = true;
      } else {
        checkBoxValue = false;
      }
      totalValue = 0;
      double actualDP = 0;
      for(int i=0; i< actualMyCartList.length ; i++){
        if(!isAddBtnShow[i] && qtyControllers[i].text.isNotEmpty){
          totalValue += actualMyCartList[i].price! * double.parse(qtyControllers[i].text.toString());
          actualDP = actualDP + ((actualMyCartList[i].price! * double.parse(qtyControllers[i].text.toString())) * (actualMyCartList[i].eligiblePercentage! / 100));
        }
      }
      revisedDrawingPower = actualDrawingPower - actualDP;
      double eligibilityPercentage = (revisedDrawingPower! / loanBalance!) * 100;
      if (eligibilityPercentage >= 100.00 || selectedScrips == 0 || loanBalance! <= 0) {
        canUnpledge = true;
      } else {
        canUnpledge = false;
      }
    });
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
                      Text(loanBalance! < 0
                          ? negativeValue(loanBalance!)
                          : '₹${numberToString(loanBalance!.toStringAsFixed(2))}',
                        textAlign: TextAlign.center,
                        style: subHeadingValue.copyWith(
                          color: loanBalance! < 0 ? colorGreen : appTheme
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
            leftAmount: Strings.rupee + numberToString(existingDrawingPower!.toStringAsFixed(2)),
            leftText: Strings.existing_drawing_power,
            rightAmount: '₹${numberToString((roundDouble(revisedDrawingPower!, 2)).toStringAsFixed(2))}',
            rightText: Strings.revised_drawing_power,
          ),
          ReusableAmountWithTextAndDivider(
            leftAmount: Strings.rupee + numberToString(existingCollateral!.toStringAsFixed(2)),
            leftText:Strings.existing_collateral ,
            rightAmount: Strings.rupee + numberToString(roundDouble((existingCollateral! - totalValue), 2).toStringAsFixed(2)),
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
                 visible: !canUnpledge,
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
                  Text(totalValue < 0 ? negativeValue(totalValue)
                      : '₹' + numberToString(totalValue.toStringAsFixed(2)),
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
                      color: canUnpledge && selectedScrips > 0 ? appTheme : colorLightGray,
                      child: AbsorbPointer(
                        absorbing: canUnpledge && selectedScrips > 0 ? false : true,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                  unpledgeRequestOTP();
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
      ),
    );
  }

  void alterCheckBox(value) {
    setState(() {
      checkBoxValue = value;
    });
    for (var index = 0; index < unpledgeItemsList.length; index++) {
      setState(() {
        if (value) {
          isAddBtnShow[index] = false;
          qtyControllers[index].text = unpledgeQtyList![index].toInt().toString();
          unpledgeItemsList[index].pledgedQuantity = unpledgeQtyList![index];
          selectedScrips = index + 1;
        } else {
          isAddBtnShow[index] = true;
          qtyControllers[index].text= "0";
          unpledgeItemsList[index].pledgedQuantity = double.parse(qtyControllers[index].text);
          selectedScrips = 0;
        }
      });
    }
    unpledgeCalculationHandling();
  }

  Future<void> minimumValueDialog() {
    return showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                         Text(Strings.minimum_value, style: regularTextStyle_14_gray),
                         SizedBox(height: 8),
                        Text(unpledgeData.unpledge!.unpledgeValue!.minimumCollateralValue! < 0
                            ? negativeValue(unpledgeData.unpledge!.unpledgeValue!.minimumCollateralValue!)
                            : Strings.rupee + numberToString(unpledgeData.unpledge!.unpledgeValue!.minimumCollateralValue!.toStringAsFixed(2)),
                            style: boldTextStyle_18_gray_dark),
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

  void unpledgeRequestOTP() async{
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    _handleSearchEnd();
    unpledgeBloc.requestUnpledgeOTP().then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        Utility.showToastMessage(value.message!);
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.loan_number] = widget.loanName;
        parameter[Strings.max_allowable] = numberToString(maxAllowableValue!.toStringAsFixed(2));
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.unpledge_otp_sent, parameter);

        otpModalBottomSheet(context);
      } else if (value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  void otpModalBottomSheet(context) {
    List<UnPledgeList> dummyUnpledgeList = [];
    for (int i = 0; i < unpledgeItemsList.length; i++) {
      if(unpledgeItemsList[i].pledgedQuantity != 0) {
        if(unpledgeItemsList[i].amount != 0){
          dummyUnpledgeList.add(new UnPledgeList(
              isin:  unpledgeItemsList[i].isin,
              quantity:  unpledgeItemsList[i].pledgedQuantity,
              psn: unpledgeItemsList[i].psn
          ));
        }
      }
    }
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return UnpledgeOTPVerificationScreen(dummyUnpledgeList,
            unpledgeData.loan!.name!,
            numberToString(maxAllowableValue!.toStringAsFixed(2)),
            Strings.shares);
      },
    );
  }

}
