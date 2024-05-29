import 'package:lms/common_widgets/constants.dart';
import 'package:lms/my_loan/MyLoansBloc.dart';
import 'package:lms/network/requestbean/SellCollateralRequestBean.dart';
import 'package:lms/sell_collateral/SellCollateralBloc.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:flutter/services.dart';
import 'SellCollateralOTPScreen.dart';
import 'dart:math' as math;

class MFInvokeScreen extends StatefulWidget {
  String loanNo;
  String isComingFor;
  String isin;
  String folio;


  MFInvokeScreen(this.loanNo, this.isComingFor, this.isin, this.folio);

  @override
  _MFInvokeScreenState createState() => _MFInvokeScreenState();
}

class _MFInvokeScreenState extends State<MFInvokeScreen> {
  Preferences? preferences;
  final myLoansBloc = MyLoansBloc();
  final sellCollateralBloc = SellCollateralBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<TextEditingController> _controllers2 = [];
  bool checkBoxValue = false;
  bool? resetValue;
  bool isMarginShortFall = false;
  bool isScripsSelect = true;
  bool isAPIRespond = false;
  List<bool> checkBoxValues = [];
  int tempLength = 0;
  List<SellList> sellList = [];
  List<bool> pledgeControllerEnable = [];
  List<Items> myPledgedSecurityList = [];
  List<CollateralLedger> collateralList = [];
  List<Items> searchMyCartList = [];
  List<double> actualQtyList = [];
  List<String> unitStringList = [];
  Loan loanData = new Loan();
  InvokeChargeDetails invokeChargeData = new InvokeChargeDetails();
  var vlMarginShortFall, vlDesiredValue;
  var totalValue, totalSelectedScrips, selectedSecuritiesValue, eligibleLoan;
  var totalCollateral;
  String marginShortfallName = "";
  double? invokeCharge;
  double? invokePercentage;
  double actualDrawingPower = 0;
  double? selectedSchemeEligibility = 0;
  List<bool> isAddBtnShow = [];
  bool hideSecurityValue = false;
  bool showSecurityValue = true;
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
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    resetValue = true;
    appBarTitle = Text(widget.loanNo, style: TextStyle(color: appTheme));
    preferences = Preferences();
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        getLoanData();
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
    super.initState();
  }

  getLoanData() async {
    myLoansBloc.getLoanDetails(widget.loanNo).then((value) {
      if (value.isSuccessFull!) {
        if (value.data!.loan != null) {
          setState(() {
            isAPIRespond = true;
            loanData = value.data!.loan!;
            totalCollateral = value.data!.loan!.totalCollateralValue;
            totalValue = 0.0;
            eligibleLoan = 0.0;
            totalSelectedScrips = 0;
            if(value.data!.collateralLedger != null){
              collateralList.addAll(value.data!.collateralLedger!);
            }
            if (value.data!.marginShortfall != null) {
              marginShortfallName = value.data!.marginShortfall!.name!;
              isMarginShortFall = true;
              vlMarginShortFall = value.data!.marginShortfall!.minimumCashAmount!;
              vlDesiredValue = value.data!.marginShortfall!.advisableCashAmount;
            } else {
              isMarginShortFall = false;
            }
            unitStringList.clear();
            for (int i = 0; i < value.data!.loan!.items!.length; i++) {
              if(value.data!.loan!.items![i].amount != 0.0) {
                myPledgedSecurityList.add(value.data!.loan!.items![i]);
                _controllers2.add(TextEditingController());
                actualDrawingPower = actualDrawingPower + ((loanData.items![i].price! * loanData.items![i].pledgedQuantity!) * (loanData.items![i].eligiblePercentage! / 100));
                unitStringList.add("0");
              }
            }
            searchMyCartList.addAll(myPledgedSecurityList);

            if(value.data!.invokeChargeDetails != null){
              invokeChargeData = value.data!.invokeChargeDetails!;
            }

            for (int i = 0; i < myPledgedSecurityList.length; i++) {
              if(widget.isComingFor == Strings.single){
                if(myPledgedSecurityList[i].isin == widget.isin && myPledgedSecurityList[i].folio == widget.folio){
                  totalSelectedScrips = 1;
                  totalValue = 0.0 + myPledgedSecurityList[i].amount!;

                  invokeAndEligibility();   //eligibility and invoke percent calculation of single selected schemes value
                  if(myPledgedSecurityList[i].pledgedQuantity.toString().split(".")[1].length != 0){
                    var unitsDecimalCount;
                    String str = myPledgedSecurityList[i].pledgedQuantity.toString();
                    var qtyArray = str.split('.');
                    unitsDecimalCount = qtyArray[1];
                    if(unitsDecimalCount == "0"){
                      unitStringList[i] = str.toString().split(".")[0];
                    }else{
                      unitStringList[i] = myPledgedSecurityList[i].pledgedQuantity.toString();
                    }
                  }
                  setState(() {
                    eligibleLoan = (myPledgedSecurityList[i].price! * double.parse(unitStringList[i])) * (myPledgedSecurityList[i].eligiblePercentage!/100);
                  });
                }
              }
            }

            if(invokeChargeData.invokeInitiateChargeType == 'Fix') {
              invokeCharge = invokeChargeData.invokeInitiateCharges;
            } else {
              if(totalValue>0){
                invokeCharge = invokeChargeData.invokeInitiateChargesMinimumAmount;
              } else {
                invokeCharge = 0.00;
              }
            }

            tempLength = myPledgedSecurityList.length;
            for (int i = 0; i < myPledgedSecurityList.length; i++) {
              actualQtyList.add(myPledgedSecurityList[i].pledgedQuantity!);
            }
            isAPIRespond = true;
          });
        } else {
          commonDialog(context, Strings.something_went_wrong_try, 0);
        }
      } else if(value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        commonDialog(context, value.errorMessage, 0);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorBg,
        resizeToAvoidBottomInset: false,
        appBar: buildAppBar(context),
        body: isAPIRespond
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


  void searchResults(String query) {
    List<Items> dummySearchList = <Items>[];
    dummySearchList.addAll(searchMyCartList);
    if (query.isNotEmpty) {
      List<Items> dummyListData = <Items>[];
      dummySearchList.forEach((item) {
        if (item.securityName!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        myPledgedSecurityList.clear();
        myPledgedSecurityList.addAll(dummyListData);
      });
    } else {
      setState(() {
        myPledgedSecurityList.clear();
        myPledgedSecurityList.addAll(searchMyCartList);
      });
    }
  }

  void _handleSearchEnd() {
    setState(() {
      focusNode.unfocus();
      this.actionIcon = Icon(Icons.search, color: appTheme, size: 25);
      this.appBarTitle = Text(widget.loanNo, style: TextStyle(color: appTheme));
      _textController.clear();
      myPledgedSecurityList.clear();
      myPledgedSecurityList.addAll(searchMyCartList);
    });
  }


  Widget sellCollateralBody() {
    double postSaleLoanBL = 0;
    if(invokeChargeData.invokeInitiateChargeType == 'Fix'  && totalValue <= 0){
      postSaleLoanBL = loanData.balance! - totalValue;
    } else {
      postSaleLoanBL = loanData.balance! - totalValue + invokeCharge!;
    }

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
                              isMarginShortFall
                                  ? ReusableSellAmountText(
                                sellText: 'Margin shortfall',
                                sellAmount: vlMarginShortFall < 0
                                    ? negativeValue(vlMarginShortFall)
                                    : '₹${numberToString(vlMarginShortFall.toStringAsFixed(2))}',
                                sellAmountColor: red,
                                iIcon: false,
                              )
                                  : SizedBox(height: 0),
                              ReusableSellAmountText(
                                sellText:'Selected schemes value',
                                sellAmount: totalValue < 0
                                    ? negativeValue(totalValue)
                                    : '₹${numberToString(totalValue.toStringAsFixed(2))}',
                                sellAmountColor: colorGreen,
                                iIcon: false,
                              ),
                              isMarginShortFall
                                  ?  ReusableSellAmountText(
                                sellText: 'Minimum desired value',
                                sellAmount: vlDesiredValue < 0
                                    ? negativeValue(vlDesiredValue)
                                    : '₹${numberToString(vlDesiredValue.toStringAsFixed(2))}',
                                sellAmountColor: red,
                                iIcon: false,
                              ): SizedBox(height: 0),
                              ReusableSellAmountText(
                                sellText: 'Remaining schemes value',
                                sellAmount: (double.parse(totalCollateral.toStringAsFixed(2)) - double.parse(totalValue.toStringAsFixed(2))) < 0
                                    ? negativeValue((double.parse(totalCollateral.toStringAsFixed(2))  - double.parse(totalValue.toStringAsFixed(2))))
                                    : '₹${numberToString((double.parse(totalCollateral.toStringAsFixed(2))  - double.parse(totalValue.toStringAsFixed(2))).toStringAsFixed(2))}',
                                sellAmountColor: colorDarkGray,
                                iIcon: false /*true*/,
                              ),
                              ReusableSellAmountText(
                                sellText: 'Revised drawing power',
                                sellAmount: (actualDrawingPower - selectedSchemeEligibility!) < 0
                                    ? negativeValue((actualDrawingPower - selectedSchemeEligibility!))
                                    : '₹${numberToString((actualDrawingPower - selectedSchemeEligibility!).toStringAsFixed(2))}',
                                sellAmountColor: (actualDrawingPower - selectedSchemeEligibility!) < 0 ? colorGreen : colorDarkGray,
                                iIcon: false,
                              ),
                              ReusableSellAmountText(
                                sellText: 'Existing loan balance',
                                sellAmount: loanData.balance! < 0
                                    ? negativeValue(loanData.balance!)
                                    : '₹${numberToString(loanData.balance!.toStringAsFixed(2))}',
                                sellAmountColor: loanData.balance! < 0 ? colorGreen : colorDarkGray,
                                iIcon: false,
                              ),ReusableSellAmountText(
                                sellText: 'Invocation Charges',
                                sellAmount: invokeChargeData.invokeInitiateChargeType == 'Fix'
                                    ? invokeCharge! < 0 ? negativeValue(invokeCharge!) : '₹${numberToString(invokeCharge!.toStringAsFixed(2))}'
                                    : totalValue > 0 ? '₹${numberToString(invokeCharge!.toStringAsFixed(2))}' : '₹0.00',
                                sellAmountColor: invokeCharge! < 0 ? colorGreen : colorDarkGray,
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
            _textController.text.isNotEmpty ? SizedBox() : Padding(
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
                        alterCheckBox(newValue);
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
                child: sellCollateralList(),
              ),
            ),
            bottomSectionNavigator(),
          ],
        ),
      ),
    );
  }

  invokeAndEligibility() {
    selectedSchemeEligibility = 0;
    for(int i =0; i< searchMyCartList.length; i++) {
      selectedSchemeEligibility = selectedSchemeEligibility! + ((searchMyCartList[i].price! * searchMyCartList[i].pledgedQuantity!) * searchMyCartList[i].eligiblePercentage! / 100);
    }
    if(invokeChargeData.invokeInitiateChargeType == 'Fix'){
      invokeCharge = invokeChargeData.invokeInitiateCharges;
    } else {
      if(totalValue > 0){
        invokePercentage = invokeChargeData.invokeInitiateCharges;
        invokeCharge = totalValue * (invokePercentage! / 100);
        if(invokeChargeData.invokeInitiateChargesMinimumAmount! > 0 && invokeCharge! < invokeChargeData.invokeInitiateChargesMinimumAmount!) {
          invokeCharge = invokeChargeData.invokeInitiateChargesMinimumAmount!;
        } else if(invokeChargeData.invokeInitiateChargesMaximumAmount! > 0 && invokeCharge! > invokeChargeData.invokeInitiateChargesMaximumAmount!) {
          invokeCharge = invokeChargeData.invokeInitiateChargesMaximumAmount!;
        }
      } else {
        invokeCharge = 0.00;
      }
    }
  }

  Widget sellCollateralList() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 16, bottom: 150),
      child: myPledgedSecurityList.length == 0
          ? Padding(padding: const EdgeInsets.only(top: 150.0), child: Center(child: Text(Strings.no_result_found))) :
      ListView.builder(
        key: Key(myPledgedSecurityList.length.toString()),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: myPledgedSecurityList.length,
        itemBuilder: (context, index) {

          if(widget.isComingFor == Strings.single){
            if(myPledgedSecurityList[index].isin == widget.isin && myPledgedSecurityList[index].folio == widget.folio){
              isAddBtnShow.add(false);
              _controllers2[index].text = myPledgedSecurityList[index].pledgedQuantity!.toInt().toString();
              checkBoxValues.add(true);
              myPledgedSecurityList[index].check = true;
              loanData.totalCollateralValue = totalValue;
              isScripsSelect = false;
            } else {
              isAddBtnShow.add(true);
              checkBoxValues.add(false);
              myPledgedSecurityList[index].check = false;
            }
          } else {
            isAddBtnShow.add(true);
            checkBoxValues.add(false);
            myPledgedSecurityList[index].check = false;
          }

          int actualIndex = searchMyCartList.indexWhere((element) => element.isin == myPledgedSecurityList[index].isin && element.folio == myPledgedSecurityList[index].folio);

          String pledgeQty = myPledgedSecurityList[index].pledgedQuantity!.toString();
          String sellQty;
          if(isAddBtnShow[actualIndex]){
            sellQty = 0.toString();
          } else {
            sellQty = pledgeQty;
          }
          myPledgedSecurityList[index].pledgedQuantity = double.parse(sellQty);
          searchMyCartList[actualIndex].pledgedQuantity = myPledgedSecurityList[index].pledgedQuantity;
          pledgeControllerEnable.add(false);
          _controllers2[actualIndex] = TextEditingController(text: unitStringList[actualIndex]);
          _controllers2[actualIndex].selection = TextSelection.fromPosition(TextPosition(offset: _controllers2[actualIndex].text.length));
          if(index == myPledgedSecurityList.length){
            setState(() {});
          }
          invokeAndEligibility();

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
                Text("${myPledgedSecurityList[index].securityName!} [${myPledgedSecurityList[index].folio}]", style: boldTextStyle_18),
                SizedBox(height: 4),
                Text("${myPledgedSecurityList[index].securityCategory!} (LTV: ${myPledgedSecurityList[index].eligiblePercentage!.toStringAsFixed(2)}%)",
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
                                  scripsValueText("₹${myPledgedSecurityList[index].price!.toStringAsFixed(2)}"),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(child: Text("${actualQtyList[actualIndex].toStringAsFixed(3)} QTY", style: mediumTextStyle_12_gray)),
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
                            shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  setState(() {
                                    FocusScope.of(context).unfocus();
                                    isAddBtnShow[actualIndex] = false;
                                    var txt;
                                    txt = double.parse(_controllers2[actualIndex].text) + 1;
                                    if (actualQtyList[actualIndex] < 1) {
                                      txt = actualQtyList[actualIndex];
                                      if(txt>actualQtyList[actualIndex]){
                                        Utility.showToastMessage(Strings.check_unit);
                                      } else {
                                        myPledgedSecurityList[index].pledgedQuantity = txt;
                                        unitStringList[actualIndex] = txt.toString();
                                        _controllers2[actualIndex].text = unitStringList[actualIndex];
                                      }
                                    } else {
                                      unitStringList[actualIndex] = "1";
                                      _controllers2[actualIndex].text = unitStringList[actualIndex].toString();
                                      myPledgedSecurityList[index].pledgedQuantity = 1.0;
                                    }
                                    totalSelectedScrips = totalSelectedScrips + 1;
                                    myPledgedSecurityList[index].amount = double.parse(_controllers2[actualIndex].text) * myPledgedSecurityList[index].price!;
                                    setState(() {
                                      totalValue = 0;
                                      eligibleLoan = 0;
                                      for(int i= 0; i<searchMyCartList.length ; i++){
                                        totalValue = totalValue + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                                        eligibleLoan += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                                      }
                                      loanData.totalCollateralValue = totalValue;
                                      if(searchMyCartList.length == totalSelectedScrips){
                                        checkBoxValue = true;
                                      }
                                      invokeAndEligibility();
                                    });
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
                                      FocusScope.of(context).unfocus();
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      setState(() {
                                        if(_controllers2[actualIndex].text.isNotEmpty){
                                          if(double.parse(_controllers2[actualIndex].text.toString()) >= 0.001){
                                            var txt;
                                            if(_controllers2[actualIndex].text.toString().contains('.') && _controllers2[actualIndex].text.toString().split(".")[1].length != 0) {
                                              var unitsDecimalCount;
                                              String str = _controllers2[actualIndex].text.toString();
                                              var qtyArray = str.split('.');
                                              unitsDecimalCount = qtyArray[1];
                                              if(int.parse(unitsDecimalCount) == 0){
                                                txt = double.parse(_controllers2[actualIndex].text) - 1;
                                                myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toString());
                                                unitStringList[actualIndex] = txt.toString();
                                                _controllers2[actualIndex].text = unitStringList[actualIndex];
                                              } else {
                                                if (unitsDecimalCount.toString().length == 1) {
                                                  txt = double.parse(_controllers2[actualIndex].text) - .1;
                                                  myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(1));
                                                  unitStringList[actualIndex] = txt.toStringAsFixed(1);
                                                  _controllers2[actualIndex].text = unitStringList[actualIndex];
                                                } else if (unitsDecimalCount.toString().length == 2) {
                                                  txt = double.parse(_controllers2[actualIndex].text) - .01;
                                                  myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(2));
                                                  unitStringList[actualIndex] = txt.toStringAsFixed(2);
                                                  _controllers2[actualIndex].text = unitStringList[actualIndex];
                                                } else {
                                                  txt = double.parse(_controllers2[actualIndex].text) - .001;
                                                  myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(3));
                                                  unitStringList[actualIndex] = txt.toStringAsFixed(3);
                                                  _controllers2[actualIndex].text = unitStringList[actualIndex];
                                                }
                                              }
                                            }else{
                                              txt = int.parse(_controllers2[actualIndex].text.toString().split(".")[0]) - 1;
                                              myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toString());
                                              unitStringList[actualIndex] = txt.toString();
                                              _controllers2[actualIndex].text = unitStringList[actualIndex];
                                            }
                                            if (txt >= 0.001) {
                                              if (double.parse(_controllers2[actualIndex].text) <= actualQtyList[actualIndex]) {
                                                myPledgedSecurityList[index].amount = txt * myPledgedSecurityList[index].price!;
                                                setState(() {
                                                  totalValue = 0;
                                                  eligibleLoan = 0;
                                                  for(int i= 0; i<searchMyCartList.length ; i++){
                                                    totalValue = totalValue + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                                                    eligibleLoan += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                                                  }
                                                });
                                                loanData.totalCollateralValue = totalValue;
                                              } else {
                                                Utility.showToastMessage(Strings.check_unit);
                                              }
                                            } else {
                                              setState(() {
                                                checkBoxValues[actualIndex] = false;
                                                isAddBtnShow[actualIndex] = true;
                                                myPledgedSecurityList[index].amount = 0.0;
                                                _controllers2[actualIndex].text = "0";
                                                unitStringList[actualIndex] = "0";
                                                totalValue = 0;
                                                eligibleLoan = 0;
                                                for(int i= 0; i<searchMyCartList.length ; i++){
                                                  totalValue = totalValue + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                                                  eligibleLoan += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                                                }
                                                loanData.totalCollateralValue = totalValue;
                                                myPledgedSecurityList[index].pledgedQuantity = double.parse(_controllers2[actualIndex].text);
                                                totalSelectedScrips = totalSelectedScrips - 1;
                                                checkBoxValue = false;
                                                if (tempLength == myPledgedSecurityList.length) {
                                                  isScripsSelect = false;
                                                } else {
                                                  isScripsSelect = true;
                                                }
                                              });
                                            }
                                          } else {
                                            setState(() {
                                              checkBoxValues[actualIndex] = false;
                                              isAddBtnShow[actualIndex] = true;
                                              myPledgedSecurityList[index].amount = 0.0;
                                              _controllers2[actualIndex].text = "0";
                                              unitStringList[actualIndex] = "0";
                                              totalValue = 0;
                                              eligibleLoan = 0;
                                              for(int i= 0; i<searchMyCartList.length ; i++){
                                                totalValue = totalValue + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                                                eligibleLoan += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                                              }
                                              loanData.totalCollateralValue = totalValue;
                                              myPledgedSecurityList[index].pledgedQuantity = double.parse(_controllers2[actualIndex].text);
                                              totalSelectedScrips = totalSelectedScrips - 1;
                                              checkBoxValue = false;
                                              if (tempLength == myPledgedSecurityList.length) {
                                                isScripsSelect = false;
                                              } else {
                                                isScripsSelect = true;
                                              }
                                            });
                                            Utility.showToastMessage(Strings.check_unit);
                                          }
                                        } else {
                                          setState(() {
                                            _controllers2[actualIndex].text = "0.001";
                                            unitStringList[actualIndex] = "0.001";
                                            myPledgedSecurityList[index].pledgedQuantity = double.parse(_controllers2[actualIndex].text);
                                            myPledgedSecurityList[index].amount = 0.001 * myPledgedSecurityList[index].price!;
                                            totalValue = 0;
                                            eligibleLoan = 0;
                                            for(int i= 0; i<searchMyCartList.length ; i++){
                                              totalValue = totalValue + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                                              eligibleLoan += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                                            }
                                          });
                                        }
                                        setState(() {
                                          invokeAndEligibility();
                                        });
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
                                  controller: _controllers2[actualIndex],
                                  decoration: InputDecoration(counterText: ""),
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    DecimalTextInputFormatter(decimalRange: 3),
                                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,3}')),
                                  ],
                                  style: boldTextStyle_18,
                                  onChanged: (value) {
                                    if (_controllers2[actualIndex].text.isNotEmpty) {
                                      if(!_controllers2[actualIndex].text.endsWith(".") && !_controllers2[actualIndex].text.endsWith(".0") && !_controllers2[actualIndex].text.endsWith(".00")){
                                        if (double.parse(_controllers2[actualIndex].text) >= 0.001 && !_controllers2[actualIndex].text.startsWith("0.000")) {
                                          if (double.parse(_controllers2[actualIndex].text) < .001) {
                                            Utility.showToastMessage(Strings.zero_unit_validation);
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                          } else if (double.parse(_controllers2[actualIndex].text) > actualQtyList[actualIndex].toDouble()) {
                                            Utility.showToastMessage("${Strings.check_unit}, This scheme has only ${actualQtyList[actualIndex]} unit.");
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                            setState(() {
                                              if(myPledgedSecurityList[index].pledgedQuantity.toString().split(".")[1].length != 0){
                                                var unitsDecimalCount;
                                                String str = myPledgedSecurityList[index].pledgedQuantity.toString();
                                                var qtyArray = str.split('.');
                                                unitsDecimalCount = qtyArray[1];
                                                if(unitsDecimalCount == "0"){
                                                  unitStringList[actualIndex] = str.toString().split(".")[0];
                                                  _controllers2[actualIndex].text = str.toString().split(".")[0];
                                                }else{
                                                  unitStringList[actualIndex] = myPledgedSecurityList[index].pledgedQuantity.toString();
                                                  _controllers2[actualIndex].text = myPledgedSecurityList[index].pledgedQuantity.toString();
                                                }
                                              }else{
                                                unitStringList[actualIndex] = myPledgedSecurityList[index].pledgedQuantity.toString();
                                                _controllers2[actualIndex].text = myPledgedSecurityList[index].pledgedQuantity.toString();
                                              }
                                              myPledgedSecurityList[index].pledgedQuantity = double.parse(_controllers2[actualIndex].text);
                                              totalValue = 0;
                                              eligibleLoan = 0;
                                              for(int i= 0; i<searchMyCartList.length ; i++){
                                                totalValue = totalValue + (searchMyCartList[i].price! * double.parse(_controllers2[i].text));
                                                eligibleLoan += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                                              }
                                              var updateAmount = double.parse(_controllers2[actualIndex].text) * myPledgedSecurityList[index].price!;
                                              loanData.totalCollateralValue = totalValue;
                                              myPledgedSecurityList[index].amount = updateAmount;
                                            });
                                          } else {

                                            if(_controllers2[actualIndex].text.toString().contains(".") && _controllers2[actualIndex].text.toString().split(".")[1].length != 0){
                                              var unitsDecimalCount;
                                              String str = _controllers2[actualIndex].text.toString();
                                              var qtyArray = str.split('.');
                                              unitsDecimalCount = qtyArray[1];
                                              if(unitsDecimalCount == "0"){
                                                unitStringList[actualIndex] = str.toString().split(".")[0];
                                              }else{
                                                unitStringList[actualIndex] = _controllers2[actualIndex].text.toString();
                                              }
                                            }else{
                                              unitStringList[actualIndex] = _controllers2[actualIndex].text.toString();
                                            }
                                            myPledgedSecurityList[index].pledgedQuantity = double.parse(unitStringList[actualIndex]);
                                            totalValue = 0;
                                            eligibleLoan = 0;
                                            for(int i= 0; i<searchMyCartList.length ; i++){
                                              totalValue = totalValue + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                                              eligibleLoan += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                                            }
                                            var updateAmount = double.parse(_controllers2[actualIndex].text) * myPledgedSecurityList[index].price!;
                                            loanData.totalCollateralValue = totalValue;
                                            myPledgedSecurityList[index].amount = updateAmount;
                                          }
                                        } else if( _controllers2[actualIndex].text != "0") {
                                          setState(() {
                                            if(actualQtyList[actualIndex] < 1){
                                              _controllers2[actualIndex].text = actualQtyList[actualIndex].toString();
                                              unitStringList[actualIndex] = actualQtyList[actualIndex].toString();
                                              totalValue = 0;
                                              eligibleLoan = 0;
                                              for(int i= 0; i<searchMyCartList.length ; i++){
                                                totalValue = totalValue + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                                                eligibleLoan += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                                              }
                                              myPledgedSecurityList[index].pledgedQuantity = actualQtyList[actualIndex];
                                            } else {
                                              _controllers2[actualIndex].text = "1";
                                              unitStringList[actualIndex] = "1";
                                              totalValue = 0;
                                              eligibleLoan = 0;
                                              for(int i= 0; i<searchMyCartList.length ; i++){
                                                totalValue = totalValue + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                                                eligibleLoan += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                                              }
                                              myPledgedSecurityList[index].pledgedQuantity = 1;
                                            }
                                            var updateAmount = double.parse(_controllers2[actualIndex].text) * myPledgedSecurityList[index].price!;
                                            myPledgedSecurityList[index].amount = updateAmount;
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                          });
                                        }
                                      }
                                    }
                                    invokeAndEligibility();
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
                                      if(_controllers2[actualIndex].text.toString().isNotEmpty){
                                        if (double.parse(_controllers2[actualIndex].text) < actualQtyList[actualIndex]) {
                                          double incrementWith = 0;
                                          var txt;
                                          if(_controllers2[actualIndex].text.toString().contains('.') && _controllers2[actualIndex].text.toString().split(".")[1].length != 0) {
                                            var unitsDecimalCount;
                                            String str = _controllers2[actualIndex].text.toString();
                                            var qtyArray = str.split('.');
                                            unitsDecimalCount = qtyArray[1];
                                            if(int.parse(unitsDecimalCount) == 0){
                                              txt = double.parse(_controllers2[actualIndex].text) + 1;
                                              if(txt>actualQtyList[actualIndex]){
                                                Utility.showToastMessage(Strings.check_unit);
                                              } else {
                                                incrementWith = 1;
                                                myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toString());
                                                unitStringList[actualIndex] = txt.toString();
                                                _controllers2[actualIndex].text = unitStringList[actualIndex];
                                              }
                                            } else {
                                              if (unitsDecimalCount.toString().length == 1) {
                                                txt = double.parse(_controllers2[actualIndex].text) + .1;
                                                if(txt>actualQtyList[actualIndex]){
                                                  Utility.showToastMessage(Strings.check_unit);
                                                } else {
                                                  incrementWith = .1;
                                                  myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(1));
                                                  unitStringList[actualIndex] = txt.toStringAsFixed(1);
                                                  _controllers2[actualIndex].text = unitStringList[actualIndex];
                                                }
                                              } else if (unitsDecimalCount.toString().length == 2) {
                                                txt = double.parse(_controllers2[actualIndex].text) + .01;
                                                if(txt>actualQtyList[actualIndex]){
                                                  Utility.showToastMessage(Strings.check_unit);
                                                } else {
                                                  incrementWith = .01;
                                                  myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(2));
                                                  unitStringList[actualIndex] = txt.toStringAsFixed(2);
                                                  _controllers2[actualIndex].text = unitStringList[actualIndex];
                                                }
                                              } else {
                                                txt = double.parse(_controllers2[actualIndex].text) + .001;
                                                if(txt>actualQtyList[actualIndex]){
                                                  Utility.showToastMessage(Strings.check_unit);
                                                } else {
                                                  incrementWith = .001;
                                                  myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(3));
                                                  unitStringList[actualIndex] = txt.toStringAsFixed(3);
                                                  _controllers2[actualIndex].text = unitStringList[actualIndex];
                                                }
                                              }
                                            }
                                          }else{
                                            if (actualQtyList[actualIndex] < 1) {
                                              txt = actualQtyList[actualIndex];
                                              if(txt>actualQtyList[actualIndex]){
                                                Utility.showToastMessage(Strings.check_unit);
                                              } else {
                                                incrementWith = actualQtyList[actualIndex];
                                                myPledgedSecurityList[index].pledgedQuantity = txt;
                                                unitStringList[actualIndex] = txt.toString();
                                                _controllers2[actualIndex].text = unitStringList[actualIndex];
                                              }
                                            } else{
                                              txt = double.parse(_controllers2[actualIndex].text) + 1;
                                              if(txt>actualQtyList[actualIndex]){
                                                Utility.showToastMessage(Strings.check_unit);
                                              } else {
                                                incrementWith = 1;
                                                myPledgedSecurityList[index].pledgedQuantity = txt;
                                                if(txt.toString().split(".")[1].length != 0){
                                                  var unitsDecimalCount;
                                                  String str = txt.toString();
                                                  var qtyArray = str.split('.');
                                                  unitsDecimalCount = qtyArray[1];
                                                  if(unitsDecimalCount == "0"){
                                                    unitStringList[actualIndex] = str.toString().split(".")[0];
                                                    _controllers2[actualIndex].text = str.toString().split(".")[0];
                                                  }else{
                                                    unitStringList[actualIndex] = txt;
                                                    _controllers2[actualIndex].text = txt;
                                                  }
                                                }
                                              }
                                            }
                                          }
                                          if(incrementWith != 0){
                                            setState(() {
                                              myPledgedSecurityList[index].pledgedQuantity = txt.toDouble();
                                              myPledgedSecurityList[index].amount = txt * myPledgedSecurityList[index].price!;
                                              totalValue = 0;
                                              eligibleLoan = 0;
                                              for(int i= 0; i<searchMyCartList.length ; i++){
                                                totalValue = totalValue + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                                                eligibleLoan += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                                              }
                                              loanData.totalCollateralValue = totalValue;
                                              if(searchMyCartList.length == totalSelectedScrips){
                                                checkBoxValue = true;
                                              }
                                            });
                                          }
                                        } else {
                                          Utility.showToastMessage(Strings.check_unit);
                                        }}
                                      else{
                                        setState(() {
                                          _controllers2[actualIndex].text = "0.001";
                                          unitStringList[actualIndex] = "0.001";
                                          myPledgedSecurityList[index].pledgedQuantity = double.parse(_controllers2[actualIndex].text);
                                          myPledgedSecurityList[index].amount = 0.001 * myPledgedSecurityList[index].price!;
                                          totalValue = 0;
                                          eligibleLoan = 0;
                                          for(int i= 0; i<searchMyCartList.length ; i++){
                                            totalValue = totalValue + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                                            eligibleLoan += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                                          }
                                        });
                                      }
                                      invokeAndEligibility();
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
                          child:Text(getInitials(myPledgedSecurityList[index].securityName, 1), style: extraBoldTextStyle_30),
                        ), //Container ,
                      ),
                    ],
                  ),
                ),
                !isAddBtnShow[actualIndex] ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings.value + " : ${numberToString((myPledgedSecurityList[index].price! * double.parse(_controllers2[actualIndex].text.isEmpty ? "0" : _controllers2[actualIndex].text.toString())).toStringAsFixed(2))}", style: mediumTextStyle_14_gray),
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
    if (totalSelectedScrips != 0) {
      isScripsSelect = false;
    } else {
      isScripsSelect = true;
    }
    return Visibility(
      visible : showSecurityValue,
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
                            scripsValueText( totalValue < 0
                                ? negativeValue(totalValue)
                                : '₹${numberToString(totalValue.toStringAsFixed(2))}')
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
                      isScripsSelect == true ? colorLightGray : appTheme,
                      child: AbsorbPointer(
                        absorbing: isScripsSelect,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                if(isScripsSelect == false){
                                  _handleSearchEnd();
                                  sellCollateralDialogBox(context);
                                }else{
                                  Utility.showToastMessage(Strings.check_quantity);
                                }
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
    List<bool> temp = checkBoxValues;
    setState(() {
      totalSelectedScrips = 0;
      totalValue = 0.0;
      eligibleLoan = 0.0;
    });
    for (var index = 0; index < myPledgedSecurityList.length; index++) {
      temp[index] = value;
      setState(() {
        int actualIndex = searchMyCartList.indexWhere((element) => element.isin == myPledgedSecurityList[index].isin && element.folio == myPledgedSecurityList[index].folio);

        if (value) {
          isAddBtnShow[index] = false;
          myPledgedSecurityList[index].pledgedQuantity = actualQtyList[actualIndex].toDouble();
          searchMyCartList[actualIndex].pledgedQuantity = myPledgedSecurityList[index].pledgedQuantity;

          if(myPledgedSecurityList[index].pledgedQuantity.toString().split(".")[1].length != 0){
            var unitsDecimalCount;
            String str = myPledgedSecurityList[index].pledgedQuantity.toString();
            var qtyArray = str.split('.');
            unitsDecimalCount = qtyArray[1];
            if(unitsDecimalCount == "0"){
              unitStringList[index] = str.toString().split(".")[0];
              _controllers2[index].text = str.toString().split(".")[0];
            }else{
              unitStringList[index] = myPledgedSecurityList[index].pledgedQuantity.toString();
              _controllers2[index].text = myPledgedSecurityList[index].pledgedQuantity!.toString();
            }
          }
          myPledgedSecurityList[index].pledgedQuantity = double.parse(_controllers2[index].text);
          searchMyCartList[actualIndex].pledgedQuantity = myPledgedSecurityList[index].pledgedQuantity;
          myPledgedSecurityList[index].amount = double.parse(_controllers2[actualIndex].text) * myPledgedSecurityList[index].price!;
          if (totalSelectedScrips == 0) {
            totalValue = 0.0 + myPledgedSecurityList[index].amount!;
          } else {
            totalValue = loanData.totalCollateralValue! + myPledgedSecurityList[index].amount!;
          }
          eligibleLoan += (myPledgedSecurityList[index].price! * double.parse(unitStringList[actualIndex])) * (myPledgedSecurityList[index].eligiblePercentage!/100);
          loanData.totalCollateralValue = totalValue;
          myPledgedSecurityList[index].check = true;
          totalSelectedScrips = index + 1;
          invokeAndEligibility();
        } else {
          isAddBtnShow[index] = true;
          totalValue = loanData.totalCollateralValue! - totalValue;
          eligibleLoan = 0.0;
          loanData.totalCollateralValue = totalValue;
          myPledgedSecurityList[index].amount = 0.0;
          _controllers2[index].text= "0";
          unitStringList[index] = "0";
          myPledgedSecurityList[index].pledgedQuantity = double.parse(_controllers2[actualIndex].text);
          searchMyCartList[actualIndex].pledgedQuantity = myPledgedSecurityList[index].pledgedQuantity;
          totalSelectedScrips = 0;
          invokeAndEligibility();
        }
        if (tempLength == myPledgedSecurityList.length) {
          isScripsSelect = false;
        } else {
          isScripsSelect = true;
        }
        checkBoxValues = temp;
        checkBoxValue = value;
      });
    }
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
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width,
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
                      child: Text(Strings.continue_cap, style: buttonTextWhite),
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

  void requestSellCollateralOTP() async {
    String? mobile = await preferences!.getMobile();
    String email = await preferences!.getEmail();
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    sellList.clear();
    List<double> myDuplicateList = [];
    List<CollateralLedger> collateralList2 = [];
    collateralList.sort((a, b) => a.requestedQuantity!.compareTo(b.requestedQuantity!));
    collateralList.reversed;
    collateralList2.addAll(collateralList.reversed);
    for (int i = 0; i < myPledgedSecurityList.length; i++) {
      myDuplicateList.add(myPledgedSecurityList[i].pledgedQuantity!);
    }
    for (int i = 0; i < myDuplicateList.length; i++) {
      for(int j = 0; j<collateralList2.length; j++){
        if(myPledgedSecurityList[i].isin == collateralList2[j].isin && myPledgedSecurityList[i].folio == collateralList2[j].folio){
          if(myDuplicateList[i] != 0){
            if(myDuplicateList[i] >= collateralList2[j].requestedQuantity!){
              if (myPledgedSecurityList[i].amount != 0.0) {
                sellList.add(new SellList(
                    isin: collateralList2[j].isin,
                    folio: collateralList2[j].folio,
                    psn: collateralList2[j].psn,
                    quantity: collateralList2[j].requestedQuantity!));

                myDuplicateList[i] = double.parse(myDuplicateList[i].toStringAsFixed(3)) - double.parse(collateralList2[j].requestedQuantity!.toStringAsFixed(3));
              }
            }else if(myDuplicateList[i] < collateralList2[j].requestedQuantity!){
              if (myPledgedSecurityList[i].amount != 0.0) {
                sellList.add(new SellList(
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


    sellCollateralBloc.requestSellCollateralOTP().then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        Utility.showToastMessage(Strings.enter_otp);
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.loan_number] = widget.loanNo;
        parameter[Strings.is_for_margin_shortfall] = isMarginShortFall ? "True" : "False";
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.sell_otp_sent, parameter);

        showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          isScrollControlled: true,
          builder: (BuildContext bc) {
            return SellCollateralOTPScreen(widget.loanNo, sellList,marginShortfallName, Strings.mutual_fund);
          },
        );
      } else if(value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }
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
                      commonDialog(context, Strings.invocation_charges_info, 0);
                    }else {
                      commonDialog(context, Strings.invoke_i_info, 0);
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