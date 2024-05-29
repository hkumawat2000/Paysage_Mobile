import 'dart:convert';
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/lender/LenderBloc.dart';
import 'package:lms/network/requestbean/MyCartRequestBean.dart';
import 'package:lms/network/requestbean/SecuritiesRequest.dart';
import 'package:lms/network/responsebean/ApprovedListResponseBean.dart';
import 'package:lms/network/responsebean/MyCartResponseBean.dart';
import 'package:lms/network/responsebean/SecuritiesResponseBean.dart';
import 'package:lms/shares/LoanApplicationBloc.dart';
import 'package:lms/shares/MyShareCartScreen.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../network/responsebean/AuthResponse/LoanDetailsResponse.dart';

class NewIncreaseLoanScreen extends StatefulWidget {
  MarginShortfall? marginShortfall;
  String comingFrom;
  List<SecuritiesListData> securities = [];
  String stockAt;
  String loanName;
  List<LenderInfo>? lenderInfo;
  List<String> lenderList;
  List<String> levelList;

  @override
  NewIncreaseLoanScreenState createState() => NewIncreaseLoanScreenState();

  NewIncreaseLoanScreen(
      this.marginShortfall, this.comingFrom, this.securities, this.stockAt, this.loanName, this.lenderInfo, this.lenderList, this.levelList);
}

class NewIncreaseLoanScreenState extends State<NewIncreaseLoanScreen> {
  final loanApplicationBloc = LoanApplicationBloc();
  ScrollController _scrollController = new ScrollController();
  Preferences? preferences;
  List<TextEditingController> _controllers = [];
  List<TextEditingController> _controllers2 = [];
  List<SecuritiesList> securitiesListItems = [];
  Cart cartData = new Cart();
  List<CartItems> myCartList = [];
  List<SecuritiesListData> searchMyCartList = [];
  List<String>? scripNameList;
  List<bool> pledgeControllerEnable = [];
  List<bool> pledgeControllerAutoFocus = [];
  List<bool> pledgeControllerShowCursor = [];
  List<FocusNode> myFocusNode = [];
  bool checkBoxValue = false;
  bool singlecheckBoxValue = true;
  List<bool> checkBoxValues = [];
  List<bool> isAddBtnShow = [];
  List<SecuritiesList> shareSecuritiesListItems = [];
  var scriptValue, totalScrips, pledgeQTY;
  var eligible_loan, status;
  var selected_securities;
  bool? resetValue;
  bool isScripsSelect = true;
  double eligibleLoan = 0;
  double totalValue = 0;
  double? minSanctionedLimit, maxSanctionedLimit;
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  MyCartResponseBean? myCartData;
  bool isUpateBtnClickable = true;
  List<bool> isUpateBtnClickableList = [];
  List<bool> selectedBoolLenderList = [];
  List<bool> selectedBoolLevelList = [];
  List<String> selectedLenderList = [];
  List<String> selectedLevelList = [];
  List<String> lenderList = [];
  List<String> levelList = [];
  final lenderBloc = LenderBloc();
  int tempLength = 0;
  bool hideSecurityValue = false;
  bool showSecurityValue = true;
  Widget appBarTitle = new Text("", style: new TextStyle(color: Colors.white));
  Icon actionIcon = new Icon(
    Icons.search,
    color: appTheme,
    size: 25,
  );
  List<SecuritiesListData> securities = [];

  TextEditingController _textController = TextEditingController();
  FocusNode focusNode = FocusNode();

  void getDetails() async {
    setState(() {
      for (int i = 0; i < widget.lenderList.length; i++) {
        lenderList.addAll(widget.lenderList);
        selectedLenderList.addAll(widget.lenderList);
        selectedBoolLenderList.add(true);
        levelList.addAll(widget.levelList);
        widget.levelList.forEach((element) {
          selectedLevelList.add(element.toString().split(" ")[1]);
          selectedBoolLevelList.add(true);
        });
      }
      securities.addAll(widget.securities);
      print("length --> ${securities.length.toString()}");
      searchMyCartList.addAll(widget.securities);
      for(int i = 0; i<=securities.length; i++){
        _controllers2.add(TextEditingController());
        isAddBtnShow.add(true);
      }
    });
  }

