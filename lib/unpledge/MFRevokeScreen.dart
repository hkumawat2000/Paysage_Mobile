import 'package:lms/all_loans_name/AllLoansNameBloc.dart';
import 'package:lms/common_widgets/ReusableAmountWithTextAndDivider.dart';
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/network/requestbean/UnpledgeRequestBean.dart';
import 'package:lms/network/responsebean/UnpledgeDetailsResponse.dart';
import 'package:lms/unpledge/UnpledgeBloc.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;
import 'UnpledgeOTPVerificationScreen.dart';

class MFRevokeScreen extends StatefulWidget {
  String loanName;
  String isComingFor;
  String isin;
  String folio;

  @override
  _MFRevokeQuantityState createState() => _MFRevokeQuantityState();

  MFRevokeScreen(this.loanName, this.isComingFor, this.isin, this.folio);
}

class _MFRevokeQuantityState extends State<MFRevokeScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Preferences preferences = new Preferences();
  final unpledgeBloc = UnpledgeBloc();
  final allLoansNameBloc = AllLoansNameBloc();
  double? revisedDrawingPower, existingDrawingPower;
  var loanName, loanBalance, existingCollateral, revisedCollateral, selectedSecurityValue,
      maxAllowableValue, selectedScips, unpledgeScripsValue, totalcollateralValue;
  List<UnpledgeItems> unpledgeItemsList = [];
  List<CollateralLedger> collateralList = [];
  List<UnpledgeItems> searchMyCartList = [];
  List<bool> unPledgeControllerEnable = [];
  UnpledgeData unpledgeData = new UnpledgeData();
  int tempLength = 0;
  List<String>? scripNameList;
  List<String> unitStringList = [];
  List<double>? actualQtyList;
  bool? resetValue;
  List<TextEditingController> _controllers = [];
  UnpledgeDetailsResponse? unpledgeDetailsResponse;
  List<bool> checkBoxValues = [];
  bool checkBoxValue = false;
  bool isScripsSelect = true;
  bool canUnpledge = true;
  bool isUnpledgeAlert = false;
  List<bool> isAddBtnShow = [];
  double totalValue = 0;
  double eligibleLoan = 0;
  Widget appBarTitle = new Text(
    "",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: appTheme,
    size: 25,
  );
  TextEditingController _textController = TextEditingController();
  double actualDrawingPower = 0;
  String? revocationChargeType;
  double revocationCharge = 0;
  double revocationMinCharge = 0;
  double revocationMaxCharge = 0;
  double revocationPercentage = 0;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    resetValue = true;
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
    final theme = Theme.of(context);
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
          actualDrawingPower = 0;
          if(unpledgeDetailsResponse!.unpledgeData!.collateralLedger != null){
            collateralList.addAll(unpledgeDetailsResponse!.unpledgeData!.collateralLedger!);
          }
          for (int i = 0; i < unpledgeData.loan!.items!.length; i++) {
            if(unpledgeData.loan!.items![i].amount != 0.0) {
              unpledgeItemsList.add(unpledgeData.loan!.items![i]);
              _controllers.add(TextEditingController());
              actualDrawingPower = actualDrawingPower + ((unpledgeData.loan!.items![i].price! * unpledgeData.loan!.items![i].pledgedQuantity!) * (unpledgeData.loan!.items![i].eligiblePercentage! / 100));
              unitStringList.add("0");
            }
            if(widget.isComingFor == Strings.single){
              if(unpledgeData.loan!.items![i].isin == widget.isin && unpledgeData.loan!.items![i].folio == widget.folio) {
                selectedScips = 1;
                selectedSecurityValue = 0.0 + unpledgeData.loan!.items![i].amount!;
                if(unpledgeItemsList[i].pledgedQuantity.toString().split(".")[1].length != 0){
                  var unitsDecimalCount;
                  String str = unpledgeItemsList[i].pledgedQuantity.toString();
                  var qtyArray = str.split('.');
                  unitsDecimalCount = qtyArray[1];
                  if(unitsDecimalCount == "0") {
                    unitStringList[i] = str.toString().split(".")[0];
                  } else {
                    unitStringList[i] = unpledgeItemsList[i].pledgedQuantity.toString();
                  }
                }
              }
            }
          }
          if(unpledgeDetailsResponse!.data!.revokeChargeDetails != null) {
            revocationChargeType = unpledgeDetailsResponse!.data!.revokeChargeDetails!.revokeInitiateChargeType;
            if(revocationChargeType == "Fix") {
              revocationCharge = unpledgeDetailsResponse!.data!.revokeChargeDetails!.revokeInitiateCharges!;
            } else {
              revocationPercentage = unpledgeDetailsResponse!.data!.revokeChargeDetails!.revokeInitiateCharges!;
              revocationMinCharge = unpledgeDetailsResponse!.data!.revokeChargeDetails!.revokeInitiateChargesMinimumAmount!;
              revocationMaxCharge = unpledgeDetailsResponse!.data!.revokeChargeDetails!.revokeInitiateChargesMaximumAmount!;
              if(selectedSecurityValue != 0){
                revocationCharge = unpledgeDetailsResponse!.data!.revokeChargeDetails!.revokeInitiateChargesMinimumAmount!;
              }else{
                revocationCharge = 0.00;
              }
            }
          }
          tempLength = unpledgeItemsList.length;
          totalcollateralValue = unpledgeData.loan!.totalCollateralValue;
          loanBalance = unpledgeDetailsResponse!.data!.loan!.balance;
          maxAllowableValue = 0;
          unpledgeData.loan!.existingdrawingPower = unpledgeData.loan!.drawingPower;
          unpledgeData.loan!.existingtotalCollateralValue = unpledgeData.loan!.totalCollateralValue;
          existingDrawingPower = unpledgeData.loan!.actualDrawingPower;
          existingCollateral = unpledgeData.loan!.existingtotalCollateralValue;
          revisedCollateral = unpledgeData.loan!.totalCollateralValue;
          revisedDrawingPower = unpledgeData.loan!.actualDrawingPower;
          unpledgeData.loan!.totalCollateralValue = 0;
          if(widget.isComingFor == Strings.all) {
            selectedSecurityValue = 0.0;
            selectedScips = 0;
          }
          searchMyCartList.addAll(unpledgeItemsList);
          scripNameList = List.generate(unpledgeData.loan!.items!.length, (index) => unpledgeData.loan!.items![index].securityName!);
          actualQtyList = List.generate(unpledgeItemsList.length, (index) => unpledgeItemsList[index].pledgedQuantity!);
          double actualDP = 0;
          for (int i = 0; i < unpledgeItemsList.length; i++) {
            int actualIndex = searchMyCartList.indexWhere((element) => element.isin == unpledgeItemsList[i].isin && element.folio == unpledgeItemsList[i].folio);

            if(double.parse(unitStringList[actualIndex]) >= 0.001) {
              actualDP = actualDP + ((unpledgeItemsList[i].price! * double.parse(unitStringList[actualIndex])) * (unpledgeItemsList[i].eligiblePercentage! / 100));
            }
          }
          revisedDrawingPower = actualDrawingPower - actualDP;
          double eligibilityPercentage = (revisedDrawingPower! / loanBalance) * 100;
          if (eligibilityPercentage >= 100.00 || selectedScips == 0 || loanBalance <= 0) {
            canUnpledge = true;
          } else {
            canUnpledge = false;
          }
          if(revocationChargeType != "Fix"){
            if(selectedSecurityValue > 0){
              if((selectedSecurityValue * revocationPercentage) / 100 >= revocationMaxCharge){
                revocationCharge = revocationMaxCharge;
              } else if((selectedSecurityValue * revocationPercentage) / 100 <= revocationMinCharge) {
                revocationCharge = revocationMinCharge;
              } else {
                revocationCharge = (selectedSecurityValue * revocationPercentage) / 100;
              }
            }else{
              revocationCharge = 0.00;
            }

          }
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
    dummySearchList.addAll(searchMyCartList);
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
        unpledgeItemsList.addAll(searchMyCartList);
      });
    }
  }

  void _handleSearchEnd() {
    setState(() {
      focusNode.unfocus();
      this.actionIcon = Icon(Icons.search, color: appTheme, size: 25);
      this.appBarTitle = Text(
        widget.loanName != null ? widget.loanName : "",
        style: TextStyle(color: appTheme),
      );
      _textController.clear();
      unpledgeItemsList.clear();
      unpledgeItemsList.addAll(searchMyCartList);
    });
  }

  Widget allUnpledgeData(){
    return ScrollConfiguration(
      behavior: new ScrollBehavior()
        ..buildViewportChrome(context, Container(), AxisDirection.down),
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
            _textController.text.isNotEmpty ? SizedBox() :Padding(
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
                        altercheckBox(newValue);
                        resetValue = newValue;
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
                    focusNode: focusNode,
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
                  focusNode.requestFocus();
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
      padding: const EdgeInsets.only(left: 20.0, top: 0, right: 20, bottom: 150),
      child: unpledgeItemsList.length == 0
          ? Padding(padding: const EdgeInsets.only(top: 150.0), child: Center(child: Text(Strings.search_result_not_found))) :
      ListView.builder(
        physics: ScrollPhysics(),
        shrinkWrap: true,
        itemCount: unpledgeItemsList.length,
        key: Key(unpledgeItemsList.length.toString()),
        itemBuilder: (context, index) {
          if(widget.isComingFor == Strings.single){
            if(unpledgeItemsList[index].isin == widget.isin && unpledgeItemsList[index].folio == widget.folio){
              checkBoxValues.add(true);
              isAddBtnShow.add(false);
              unpledgeItemsList[index].check = true;
              unpledgeData.loan!.totalCollateralValue = selectedSecurityValue;
              isScripsSelect = false;
              isUnpledgeAlert = false;
            } else {
              isAddBtnShow.add(true);
              checkBoxValues.add(false);
              unpledgeItemsList[index].check = false;
            }
          } else {
            isAddBtnShow.add(true);
            checkBoxValues.add(false);
            unpledgeItemsList[index].check = false;
          }
          int actualIndex = searchMyCartList.indexWhere((element) => element.isin == unpledgeItemsList[index].isin && element.folio == unpledgeItemsList[index].folio);
          String unpledgeQty;
          String strUnpledge = unpledgeItemsList[index].pledgedQuantity!.toString();
          if(isAddBtnShow[actualIndex]) {
            unpledgeQty = 0.toString();
          } else {
            unpledgeQty = strUnpledge;
          }
          unpledgeItemsList[index].pledgedQuantity = double.parse(unpledgeQty);
          _controllers[actualIndex] = TextEditingController(text: unitStringList[actualIndex]);
          _controllers[actualIndex].selection =TextSelection.fromPosition(TextPosition(offset: _controllers[actualIndex].text.length));
          unPledgeControllerEnable.add(false);
          if(index + 1 == unpledgeItemsList.length) {
            calculatePercentage(false);
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
                Text("${unpledgeItemsList[index].securityName!} [${unpledgeItemsList[index].folio}]", style: boldTextStyle_18),
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
                                      Expanded(child: Text("${actualQtyList![actualIndex].toString()} QTY", style: mediumTextStyle_12_gray)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),isAddBtnShow[actualIndex] ?
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
                                    var txt;
                                    txt = double.parse(_controllers[actualIndex].text) + 1;
                                    if (actualQtyList![actualIndex] < 1) {
                                      txt = actualQtyList![actualIndex];
                                      if(txt>actualQtyList![actualIndex]){
                                        Utility.showToastMessage(Strings.check_unit);
                                      } else {
                                        unpledgeItemsList[index].pledgedQuantity = txt;
                                        unitStringList[actualIndex] = txt.toString();
                                        _controllers[actualIndex].text = unitStringList[actualIndex];
                                      }
                                    }else{
                                      unitStringList[actualIndex] = "1";
                                      _controllers[actualIndex].text = unitStringList[actualIndex].toString();
                                      unpledgeItemsList[index].pledgedQuantity = 1.0;
                                    }
                                    updateTotalSchemeValue();
                                    selectedScips = selectedScips + 1;
                                    unpledgeItemsList[index].amount = double.parse(_controllers[actualIndex].text) * unpledgeItemsList[index].price!;
                                    setState(() {
                                      if(searchMyCartList.length == selectedScips){
                                        checkBoxValue = true;
                                      }
                                      if(double.parse(revisedDrawingPower.toString()) > maxAllowableValue){
                                        if (double.parse(revisedDrawingPower.toString()) <= double.parse(existingDrawingPower.toString())) {
                                          isScripsSelect = false;
                                        } else {
                                          isScripsSelect = true;
                                        }
                                      }else{
                                        if(selectedSecurityValue <= maxAllowableValue) {
                                          isUnpledgeAlert = false;
                                        }else{
                                          isUnpledgeAlert = true;
                                        }
                                      }
                                    });
                                    if(_controllers[actualIndex].text.isNotEmpty){
                                      calculatePercentage(true);}
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
                                onPressed: () async {
                                  Utility.isNetworkConnection().then((isNetwork) {
                                    if (isNetwork) {
                                      setState(() {
                                        FocusScope.of(context).requestFocus(new FocusNode());
                                        if(_controllers[actualIndex].text.isNotEmpty){
                                          if(double.parse(_controllers[actualIndex].text.toString()) >= 0.001) {
                                            var txt, decrementWith;
                                            if(unitStringList[actualIndex].toString().contains('.') && unitStringList[actualIndex].toString().split(".")[1].length != 0) {
                                              var unitsDecimalCount;
                                              String str = _controllers[actualIndex].text.toString();
                                              var qtyArray = str.split('.');
                                              unitsDecimalCount = qtyArray[1];
                                              if(int.parse(unitsDecimalCount) == 0){
                                                txt = double.parse(_controllers[actualIndex].text) - 1;
                                                decrementWith = 1;
                                                unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toString());
                                                unitStringList[actualIndex] = txt.toString();
                                                _controllers[actualIndex].text =  unitStringList[actualIndex];
                                              } else {
                                                if (unitsDecimalCount.toString().length == 1) {
                                                  txt = double.parse(_controllers[actualIndex].text) - .1;
                                                  decrementWith = .1;
                                                  unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(1));
                                                  unitStringList[actualIndex] = txt.toStringAsFixed(1);
                                                  _controllers[actualIndex].text =  unitStringList[actualIndex];
                                                } else if (unitsDecimalCount.toString().length == 2) {
                                                  txt = double.parse(_controllers[actualIndex].text) - .01;
                                                  decrementWith = .01;
                                                  unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(2));
                                                  unitStringList[actualIndex] = txt.toStringAsFixed(2);
                                                  _controllers[actualIndex].text = unitStringList[actualIndex];
                                                } else {
                                                  txt = double.parse(_controllers[actualIndex].text) - .001;
                                                  decrementWith = .001;
                                                  unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(3));
                                                  unitStringList[actualIndex] = txt.toStringAsFixed(3);
                                                  _controllers[actualIndex].text = unitStringList[actualIndex];
                                                }
                                              }
                                            }else{
                                              txt = int.parse(_controllers[actualIndex].text.toString().split(".")[0]) - 1;
                                              decrementWith = 1;
                                              unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toString());
                                              unitStringList[actualIndex] = txt.toString();
                                              _controllers[actualIndex].text = unitStringList[actualIndex];
                                            }
                                            if (txt >= 0.001) {
                                              if (double.parse(_controllers[actualIndex].text) <= actualQtyList![actualIndex]) {
                                                unpledgeItemsList[index].amount = txt * unpledgeItemsList[index].price!;
                                                print("quantityy --> ${unpledgeItemsList[index].amount.toString()}");
                                                updateTotalSchemeValue();
                                              } else {
                                                Utility.showToastMessage(Strings.check_unit);
                                              }
                                            } else {
                                              setState(() {
                                                isAddBtnShow[actualIndex] = true;
                                                unpledgeItemsList[index].amount = 0.0;
                                                _controllers[actualIndex].text = "0";
                                                unitStringList[actualIndex] = "0";
                                                updateTotalSchemeValue();
                                                unpledgeItemsList[index].pledgedQuantity = double.parse(_controllers[actualIndex].text);
                                                selectedScips = selectedScips - 1;
                                                checkBoxValue = false;
                                                if(double.parse(revisedDrawingPower.toString()) > maxAllowableValue){
                                                  if (double.parse(revisedDrawingPower.toString()) <= double.parse(existingDrawingPower.toString())) {
                                                    isScripsSelect = false;
                                                  } else {
                                                    isScripsSelect = true;
                                                  }
                                                }else{
                                                  if(selectedSecurityValue <= maxAllowableValue) {
                                                    isUnpledgeAlert = false;
                                                  }else{
                                                    isUnpledgeAlert = true;
                                                  }
                                                }
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              isAddBtnShow[actualIndex] = true;
                                              unpledgeItemsList[index].amount = 0.0;
                                              _controllers[actualIndex].text = "0";
                                              unitStringList[actualIndex] = "0";
                                              updateTotalSchemeValue();
                                              unpledgeItemsList[index].pledgedQuantity = double.parse(_controllers[actualIndex].text);
                                              selectedScips = selectedScips - 1;
                                              checkBoxValue = false;
                                              if(double.parse(revisedDrawingPower.toString()) > maxAllowableValue){
                                                if (double.parse(revisedDrawingPower.toString()) <= double.parse(existingDrawingPower.toString())) {
                                                  isScripsSelect = false;
                                                } else {
                                                  isScripsSelect = true;
                                                }
                                              }else{
                                                if(selectedSecurityValue <= maxAllowableValue) {
                                                  isUnpledgeAlert = false;
                                                }else{
                                                  isUnpledgeAlert = true;
                                                }
                                              }
                                            });
                                            Utility.showToastMessage(Strings.check_unit);
                                          }
                                        }else{
                                          setState(() {
                                            _controllers[actualIndex].text = "0.001";
                                            unitStringList[actualIndex] = "0.001";
                                            unpledgeItemsList[index].pledgedQuantity = double.parse(_controllers[actualIndex].text);
                                            unpledgeItemsList[index].amount = 0.001 * unpledgeItemsList[index].price!;
                                            updateTotalSchemeValue();
                                          });
                                        }
                                        if(_controllers[actualIndex].text.isNotEmpty){
                                          calculatePercentage(true);}
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
                                  controller: _controllers[actualIndex],
                                  decoration: InputDecoration(counterText: ""),
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    DecimalTextInputFormatter(decimalRange: 3),
                                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,3}')),
                                  ],
                                  style: boldTextStyle_18,
                                  onChanged: (value) {
                                    if (_controllers[actualIndex].text.isNotEmpty) {
                                      if(!_controllers[actualIndex].text.endsWith(".") && !_controllers[actualIndex].text.endsWith(".0") && !_controllers[actualIndex].text.endsWith(".00")){
                                        if (double.parse(_controllers[actualIndex].text) >= 0.001 && !_controllers[actualIndex].text.startsWith("0.000")) {
                                          if (double.parse(_controllers[actualIndex].text) < .001) {
                                            Utility.showToastMessage(Strings.zero_unit_validation);
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                          } else if (double.parse(_controllers[actualIndex].text) > actualQtyList![actualIndex].toDouble()) {
                                            Utility.showToastMessage("${Strings.check_unit}, This scheme has only ${actualQtyList![actualIndex]} unit.");
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                            setState(() {
                                              if(unpledgeItemsList[index].pledgedQuantity.toString().split(".")[1].length != 0){
                                                var unitsDecimalCount;
                                                String str = unpledgeItemsList[index].pledgedQuantity.toString();
                                                var qtyArray = str.split('.');
                                                unitsDecimalCount = qtyArray[1];
                                                if(unitsDecimalCount == "0"){
                                                  unitStringList[actualIndex] = str.toString().split(".")[0];
                                                  _controllers[actualIndex].text = str.toString().split(".")[0];
                                                }else{
                                                  unitStringList[actualIndex] = unpledgeItemsList[index].pledgedQuantity.toString();
                                                  _controllers[actualIndex].text = unpledgeItemsList[index].pledgedQuantity.toString();
                                                }
                                              }else{
                                                unitStringList[actualIndex] = unpledgeItemsList[index].pledgedQuantity.toString();
                                                _controllers[actualIndex].text = unpledgeItemsList[index].pledgedQuantity.toString();
                                              }
                                              unpledgeItemsList[index].pledgedQuantity = double.parse(_controllers[actualIndex].text);
                                              updateTotalSchemeValue();
                                              var updateAmount = double.parse(_controllers[actualIndex].text) * unpledgeItemsList[index].price!;
                                              unpledgeData.loan!.totalCollateralValue = selectedSecurityValue;
                                              unpledgeItemsList[index].amount = updateAmount;
                                            });
                                          } else {
                                            if(_controllers[actualIndex].text.toString().contains(".") && _controllers[actualIndex].text.toString().split(".")[1].length != 0){
                                              var unitsDecimalCount;
                                              String str = _controllers[actualIndex].text.toString();
                                              var qtyArray = str.split('.');
                                              unitsDecimalCount = qtyArray[1];
                                              if(unitsDecimalCount == "0"){
                                                unitStringList[actualIndex] = str.toString().split(".")[0];
                                              }else{
                                                unitStringList[actualIndex] = _controllers[actualIndex].text.toString();
                                              }
                                            }else{
                                              unitStringList[actualIndex] = _controllers[actualIndex].text.toString();
                                            }
                                            unpledgeItemsList[index].pledgedQuantity = double.parse(unitStringList[actualIndex]);
                                            updateTotalSchemeValue();
                                            var updateAmount = double.parse(_controllers[actualIndex].text) * unpledgeItemsList[index].price!;
                                            unpledgeData.loan!.totalCollateralValue = selectedSecurityValue;
                                            unpledgeItemsList[index].amount = updateAmount;
                                          }
                                        } else if( _controllers[actualIndex].text != "0") {
                                          setState(() {
                                            if(actualQtyList![actualIndex] < 1){
                                              _controllers[actualIndex].text = actualQtyList![actualIndex].toString();
                                              unitStringList[actualIndex] = actualQtyList![actualIndex].toString();
                                              updateTotalSchemeValue();
                                              unpledgeItemsList[index].pledgedQuantity = actualQtyList![actualIndex];
                                            } else {
                                              _controllers[actualIndex].text = "1";
                                              unitStringList[actualIndex] = "1";
                                              updateTotalSchemeValue();
                                              unpledgeItemsList[index].pledgedQuantity = 1;
                                            }
                                            var updateAmount = double.parse(_controllers[actualIndex].text) * unpledgeItemsList[index].price!;
                                            unpledgeData.loan!.totalCollateralValue = selectedSecurityValue;
                                            unpledgeItemsList[index].amount = updateAmount;
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                          });
                                        }
                                      }
                                    }
                                    if(_controllers[actualIndex].text.isNotEmpty && double.parse(_controllers[actualIndex].text) >= 0.001){
                                      if(_controllers[actualIndex].text.contains(".") && _controllers[actualIndex].text.split(".")[1].isNotEmpty){
                                        if(_controllers[actualIndex].text.toString().contains(".") && _controllers[actualIndex].text.toString().split(".")[1].length != 0){
                                          var unitsDecimalCount;
                                          String str = _controllers[actualIndex].text.toString();
                                          var qtyArray = str.split('.');
                                          unitsDecimalCount = qtyArray[1];
                                          if(unitsDecimalCount.toString().isNotEmpty && unitsDecimalCount != 0){
                                            unitStringList[actualIndex] = _controllers[actualIndex].text.toString();
                                          }else{
                                            unitStringList[actualIndex] = str.toString().split(".")[0];
                                          }
                                        }else{
                                          unitStringList[actualIndex] = _controllers[actualIndex].text.toString();
                                        }
                                        calculatePercentage(true);
                                      }
                                    }
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
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      if(_controllers[actualIndex].text.isNotEmpty){
                                        if (double.parse(_controllers[actualIndex].text) < actualQtyList![actualIndex]) {
                                          double incrementWith = 0;
                                          var txt;
                                          if(unitStringList[actualIndex].toString().contains('.') && unitStringList[actualIndex].toString().split(".")[1].length != 0) {
                                            var unitsDecimalCount;
                                            String str = _controllers[actualIndex].text.toString();
                                            var qtyArray = str.split('.');
                                            unitsDecimalCount = qtyArray[1];
                                            if(int.parse(unitsDecimalCount) == 0){
                                              txt = double.parse(_controllers[actualIndex].text) + 1;
                                              if(txt>actualQtyList![actualIndex]){
                                                Utility.showToastMessage(Strings.check_unit);
                                              } else {
                                                incrementWith = 1;
                                                unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toString());
                                                unitStringList[actualIndex] = txt.toString();
                                                _controllers[actualIndex].text = unitStringList[actualIndex];
                                              }
                                            } else {
                                              if (unitsDecimalCount.toString().length == 1) {
                                                txt = double.parse(_controllers[actualIndex].text) + .1;
                                                if(txt>actualQtyList![actualIndex]){
                                                  Utility.showToastMessage(Strings.check_unit);
                                                } else{
                                                  incrementWith = .1;
                                                  unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(1));
                                                  unitStringList[actualIndex] = txt.toStringAsFixed(1);
                                                  _controllers[actualIndex].text = unitStringList[actualIndex];
                                                }
                                              } else if (unitsDecimalCount.toString().length == 2) {
                                                txt = double.parse(_controllers[actualIndex].text) + .01;
                                                if(txt>actualQtyList![actualIndex]){
                                                  Utility.showToastMessage(Strings.check_unit);
                                                } else {
                                                  incrementWith = .01;
                                                  unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(2));
                                                  unitStringList[actualIndex] = txt.toStringAsFixed(2);
                                                  _controllers[actualIndex].text = unitStringList[actualIndex];
                                                }
                                              } else {
                                                txt = double.parse(_controllers[actualIndex].text) + .001;
                                                if(txt>actualQtyList![actualIndex]){
                                                  Utility.showToastMessage(Strings.check_unit);
                                                } else {
                                                  incrementWith = .001;
                                                  unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(3));
                                                  unitStringList[actualIndex] = txt.toStringAsFixed(3);
                                                  _controllers[actualIndex].text = unitStringList[actualIndex];
                                                }
                                              }
                                            }
                                          } else {
                                            if (actualQtyList![actualIndex] < 1) {
                                              txt = actualQtyList![actualIndex];
                                              if(txt>actualQtyList![actualIndex]){
                                                Utility.showToastMessage(Strings.check_unit);
                                              } else {
                                                incrementWith = actualQtyList![actualIndex];
                                                unpledgeItemsList[index].pledgedQuantity = txt;
                                                unitStringList[actualIndex] = txt.toString();
                                                _controllers[actualIndex].text = unitStringList[actualIndex];
                                              }
                                            } else {
                                              txt = double.parse(_controllers[actualIndex].text) + 1;
                                              if(txt>actualQtyList![actualIndex]){
                                                Utility.showToastMessage(Strings.check_unit);
                                              } else {
                                                incrementWith = 1;
                                                unpledgeItemsList[index].pledgedQuantity = txt;

                                                if(txt.toString().split(".")[1].length != 0){
                                                  var unitsDecimalCount;
                                                  String str = txt.toString();
                                                  var qtyArray = str.split('.');
                                                  unitsDecimalCount = qtyArray[1];
                                                  if(unitsDecimalCount == "0"){
                                                    unitStringList[actualIndex] = str.toString().split(".")[0];
                                                    _controllers[actualIndex].text = str.toString().split(".")[0];
                                                  }else{
                                                    unitStringList[actualIndex] = txt;
                                                    _controllers[actualIndex].text = txt;
                                                  }
                                                }
                                              }
                                            }
                                          }
                                          if(incrementWith !=0){
                                            setState(() {
                                              checkBoxValues[actualIndex] = true;
                                              unpledgeItemsList[index].check = true;
                                              unpledgeItemsList[index].pledgedQuantity = txt.toDouble();
                                              unpledgeItemsList[index].amount = txt * unpledgeItemsList[index].price!;
                                              updateTotalSchemeValue();
                                              if(searchMyCartList.length == selectedScips){
                                                checkBoxValue = true;
                                              }
                                            });
                                          }
                                        } else {
                                          Utility.showToastMessage(Strings.check_unit);
                                        }}else{
                                        _controllers[actualIndex].text = "0.001";
                                        unitStringList[actualIndex] = "0.001";
                                        updateTotalSchemeValue();
                                        unpledgeItemsList[index].pledgedQuantity = 0.001;
                                      }
                                      if(_controllers[actualIndex].text.isNotEmpty){
                                        calculatePercentage(true);
                                      }
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
                    Text(Strings.value + " : ${numberToString((unpledgeItemsList[index].price! * double.parse(_controllers[actualIndex].text.isEmpty ? "0" : _controllers[actualIndex].text.toString())).toStringAsFixed(2))}", style: mediumTextStyle_14_gray),
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

  updateTotalSchemeValue(){
    setState(() {
      selectedSecurityValue = 0;
      for(int i= 0; i<searchMyCartList.length ; i++){
        selectedSecurityValue = selectedSecurityValue + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
      }
      unpledgeData.loan!.totalCollateralValue = selectedSecurityValue;
    });
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
                      Text(loanBalance < 0 ? negativeValue(loanBalance) : '₹${numberToString(loanBalance.toStringAsFixed(2))}',
                        textAlign: TextAlign.center,
                        style: subHeadingValue.copyWith(
                            color: loanBalance < 0 ? colorGreen : appTheme
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
            leftAmount: Strings.rupee + numberToString(existingCollateral.toStringAsFixed(2)),
            leftText:Strings.existing_collateral ,
            rightAmount: Strings.rupee + numberToString(roundDouble((existingCollateral - selectedSecurityValue), 2).toStringAsFixed(2)),
            rightText: Strings.remaining_collateral,
          ),
        ],
      ),
    );
  }


  calculatePercentage(bool isRefresh){
    double actualDP = 0;
    for (int i = 0; i < unpledgeItemsList.length; i++) {
      int actualIndex = searchMyCartList.indexWhere((element) => element.isin == unpledgeItemsList[i].isin && element.folio == unpledgeItemsList[i].folio);

      if(double.parse(unitStringList[actualIndex]) >= 0.001) {
        actualDP = actualDP + ((unpledgeItemsList[i].price! * double.parse(unitStringList[actualIndex])) * (unpledgeItemsList[i].eligiblePercentage! / 100));
      }
    }
    revisedDrawingPower = actualDrawingPower - actualDP;
    double eligibilityPercentage = (revisedDrawingPower! / loanBalance) * 100;
    if (eligibilityPercentage >= 100.00 || selectedScips == 0 || loanBalance <= 0) {
      canUnpledge = true;
    } else {
      canUnpledge = false;
    }

    if(revocationChargeType != "Fix"){
      if(selectedSecurityValue > 0){
        if((selectedSecurityValue * revocationPercentage) / 100 >= revocationMaxCharge){
          revocationCharge = revocationMaxCharge;
        } else if((selectedSecurityValue * revocationPercentage) / 100 <= revocationMinCharge) {
          revocationCharge = revocationMinCharge;
        } else {
          revocationCharge = (selectedSecurityValue * revocationPercentage) / 100;
        }
      }else{
        revocationCharge = 0.00;
      }
    }
    if(isRefresh){
      setState(() {
      });
    }

  }

  Widget unpledgeBottomSheet(){
    if (selectedScips != 0) {
      isScripsSelect = false;
      isUnpledgeAlert = false;
    } else {
      isScripsSelect = true;
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
                visible: !canUnpledge,
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
                  Text(roundDouble(selectedSecurityValue, 2) < 0
                      ? negativeValue(roundDouble(selectedSecurityValue, 2))
                      : '₹' + numberToString(roundDouble(selectedSecurityValue, 2).toStringAsFixed(2)),
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
                            commonDialog(context, Strings.revocation_charges_info, 0);
                          },
                        ),
                      ],
                    ),
                  ),
                  revocationChargeType == "Fix"
                      ? Text('₹${revocationCharge.toStringAsFixed(2)}',
                    style: bottomSheetValueTextStyle,
                  )
                      : selectedSecurityValue > 0 ? Text('₹${numberToString(revocationCharge.toStringAsFixed(2))}',
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
                      color: canUnpledge && selectedScips != 0 ? appTheme : colorLightGray,
                      child: AbsorbPointer(
                        absorbing: canUnpledge && selectedScips != 0 ? false : true,
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

  void altercheckBox(value) {
    List<bool> temp = checkBoxValues;
    setState(() {
      selectedScips = 0;
      selectedSecurityValue = 0.0;
    });
    for (var index = 0; index < unpledgeItemsList.length; index++) {
      temp[index] = value;
      setState(() {
        if (value) {
          isAddBtnShow[index] = false;
          unpledgeItemsList[index].pledgedQuantity = actualQtyList![index];
          if(unpledgeItemsList[index].pledgedQuantity.toString().split(".")[1].length != 0){
            var unitsDecimalCount;
            String str = unpledgeItemsList[index].pledgedQuantity.toString();
            var qtyArray = str.split('.');
            unitsDecimalCount = qtyArray[1];
            if(unitsDecimalCount == "0"){
              unitStringList[index] = str.toString().split(".")[0];
              _controllers[index].text = str.toString().split(".")[0];
            }else{
              unitStringList[index] = unpledgeItemsList[index].pledgedQuantity.toString();
              _controllers[index].text = unpledgeItemsList[index].pledgedQuantity!.toString();
            }
          }
          unpledgeItemsList[index].amount = double.parse(_controllers[index].text) * unpledgeItemsList[index].price!;
          if (selectedScips == 0) {
            selectedSecurityValue = 0.0 + unpledgeItemsList[index].amount!;
          } else {
            selectedSecurityValue = unpledgeData.loan!.totalCollateralValue! + unpledgeItemsList[index].amount!;
          }
          unpledgeData.loan!.totalCollateralValue = selectedSecurityValue;
          unpledgeItemsList[index].check = true;
          selectedScips = index + 1;
        } else {
          isAddBtnShow[index] = true;
          selectedSecurityValue = roundDouble(unpledgeData.loan!.totalCollateralValue!, 2) - unpledgeItemsList[index].amount!;
          unpledgeData.loan!.totalCollateralValue = selectedSecurityValue;
          unpledgeItemsList[index].amount = 0.0;
          _controllers[index].text = "0";
          unitStringList[index] = "0";
          unpledgeItemsList[index].pledgedQuantity = double.parse(_controllers[index].text);
          selectedScips = 0;
        }
        if (tempLength == unpledgeItemsList.length) {
          isScripsSelect = false;
        } else {
          isScripsSelect = true;
        }
        if(double.parse(revisedDrawingPower.toString()) > maxAllowableValue){
          if (double.parse(revisedDrawingPower.toString()) <= double.parse(existingDrawingPower.toString())) {
            isScripsSelect = false;
          } else {
            isScripsSelect = true;
          }
        }else{
          if(selectedSecurityValue <= maxAllowableValue) {
            isUnpledgeAlert = false;
          }else{
            isUnpledgeAlert = true;
          }
        }
        checkBoxValue = value;
      });
    }

    calculatePercentage(true);
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
        parameter[Strings.max_allowable] = numberToString(maxAllowableValue.toStringAsFixed(2));
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
    List<double> myDuplicateList = [];
    List<CollateralLedger> collateralList2 = [];
    collateralList.sort((a, b) => a.requestedQuantity!.compareTo(b.requestedQuantity!));
    collateralList.reversed;
    collateralList2.addAll(collateralList.reversed);


    for (int i = 0; i < unpledgeItemsList.length; i++) {
      myDuplicateList.add(unpledgeItemsList[i].pledgedQuantity!);
    }
    for (int i = 0; i < unpledgeItemsList.length; i++) {
      for(int j = 0; j<collateralList2.length; j++){
        if(unpledgeItemsList[i].isin == collateralList2[j].isin && unpledgeItemsList[i].folio == collateralList2[j].folio){
          if(myDuplicateList[i] != 0){
            if(myDuplicateList[i] >= collateralList2[j].requestedQuantity!){
              if (unpledgeItemsList[i].amount != 0.0) {
                dummyUnpledgeList.add(new UnPledgeList(
                    isin: collateralList2[j].isin,
                    folio: collateralList2[j].folio,
                    psn: collateralList2[j].psn,
                    quantity: collateralList2[j].requestedQuantity!));

                myDuplicateList[i] = double.parse(myDuplicateList[i].toStringAsFixed(3)) - double.parse(collateralList2[j].requestedQuantity!.toStringAsFixed(3));
              }
            }else if(myDuplicateList[i] < collateralList2[j].requestedQuantity!){
              if (unpledgeItemsList[i].amount != 0.0) {
                dummyUnpledgeList.add(new UnPledgeList(
                    isin: collateralList2[j].isin,
                    folio: collateralList2[j].folio,
                    psn: collateralList2[j].psn,
                    quantity: double.parse(myDuplicateList[i].toStringAsFixed(3))
                ));
              }
              myDuplicateList[i] = 0;
            }
          }
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
            numberToString(maxAllowableValue.toStringAsFixed(2)),
            Strings.mutual_fund);
      },
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