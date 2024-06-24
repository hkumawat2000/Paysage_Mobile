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

class SellCollateralScreen extends StatefulWidget {
  String loanNo;
  String isComingFor;
  String isin;
  String loanType;

  SellCollateralScreen(this.loanNo, this.isComingFor, this.isin, this.loanType);

  @override
  _SellCollateralScreenState createState() => _SellCollateralScreenState();
}

class _SellCollateralScreenState extends State<SellCollateralScreen> {
  Preferences? preferences;
  MyLoansBloc myLoansBloc = MyLoansBloc();
  SellCollateralBloc sellCollateralBloc = SellCollateralBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  List<TextEditingController> qtyControllers = [];
  List<FocusNode> focusNode = [];
  bool checkBoxValue = false;
  bool isMarginShortFall = false;
  bool isAPIRespond = false;
  List<Items> myPledgedSecurityList = [];
  List<Items> actualMyCartList = [];
  List<int> actualQtyList = [];
  List<bool> isAddBtnShow = [];
  Loan loanData = new Loan();
  double? vlMarginShortFall, vlDesiredValue;
  double totalValue = 0;
  double? totalCollateral;
  String marginShortfallName = "";
  Widget appBarTitle = new Text("", style: new TextStyle(color: Colors.white));
  Icon actionIcon = new Icon(Icons.search, color: appTheme, size: 25);
  TextEditingController _textController = TextEditingController();
  FocusNode focusNodes = FocusNode();
  double? selectedSecurityEligibility = 0;
  double actualDrawingPower = 0;