  void searchResults(String query) {
    List<SecuritiesListData> dummySearchList = <SecuritiesListData>[];
    dummySearchList.addAll(searchMyCartList);
    if (query.isNotEmpty) {
      List<SecuritiesListData> dummyListData = <SecuritiesListData>[];
      dummySearchList.forEach((item) {
        if (item.scripName!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        securities.clear();
        securities.addAll(dummyListData);
      });
    } else {
      setState(() {
        securities.clear();
        securities.addAll(searchMyCartList);
      });
    }
  }

  void _handleSearchEnd() {
    setState(() {
      focusNode.unfocus();
      this.actionIcon = Icon(Icons.search, color: appTheme, size: 25);
      this.appBarTitle = subHeadingText("Pledge Securities");
      _textController.clear();
      securities.clear();
      securities.addAll(searchMyCartList);
    });
  }

  @override
  void initState() {
    resetValue = true;
    preferences = Preferences();
    appBarTitle = subHeadingText("Pledge Securities");
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        getDetails();
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    loanApplicationBloc.dispose();
    _scrollController.dispose();
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
          body: securities != null ? allPledgeData(securities) : Container()),
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
          child: IconButton(
            icon: actionIcon,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = Icon(
                    Icons.close,
                    color: appTheme,
                    size: 25,
                  );
                  this.appBarTitle = TextField(
                    controller: _textController,
                    focusNode: focusNode,
                    style: TextStyle(
                      color: appTheme,
                    ),
                    cursorColor: appTheme,
                    decoration: InputDecoration(
                        prefixIcon: new Icon(
                          Icons.search,
                          color: appTheme,
                          size: 25,
                        ),
                        hintText: "Search...",
                        focusColor: appTheme,
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: appTheme)),
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

  Widget allPledgeData(List<SecuritiesListData> securities) {
    return NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([
                SizedBox(height: 0.5,),
                widget.comingFrom == Strings.margin_shortfall ? Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: marginShortFall(context,
                      widget.marginShortfall!.loanBalance,
                      widget.marginShortfall!.minimumPledgeAmount,
                      widget.marginShortfall!.minimumCashAmount,
                      widget.marginShortfall!.drawingPower,
                      AssetsImagePath.business_finance,
                      colorLightRed,
                      false, Strings.shares),
                ) :  Container(),
              ]),
            )
          ];
        },
        body: Column(
          children: <Widget>[
            _textController.text.isNotEmpty ? SizedBox() :Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  scripsNameText(encryptAcNo(widget.stockAt)),
                 SizedBox(
                   child: GestureDetector(
                     child: Row(
                       mainAxisAlignment: MainAxisAlignment.end,
                       children: [
                         Text(Strings.filter, style: regularTextStyle_14),
                         SizedBox(width: 4),
                         Icon(Icons.filter_alt_rounded, size: 24, color: appTheme)
                       ],
                     ),
                     onTap: () {
                       showModalBottomSheet(
                         backgroundColor: Colors.transparent,
                         context: context,
                         isScrollControlled: true,
                         builder: (BuildContext context) {
                           return filerDialogShare();
                         },
                       );
                     },
                   ),
                 ),
                ],
              ),
            ),
            SizedBox(height: 10),
            Expanded(
              child: SingleChildScrollView(
                physics: NeverScrollableScrollPhysics(),
                child: pledgeSecuritiesList(),
              ),
            ),
            showSecurityValue ? bottomSection() : bottomSectionEL(),
          ],
        ));
  }

  filerDialogShare() {
    List<bool> lenderCheckBox = [];
    lenderCheckBox.addAll(selectedBoolLenderList);
    List<bool> levelCheckBox = [];
    levelCheckBox.addAll(selectedBoolLevelList);

    return Container(
      height: MediaQuery.of(context).size.height - 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 3.0),
        borderRadius: BorderRadius.only(topRight: Radius.circular(16.0), topLeft: Radius.circular(16.0)),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
        ],
      ),
      child: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([SizedBox(height: 1)]),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(Strings.lender, style: boldTextStyle_18.copyWith(fontSize: 20)),
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter s) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: lenderList.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                onChanged: (val) => null,
                                value: true,
                                title: Text(lenderList[index]),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Text(Strings.level, style: boldTextStyle_18.copyWith(fontSize: 20)),
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter s) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: levelList.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                onChanged: (val) {
                                  s(() {
                                    levelCheckBox[index] = val!;
                                    if(!levelCheckBox.contains(true)){
                                      Utility.showToastMessage("Atleast one level is mandatory");
                                      levelCheckBox[index] = !val;
                                    }
                                  });
                                },
                                value: levelCheckBox[index],
                                title: Text(levelList[index]),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      width: 100,
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                            side: BorderSide(color: red)),
                        elevation: 1.0,
                        color: colorWhite,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            Navigator.pop(context);
                          },
                          child: Text(
                            Strings.cancel,
                            style: buttonTextRed,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 40,
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
                            Utility.isNetworkConnection()
                                .then((isNetwork){
                              if (isNetwork){
                                setState(() {
                                  List<String> previousLevelList = [];
                                  previousLevelList.addAll(selectedLevelList);
                                  if(!levelCheckBox.contains(true)){
                                    Utility.showToastMessage("Atleast one level is mandatory");
                                  } else {
                                    selectedLenderList.clear();
                                    selectedLevelList.clear();
                                    for (int i = 0; i < lenderList.length; i++) {
                                      if (lenderCheckBox[i]) {
                                        selectedLenderList.add(lenderList[i]);
                                        selectedBoolLenderList[i] = true;
                                      } else {
                                        selectedBoolLenderList[i] = false;
                                      }
                                    }

                                    for (int i = 0; i < levelList.length; i++) {
                                      if (levelCheckBox[i]) {
                                        selectedLevelList.add(levelList[i].toString().split(" ")[1]);
                                        selectedBoolLevelList[i] = true;
                                      } else {
                                        selectedBoolLevelList[i] = false;
                                      }
                                    }
                                    bool condition1 = previousLevelList.toSet().difference(selectedLevelList.toSet()).isEmpty;
                                    bool condition2 = previousLevelList.length == selectedLevelList.length;
                                    bool isEqual = condition1 && condition2;
                                    Navigator.pop(context);
                                    if(!isEqual){
                                      LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
                                      _handleSearchEnd();
                                      loanApplicationBloc.getSecurities(SecuritiesRequest(
                                          lender: selectedLenderList.join(","),
                                          level: selectedLevelList.join(","),
                                          demat:  widget.stockAt)).then((
                                          value) async {
                                        Navigator.pop(context);
                                        if (value.isSuccessFull!) {
                                          shareSecuritiesListItems.clear();
                                          securities.clear();
                                          isAddBtnShow.clear();
                                          searchMyCartList.clear();
                                          _controllers2.clear();
                                          totalValue = 0;
                                          eligibleLoan = 0;
                                          setState(() {
                                            for (int i = 0; i < value.securityData!.securities!.length; i++) {
                                              if (value.securityData!.securities![i].isEligible == true && value.securityData!.securities![i].quantity != 0
                                                  && value.securityData!.securities![i].price != 0 && value.securityData!.securities![i].stockAt == widget.stockAt){
                                                securities.add(value.securityData!.securities![i]);
                                                searchMyCartList.add(value.securityData!.securities![i]);
                                              }
                                            }
                                            for(int i = 0; i<=securities.length; i++){
                                              _controllers2.add(TextEditingController());
                                              isAddBtnShow.add(true);
                                            }
                                          });
                                        } else if(value.errorCode == 404){
                                          commonDialog(context, Strings.not_fetch, 0);
                                        } else if(value.errorCode == 403){
                                          commonDialog(context, Strings.session_timeout, 4);
                                        } else {
                                          Utility.showToastMessage(value.errorMessage!);
                                        }
                                      });
                                    }
                                  }
                                });
                              } else {
                                Utility.showToastMessage(Strings.no_internet_message);
                              }
                            });
                          },
                          child: Text(
                            Strings.apply,
                            style: buttonTextWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget dematAccountNo() {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "Demat Account",
            style: mediumTextStyle_16_gray,
          ),
          Text(
            widget.stockAt,
            style: mediumTextStyle_16_dark,
          ),
        ],
      ),
    );
  }

  Widget pledgeSecuritiesList() {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, top: 0, right: 20, bottom: 120),
      child: securities.length == 0
          ? Padding(
        padding: const EdgeInsets.only(top: 150.0),
        child: Center(child: Text("No Data")),
      ): ListView.builder(
        key: Key(securities.length.toString()),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: securities.length,
        itemBuilder: (context, index) {
          int actualIndex = searchMyCartList.indexWhere((element) => element.scripName == securities[index].scripName);
          isAddBtnShow.add(true);
          var pledge_qty;
          pledge_qty = securities[index].quantity!.toInt().toString();
          _controllers2[actualIndex] = TextEditingController(text: pledge_qty);
          _controllers2[actualIndex].selection =
              TextSelection.fromPosition(TextPosition(offset: _controllers2[actualIndex].text.length));
          pledgeControllerEnable.add(false);

          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white, width: 3.0),
              // set border width
              borderRadius: BorderRadius.all(Radius.circular(10.0)), // set rounded corner radius
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(securities[index].scripName!, style: boldTextStyle_18),
                SizedBox(height: 4),
                Text("${securities[index].category!} (LTV: ${securities[index].eligiblePercentage!.toStringAsFixed(2)}%)",
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
                                  scripsValueText("₹${securities[index].price!.toStringAsFixed(2)}"),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(child: Text("${securities[index].totalQty!.toInt().toString()} QTY", style: mediumTextStyle_12_gray)),
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
                                    _controllers2[actualIndex].text = "1";
                                    securities[index].quantity = 1.0;
                                    totalValue = 0;
                                    eligibleLoan = 0;
                                    for(int i =0; i< searchMyCartList.length; i++){
                                      if(!isAddBtnShow[i]){
                                        totalValue += searchMyCartList[i].price! * double.parse(_controllers2[i].text);
                                        eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers2[i].text) * searchMyCartList[i].eligiblePercentage! / 100;
                                      }
                                    }
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
                      ) : Column(
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
                                      int txt = int.parse(_controllers2[actualIndex].text) - 1;
                                      setState(() {
                                        if (!isAddBtnShow[actualIndex]) {
                                          if (txt != 0) {
                                            if ((double.parse(_controllers2[actualIndex].text) <= securities[index].totalQty!)) {
                                              _controllers2[actualIndex].text = txt.toString();
                                              securities[index].quantity = securities[index].quantity! - 1;
                                              totalValue = 0;
                                              eligibleLoan = 0;
                                              for(int i =0; i< searchMyCartList.length; i++){
                                                if(!isAddBtnShow[i]){
                                                  totalValue += searchMyCartList[i].price! * double.parse(_controllers2[i].text);
                                                  eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers2[i].text) * searchMyCartList[i].eligiblePercentage! / 100;
                                                }
                                              }
                                              cartData.totalCollateralValue = totalValue;
                                            } else {
                                              Utility.showToastMessage(Strings.check_quantity);
                                            }
                                          }else{
                                            setState(() {
                                              FocusScope.of(context).unfocus();
                                              isAddBtnShow[actualIndex] = true;
                                              checkBoxValue = false;
                                              _controllers2[actualIndex].text = "0";
                                              securities[index].quantity = 0;
                                              totalValue = 0;
                                              eligibleLoan = 0;
                                              for(int i =0; i< searchMyCartList.length; i++){
                                                if(!isAddBtnShow[i]){
                                                  totalValue += searchMyCartList[i].price! * double.parse(_controllers2[i].text);
                                                  eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers2[i].text) * searchMyCartList[i].eligiblePercentage! / 100;
                                                }
                                              }
                                            });
                                          }
                                        } else {
                                          Utility.showToastMessage(Strings.validation_select_checkbox);
                                        }
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
                                  decoration: InputDecoration(counterText: ""),
                                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                                  inputFormatters: [
                                    FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                  ],
                                  controller: _controllers2[actualIndex],
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  onChanged: (value) {
                                    if (!isAddBtnShow[actualIndex]) {
                                      if (_controllers2[actualIndex].text.isNotEmpty) {
                                        if (_controllers2[actualIndex].text != "0") {
                                          if (int.parse(_controllers2[actualIndex].text) < 1) {
                                            Utility.showToastMessage(Strings.message_quantity_not_less_1);
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                          } else if (double.parse(_controllers2[actualIndex].text) > securities[index].totalQty!) {
                                            Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${securities[index].totalQty!.toInt().toString()} quantity.");
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                            setState(() {
                                              _controllers2[actualIndex].text = securities[index].totalQty.toString();
                                              securities[index].quantity = double.parse(_controllers2[actualIndex].text);
                                              totalValue = 0;
                                              eligibleLoan = 0;
                                              for(int i =0; i< searchMyCartList.length; i++){
                                                if(!isAddBtnShow[i]){
                                                  totalValue += searchMyCartList[i].price! * double.parse(_controllers2[i].text);
                                                  eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers2[i].text) * searchMyCartList[i].eligiblePercentage! / 100;
                                                }
                                              }
                                            });
                                          } else {
                                            setState(() {
                                              securities[index].quantity = double.parse(_controllers2[actualIndex].text);
                                              totalValue = 0;
                                              eligibleLoan = 0;
                                              for(int i =0; i< searchMyCartList.length; i++){
                                                if(!isAddBtnShow[i]){
                                                  totalValue += searchMyCartList[i].price! * double.parse(_controllers2[i].text);
                                                  eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers2[i].text) * searchMyCartList[i].eligiblePercentage! / 100;
                                                }
                                              }
                                            });
                                          }
                                        } else {
                                          setState(() {
                                            _controllers2[actualIndex].text = "";
                                            _controllers2[actualIndex].text = "1";
                                            securities[index].quantity = 1;
                                            totalValue = 0;
                                            eligibleLoan = 0;
                                            for(int i =0; i< searchMyCartList.length; i++){
                                              if(!isAddBtnShow[i]){
                                                totalValue += searchMyCartList[i].price! * double.parse(_controllers2[i].text);
                                                eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers2[i].text) * searchMyCartList[i].eligiblePercentage! / 100;
                                              }
                                            }
                                            FocusScope.of(context).requestFocus(new FocusNode());
                                          });
                                        }
                                      } else {
                                      }
                                    } else {
                                      FocusScope.of(context).requestFocus(new FocusNode());
                                      Utility.showToastMessage(Strings.validation_select_checkbox);
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(left: 0.0),
                                child: IconButton(
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
                                        if (int.parse(_controllers2[actualIndex].text) < int.parse(securities[index].totalQty!.toInt().toString())) {
                                          int txt = int.parse(_controllers2[actualIndex].text) + 1;
                                          setState(() {
                                            if (!isAddBtnShow[actualIndex]) {
                                              _controllers2[actualIndex].text = txt.toString();
                                              securities[index].quantity = securities[index].quantity! + 1;
                                              totalValue = 0;
                                              eligibleLoan = 0;
                                              for(int i =0; i< searchMyCartList.length; i++){
                                                if(!isAddBtnShow[i]){
                                                  totalValue += searchMyCartList[i].price! * double.parse(_controllers2[i].text);
                                                  eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers2[i].text) * searchMyCartList[i].eligiblePercentage! / 100;
                                                }
                                              }
                                            } else {
                                              isAddBtnShow[actualIndex] = true;
                                              totalScrips = totalScrips + 1;
                                              _controllers2[actualIndex].text = txt.toString();
                                              securities[index].quantity = securities[index].quantity! + 1;
                                              totalValue = 0;
                                              eligibleLoan = 0;
                                              for(int i =0; i< searchMyCartList.length; i++){
                                                if(!isAddBtnShow[i]){
                                                  totalValue += searchMyCartList[i].price! * double.parse(_controllers2[i].text);
                                                  eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers2[i].text) * searchMyCartList[i].eligiblePercentage! / 100;
                                                }
                                              }
                                            }
                                            if(securities.length == totalScrips){
                                              checkBoxValue = true;
                                            }
                                          });
                                        } else {
                                          Utility.showToastMessage(Strings.check_quantity);
                                        }
                                      } else {
                                        Utility.showToastMessage(Strings.no_internet_message);
                                      }
                                    });
                                  },
                                ),
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
                          child: securities[index].amcImage != null && securities[index].amcImage!.isNotEmpty
                              ? CircleAvatar(backgroundImage: NetworkImage(securities[index].amcImage!),backgroundColor: colorRed, radius: 50.0)
                              : Text(getInitials(securities[index].scripName, 1), style: extraBoldTextStyle_30),
                        ), //Container ,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                !isAddBtnShow[actualIndex] ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings.value + " : ${(securities[index].price! * double.parse(_controllers2[actualIndex].text.toString())).toStringAsFixed(2)}", style: mediumTextStyle_14_gray),
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

  Widget bottomSection() {
    setState(() {
        if(eligibleLoan > 0){
          isScripsSelect = false;
        } else {
          isScripsSelect = true;
        }
    });
    return Visibility(
      visible: showSecurityValue,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 3.0),
            // set border width
            borderRadius:
            BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
            // set rounded corner radius
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Expanded(child: Text(Strings.security_value, style: mediumTextStyle_18_gray)),
                            scripsValueText('₹' +numberToString(totalValue.toStringAsFixed(2)))
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Eligible Loan",
                              style: mediumTextStyle_18_gray,),
                            Text('₹' + numberToString(eligibleLoan.toStringAsFixed(2)), style: textStyleGreenStyle_18)
                          ],
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
                    height: 50,
                    width: 140,
                    child: Material(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      elevation: 1.0,
                      color: isScripsSelect == true ? colorLightGray : appTheme,
                      child: AbsorbPointer(
                        absorbing: isScripsSelect,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                // sendMyCart(false);
                                onViewVaultClick();
                              } else {
                                Utility.showToastMessage(Strings.no_internet_message);
                              }
                            });
                          },
                          child: Text(Strings.view_vault, style: buttonTextWhite),
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

  Widget bottomSectionEL() {
    setState(() {
      if(eligibleLoan > 0){
        isScripsSelect = false;
      } else {
        isScripsSelect = true;
      }
    });
    return Visibility(
      visible: hideSecurityValue,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: Colors.white, width: 3.0),
            // set border width
            borderRadius:
            BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
            // set rounded corner radius
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
                  Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Text("Eligible Loan",
                              style: mediumTextStyle_18_gray,),
                            Text('₹' + numberToString(eligibleLoan.toStringAsFixed(2)), style: textStyleGreenStyle_18)
                          ],
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      elevation: 1.0,
                      color: isScripsSelect == true ? colorLightGray : appTheme,
                      child: AbsorbPointer(
                        absorbing: isScripsSelect,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                // sendMyCart(false);
                                onViewVaultClick();
                              } else {
                                Utility.showToastMessage(Strings.no_internet_message);
                              }
                            });
                          },
                          child: Text(Strings.my_vault, style: buttonTextWhite),
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

  onViewVaultClick() async {
    _handleSearchEnd();
    List<SecuritiesListData> selectedSecurityList = [];
    for(int i=0; i<securities.length;i++){
      if(!isAddBtnShow[i]){
        securities[i].quantity = double.parse(_controllers2[i].text.toString());
        selectedSecurityList.add(securities[i]);
      }
    }
    List<SecuritiesListData> securityList = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => MyShareCartScreen(widget.loanName, widget.marginShortfall, widget.comingFrom, selectedSecurityList, securitiesListItems, widget.stockAt, widget.lenderInfo)));
    updateQuantity(securityList);
  }

  updateQuantity(List<SecuritiesListData> securityList){
    for(int i=0; i<securities.length; i++){
      String index = "null";
      double qty = 0;
      securityList.forEach((element) {
        if(element.iSIN == securities[i].iSIN){
          index = i.toString();
          qty = element.quantity!;
        }
      });
      setState(() {
        if(index != "null"){
          securities[i].quantity = qty;
          _controllers2[i].text = qty.toInt().toString();
          if(securities[i].quantity! <= 0){
            isAddBtnShow[i] = true;
          } else {
            isAddBtnShow[i] = false;
          }
        } else {
          securities[i].quantity = 0;
          _controllers2[i].text = "0";
          isAddBtnShow[i] = true;
        }
      });
    }
    setState(() {
      totalValue = 0;
      eligibleLoan = 0;
      for(int i =0; i< searchMyCartList.length; i++){
        if(!isAddBtnShow[i]){
          totalValue += searchMyCartList[i].price! * double.parse(_controllers2[i].text);
          eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers2[i].text) * searchMyCartList[i].eligiblePercentage! / 100;
        }
      }
    });
  }

  void altercheckBox(value) {
    List<bool> temp = isAddBtnShow;
    setState(() {
      totalScrips = 0;
      totalValue = 0.0;
    });
    for (var index = 0; index < myCartList.length; index++) {
      int actualIndex = searchMyCartList.indexWhere((element) => element.scripName == securities[index].scripName);

      temp[index] = value;
      setState(() {
        if (value) {
          isAddBtnShow[index] = false;
          securities[index].quantity = widget.securities[index].quantity!.toDouble();
          _controllers2[actualIndex].text = securities[index].quantity.toString();
          cartData.totalCollateralValue = totalValue;
          eligibleLoan = cartData.totalCollateralValue! / 2;
          totalScrips = index + 1;
        } else {
          _controllers2[actualIndex].text = "0";
          securities[index].quantity = double.parse(_controllers2[actualIndex].text);
          eligibleLoan = cartData.totalCollateralValue! / 2;
          totalScrips = 0;
        }
        if (tempLength == myCartList.length) {
          isScripsSelect = false;
        } else {
          isScripsSelect = true;
        }
        isAddBtnShow = temp;
        checkBoxValue = value;
      });
    }
  }
}
