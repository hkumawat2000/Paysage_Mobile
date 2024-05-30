import 'dart:convert';
import 'package:lms/lender/LenderBloc.dart';
import 'package:lms/network/requestbean/MFSchemeRequest.dart';
import 'package:lms/network/requestbean/MyCartRequestBean.dart';
import 'package:lms/network/responsebean/MFSchemeResponse.dart';
import 'package:lms/pledge_eligibility/mutual_fund/MFSchemeBloc.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/ErrorMessageWidget.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/LoadingWidget.dart';
import 'package:lms/widgets/NoDataWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'IsinDetailDao.dart';
import 'MF_DetailViewDialogScreen.dart';
import 'MF_ViewVaultDetailsViewScreen.dart';
import 'dart:math' as math;

class MFSchemeSelectionScreen extends StatefulWidget {
  @override
  MFSchemeSelectionScreenState createState() => MFSchemeSelectionScreenState();
}

class MFSchemeSelectionScreenState extends State<MFSchemeSelectionScreen> {
  Widget appBarTitle = new Text("", style: mediumTextStyle_18_gray_dark);
  Icon actionIcon = new Icon(Icons.search, color: appTheme, size: 25);
  TextEditingController _textController = TextEditingController();
  bool? isDefaultBottomDialog = true;
  bool? isEligibleBottomDialog = false;
  List<bool> isAddBtnSelected = [];
  List<bool> isAddQtyEnable = [];
  String _currentMutualFundOption = Strings.equity;
  List<String> selectedLenderList = [];
  List<String> selectedLevelList = [];
  List<bool> selectedBoolLenderList = [];
  List<bool> selectedBoolLevelList = [];
  List<String> lenderList = [];
  List<String> levelList = [];
  List<DropdownMenuItem<String>>? _dropDownMutualFund;
  final lenderBloc = LenderBloc();
  final mFSchemeBloc = MFSchemeBloc();
  List<SchemesList> schemesListAfterFilter = [];
  List<TextEditingController> unitControllersList = [];
  List mutualFundList = [Strings.equity, Strings.debt];
  IsinDetailDao isinDetailDao = IsinDetailDao();
  bool isSchemeSelect = true;
  List<SchemesList> schemesList = [];
  List<FocusNode> focusNode = [];
  double schemeValue = 0.0;
  double eligibleLoanAmount = 0.0;
  FocusNode searchFocusNode = FocusNode();
  ScrollController _scrollController = new ScrollController();

