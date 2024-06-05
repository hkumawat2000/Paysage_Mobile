import 'dart:convert';

import 'package:lms/network/requestbean/MyCartRequestBean.dart';
import 'package:lms/network/responsebean/MyCartResponseBean.dart';
import 'package:lms/shares/LoanApplicationBloc.dart';
import 'package:lms/terms_conditions/TermsConditions.dart';
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
import 'package:flutter_switch/flutter_switch.dart';
import 'package:page_indicator/page_indicator.dart';
import 'dart:math' as math;

import '../../network/responsebean/MFSchemeResponse.dart';


class MF_ViewVaultDetailsViewScreen extends StatefulWidget {
  MyCartRequestBean myCartRequestBean;
  List<SchemesList> schemesList = [];

  MF_ViewVaultDetailsViewScreen(this.myCartRequestBean, this.schemesList);

  @override
  MF_ViewVaultDetailsViewScreenState createState() =>
      MF_ViewVaultDetailsViewScreenState();
}

class MF_ViewVaultDetailsViewScreenState extends State<MF_ViewVaultDetailsViewScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget appBarTitle = new Text("", style: mediumTextStyle_18_gray_dark);
  Icon actionIcon = new Icon(
    Icons.search,
    color: appTheme,
    size: 25,
  );
  TextEditingController _textController = TextEditingController();
  PageController controller = PageController();
  GlobalKey<PageContainerState> key = GlobalKey();
  bool isToggleSelect = false;
  bool? isDefaultBottomDialog = true;
  bool? isEligibleBottomDialog = false;
  String? currentLenderSortBy;
  LoanApplicationBloc loanApplicationBloc = LoanApplicationBloc();
  List<DropdownMenuItem<String>>? dropDownSortBy;
  var sortingList = [
    Strings.sorting_list_item_1,
    Strings.sorting_list_item_2,
    Strings.sorting_list_item_3,
    Strings.sorting_list_item_4
  ];
  List<Atrina> cartViewList = [];
  List<CartItems> catAList = [];
  List<CartItems> catBList = [];
  List<CartItems> catCList = [];
  List<CartItems> catDList = [];
  List<CartItems> superCatAList = [];
  List<CategoryWiseList> categoryWiseList = [];
  List<TextEditingController> schemeTextControllerList = [];
  String? cartName;
  List<CartItems> schemesList = [];
  double schemeValue = 0.0;
  double eligibleLoanAmount = 0.0;
  List<bool> pledgeControllerEnable = [];
  List<FocusNode> focusNode = [];
  List<SchemesList>? schemesList2 = [];

  void changedSortByItem(String? selectedStatus) {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        setState(() {
          currentLenderSortBy = selectedStatus;
          switch (currentLenderSortBy) {
            case Strings.sorting_list_item_1:
              cartViewList.sort((a, b) => a.roi!.compareTo(b.roi!));
              break;
            case Strings.sorting_list_item_2:
              cartViewList.sort((b, a) => a.roi!.compareTo(b.roi!));
              break;
            case Strings.sorting_list_item_3:
              cartViewList.sort((a, b) => a.minLimit!.compareTo(b.minLimit!));
              break;
            case Strings.sorting_list_item_4:
              cartViewList.sort((a, b) => a.maxLimit!.compareTo(b.maxLimit!));
              break;
          }
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  List<DropdownMenuItem<String>> getSortByItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String status in sortingList) {
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

  @override
  void initState() {
    appBarTitle = Text(
      Strings.eligibility,
      style: mediumTextStyle_18_gray_dark,
    );
    dropDownSortBy = getSortByItems();
    callUpsertCartAPI(false);
    super.initState();
  }

  callUpsertCartAPI(bool isLoading) {
    schemesList2!.addAll(widget.schemesList);
    if(isLoading){
      LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    }
    loanApplicationBloc.myCart(widget.myCartRequestBean).then((value) {
      if(isLoading){
        Navigator.pop(context);
      }
      if (value.isSuccessFull!) {
        if(isLoading){
          Navigator.push(context, MaterialPageRoute(
              builder: (BuildContext context) => TermsConditionsScreen(
                  roundDownTo(eligibleLoanAmount).toString(), cartName!, "",
                  Strings.mutual_fund, "", "")));
        } else {
          schemeTextControllerList.clear();
          catAList.clear();
          catBList.clear();
          catCList.clear();
          catDList.clear();
          superCatAList.clear();
          categoryWiseList.clear();
          cartName = value.data!.cart!.name;
          schemesList.addAll(value.data!.cart!.items!);
          schemeValue = value.data!.cart!.totalCollateralValue!;
          eligibleLoanAmount = value.data!.cart!.eligibleLoan!;
          for (int i = 0; i < value.data!.cart!.items!.length; i++) {
            schemeTextControllerList.add(TextEditingController(text: value.data!.cart!.items![i].pledgedQuantity.toString()));
            focusNode.add(FocusNode());
            switch (value.data!.cart!.items![i].securityCategory!) {
              case Strings.cat_a:
                catAList.add(value.data!.cart!.items![i]);
                break;
              case Strings.cat_b:
                catBList.add(value.data!.cart!.items![i]);
                break;
              case Strings.cat_c:
                catCList.add(value.data!.cart!.items![i]);
                break;
              case Strings.cat_d:
                catDList.add(value.data!.cart!.items![i]);
                break;
              case Strings.super_cat_a:
                superCatAList.add(value.data!.cart!.items![i]);
                break;
            }
          }
          categoryWiseList.add(CategoryWiseList(Strings.cat_a, catAList));
          categoryWiseList.add(CategoryWiseList(Strings.cat_b, catBList));
          categoryWiseList.add(CategoryWiseList(Strings.cat_c, catCList));
          categoryWiseList.add(CategoryWiseList(Strings.cat_d, catDList));
          categoryWiseList.add(CategoryWiseList(Strings.super_cat_a, superCatAList));
          for(int i=0; i<catAList.length; i++){
            schemeTextControllerList[i].text = int.parse(catAList[i].pledgedQuantity!.toString().split(".")[1]) == 0 ? catAList[i].pledgedQuantity!.toString().split(".")[0] : catAList[i].pledgedQuantity!.toString();
          }
          for(int i=0; i<catBList.length; i++){
            schemeTextControllerList[catAList.length + i].text = int.parse(catBList[i].pledgedQuantity!.toString().split(".")[1]) == 0 ? catBList[i].pledgedQuantity!.toString().split(".")[0] : catBList[i].pledgedQuantity!.toString();
          }
          for(int i=0; i<catCList.length; i++){
            schemeTextControllerList[catAList.length + catBList.length + i].text = int.parse(catCList[i].pledgedQuantity!.toString().split(".")[1]) == 0 ? catCList[i].pledgedQuantity!.toString().split(".")[0] : catCList[i].pledgedQuantity!.toString();
          }
          for(int i=0; i<catDList.length; i++){
            schemeTextControllerList[catAList.length + catBList.length + catCList.length + i].text = int.parse(catDList[i].pledgedQuantity!.toString().split(".")[1]) == 0 ? catDList[i].pledgedQuantity!.toString().split(".")[0] : catDList[i].pledgedQuantity!.toString();
          }
          for(int i=0; i<superCatAList.length; i++){
            schemeTextControllerList[catAList.length + catBList.length + catCList.length+ catDList.length + i].text = int.parse(superCatAList[i].pledgedQuantity!.toString().split(".")[1]) == 0 ? superCatAList[i].pledgedQuantity!.toString().split(".")[0] : superCatAList[i].pledgedQuantity!.toString();
          }
        }
      } else if(value.errorCode == 403){
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  Future<bool> _onBackPressed() async {
    // return backConfirmationDialog(context);
    Navigator.pop(context, schemesList2);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: GestureDetector(
        onTap: (){
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: colorBg,
          appBar: buildBar(context),
          body: getUpsertCartDetails(),
        ),
      ),
    );
  }

  Widget getUpsertCartDetails() {
    return StreamBuilder(
      stream: loanApplicationBloc.myCartList,
      builder: (context, AsyncSnapshot<MyCartData> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return NoDataWidget();
          } else {
            cartViewList.clear();
            cartViewList.add(Atrina(snapshot.data!.cart!.lender, snapshot.data!.roi,
                snapshot.data!.minSanctionedLimit, snapshot.data!.maxSanctionedLimit));
            return viewVaultScreenBody(snapshot);
          }
        } else if (snapshot.hasError) {
          if (snapshot.error == "403") {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              commonDialog(context, Strings.session_timeout, 4);
            });
            return ErrorMessageWidget(error: "");
          }
          return ErrorMessageWidget(error: snapshot.error!.toString());
        } else {
          return LoadingWidget();
        }
      },
    );
  }

  Widget viewVaultScreenBody(AsyncSnapshot<MyCartData> snapshot) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Card(
            elevation: 0.0,
            color: colorWhite,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
              child: toggleDetailCardView(),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        sortBy(),
        SizedBox(height: 10),
        isToggleSelect
            ? lenderCardViewList()
            : Expanded(child: securitiesDetailsViewList(snapshot)),
        isToggleSelect
            ? Container()
            : isDefaultBottomDialog!
            ? bottomSheetDialog(snapshot)
            : eligibleLimitViewVaultDialog(snapshot)
      ],
    );
  }

  Widget lenderCardViewList() {
    var size = MediaQuery.of(context).size;
    final double itemWidth = size.width / 2;
    return Visibility(
      visible: isToggleSelect,
      child: Expanded(
        child: new GridView.count(
            crossAxisCount: 2,
            padding: const EdgeInsets.only(left: 20, right: 20),
            childAspectRatio: (itemWidth / 308),
            // controller: new ScrollController(keepScrollOffset: false),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            children: [
              ...cartViewList.map((Atrina atrina) {
                return Container(
                  margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 5),
                  decoration: BoxDecoration(
                    color: colorWhite,
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 4, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(atrina.lender!, style: boldTextStyle_18,
                                overflow: TextOverflow.ellipsis),
                            SizedBox(
                              height: 14,
                            ),
                            mediumHeadingText(Strings.roi),
                            SizedBox(
                              height: 5,
                            ),
                            scripsValueText("${atrina.roi!.toStringAsFixed(2)}%"),
                            SizedBox(
                              height: 16,
                            ),
                            mediumHeadingText(Strings.min_limit),
                            SizedBox(
                              height: 5,
                            ),
                            scripsValueText("₹${atrina.minLimit!.toStringAsFixed(2)}"),
                            SizedBox(
                              height: 16,
                            ),
                            mediumHeadingText(Strings.max_limit),
                            SizedBox(
                              height: 5,
                            ),
                            scripsValueText("₹${atrina.maxLimit!.toStringAsFixed(2)}"),
                          ],
                        ),
                      ),
                      Expanded(child: SizedBox(height: 21)),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: SizedBox(
                                height: 29,
                                child: RaisedButton(
                                  child: Text(
                                    "Select",
                                    textAlign: TextAlign.center,
                                  ),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0))),
                                  textColor: Colors.white,
                                  color: appTheme,
                                  onPressed: () {
                                    Utility.isNetworkConnection().then((isNetwork) {
                                      if (isNetwork) {
                                        setState(() {
                                          isToggleSelect = !isToggleSelect;
                                        });
                                      } else {
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
                    ],
                  ),
                );
              }).toList(),
            ]
        ),
      ),
    );
  }

  Widget securitiesDetailsViewList(AsyncSnapshot<MyCartData> snapshot) {
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
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            snapshot.data!.cart!.lender!,
                            style: boldTextStyle_18,
                          ),
                        ),
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
                                  Text("${snapshot.data!.roi!.toStringAsFixed(2)}%",
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
                                  Text("₹${numberToString(snapshot.data!.minSanctionedLimit!.toStringAsFixed(2))}",
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
                                  Text("₹${numberToString(snapshot.data!.maxSanctionedLimit!.toStringAsFixed(2))}",
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
              }),
        ),
      ],
    );
  }

  Widget categoryWiseScheme(int index) {
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
              int actualIndex = schemesList.indexWhere((element) => element.isin == categoryWiseList[index].items![i].isin);
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(categoryWiseList[index].items![i].securityName!,
                          style: boldTextStyle_18,
                        ),
                        SizedBox(height: 2),
                        Text("${categoryWiseList[index].items![i].securityCategory!} (LTV: ${categoryWiseList[index].items![i].eligiblePercentage!.toStringAsFixed(2)}%)",
                            style: boldTextStyle_12_gray),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
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
                                          FocusScope.of(context).unfocus();
                                          var fieldText = schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase().split("_")[0], i)].text.toString();
                                          if(fieldText.isNotEmpty && (double.parse(fieldText) == 1 || double.parse(fieldText) == 0.00  || double.parse(fieldText) == 0.0 || double.parse(fieldText) == 0 || double.parse(fieldText) == .0 ||double.parse(fieldText) == .00 ||double.parse(fieldText) == .000 || double.parse(fieldText)== 0.001)){
                                            setState(() {
                                              schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = "0.001";
                                              widget.myCartRequestBean.securities!.list![widget.myCartRequestBean.securities!.list!.indexWhere((element) => element.isin == categoryWiseList[index].items![i].isin)].quantity = double.parse("0.001");
                                              schemesList[actualIndex].pledgedQuantity = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                              schemesList2![actualIndex].units = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                              calculationHandling();
                                              Utility.showToastMessage(Strings.message_unit_not_less_1);
                                            });
                                          } else {
                                            var txt, decrementWith;
                                            if(fieldText.contains('.') && fieldText.split(".")[1].length != 0) {
                                              var unitsDecimalCount;
                                              var qtyArray = fieldText.split('.');
                                              unitsDecimalCount = qtyArray[1];
                                              if(int.parse(unitsDecimalCount) == 0){
                                                txt = double.parse(fieldText) - 1;
                                                decrementWith = 1;
                                                fieldText = txt.toString();
                                              } else {
                                                if (unitsDecimalCount.toString().length == 1) {
                                                  txt = double.parse(fieldText) - .1;
                                                  decrementWith = .1;
                                                  fieldText = txt.toStringAsFixed(1);
                                                } else if (unitsDecimalCount.toString().length == 2) {
                                                  txt = double.parse(fieldText) - .01;
                                                  decrementWith = .01;
                                                  fieldText = txt.toStringAsFixed(2);
                                                } else {
                                                  txt = double.parse(fieldText) - .001;
                                                  decrementWith = .001;
                                                  fieldText = txt.toStringAsFixed(3);
                                                }
                                              }
                                            }else{
                                              txt = fieldText.toString().isNotEmpty ? int.parse(fieldText.toString().split(".")[0]) - 1 : 0.001;
                                              decrementWith = 1;
                                              fieldText = txt.toString();
                                            }
                                            schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase().split("_")[0], i)].text = fieldText;
                                            widget.myCartRequestBean.securities!.list![widget.myCartRequestBean.securities!.list!.indexWhere((element) => element.isin == categoryWiseList[index].items![i].isin)].quantity = double.parse(fieldText);
                                            schemesList[actualIndex].pledgedQuantity = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                            schemesList2![actualIndex].units = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                            calculationHandling();
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
                                    controller: schemeTextControllerList[
                                    getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)],
                                    focusNode: focusNode[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)],
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(counterText: ""),
                                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                                    inputFormatters: [
                                      DecimalTextInputFormatter(decimalRange: 3),
                                      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,3}')),
                                    ],
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                    onChanged: (value) {
                                      var txt;
                                      if(!schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text.toString().endsWith(".")) {
                                        if (value.isNotEmpty && double.parse(value.toString()) >= 0.001) {
                                          if (double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text) != 0) {
                                            widget.myCartRequestBean.securities!.list![widget.myCartRequestBean.securities!.list!.indexWhere((element) => element.isin == categoryWiseList[index].items![i].isin)].quantity =
                                                double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                            schemesList[actualIndex].pledgedQuantity = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                            schemesList2![actualIndex].units = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                            calculationHandling();
                                          } else {
                                            setState(() {
                                              FocusScope.of(context).unfocus();
                                              Utility.showToastMessage(Strings.message_unit_not_less_1);
                                              schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = "0.001";
                                              widget.myCartRequestBean.securities!.list![widget.myCartRequestBean.securities!.list!.indexWhere((element) => element.isin == categoryWiseList[index].items![i].isin)].quantity = 0.001;
                                              schemesList[actualIndex].pledgedQuantity = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                              schemesList2![actualIndex].units = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                              calculationHandling();
                                            });
                                          }
                                        } else {
                                          if (schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text.isEmpty ||
                                              schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text == ".0" ||
                                              schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text == ".00" ||
                                              schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text == "0" ||
                                              schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text == "0." ||
                                              schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text == "0.0" ||
                                              schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text == "0.00") {

                                            focusNode[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].addListener(() {

                                              if(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text.isEmpty ||
                                                  schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text == ".0" ||
                                                  schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text == ".00" ||
                                                  schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text == "0" ||
                                                  schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text == "0." ||
                                                  schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text == "0.0" ||
                                                  schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text == "0.00"){
                                                if(focusNode[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].hasFocus){
                                                  focusNode[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].requestFocus();
                                                }else{
                                                  FocusScope.of(context).unfocus();
                                                  focusNode[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].unfocus();
                                                  setState(() {
                                                    schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = "0.001";
                                                    widget.myCartRequestBean.securities!.list![widget.myCartRequestBean.securities!.list!.indexWhere((element) =>
                                                    element.isin == categoryWiseList[index].items![i].isin)].quantity = 0.001;

                                                    schemesList[actualIndex].pledgedQuantity = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                                    schemesList2![actualIndex].units = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                                    calculationHandling();
                                                  });
                                                }
                                              }else if(double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text) >= 0.001){
                                                printLog("update normally ");
                                              }else{
                                                setState(() {
                                                  FocusScope.of(context).unfocus();
                                                  schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = "0.001";
                                                  widget.myCartRequestBean.securities!.list![widget.myCartRequestBean.securities!.list!.indexWhere((element) => element.isin == categoryWiseList[index].items![i].isin)].quantity = 0.001;
                                                  schemesList[actualIndex].pledgedQuantity = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                                  schemesList2![actualIndex].units = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                                  calculationHandling();
                                                });
                                              }
                                            });
                                          } else {
                                            setState(() {
                                              FocusScope.of(context).unfocus();
                                              schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = "0.001";
                                              widget.myCartRequestBean.securities!.list![widget.myCartRequestBean.securities!.list!.indexWhere((element) => element.isin == categoryWiseList[index].items![i].isin)].quantity = 0.001;
                                              schemesList[actualIndex].pledgedQuantity = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                              schemesList2![actualIndex].units = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                              calculationHandling();
                                            });
                                          }
                                        }
                                      }else{
                                        var value;
                                        value = schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text;
                                        focusNode[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].addListener(() {
                                          if(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text.toString().endsWith('.')){
                                            if(focusNode[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].hasFocus){
                                              focusNode[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].requestFocus();
                                            } else {
                                              if(value.toString().split(".")[0].isEmpty){
                                                schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = "0.001";
                                                widget.myCartRequestBean.securities!.list![widget.myCartRequestBean.securities!.list!.indexWhere((element) =>
                                                element.isin == categoryWiseList[index].items![i].isin)].quantity = 0.001;
                                                schemesList[actualIndex].pledgedQuantity = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                                schemesList2![actualIndex].units = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                                calculationHandling();
                                              } else if(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text.toString().endsWith('.')){
                                                value = int.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text.toString().split(".")[0]);
                                                schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = value.toString();
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
                                        borderRadius:
                                        BorderRadius.circular(100),
                                        border: Border.all(width: 1, color: colorBlack)),
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
                                        FocusScope.of(context).unfocus();
                                        var fieldText = schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase().split("_")[0], i)].text.toString();
                                        var txt, incrementWith;
                                        if(fieldText.contains('.') && fieldText.split(".")[1].length != 0) {
                                          var unitsDecimalCount;
                                          var qtyArray = fieldText.split('.');
                                          unitsDecimalCount = qtyArray[1];
                                          if(unitsDecimalCount.isNotEmpty && int.parse(unitsDecimalCount) == 0){
                                            txt = double.parse(fieldText) + 1;
                                            incrementWith = 1;
                                            fieldText = txt.toString();
                                          } else {
                                            if (unitsDecimalCount.toString().length == 1) {
                                              txt = double.parse(fieldText) + .1;
                                              incrementWith = .1;
                                              fieldText = txt.toStringAsFixed(1);
                                            } else if (unitsDecimalCount.toString().length == 2) {
                                              txt = double.parse(fieldText) + .01;
                                              incrementWith = .01;
                                              fieldText = txt.toStringAsFixed(2);
                                            } else {
                                              txt = double.parse(fieldText) + .001;
                                              incrementWith = .001;
                                              fieldText = txt.toStringAsFixed(3);
                                            }
                                          }
                                        }else{
                                          txt = fieldText.toString().isNotEmpty ? int.parse(fieldText.toString().split(".")[0]) + 1 : 0.001;
                                          incrementWith = 1;
                                          fieldText = txt.toString();
                                        }
                                        setState(() {
                                          schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase().split("_")[0], i)].text = fieldText;
                                          widget.myCartRequestBean.securities!.list![widget.myCartRequestBean.securities!.list!.indexWhere((element) => element.isin == categoryWiseList[index].items![i].isin)].quantity = double.parse(fieldText);
                                          schemesList[actualIndex].pledgedQuantity = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                                          schemesList2![actualIndex].units =double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
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
                                      if(schemesList.length <= 1){
                                        FocusScope.of(context).unfocus();
                                        Utility.showToastMessage("At least one scheme to be lien for loan");
                                      } else {
                                        deleteDialogBox(index, i, categoryWiseList[index].items![i].isin!);
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
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
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

  Widget toggleDetailCardView() {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Card(
        elevation: 0.0,
        color: colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(5, 10, 5, 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(Strings.detail_view,
                  style: isToggleSelect
                      ? semiBoldTextStyle_18_gray
                      : semiBoldTextStyle_18),
              SizedBox(
                width: 5,
              ),
              FlutterSwitch(
                width: 40.0,
                height: 23.0,
                toggleSize: 20.0,
                value: isToggleSelect,
                borderRadius: 30.0,
                padding: 2.0,
                toggleColor: colorWhite,
                switchBorder: Border.all(
                  color: appTheme,
                  width: 3.0,
                ),
                toggleBorder: Border.all(
                  color: appTheme,
                  width: 2.5,
                ),
                activeColor: colorWhite,
                inactiveColor: colorWhite,
                onToggle: (val) {
                  Utility.isNetworkConnection().then((isNetwork) async {
                    if (isNetwork) {
                      setState(() {
                        isToggleSelect = val;
                      });
                    } else {
                      Utility.showToastMessage(Strings.no_internet_message);
                    }
                  });
                },
              ),
              SizedBox(
                width: 5,
              ),
              Text(Strings.card_view,
                  style: isToggleSelect
                      ? semiBoldTextStyle_18
                      : semiBoldTextStyle_18_gray),
            ],
          ),
        ),
      ),
    );
  }

  Widget bottomSheetDialog(AsyncSnapshot<MyCartData> snapshot) {
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
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(Strings.scheme_value,
                            style: mediumTextStyle_18_gray,
                          ),
                        ),
                        Text("₹${numberToString(schemeValue.toStringAsFixed(2))}",
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
                          child: Text(Strings.eligible_loan_amount_small, style: mediumTextStyle_18_gray),
                        ),
                        Text(eligibleLoanAmount >= snapshot.data!.maxSanctionedLimit!
                            ? '₹' + numberToString(snapshot.data!.maxSanctionedLimit!.toStringAsFixed(2))
                            : '₹' + numberToString(roundDownTo(eligibleLoanAmount).toString()),
                            style: textStyleGreenStyle_18)
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 0),
                child: Container(
                  height: 50,
                  width: 140,
                  child: Material(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 1.0,
                    color: snapshot.data!.minSanctionedLimit! <= eligibleLoanAmount ? schemeValue <= 999999999999 ? appTheme : colorLightGray : colorLightGray,
                    child: AbsorbPointer(
                      absorbing: snapshot.data!.minSanctionedLimit! > eligibleLoanAmount ? true : false,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          Utility.isNetworkConnection().then((isNetwork) async {
                            if (isNetwork) {
                              if(schemeValue <= 999999999999){
                                roundDownTo(eligibleLoanAmount).toString();
                                widget.myCartRequestBean.cartName = cartName;
                                printLog("requestBean${json.encode(widget.myCartRequestBean)}");
                                printLog("eligible loan === ${eligibleLoanAmount.toString()}");
                                callUpsertCartAPI(true);
                              } else {
                                commonDialog(context, Strings.scheme_validation, 0);
                              }
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget eligibleLimitViewVaultDialog(AsyncSnapshot<MyCartData> snapshot) {
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
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: Row(
                          children: <Widget>[
                            Text(eligibleLoanAmount >= snapshot.data!.maxSanctionedLimit!
                                ? '₹' + numberToString(snapshot.data!.maxSanctionedLimit!.toStringAsFixed(2))
                                : '₹' + numberToString(roundDownTo(eligibleLoanAmount).toString()),
                                style: textStyleGreenStyle_18),
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
                          color: snapshot.data!.minSanctionedLimit! <= eligibleLoanAmount ? schemeValue <= 999999999999 ? appTheme : colorLightGray : colorLightGray,
                          child: AbsorbPointer(
                            absorbing: snapshot.data!.minSanctionedLimit! > eligibleLoanAmount ? true : false,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () async {
                                Utility.isNetworkConnection().then((isNetwork) {
                                  if (isNetwork) {
                                    if(schemeValue <= 999999999999){
                                      widget.myCartRequestBean.cartName = cartName;
                                      printLog("requestBean${json.encode(widget.myCartRequestBean)}");
                                      callUpsertCartAPI(true);
                                    }else{
                                      commonDialog(context, Strings.scheme_validation, 0);
                                    }
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

  Widget sortBy() {
    var size = MediaQuery.of(context).size;
    final double itemWidth = (size.width - 50) / 2;
    return Align(
      alignment: Alignment.topLeft,
      child: Visibility(
        visible: isToggleSelect,
        child: Container(
          width: itemWidth,
          height: 40,
          margin: const EdgeInsets.only(left: 20, right: 20),
          decoration: BoxDecoration(
            color: colorLightGray2,
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 5.0, right: 5.0),
            alignment: Alignment.center,
            child: Card(
                elevation: 0.0,
                color: colorLightGray2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: currentLenderSortBy,
                    hint: Center(
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(Strings.sort_by,style: regularTextStyle_14_gray,),
                          // IconButton(iconSize: 18,icon: Image.asset(
                          //   AssetsImagePath.drop_down_arrow,
                          //   color: colorLightGray,
                          // ), onPressed: () {  },),
                          Icon(Icons.arrow_downward,color: colorLightGray, size: 23,),
                        ],
                      ),
                    ),
                    iconSize: 0.0,
                    elevation: 16,
                    onChanged: changedSortByItem,
                    items: dropDownSortBy,
                  ),
                )),
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
        onPressed: () {
          _onBackPressed();
        },
      ),
      // actions: <Widget>[
      //   Theme(
      //     data: theme.copyWith(primaryColor: Colors.white),
      //     child: IconButton(
      //       icon: actionIcon,
      //       onPressed: () {
      //         setState(() {
      //           if (this.actionIcon.icon == Icons.search) {
      //             this.actionIcon = Icon(
      //               Icons.close,
      //               color: appTheme,
      //               size: 25,
      //             );
      //             this.appBarTitle = TextField(
      //               controller: _textController,
      //               style: TextStyle(
      //                 color: appTheme,
      //               ),
      //               cursorColor: appTheme,
      //               decoration: InputDecoration(
      //                   prefixIcon: new Icon(
      //                     Icons.search,
      //                     color: appTheme,
      //                     size: 25,
      //                   ),
      //                   hintText: "Search...",
      //                   focusColor: appTheme,
      //                   border: InputBorder.none,
      //                   hintStyle: TextStyle(color: appTheme)),
      //               onChanged: (value) {},
      //             );
      //           } else {
      //             _handleSearchEnd();
      //           }
      //         });
      //       },
      //     ),
      //   ),
      // ],
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
      // mFSchemeBloc.schemeSearch(schemesListAfterFilter, "", schemesOriginalList);
    });
  }

  calculationHandling(){
    schemeValue = 0;
    eligibleLoanAmount = 0;
    for(int i=0; i < schemesList.length; i++){
      schemeValue = schemeValue + (schemesList[i].price! * schemesList[i].pledgedQuantity!);
      eligibleLoanAmount = eligibleLoanAmount + (schemesList[i].price! * schemesList[i].pledgedQuantity! * (schemesList[i].eligiblePercentage! / 100));
    }
  }

  Future<void> deleteDialogBox(int index, int i, String isin) {
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
                      minWidth: MediaQuery
                          .of(context)
                          .size
                          .width,
                      onPressed: () async {
                        setState(() {
                          FocusScope.of(context).unfocus();
                          Navigator.pop(context);
                          int actualIndex = schemesList.indexWhere((element) => element.isin == categoryWiseList[index].items![i].isin);
                          widget.myCartRequestBean.securities!.list!.removeWhere((element) => element.isin == categoryWiseList[index].items![i].isin);
                          widget.myCartRequestBean.cartName = cartName;
                          schemesList[actualIndex].pledgedQuantity = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                          schemesList2![actualIndex].units = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
                          schemeTextControllerList.removeAt(getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i));
                          schemesList.removeWhere((element) => element.isin == isin);
                          schemesList2!.removeWhere((element) => element.isin == isin);
                          calculationHandling();
                          categoryWiseList[index].items!.removeAt(i);
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

class Atrina {
  const Atrina(this.lender, this.roi, this.minLimit, this.maxLimit);

  final String? lender;
  final double? roi;
  final double? minLimit;
  final double? maxLimit;
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