  @override
  void initState() {
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
            if (value.data!.marginShortfall != null) {
              marginShortfallName = value.data!.marginShortfall!.name!;
              isMarginShortFall = true;
              vlMarginShortFall = value.data!.marginShortfall!.minimumCashAmount!;
              vlDesiredValue = value.data!.marginShortfall!.advisableCashAmount;
            } else {
              isMarginShortFall = false;
            }

            for (int i = 0; i < value.data!.loan!.items!.length; i++) {
              if(value.data!.loan!.items![i].amount != 0.0) {
                myPledgedSecurityList.add(value.data!.loan!.items![i]);
                actualDrawingPower = actualDrawingPower + ((loanData.items![i].price! * loanData.items![i].pledgedQuantity!) *
                    (loanData.items![i].eligiblePercentage! / 100));
              }
            }
            actualMyCartList.addAll(myPledgedSecurityList);

            for (int i = 0; i < myPledgedSecurityList.length; i++) {
              qtyControllers.add(TextEditingController());
              focusNode.add(FocusNode());
              actualQtyList.add(myPledgedSecurityList[i].pledgedQuantity!.toInt());
              if(widget.isComingFor == Strings.single && myPledgedSecurityList[i].isin == widget.isin){
                isAddBtnShow.add(false);
                qtyControllers[i].text = myPledgedSecurityList[i].pledgedQuantity!.toInt().toString();
              } else {
                isAddBtnShow.add(true);
              }
            }
            sellCalculationHandling();
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
                    focusNode: focusNodes,
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


  void searchResults(String query) {
    List<Items> dummySearchList = [];
    dummySearchList.addAll(actualMyCartList);
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
        myPledgedSecurityList.addAll(actualMyCartList);
      });
    }
  }

  void _handleSearchEnd() {
    setState(() {
      focusNodes.unfocus();
      this.actionIcon = Icon(Icons.search, color: appTheme, size: 25);
      this.appBarTitle = Text(widget.loanNo,
        style: TextStyle(color: appTheme),
      );
      _textController.clear();
      myPledgedSecurityList.clear();
      myPledgedSecurityList.addAll(actualMyCartList);
    });
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
                              isMarginShortFall ? ReusableSellAmountText(
                                sellText: 'Margin shortfall',
                                loanType: widget.loanType,
                                sellAmount: vlMarginShortFall! < 0
                                    ? negativeValue(vlMarginShortFall!)
                                    : '₹${numberToString(vlMarginShortFall!.toStringAsFixed(2))}',
                                sellAmountColor: red,
                                iIcon: false,
                              ) : SizedBox(height: 0),
                              ReusableSellAmountText(
                                sellText: 'Selected securities value',
                                sellAmount: totalValue < 0
                                    ? negativeValue(totalValue)
                                    : '₹${numberToString(totalValue.toStringAsFixed(2))}',
                                sellAmountColor: colorGreen,
                                iIcon: false,
                              ),
                              isMarginShortFall ?  ReusableSellAmountText(
                                sellText: 'Minimum desired value',
                                sellAmount: vlDesiredValue! < 0
                                    ? negativeValue(vlDesiredValue!)
                                    : '₹${numberToString(vlDesiredValue!.toStringAsFixed(2))}',
                                sellAmountColor: red,
                                iIcon: false,
                              ): SizedBox(height: 0),
                              ReusableSellAmountText(
                                sellText: 'Remaining securities value',
                                sellAmount: (totalCollateral! - double.parse(totalValue.toStringAsFixed(2))) < 0
                                    ? negativeValue((totalCollateral! - double.parse(totalValue.toStringAsFixed(2))))
                                    : '₹${numberToString((totalCollateral! - double.parse(totalValue.toStringAsFixed(2))).toStringAsFixed(2))}',
                                sellAmountColor: colorDarkGray,
                                iIcon: false,
                              ),
                              ReusableSellAmountText(
                                sellText: 'Revised drawing power',
                                sellAmount: (actualDrawingPower - selectedSecurityEligibility!) < 0
                                    ? negativeValue((actualDrawingPower - selectedSecurityEligibility!))
                                    : '₹${numberToString((actualDrawingPower - selectedSecurityEligibility!).toStringAsFixed(2))}',
                                sellAmountColor: (actualDrawingPower - selectedSecurityEligibility!) < 0 ? colorGreen : colorDarkGray,
                                iIcon: false,
                              ),
                              ReusableSellAmountText(
                                sellText: 'Existing loan balance',
                                sellAmount: loanData.balance! < 0
                                    ? negativeValue(loanData.balance!)
                                    : '₹${numberToString(loanData.balance!.toStringAsFixed(2))}',
                                sellAmountColor: loanData.balance! < 0 ? colorGreen : colorDarkGray,
                                iIcon: false,
                              ),
                              ReusableSellAmountText(
                                sellText: 'Post sale loan balance',
                                sellAmount: (loanData.balance! - double.parse(totalValue.toStringAsFixed(2))) < 0
                                    ? negativeValue((loanData.balance! - double.parse(totalValue.toStringAsFixed(2))))
                                    : '₹${numberToString((loanData.balance! - double.parse(totalValue.toStringAsFixed(2))).toStringAsFixed(2))}',
                                sellAmountColor: (loanData.balance! - double.parse(totalValue.toStringAsFixed(2))) < 0 ? colorGreen : colorDarkGray,
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
                      FocusScope.of(context).unfocus();
                      alterCheckBox(newValue);
                    },
                    value: checkBoxValue,
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
      child: myPledgedSecurityList.length == 0 ?
      Padding(padding: const EdgeInsets.only(top: 150.0), child: Center(child: Text(Strings.no_result_found))) :
      ListView.builder(
        key: Key(myPledgedSecurityList.length.toString()),
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: myPledgedSecurityList.length,
        itemBuilder: (context, index) {
          int actualIndex = actualMyCartList.indexWhere((element) => element.securityName == myPledgedSecurityList[index].securityName);
          String sellQty;
          if(isAddBtnShow[actualIndex]){
            sellQty = 0.toString();
          } else {
            sellQty = myPledgedSecurityList[index].pledgedQuantity!.toInt().toString().split('.')[0];
          }
          myPledgedSecurityList[index].pledgedQuantity = double.parse(sellQty);
          if(index == myPledgedSecurityList.length){
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
                Text(myPledgedSecurityList[index].securityName!, style: boldTextStyle_18),
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
                                  scripsValueText("₹${numberToString(myPledgedSecurityList[index].price!.toStringAsFixed(2))}"),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Expanded(child: Text("${actualQtyList[actualIndex].toString()} QTY", style: mediumTextStyle_12_gray)),
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
                                    myPledgedSecurityList[index].pledgedQuantity = 1.0;
                                    sellCalculationHandling();
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
                          child:Text(getInitials(myPledgedSecurityList[index].securityName, 1), style: extraBoldTextStyle_30),
                        ), //Container ,
                      ),
                    ],
                  ),
                ),
                !isAddBtnShow[actualIndex] ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(Strings.value + " : ${numberToString((myPledgedSecurityList[index].price! * double.parse(qtyControllers[actualIndex].text.isEmpty ? "0" : qtyControllers[actualIndex].text.toString())).toStringAsFixed(2))}", style: mediumTextStyle_14_gray),
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


  sellCalculationHandling(){
    setState(() {
      if(!isAddBtnShow.contains(true)){
        checkBoxValue = true;
      } else {
        checkBoxValue = false;
      }
      totalValue = 0;
      selectedSecurityEligibility = 0;
      for(int i=0; i<actualMyCartList.length ; i++){
        if(!isAddBtnShow[i] && qtyControllers[i].text.isNotEmpty){
          totalValue += actualMyCartList[i].price! * double.parse(qtyControllers[i].text.toString());
          selectedSecurityEligibility = selectedSecurityEligibility! + (actualMyCartList[i].price! * double.parse(qtyControllers[i].text.toString()) * actualMyCartList[i].eligiblePercentage! / 100);
        }
      }
    });
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
                      Text(totalValue < 0 ? negativeValue(totalValue)
                          : '₹' + numberToString(totalValue.toStringAsFixed(2)),
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
                    color: totalValue <= 0 ? colorLightGray : appTheme,
                    child: AbsorbPointer(
                      absorbing: totalValue <= 0 ? true : false,
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

  void alterCheckBox(value) {
    setState(() {
      totalValue = 0.0;
      checkBoxValue = value;
    });
    for (var index = 0; index < myPledgedSecurityList.length; index++) {
      setState(() {
        if (value) {
          isAddBtnShow[index] = false;
          myPledgedSecurityList[index].pledgedQuantity = actualQtyList[index].toDouble();
          qtyControllers[index].text = myPledgedSecurityList[index].pledgedQuantity!.toInt().toString();
        } else {
          isAddBtnShow[index] = true;
          qtyControllers[index].text= "0";
          myPledgedSecurityList[index].pledgedQuantity = double.parse(qtyControllers[index].text);
        }
      });
    }
    sellCalculationHandling();
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
                    child: new Text(widget.loanType == Strings.shares ? Strings.sell_collateral_confirmation : Strings.invoke_confirmation, style: regularTextStyle_16_dark),
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

  void requestSellCollateralOTP() async {
    String? mobile = await preferences!.getMobile();
    String email = await preferences!.getEmail();
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    List<SellList> sellList = [];
    for (int i = 0; i < myPledgedSecurityList.length; i++) {
      if (myPledgedSecurityList[i].pledgedQuantity != 0.0 && !isAddBtnShow[i]) {
        sellList.add(new SellList(
            isin: myPledgedSecurityList[i].isin,
            quantity: double.parse(myPledgedSecurityList[i].pledgedQuantity.toString()),
            psn : myPledgedSecurityList[i].psn));
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
            return SellCollateralOTPScreen(widget.loanNo, sellList, marginShortfallName, Strings.shares);
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
                    commonDialog(context,Strings.sell_collateral_i_info, 0);
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
