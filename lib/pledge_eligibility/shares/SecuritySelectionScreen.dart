import 'dart:io';

import 'package:lms/approved_securities/ApprovedSecuritiesScreen.dart';
import 'package:lms/lender/LenderBloc.dart';
import 'package:lms/network/requestbean/SecuritiesRequest.dart';
import 'package:lms/network/responsebean/DematAcResponse.dart';
import 'package:lms/network/responsebean/SecuritiesResponseBean.dart';
import 'package:lms/pledge_eligibility/mutual_fund/IsinDetailBloc.dart';
import 'package:lms/pledge_eligibility/shares/DetailViewDialogScreen.dart';
import 'package:lms/shares/LoanApplicationBloc.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/ErrorMessageWidget.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/LoadingWidget.dart';
import 'package:lms/widgets/NoDataWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';

import 'ViewVaultDetailsViewScreen.dart';

class SecuritySelectionScreen extends StatefulWidget {
  List<DematAc>? dematAcList;

  SecuritySelectionScreen(this.dematAcList);

  @override
  SecuritySelectionScreenState createState() => SecuritySelectionScreenState();
}

class SecuritySelectionScreenState extends State<SecuritySelectionScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget appBarTitle = new Text("Pledge Securities", style: mediumTextStyle_18_gray_dark);
  Icon actionIcon = new Icon(Icons.search, color: appTheme, size: 25);
  TextEditingController _textController = TextEditingController();
  bool? isDefaultBottomDialog = true;
  bool? isEligibleBottomDialog = false;
  List<bool> isAddBtnSelected = [];
  List<bool> isAddQtyEnable = [];
  List<FocusNode> focusNode = [];
  List<TextEditingController> qtyControllersList = [];
  DematAc? selectedDematAccount;
  bool isToggleOn = false;
  bool showFilter = true;
  bool isDematChoice = false;
  List<DropdownMenuItem<DematAc>>? _dropDownDematAccount;
  List<LenderInfo> lenderInfo = [];
  FocusNode focusNodes = FocusNode();

  List<String> lenderList = [];
  List<String> levelList = [];
  List selectedLenderList = [];
  List selectedLevelList = [];
  List<bool> selectedBoolLenderList = [];
  List<bool> selectedBoolLevelList = [];
  final lenderBloc = LenderBloc();
  final loanApplicationBloc = LoanApplicationBloc();
  List<SecuritiesListData> showSecurityList = [];
  List<SecuritiesListData> securityListAfterFilter = [];
  List<SecuritiesListData> distinctSecurityList = [];
  List<String>? stockAt;
  List<SecuritiesListData> holdingSecurityList = [];
  List<SecuritiesListData> holdingSecurityListForSearch = [];
  double securityValue = 0.0;
  double eligibleLoan = 0.0;
  IsinDetailBloc isinDetailBloc = IsinDetailBloc();
  bool isBottomSheetVisible = true;

  @override
  void initState() {
    _dropDownDematAccount = getDropDownFormatMenuItems();
    getDetails();
    super.initState();
  }

  getDetails() {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        // LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
        lenderBloc.getLenders().then((value) {
          if (value.isSuccessFull!) {
            for (int i = 0; i < value.lenderData!.length; i++) {
              lenderList.add(value.lenderData![i].name!);
              selectedLenderList.add(value.lenderData![i].name!);
              selectedBoolLenderList.add(true);
              levelList.addAll(value.lenderData![0].levels!);
              value.lenderData![0].levels!.forEach((element) {
                selectedLevelList.add(element.toString().split(" ")[1]);
                selectedBoolLevelList.add(true);
              });
            }

            loanApplicationBloc.getSecurities(SecuritiesRequest(
                lender: selectedLenderList.join(","),
                level: selectedLevelList.join(","),
                demat: widget.dematAcList!.length == 1 ? widget.dematAcList![0].stockAt : "")).then((value) {
              if (value.isSuccessFull!) {
                if(widget.dematAcList!.length != 1){
                  for (var i = 0; i < value.securityData!.securities!.length; i++) {
                    if (value.securityData!.securities![i].price != 0.0) {
                      securityListAfterFilter.add(value.securityData!.securities![i]);
                      distinctSecurityList.add(value.securityData!.securities![i]);
                      qtyControllersList.add(TextEditingController());
                      isAddBtnSelected.add(true);
                      isAddQtyEnable.add(false);
                      focusNode.add(FocusNode());
                    }
                  }
                } else {
                  isToggleOn = true;
                  selectedDematAccount = widget.dematAcList![0];
                  setState(() {
                    for (var i = 0; i < value.securityData!.securities!.length; i++) {
                      if (value.securityData!.securities![i].price != 0.0 && value.securityData!.securities![i].isEligible!) {
                        securityListAfterFilter.add(value.securityData!.securities![i]);
                        holdingSecurityList.add(value.securityData!.securities![i]);
                        holdingSecurityListForSearch.add(value.securityData!.securities![i]);
                        qtyControllersList.add(TextEditingController());
                        isAddBtnSelected.add(true);
                        isAddQtyEnable.add(false);
                        focusNode.add(FocusNode());
                      }
                    }
                  });
                }
                lenderInfo.addAll(value.securityData!.lenderInfo!);
                setState(() {});
              } else if (value.errorCode == 403) {
                commonDialog(context, Strings.session_timeout, 4);
              } else if(value.errorCode == 500){
                setState(() {
                  isBottomSheetVisible = false;
                });
              } else {
                Utility.showToastMessage(value.errorMessage!);
              }
            });
          } else if (value.errorCode == 403) {
            Navigator.pop(context);
            commonDialog(context, Strings.session_timeout, 4);
          } else if (value.errorCode == 404) {
            Navigator.pop(context);
            commonDialog(context, Strings.not_fetch, 0);
          } else {
            Navigator.pop(context);
            Utility.showToastMessage(value.errorMessage!);
          }
        });
      }else{
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: colorBg,
      appBar: buildBar(context),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: securitySelectionBody(),
      ),
    );
  }

  Widget securitySelectionBody() {
    return NestedScrollView(
      physics: NeverScrollableScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height : 0.5),
            ]),
          )
        ];
      },
      body: Column(
        children: <Widget>[
          Column(
            children: [
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: colorWhite,
                ),
                child: Row(
                  children: [
                    dematDropdown(),
                    SizedBox(width: 20),
                    isBottomSheetVisible ? levelLenderFilter() : Container(),
                    // myHoldingToggle(),
                  ],
                ),
              ),
              // SizedBox(height: 4),
              // Padding(
              //   padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
              //   child: Row(
              //     children: [
              //       Expanded(child: SizedBox()),
              //       levelLenderFilter(),
              //     ],
              //   ),
              // ),
              SizedBox(height: 4),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: schemesListBuilder(),
            ),
          ),
          isBottomSheetVisible ?
          isDefaultBottomDialog! ? bottomSheetDialog()
              : eligibleLimitViewVaultDialog() : SizedBox(),
        ],
      ),
    );
  }

  schemesListBuilder() {
    return StreamBuilder(
      stream: loanApplicationBloc.getSchemesList,
      builder: (context, AsyncSnapshot<SecuritiesResponseBean> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.securityData == null || snapshot.data!.securityData!.securities!.length == 0) {
              return NoDataWidget();
          } else {
            showSecurityList = snapshot.data!.securityData!.securities!;
            return securitiesList();
          }
        } else if (snapshot.hasError) {
          if (snapshot.error == "403") {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              commonDialog(context, Strings.session_timeout, 4);
            });
            return ErrorMessageWidget(error: "");
          } else if(snapshot.error == "404"){
            isBottomSheetVisible = false;
            return noSecurityWidget();
          } else {
            return ErrorMessageWidget(error: snapshot.error.toString());
          }
        } else {
          return Column(
            children: [
              SizedBox(height: 60),
              LoadingWidget(),
            ],
          );
        }
      },
    );
  }

  noSecurityWidget(){
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: appTheme, width: 1.0), // set border width
          borderRadius: BorderRadius.all(Radius.circular(10.0)), // set rounded corner radius
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: "Seems like there are no securities in your DEMAT holding. Let's fill them up with a variety of securities from the Lender’s ",
                style: semiBoldTextStyle_18_gray_dark,
                children: [
                  TextSpan(
                    text: "Approved List.",
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        Utility.isNetworkConnection().then((isNetwork) {
                          if (isNetwork) {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (BuildContext context) => ApprovedSecuritiesScreen()));
                          } else {
                            Utility.showToastMessage(Strings.no_internet_message);
                          }
                        });
                      },
                  ),
                ],
              ),
            ),
            RichText(
              text: TextSpan(
                text: "\nStart investing now: ",
                style: semiBoldTextStyle_18_gray_dark,
                children: [
                  TextSpan(
                    text: "Choice FinX",
                    style: TextStyle(color: Colors.blue),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () async {
                        Utility.isNetworkConnection().then((isNetwork) {
                          if (isNetwork) {
                            if(Platform.isAndroid) {
                              Utility.launchURL(Constants.jiffyPlayStore);
                            }else{
                              Utility.launchURL(Constants.jiffyAppStore);
                            }
                          } else {
                            Utility.showToastMessage(Strings.no_internet_message);
                          }
                        });
                      },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget dematDropdown() {
    return Expanded(
      flex: 5,
      child: Container(
        child: widget.dematAcList!.length != 1 ? DropdownButton<DematAc>(
          isExpanded: true,
          value: selectedDematAccount,
          hint: Text("Demat Account"),
          icon: Image.asset(AssetsImagePath.down_arrow, height: 15, width: 15),
          elevation: 8,
          onChanged: changedDropDownFormatItem,
          items: _dropDownDematAccount,
        ) : Text(encryptAcNo(widget.dematAcList![0].stockAt.toString()), style: extraBoldTextStyle_18),
      ),
    );
  }

  List<DropdownMenuItem<DematAc>> getDropDownFormatMenuItems() {
    List<DropdownMenuItem<DematAc>> items = [];
    for (DematAc status in widget.dematAcList!) {
      items.add(DropdownMenuItem(value: status,
          child: Text(status.stockAt!, style: regularTextStyle_14_gray)),
      );
    }
    return items;
  }


  void changedDropDownFormatItem(DematAc? selectedStatus) {
    if(selectedDematAccount != selectedStatus){
      selectedLenderList.clear();
      selectedLevelList.clear();
      selectedBoolLevelList.clear();
      selectedLenderList.addAll(lenderList);
      levelList.forEach((element) {
        selectedLevelList.add(element.split(" ")[1]);
        selectedBoolLevelList.add(true);
      });
      securityValue = 0;
      eligibleLoan = 0;
      selectedDematAccount = selectedStatus;
      if(selectedStatus!.isChoice == 1) {
        LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
        _handleSearchEnd();
        isBottomSheetVisible = true;
        loanApplicationBloc.getSecurities(SecuritiesRequest(
            lender: selectedLenderList.join(","),
            level: selectedLevelList.join(","),
            demat: selectedDematAccount!.stockAt)).then((value) {
          Navigator.pop(context);
          if (value.isSuccessFull!) {
            isToggleOn = true;
            qtyControllersList.clear();
            isAddBtnSelected.clear();
            isAddQtyEnable.clear();
            securityListAfterFilter.clear();
            holdingSecurityList.clear();
            setState(() {
              for (var i = 0; i < value.securityData!.securities!.length; i++) {
                if (value.securityData!.securities![i].price != 0.0 && value.securityData!.securities![i].isEligible!) {
                  securityListAfterFilter.add(value.securityData!.securities![i]);
                  holdingSecurityList.add(value.securityData!.securities![i]);
                  holdingSecurityListForSearch.add(value.securityData!.securities![i]);
                  qtyControllersList.add(TextEditingController());
                  isAddBtnSelected.add(true);
                  isAddQtyEnable.add(false);
                  focusNode.add(FocusNode());
                }
              }
              print("distinct list toggle--> ${distinctSecurityList.length}");
            });
          } else if (value.errorCode == 403) {
            commonDialog(context, Strings.session_timeout, 4);
          } else if(value.errorCode == 404){
            setState((){
              isBottomSheetVisible = false;
            });
          } else {
            Utility.showToastMessage(value.errorMessage!);
          }
        });
      } else {
        setState(() {
          isToggleOn = false;
          _handleSearchEnd();
          print("distinct list toggle--> ${distinctSecurityList.length}");
          securityListAfterFilter.clear();
          showSecurityList.clear();
          qtyControllersList.clear();
          isAddBtnSelected.clear();
          isAddQtyEnable.clear();
          focusNode.clear();
          distinctSecurityList.forEach((i) {
            securityListAfterFilter.add(i);
            showSecurityList.add(i);
            qtyControllersList.add(TextEditingController());
            isAddBtnSelected.add(true);
            isAddQtyEnable.add(false);
            focusNode.add(FocusNode());
          });
        });
      }
    }
  }

  Widget myHoldingToggle() {
    return Expanded(
      child: GestureDetector(
        child: Row(
          children: [
            Text('My Holdings', style: semiBoldTextStyle_14),
            SizedBox(width: 4),
            Container(
              child: AbsorbPointer(
                absorbing: selectedDematAccount != null && selectedDematAccount!.isChoice == 1 ? false : true,
                child: FlutterSwitch(
                  value: isToggleOn ? true : false,
                  activeColor: colorWhite,
                  inactiveColor: colorWhite,
                  width: 35.0,
                  height: 19.0,
                  toggleSize: 15.0,
                  borderRadius: 30.0,
                  padding: 2.0,
                  toggleColor: colorWhite,
                  switchBorder: Border.all(color: appTheme, width: 3.0),
                  toggleBorder: Border.all(color: appTheme, width: 2.5),
                  onToggle: (val) {
                    Utility.isNetworkConnection().then((isNetwork) {
                      if (isNetwork) {
                        setState(() {
                          isToggleOn = val;
                          securityValue = 0;
                          eligibleLoan = 0;
                          _handleSearchEnd();
                          if(val){
                            isToggleOn = true;
                            selectedLenderList.clear();
                            selectedLevelList.clear();
                            selectedBoolLevelList.clear();
                            selectedLenderList.addAll(lenderList);
                            levelList.forEach((element) {
                              selectedLevelList.add(element.split(" ")[1]);
                              selectedBoolLevelList.add(true);
                            });
                            showSecurityList.clear();
                            securityListAfterFilter.clear();
                            qtyControllersList.clear();
                            isAddBtnSelected.clear();
                            isAddQtyEnable.clear();
                            focusNode.clear();
                            holdingSecurityList.forEach((i) {
                              securityListAfterFilter.add(i);
                              showSecurityList.add(i);
                              qtyControllersList.add(TextEditingController());
                              isAddBtnSelected.add(true);
                              isAddQtyEnable.add(false);
                              focusNode.add(FocusNode());
                            });
                          } else {
                            isToggleOn = false;
                            selectedLenderList.clear();
                            selectedLevelList.clear();
                            selectedBoolLevelList.clear();
                            selectedLenderList.addAll(lenderList);
                            levelList.forEach((element) {
                              selectedLevelList.add(element.split(" ")[1]);
                              selectedBoolLevelList.add(true);
                            });
                            securityListAfterFilter.clear();
                            showSecurityList.clear();
                            qtyControllersList.clear();
                            isAddBtnSelected.clear();
                            isAddQtyEnable.clear();
                            focusNode.clear();
                            distinctSecurityList.forEach((i) {
                              securityListAfterFilter.add(i);
                              showSecurityList.add(i);
                              qtyControllersList.add(TextEditingController());
                              isAddBtnSelected.add(true);
                              isAddQtyEnable.add(false);
                              focusNode.add(FocusNode());
                            });
                            print("toggle off distinct list--> ${distinctSecurityList.length}");
                          }
                        });
                      }else{
                        Utility.showToastMessage(Strings.no_internet_message);
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget securitiesList() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 0, right: 10, bottom: 120),
      child: ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: showSecurityList.length,
        itemBuilder: (context, index) {

          int actualIndex = securityListAfterFilter.indexWhere((element) => element.scripName == showSecurityList[index].scripName);

          return Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            decoration: BoxDecoration(
              color: colorWhite,
              border: Border.all(color: Colors.white, width: 3.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(showSecurityList[index].scripName!, style: boldTextStyle_18),
                  SizedBox(height: 4),
                  Row(
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
                                    scripsValueText("₹${showSecurityList[index].price!.toStringAsFixed(2)}"),
                                    SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: isToggleOn ? Text("${showSecurityList[index].totalQty!.toInt()} QTY", style: mediumTextStyle_12_gray) : Container()
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        isAddBtnSelected[actualIndex] ? addSecuritiesBtn(index, actualIndex): increaseDecreaseSecurities(index, actualIndex),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Stack(
                              children: <Widget>[
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
                                    child: showSecurityList[index].amcImage != null && showSecurityList[index].amcImage!.isNotEmpty
                                        ? CircleAvatar(backgroundImage: NetworkImage(showSecurityList[index].amcImage!),backgroundColor: colorRed, radius: 50.0)
                                        : Text(getInitials(showSecurityList[index].scripName, 1), style: extraBoldTextStyle_30),
                                    // Text(getInitials(showSecurityList[index].scripName, 1), style: extraBoldTextStyle_30),
                                    // : Text(schemesList[index].amcCode!, style: extraBoldTextStyle_30),
                                  ), //Container ,
                                ), //Container
                                Positioned(
                                  top: 51,
                                  left: 4,
                                  height: 22,
                                  width: 68,
                                  child: Container(
                                    width: 68,
                                    child: Material(
                                      color: colorBg,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(35),
                                          side: BorderSide(color: red)),
                                      elevation: 1.0,
                                      child: MaterialButton(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                        minWidth: MediaQuery.of(context).size.width,
                                        onPressed: () {
                                          setState(() {
                                            Utility.isNetworkConnection().then((isNetwork) {
                                              if (isNetwork) {
                                                FocusScope.of(context).unfocus();
                                                LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
                                                isinDetailBloc.isinDetails(showSecurityList[index].iSIN.toString()).then((value) async {
                                                  Navigator.pop(context);
                                                  if(value.isSuccessFull!){
                                                    showSecurityList[index].quantity = qtyControllersList[actualIndex].text.isNotEmpty ? double.parse(qtyControllersList[actualIndex].text) : 0;
                                                    securityListAfterFilter[actualIndex].quantity = qtyControllersList[actualIndex].text.isNotEmpty ? double.parse(qtyControllersList[actualIndex].text) : 0;
                                                    // showSecurityList[index].securityValue = securityValue;
                                                    // showSecurityList[index].eligibleLoan = eligibleLoan;
                                                    List<SecuritiesListData> selectedSecurityList = [];
                                                    for(int i=0; i<showSecurityList.length;i++){
                                                      if(!isAddBtnSelected[i]){
                                                        showSecurityList[i].quantity = double.parse(qtyControllersList[i].text.toString());
                                                        selectedSecurityList.add(showSecurityList[i]);
                                                      }
                                                    }
                                                    print("length of list --> ${selectedSecurityList.length}");

                                                    List<SecuritiesListData> securityList = await showModalBottomSheet(
                                                      isScrollControlled: true,
                                                      enableDrag: false,
                                                      backgroundColor: Colors.transparent,
                                                      context: context,
                                                      builder: (BuildContext bc) {
                                                        return DetailViewDialog(selectedSecurityList, holdingSecurityList, showSecurityList[index], value.data!.isinDetails, selectedDematAccount, lenderInfo, qtyControllersList[actualIndex].text.toString(), isToggleOn);
                                                      },
                                                    );
                                                    updateQuantity(securityList);
                                                  }else if (value.errorCode == 403) {
                                                    commonDialog(context, Strings.session_timeout, 4);
                                                  } else {
                                                    Utility.showToastMessage(value.errorMessage!);
                                                  }
                                                });
                                              } else {
                                                Utility.showToastMessage(Strings.no_internet_message);
                                              }
                                            });
                                          });
                                        },
                                        child: Text(
                                          "Details",
                                          style: TextStyle(
                                              color: red,
                                              fontSize: 10,
                                              fontWeight: bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ) //Container
                              ], //<Widget>[]
                            ), //Stack
                          ],
                        ),
                      ],
                  ),
                  // lenderListUI()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget increaseDecreaseSecurities(index, actualIndex) {
    return Visibility(
        visible: isAddQtyEnable[actualIndex],
        child: Column(
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
                        int txt = qtyControllersList[actualIndex].text.isNotEmpty ? int.parse(qtyControllersList[actualIndex].text) - 1 : 0;
                        qtyControllersList[actualIndex].text = txt.toString();
                        setState(() {
                          if(int.parse(qtyControllersList[actualIndex].text) < 1){
                            txt = 0;
                            showSecurityList[index].quantity = 0;
                            securityListAfterFilter[actualIndex].quantity = 0;
                            qtyControllersList[actualIndex].text = "0";
                            isAddBtnSelected[actualIndex] = true;
                            isAddQtyEnable[actualIndex] = false;
                          }else{
                            isAddBtnSelected[actualIndex] = false;
                            isAddQtyEnable[actualIndex] = true;
                            showSecurityList[index].quantity = double.parse(txt.toString());
                            securityListAfterFilter[actualIndex].quantity = double.parse(txt.toString());
                          }
                          securityAndELValue();
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
                    controller: qtyControllersList[actualIndex],
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(counterText: ""),
                      focusNode: focusNode[actualIndex],
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                      ],
                      style: boldTextStyle_18,
                      onChanged: (value) {
                        setState(() {
                          if(!isAddBtnSelected[actualIndex]){
                            if(qtyControllersList[actualIndex].text.toString().isNotEmpty) {
                              if (int.parse(qtyControllersList[actualIndex].text.toString()) >= 1) {
                                double txt = double.parse(qtyControllersList[actualIndex].text.toString());
                                if(isToggleOn && txt > securityListAfterFilter[actualIndex].totalQty!){
                                  FocusScope.of(context).unfocus();
                                  Utility.showToastMessage("Please check your available quantity");
                                  qtyControllersList[actualIndex].text = showSecurityList[index].totalQty!.toInt().toString();
                                  txt = showSecurityList[index].totalQty!;
                                  showSecurityList[index].quantity = txt;
                                  securityListAfterFilter[actualIndex].quantity = txt;
                                  securityAndELValue();
                                }else{
                                  isAddBtnSelected[actualIndex] = false;
                                  isAddQtyEnable[actualIndex] = true;
                                  showSecurityList[index].quantity = txt;
                                  securityListAfterFilter[actualIndex].quantity = txt;
                                  securityAndELValue();
                                }
                              }
                            }else if(qtyControllersList[actualIndex].text.toString() == " " || qtyControllersList[actualIndex].text.toString().isEmpty || int.parse(qtyControllersList[actualIndex].text.toString()) < 1){
                              focusNode[actualIndex].addListener(() {
                                if(qtyControllersList[actualIndex].text.toString() == " " || qtyControllersList[actualIndex].text.toString().isEmpty || int.parse(qtyControllersList[actualIndex].text.toString()) < 1) {
                                  if (focusNode[actualIndex].hasFocus) {
                                    focusNode[actualIndex].requestFocus();
                                  }else{
                                    focusNode[actualIndex].unfocus();
                                    isAddBtnSelected[actualIndex] = true;
                                    isAddQtyEnable[actualIndex] = false;
                                    securityAndELValue();
                                  }
                                }
                              });
                            }
                          }
                        });
                      }),
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
                        setState(() {
                        int? txt;
                        if(qtyControllersList[actualIndex].text.isNotEmpty && isToggleOn && double.parse(qtyControllersList[actualIndex].text) >= securityListAfterFilter[actualIndex].totalQty!){
                            txt = int.parse(qtyControllersList[actualIndex].text);
                            Utility.showToastMessage("Please check your available quantity");
                        }else{
                          txt = qtyControllersList[actualIndex].text.isNotEmpty ? int.parse(qtyControllersList[actualIndex].text) + 1 : 0;
                        }
                          qtyControllersList[actualIndex].text = txt.toString();
                          showSecurityList[index].quantity = double.parse(txt.toString());
                          securityListAfterFilter[actualIndex].quantity = double.parse(txt.toString());
                          securityAndELValue();
                        });
                      } else {
                        Utility.showToastMessage(Strings.no_internet_message);
                      }
                    });
                  },
                ),
              ],
            ),
          ],
        ));
  }

  Widget addSecuritiesBtn(index, actualIndex) {
    return Visibility(
        visible: isAddBtnSelected[actualIndex],
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
                      isAddQtyEnable[actualIndex] = true;
                      isAddBtnSelected[actualIndex] = false;
                      qtyControllersList[actualIndex].text ="1";
                      showSecurityList[index].quantity = double.parse(qtyControllersList[actualIndex].text);
                      securityListAfterFilter[actualIndex].quantity = double.parse(qtyControllersList[actualIndex].text);
                      securityAndELValue();
                      print("total value ${securityValue.toString()}");
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

  securityAndELValue(){
    securityValue = 0;
    eligibleLoan = 0;
    for (int i = 0; i < securityListAfterFilter.length; i++) {
        if(!isAddBtnSelected[i]) {
        securityValue += securityListAfterFilter[i].price! *  (qtyControllersList[i].text.isNotEmpty ? double.parse(qtyControllersList[i].text.toString()) : 0);
        eligibleLoan += (securityListAfterFilter[i].price! * (qtyControllersList[i].text.isNotEmpty ? double.parse(qtyControllersList[i].text.toString()) : 0) * securityListAfterFilter[i].eligiblePercentage!) / 100;
      }
    }
  }

  Widget levelLenderFilter(){
    return Visibility(
      visible: !(isToggleOn && holdingSecurityList.length == 0),
      child: Expanded(
        flex: 2,
        child: GestureDetector(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Text(Strings.filter, style: regularTextStyle_14),
              // SizedBox(width: 4),
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
    );
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
                                  List previousLevelList = [];
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
                                      isBottomSheetVisible = true;
                                      loanApplicationBloc.getSecurities(SecuritiesRequest(
                                          lender: selectedLenderList.join(","),
                                          level: selectedLevelList.join(","),
                                          demat: widget.dematAcList!.length == 1 ? widget.dematAcList![0].stockAt : selectedDematAccount != null ? selectedDematAccount!.stockAt : ""
                                        // demat: selectedDematAccount != null ? isToggleOn ? selectedDematAccount!.stockAt : "" : ""
                                      )).then((value) {
                                        Navigator.pop(context);
                                        if (value.isSuccessFull!) {
                                          qtyControllersList.clear();
                                          isAddBtnSelected.clear();
                                          isAddQtyEnable.clear();
                                          securityListAfterFilter.clear();
                                          securityListAfterFilter.addAll(value.securityData!.securities!);
                                          securityListAfterFilter.forEach((element) {
                                            qtyControllersList.add(TextEditingController());
                                            isAddBtnSelected.add(true);
                                            isAddQtyEnable.add(false);
                                          });
                                          setState(() {
                                            securityValue = 0;
                                            eligibleLoan = 0;
                                          });
                                        } else if(value.errorCode == 404){
                                          setState((){
                                            isBottomSheetVisible = false;
                                          });
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


  Widget lenderListUI() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: Image.asset(
            AssetsImagePath.lender_choice_finserv,
            height: 24,
            width: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        IconButton(
          icon: Image.asset(AssetsImagePath.lender_bajaj_finance,
              height: 24, width: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        IconButton(
          icon: Image.asset(AssetsImagePath.lender_tata_capital,
              height: 24, width: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        )
      ],
    );
  }

  Widget bottomSheetDialog() {
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
                          Expanded(
                            child: Text(
                              Strings.security_value,
                              style: mediumTextStyle_18_gray,
                            ),
                          ),
                          Text(
                            "₹${numberToString(securityValue.toStringAsFixed(2))}",
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
                              child: Text(
                            Strings.eligible_loan_amount_small,
                            style: mediumTextStyle_18_gray,
                          )),
                          Text("₹${numberToString(eligibleLoan.toStringAsFixed(2))}", style: textStyleGreenStyle_18)
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
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      elevation: 1.0,
                      color: securityValue != 0 ? appTheme : colorLightGray,
                      child: AbsorbPointer(
                        absorbing: securityValue != 0 ? false : true,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                onViewVaultClick();
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

  Widget eligibleLimitViewVaultDialog() {
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
                          Expanded(child: Text("₹${numberToString(eligibleLoan.toStringAsFixed(2))}", style: textStyleGreenStyle_18)),
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(35)),
                            elevation: 1.0,
                            color: securityValue != 0 ? appTheme : colorLightGray,
                            child: AbsorbPointer(
                              absorbing: securityValue != 0 ? false : true,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  Utility.isNetworkConnection().then((isNetwork) {
                                    if (isNetwork) {
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

  onViewVaultClick() async {
    if(selectedDematAccount != null){
      _handleSearchEnd();
      List<SecuritiesListData> selectedSecurityList = [];
      for(int i=0; i<showSecurityList.length;i++){
        if(!isAddBtnSelected[i]){
          showSecurityList[i].quantity = double.parse(qtyControllersList[i].text.toString());
          selectedSecurityList.add(showSecurityList[i]);
        }
      }
      print("length of list --> ${selectedSecurityList.length}");
      List<SecuritiesListData> securityList = await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => ViewVaultDetailsViewScreen(selectedSecurityList, holdingSecurityList, selectedDematAccount, lenderInfo, isToggleOn)));
      updateQuantity(securityList);
    } else {
      commonDialog(context, "Please select a Demat Account Number", 0);
    }
  }


  updateQuantity(List<SecuritiesListData> securityList){
    for(int i=0; i<showSecurityList.length; i++){
      printLog("i => $i");
      String index = "null";
      double qty = 0;
      securityList.forEach((element) {
        if(element.iSIN == showSecurityList[i].iSIN){
          index = i.toString();
          qty = element.quantity!;
        }
      });
      setState(() {
        if(index != "null"){
          showSecurityList[i].quantity = qty;
          qtyControllersList[i].text = qty.toInt().toString();
          if(showSecurityList[i].quantity! <= 0){
            isAddBtnSelected[i] = true;
            isAddQtyEnable[i] = false;
          } else {
            isAddBtnSelected[i] = false;
            isAddQtyEnable[i] = true;
          }
        } else {
          showSecurityList[i].quantity = 0;
          qtyControllersList[i].text = "0";
          isAddBtnSelected[i] = true;
          isAddQtyEnable[i] = false;
        }
      });
    }
    securityAndELValue();
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
          child: isBottomSheetVisible ? IconButton(
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
                    focusNode: focusNodes,
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
                    onChanged: (value) => loanApplicationBloc.securitySearch(securityListAfterFilter, value, true),
                  );
                  focusNodes.requestFocus();
                } else {
                  focusNodes.unfocus();
                  _handleSearchEnd();
                }
              });
            },
          ) : Container(),
        ),
      ],
    );
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = Icon(Icons.search, color: appTheme, size: 25);
      this.appBarTitle = Text(
        Strings.eligibility,
        style: mediumTextStyle_18_gray_dark,
      );
      _textController.clear();
      // if(isToggleOn){
      loanApplicationBloc.securitySearch(showSecurityList, "", true);
      showSecurityList.clear();
      showSecurityList.addAll(securityListAfterFilter);
      // }else{
      //   loanApplicationBloc.securitySearch(showSecurityList, "", true);
      //   showSecurityList.clear();
      //   showSecurityList.addAll(securityListAfterFilter);
      // }
    });
  }

}