  List<DropdownMenuItem<String>> getDropDownFormatMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String status in mutualFundList) {
      items.add(
        DropdownMenuItem(
          value: status,
          child: Text(
            status,
            style: regularTextStyle_14_gray,
          ),
        ),
      );
    }
    return items;
  }

  scrollUp(){
    if(_scrollController.position.pixels != _scrollController.position.minScrollExtent) {
      _scrollController.animateTo(_scrollController.position.minScrollExtent,
          duration: Duration(milliseconds: 700), curve: Curves.fastOutSlowIn);
    }
  }

  void changedDropDownMutualFund(String? selectedStatus) {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if(_currentMutualFundOption != selectedStatus){
          setState(() {
            _currentMutualFundOption = selectedStatus!;
            LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
            scrollUp();
            selectedLenderList.clear();
            selectedLevelList.clear();
            selectedBoolLevelList.clear();
            selectedLenderList.addAll(lenderList);
            levelList.forEach((element) {
              selectedLevelList.add(element.split(" ")[1]);
              selectedBoolLevelList.add(true);
            });
            _handleSearchEnd();
            mFSchemeBloc.getSchemesList(MFSchemeRequest(_currentMutualFundOption,
                selectedLenderList.join(","), selectedLevelList.join(","))).then((value) {
              if (value.isSuccessFull!) {
                schemesListAfterFilter.clear();
                isAddBtnSelected.clear();
                unitControllersList.clear();
                focusNode.clear();
                isAddQtyEnable.clear();
                schemesListAfterFilter.addAll(value.mFSchemeData!.schemesList!);
                schemesListAfterFilter.forEach((element) {
                  isAddBtnSelected.add(true);
                  unitControllersList.add(TextEditingController());
                  focusNode.add(FocusNode());
                  isAddQtyEnable.add(false);
                });
                setState(() {
                  schemeValue = 0.0;
                  eligibleLoanAmount = 0.0;
                });
                Navigator.pop(context);
              } else {
                Navigator.pop(context);
                Utility.showToastMessage(value.errorMessage!);
              }
            });
          });
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  @override
  void initState() {
    appBarTitle = Text(
      Strings.eligibility,
      style: mediumTextStyle_18_gray_dark,
    );
    _dropDownMutualFund = getDropDownFormatMenuItems();
    _scrollController.addListener(() {

    });
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

        mFSchemeBloc.getSchemesList(
            MFSchemeRequest(_currentMutualFundOption, selectedLenderList.join(","),
                selectedLevelList.join(","))).then((value) {
          if (value.isSuccessFull!) {
            schemesListAfterFilter.clear();
            isAddBtnSelected.clear();
            unitControllersList.clear();
            isAddQtyEnable.clear();
            focusNode.clear();
            schemesListAfterFilter.addAll(value.mFSchemeData!.schemesList!);
            schemesListAfterFilter.forEach((element) {
              isAddBtnSelected.add(true);
              unitControllersList.add(TextEditingController());
              isAddQtyEnable.add(false);
              focusNode.add(FocusNode());
            });
          } else {
            Utility.showToastMessage(value.errorMessage!);
          }
        });
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
    super.initState();
  }

  void dispose(){
    focusNode.forEach((focusNode) {
      focusNode.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: colorBg,
        appBar: buildBar(context),
        body: schemeSelectionBody(),
      ),
    );
  }

  schemesListBuilder() {
    return StreamBuilder(
      stream: mFSchemeBloc.getSchemes,
      builder: (context, AsyncSnapshot<MFSchemeResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.mFSchemeData == null ||
              snapshot.data!.mFSchemeData!.schemesList!.length == 0) {
            return NoDataWidget();
          } else {
            schemesList = snapshot.data!.mFSchemeData!.schemesList!;
            return schemesListWidget();
          }
        } else if (snapshot.hasError) {
          if (snapshot.error == "403") {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              commonDialog(context, Strings.session_timeout, 4);
            });
            return ErrorMessageWidget(error: "");
          }
          return ErrorMessageWidget(error: snapshot.error.toString());
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

  Widget schemeSelectionBody() {
    return NestedScrollView(
      physics: NeverScrollableScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height : 0.5
              ),
            ]),
          )
        ];
      },
      body: Column(
        children: <Widget>[
          Padding(
            padding:
            const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                mutualFundDropdown(),
                SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                          return filerDialog();
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: _scrollController,
              child: schemesListBuilder(),
            ),
          ),
          isDefaultBottomDialog!
              ? bottomSheetDialog()
              : eligibleLimitViewVaultDialog()
        ],
      ),
    );
  }

  filerDialog() {
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
                                    scrollUp();
                                    _handleSearchEnd();
                                    mFSchemeBloc.getSchemesList(MFSchemeRequest(_currentMutualFundOption,
                                        selectedLenderList.join(","),
                                        selectedLevelList.join(","))).then((value) {
                                      if (value.isSuccessFull!) {
                                        schemesListAfterFilter.clear();
                                        isAddBtnSelected.clear();
                                        unitControllersList.clear();
                                        isAddQtyEnable.clear();
                                        schemesListAfterFilter.addAll(value.mFSchemeData!.schemesList!);
                                        schemesListAfterFilter.forEach((element) {
                                          isAddBtnSelected.add(true);
                                          unitControllersList.add(TextEditingController());
                                          isAddQtyEnable.add(false);
                                        });
                                        setState(() {
                                          schemeValue = 0.0;
                                          eligibleLoanAmount = 0.0;
                                        });
                                        Navigator.pop(context);
                                      } else {
                                        Navigator.pop(context);
                                        Utility.showToastMessage(value.errorMessage!);
                                      }
                                    });
                                  }
                                }
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

  Widget mutualFundDropdown() {
    return Expanded(
      child: Container(
        child: DropdownButton<String>(
          isExpanded: true,
          value: _currentMutualFundOption,
          icon: Image.asset(AssetsImagePath.down_arrow, height: 15, width: 15),
          elevation: 16,
          onChanged: changedDropDownMutualFund,
          items: _dropDownMutualFund,
        ),
      ),
    );
  }

  Widget schemesListWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, top: 0, right: 10, bottom: 120),
      child: ListView.builder(
        key: Key(schemesList.length.toString()),
        // controller: _scrollController,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: schemesList.length,
        itemBuilder: (context, index) {

          // if (index == schemesList.length) {
          //   return Container(height: MediaQuery.of(context).size.height / 2);
          // }
          int actualIndex = schemesListAfterFilter.indexWhere((element) => element.schemeName == schemesList[index].schemeName);

          return Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text("${schemesList[index].schemeName!}",
                          style: boldTextStyle_18),
                      SizedBox(
                        height: 4,
                      ),
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
                                        scripsValueText(
                                            "₹${schemesList[index].price!.toString()}"),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${isAddBtnSelected[actualIndex] ? "0" : unitControllersList[actualIndex].text.toString().trim()} Units",
                                                style: mediumTextStyle_12_gray,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isAddBtnSelected[actualIndex]
                                ? addSchemesBtn(index, actualIndex)
                                : increaseDecreaseSchemes(index, actualIndex),
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
                                          child: schemesList[index].amcImage != null && schemesList[index].amcImage!.isNotEmpty
                                              ? CircleAvatar(backgroundImage: NetworkImage(schemesList[index].amcImage!),backgroundColor: colorRed, radius: 50.0)
                                              : Text(getInitials(schemesList[index].schemeName, 1), style: extraBoldTextStyle_30),
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
                                                Utility.isNetworkConnection().then((isNetwork) async {
                                                  if (isNetwork) {
                                                    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
                                                    isinDetailDao.isinDetails(schemesList[index].isin.toString()).then((value) async {
                                                      Navigator.pop(context);
                                                      if (value.isSuccessFull!) {
                                                        schemesList[index].units = unitControllersList[actualIndex].text.isNotEmpty ? double.parse(unitControllersList[actualIndex].text) : 0;
                                                        schemesListAfterFilter[actualIndex].units = unitControllersList[actualIndex].text.isNotEmpty ? double.parse(unitControllersList[actualIndex].text) : 0;
                                                        List<SchemesList> selectedSchemeList = [];
                                                        for(int i=0; i<schemesListAfterFilter.length;i++){
                                                          if(!isAddBtnSelected[i]){
                                                            schemesListAfterFilter[i].units = double.parse(unitControllersList[i].text.toString());
                                                            selectedSchemeList.add(schemesListAfterFilter[i]);
                                                          }
                                                        }
                                                        print("length of list --> ${selectedSchemeList.length}");

                                                        List<SchemesList> securityList = await showModalBottomSheet(
                                                          isScrollControlled: true,
                                                          enableDrag: false,
                                                          backgroundColor: Colors.transparent,
                                                          context: context,
                                                          builder: (BuildContext bc) {
                                                            return MF_DetailViewDialog(selectedSchemeList, schemesList[index], value.data!.isinDetails, _currentMutualFundOption, lenderList[0], schemesListAfterFilter, unitControllersList[actualIndex].text.toString());
                                                          },
                                                        );
                                                        // printLog("dialogResult ==> $dialogResult");
                                                        setState(() {
                                                        // if(dialogResult != null) {
                                                        //   if (double.parse(dialogResult.toString()) > 0) {
                                                        //     isAddBtnSelected[actualIndex] = false;
                                                        //     isAddQtyEnable[actualIndex] = true;
                                                        //   } else {
                                                        //     isAddBtnSelected[actualIndex] = true;
                                                        //     isAddQtyEnable[actualIndex] = false;
                                                        //   }
                                                        //   unitControllersList[actualIndex].text = dialogResult.toString();
                                                        //   schemesList[index].units = double.parse(unitControllersList[actualIndex].text);
                                                        //   schemesListAfterFilter[actualIndex].units = double.parse(unitControllersList[actualIndex].text);
                                                        //   updateSchemeValueAndEL();
                                                        // }
                                                          updateQuantity(securityList);
                                                        });
                                                      } else if (value.errorCode == 403) {
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
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   "Scheme Type: ${schemesList[index].schemeType}",
                      //   style: mediumTextStyle_12_gray,
                      // ),
                      // lenderListUI(schemesList[index].lenders!)
                    ],
                  )));
        },
      ),
    );
  }

  Widget increaseDecreaseSchemes(int index, int actualIndex) {
    if (eligibleLoanAmount != 0.0) {
      isSchemeSelect = false;
    } else {
      isSchemeSelect = true;
    }
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
                    border: Border.all(width: 1, color: colorBlack),
                  ),
                  child: Icon(Icons.remove, color: colorBlack, size: 18),
                ),
                onPressed: () async {
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      FocusScope.of(context).unfocus();
                      var txt;
                      if(unitControllersList[actualIndex].text.toString().contains('.') && unitControllersList[actualIndex].text.toString().split(".")[1].length != 0) {
                        var unitsDecimalCount;
                        String str = unitControllersList[actualIndex].text.toString();
                        var qtyArray = str.split('.');
                        unitsDecimalCount = qtyArray[1];
                        if(int.parse(unitsDecimalCount) == 0) {
                          txt = double.parse(unitControllersList[actualIndex].text) - 1;
                          unitControllersList[actualIndex].text = txt.toString();
                        } else {
                          if (unitsDecimalCount.toString().length == 1) {
                            txt = double.parse(unitControllersList[actualIndex].text) - .1;
                            unitControllersList[actualIndex].text = txt.toStringAsFixed(1);
                          } else if (unitsDecimalCount.toString().length == 2) {
                            txt = double.parse(unitControllersList[actualIndex].text) - .01;
                            unitControllersList[actualIndex].text = txt.toStringAsFixed(2);
                          } else {
                            txt = double.parse(unitControllersList[actualIndex].text) - .001;
                            unitControllersList[actualIndex].text = txt.toStringAsFixed(3);
                          }
                        }
                      } else {
                        txt = unitControllersList[actualIndex].text.isNotEmpty ? int.parse(unitControllersList[actualIndex].text.toString().split(".")[0]) - 1 : 0;
                        unitControllersList[actualIndex].text = txt.toString();
                      }
                      setState(() {
                        if (txt >= 0.001) {
                          schemesList[index].units = double.parse(unitControllersList[actualIndex].text);
                          schemesListAfterFilter[actualIndex].units = double.parse(unitControllersList[actualIndex].text);
                        } else {
                          isAddBtnSelected[actualIndex] = true;
                          isAddQtyEnable[actualIndex] = false;
                          schemesList[index].units = 0;
                          unitControllersList[actualIndex].text = "0";
                          schemesListAfterFilter[actualIndex].units = 0;
                        }
                        updateSchemeValueAndEL();
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
                  controller: unitControllersList[actualIndex],
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(counterText: ""),
                  focusNode: focusNode[actualIndex],
                  showCursor: true,
                  keyboardType:
                  TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    DecimalTextInputFormatter(decimalRange: 3),
                    FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,3}')),
                  ],
                  style: boldTextStyle_18,
                  onChanged: (value) {
                    var txt;
                    if(!unitControllersList[actualIndex].text.toString().endsWith(".")){
                      if(value.isNotEmpty && double.parse(value.toString()) >= 0.001){
                        if(double.parse(unitControllersList[actualIndex].text) != 0){
                          setState(() {
                            if(unitControllersList[actualIndex].text.toString().contains('.') && unitControllersList[actualIndex].text.toString().split(".")[1].length != 0) {
                              var unitsDecimalCount;
                              String str = unitControllersList[actualIndex].text.toString();
                              var qtyArray = str.split('.');
                              unitsDecimalCount = qtyArray[1];
                              if(unitsDecimalCount.toString().length > 3) {
                                txt = double.parse(unitControllersList[actualIndex].text);
                                unitControllersList[actualIndex].text = txt.toStringAsFixed(3);
                              }
                            }
                            isAddBtnSelected[actualIndex] = false;
                            isAddQtyEnable[actualIndex] = true;
                            schemesList[index].units = double.parse(unitControllersList[actualIndex].text);
                            schemesListAfterFilter[actualIndex].units = double.parse(unitControllersList[actualIndex].text);
                            updateSchemeValueAndEL();
                          });
                        } else {
                          setState(() {
                            isAddBtnSelected[actualIndex] = true;
                            isAddQtyEnable[actualIndex] = false;
                            updateSchemeValueAndEL();
                          });
                        }
                      } else {
                        if(unitControllersList[actualIndex].text.isEmpty || unitControllersList[actualIndex].text == ".0" || unitControllersList[actualIndex].text == ".00"|| unitControllersList[actualIndex].text == "0" || unitControllersList[actualIndex].text == "0." || unitControllersList[actualIndex].text == "0.0" || unitControllersList[actualIndex].text == "0.00"){
                          focusNode[actualIndex].addListener(() {
                            if(unitControllersList[actualIndex].text.isEmpty || unitControllersList[actualIndex].text == ".0" || unitControllersList[actualIndex].text == ".00" || unitControllersList[actualIndex].text == "0" || unitControllersList[actualIndex].text == "0." || unitControllersList[actualIndex].text == "0.0" || unitControllersList[actualIndex].text == "0.00"){
                              if(focusNode[actualIndex].hasFocus) {
                                focusNode[actualIndex].requestFocus();
                              } else {
                                FocusScope.of(context).unfocus();
                                focusNode[actualIndex].unfocus();
                                isAddBtnSelected[actualIndex] = true;
                                isAddQtyEnable[actualIndex] = false;
                                updateSchemeValueAndEL();
                              }
                            }
                          });
                        } else {
                          setState(() {
                            FocusScope.of(context).unfocus();
                            isAddBtnSelected[actualIndex] = true;
                            isAddQtyEnable[actualIndex] = false;
                            updateSchemeValueAndEL();
                          });
                        }
                      }
                    } else {
                      var value;
                      value = unitControllersList[actualIndex].text;
                      focusNode[actualIndex].addListener(() {
                        if(unitControllersList[actualIndex].text.toString().endsWith('.')){
                          if(focusNode[actualIndex].hasFocus){
                            focusNode[actualIndex].requestFocus();
                          } else {
                            if(value.toString().split(".")[0].isEmpty){
                              isAddBtnSelected[actualIndex] = true;
                              isAddQtyEnable[actualIndex] = false;
                              unitControllersList[actualIndex].text = "0.0";
                              updateSchemeValueAndEL();
                            } else if(unitControllersList[actualIndex].text.toString().endsWith('.')){
                              value = int.parse(unitControllersList[actualIndex].text.toString().split(".")[0]);
                              unitControllersList[actualIndex].text = value.toString();
                            }
                          }
                        }
                      });
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
                    border: Border.all(width: 1, color: colorBlack),
                  ),
                  child: Icon(Icons.add, color: colorBlack, size: 18),
                ),
                onPressed: () async {
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      FocusScope.of(context).unfocus();
                      var txt;
                      if(unitControllersList[actualIndex].text.toString().contains('.') && unitControllersList[actualIndex].text.toString().split(".")[1].length != 0) {
                        var unitsDecimalCount;
                        String str = unitControllersList[actualIndex].text.toString();
                        var qtyArray = str.split('.');
                        unitsDecimalCount = qtyArray[1];
                        if(int.parse(unitsDecimalCount) == 0){
                          txt = double.parse(unitControllersList[actualIndex].text) + 1;
                          unitControllersList[actualIndex].text = txt.toString();
                        } else {
                          if (unitsDecimalCount.toString().length == 1) {
                            txt = double.parse(unitControllersList[actualIndex].text) + .1;
                            unitControllersList[actualIndex].text = txt.toStringAsFixed(1);
                          } else if (unitsDecimalCount.toString().length == 2) {
                            txt = double.parse(unitControllersList[actualIndex].text) + .01;
                            unitControllersList[actualIndex].text = txt.toStringAsFixed(2);
                          } else {
                            txt = double.parse(unitControllersList[actualIndex].text) + .001;
                            unitControllersList[actualIndex].text = txt.toStringAsFixed(3);
                          }
                        }
                      } else {
                        txt = unitControllersList[actualIndex].text.isNotEmpty ? int.parse(unitControllersList[actualIndex].text.toString().split(".")[0]) + 1 : 0;
                        unitControllersList[actualIndex].text = txt.toString();
                      }
                      setState(() {
                        schemesList[index].units = double.parse(unitControllersList[actualIndex].text);
                        schemesListAfterFilter[actualIndex].units = double.parse(unitControllersList[actualIndex].text);
                        updateSchemeValueAndEL();
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
      ),
    );
  }

  Widget addSchemesBtn(int index, int actualIndex) {
    return Visibility(
      visible: isAddBtnSelected[actualIndex],
      child: Container(
        height: 30,
        width: 70,
        child: Material(
          color: appTheme,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          elevation: 1.0,
          child: MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () {
              Utility.isNetworkConnection().then((isNetwork) {
                if (isNetwork) {
                  setState(() {
                    isAddQtyEnable[actualIndex] = true;
                    isAddBtnSelected[actualIndex] = false;
                    unitControllersList[actualIndex].text = "1";
                    schemesList[index].units = double.parse(unitControllersList[actualIndex].text);
                    schemesListAfterFilter[actualIndex].units = double.parse(unitControllersList[actualIndex].text);
                    updateSchemeValueAndEL();
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
      ),
    );
  }

  updateSchemeValueAndEL() {
    schemeValue = 0;
    eligibleLoanAmount = 0;
    for(int i=0; i < schemesListAfterFilter.length; i++) {
      if(unitControllersList[i].text.isEmpty || double.parse(unitControllersList[i].text) == 0) {
        isAddBtnSelected[i] = true;
        isAddQtyEnable[i] = false;
      }
      if(!isAddBtnSelected[i]) {
        schemeValue += schemesListAfterFilter[i].price! * double.parse(unitControllersList[i].text.toString());
        eligibleLoanAmount += schemesListAfterFilter[i].price! * double.parse(unitControllersList[i].text.toString()) * (schemesListAfterFilter[i].ltv! / 100);
      }
    }
  }

  Widget lenderListUI(String lenders) {
    List<String> lenderIconList = lenders.split(",");
    return Center(
      child: Container(
        height: 40,
        child: ListView.builder(
          itemCount: lenderIconList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Image.asset(
                getInitials(lenderIconList[index], 1).toLowerCase() == "c"
                    ? AssetsImagePath.lender_finserv
                    : getInitials(lenderIconList[index], 1).toLowerCase() == "b"
                        ? AssetsImagePath.lender_bajaj_finance
                        : getInitials(lenderIconList[index], 1).toLowerCase() == "t"
                            ? AssetsImagePath.lender_tata_capital
                            : AssetsImagePath.lender_finserv,
                height: 24,
                width: 24,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget bottomSheetDialog() {
    setState(() {
      if (eligibleLoanAmount != 0.0) {
        isSchemeSelect = false;
      } else {
        isSchemeSelect = true;
      }
    });
    return Visibility(
      visible: isDefaultBottomDialog!,
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
                        isDefaultBottomDialog = false;
                        isEligibleBottomDialog = true;
                      });
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(Strings.scheme_value, style: mediumTextStyle_18_gray),
                        ),
                        Text(
                          "₹${numberToString(schemeValue.toStringAsFixed(2))}", style: boldTextStyle_18_gray_dark,
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
                          child: Text(Strings.eligible_loan_amount_small, style: mediumTextStyle_18_gray),
                        ),
                        Text("₹${numberToString(eligibleLoanAmount.toStringAsFixed(2))}", style: textStyleGreenStyle_18)
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
                    color: isSchemeSelect == false ? schemeValue <= 999999999999 ? appTheme : colorLightGray : colorLightGray,
                    child: AbsorbPointer(
                      absorbing: isSchemeSelect,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          Utility.isNetworkConnection().then((isNetwork) async {
                            if (isNetwork) {
                              FocusScope.of(context).unfocus();
                              Securities securities = Securities();
                              List<SecuritiesList> schemeQtyList = [];
                              List<SchemesList> schemesList = [];
                              schemeQtyList.clear();
                              for(int i = 0; i<schemesListAfterFilter.length; i++) {
                                if(!isAddBtnSelected[i]){
                                  schemeQtyList.add(new SecuritiesList(
                                      isin: schemesListAfterFilter[i].isin,
                                      quantity: double.parse(unitControllersList[i].text)),
                                  );
                                  schemesList.add(schemesListAfterFilter[i]);
                                }
                              }
                              securities.list = schemeQtyList;
                              if(schemeValue <= 999999999999){
                                _handleSearchEnd();
                                MyCartRequestBean requestBean =
                                MyCartRequestBean(
                                  securities: securities,
                                  instrumentType: Strings.mutual_fund,
                                  schemeType: _currentMutualFundOption,
                                  loan_margin_shortfall_name: "",
                                  pledgor_boid: "",
                                  cartName: "",
                                  loamName: "",
                                  lender: lenderList[0],
                                );
                                List<SchemesList> securityList = await Navigator.push(context,
                                    MaterialPageRoute(builder: (BuildContext context) => MF_ViewVaultDetailsViewScreen(requestBean, schemesList)));
                                updateQuantity(securityList);
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

  updateQuantity(List<SchemesList> securityList){
    for(int i=0; i<schemesListAfterFilter.length; i++){
      printLog("i => $i");
      String index = "null";
      double qty = 0;
      securityList.forEach((element) {
        if(element.isin == schemesListAfterFilter[i].isin){
          index = i.toString();
          qty = element.units!;
        }
      });
      setState(() {
        if(index != "null"){
          var unitsDecimalCount;
          String str = qty.toString();
          var qtyArray = str.split('.');
          unitsDecimalCount = qtyArray[1];
          if(unitsDecimalCount == "0"){
            schemesListAfterFilter[i].units = qty;
            unitControllersList[i].text = qty.toInt().toString();
          }else{
            schemesListAfterFilter[i].units = qty;
            unitControllersList[i].text = qty.toString();
          }
          if(schemesListAfterFilter[i].units! <= 0){
            isAddBtnSelected[i] = true;
            isAddQtyEnable[i] = false;
          } else {
            isAddBtnSelected[i] = false;
            isAddQtyEnable[i] = true;
          }
        } else {
          schemesListAfterFilter[i].units = 0;
          unitControllersList[i].text = "0";
          isAddBtnSelected[i] = true;
          isAddQtyEnable[i] = false;
        }
      });
    }
    updateSchemeValueAndEL();
  }


  Widget eligibleLimitViewVaultDialog() {
    setState(() {
      if (eligibleLoanAmount == 0.0) {
        isSchemeSelect = true;
      } else {
        isSchemeSelect = false;
      }
    });
    return Visibility(
      visible: isEligibleBottomDialog!,
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
                    icon: Image.asset(AssetsImagePath.up_arrow, height: 15, width: 15),
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
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text("₹${numberToString(eligibleLoanAmount.toStringAsFixed(2))}",
                                style: textStyleGreenStyle_18),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(Strings.eligible_loan_amount_small, style: mediumTextStyle_12_gray)
                              ],
                            ),
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
                          color: isSchemeSelect == false ? schemeValue <= 999999999999 ? appTheme : colorLightGray : colorLightGray,
                          child: AbsorbPointer(
                            absorbing: isSchemeSelect,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                Utility.isNetworkConnection().then((isNetwork) async {
                                  if (isNetwork) {
                                    Securities securities = Securities();
                                    List<SecuritiesList> schemeQtyList = [];
                                    List<SchemesList> schemesList = [];
                                    schemeQtyList.clear();
                                    for(int i = 0; i<schemesListAfterFilter.length; i++){
                                      if(!isAddBtnSelected[i]){
                                        schemeQtyList.add(new SecuritiesList(
                                            isin: schemesListAfterFilter[i].isin,
                                            quantity: double.parse(unitControllersList[i].text))
                                        );
                                        schemesList.add(schemesListAfterFilter[i]);
                                      }
                                    }
                                    securities.list = schemeQtyList;
                                    if(schemeValue <= 999999999999){
                                      _handleSearchEnd();
                                      MyCartRequestBean requestBean =
                                      MyCartRequestBean(
                                        securities: securities,
                                        instrumentType: Strings.mutual_fund,
                                        schemeType: _currentMutualFundOption,
                                        loan_margin_shortfall_name: "",
                                        pledgor_boid: "",
                                        cartName: "",
                                        loamName: "",
                                        lender: lenderList[0],
                                      );
                                      List<SchemesList> securityList = await Navigator.push(context,
                                          MaterialPageRoute(builder: (BuildContext context) => MF_ViewVaultDetailsViewScreen(requestBean, schemesList)));
                                      updateQuantity(securityList);
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
            ],
          ),
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
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        Theme(
          data: theme.copyWith(primaryColor: Colors.white),
          child: IconButton(
            icon: actionIcon,
            onPressed: () {
              if (this.actionIcon.icon == Icons.search) {
                setState(() {
                  this.actionIcon = Icon(
                    Icons.close,
                    color: appTheme,
                    size: 25,
                  );
                  this.appBarTitle = TextField(
                    controller: _textController,
                    focusNode: searchFocusNode,
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
                    onChanged: (value) => mFSchemeBloc.schemeSearch(schemesListAfterFilter, value),
                  );
                  searchFocusNode.requestFocus();
                });
              } else {
                _handleSearchEnd();
              }
            },
          ),
        ),
      ],
    );
  }

  void _handleSearchEnd() {
    setState(() {
      searchFocusNode.unfocus();
      this.actionIcon = Icon(Icons.search, color: appTheme, size: 25);
      this.appBarTitle = Text(
        Strings.eligibility,
        style: mediumTextStyle_18_gray_dark,
      );
      _textController.clear();
      mFSchemeBloc.schemeSearch(schemesListAfterFilter, "");
    });
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
