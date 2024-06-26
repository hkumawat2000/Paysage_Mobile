import 'package:lms/network/requestbean/MyCartRequestBean.dart';
import 'package:lms/network/responsebean/DematAcResponse.dart';
import 'package:lms/network/responsebean/SecuritiesResponseBean.dart';
import 'package:lms/pledge_eligibility/mutual_fund/MF_ViewVaultDetailsViewScreen.dart';
import 'package:lms/shares/LoanApplicationBloc.dart';
import 'package:lms/terms_conditions/TermsConditions.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_switch/flutter_switch.dart';
// import 'package:page_indicator/page_indicator.dart';

class ViewVaultDetailsViewScreen extends StatefulWidget {
  List<SecuritiesListData> selectedSecurityList = [];
  List<SecuritiesListData> holdingSecurityList = [];
  DematAc? selectedDematAccount;
  List<LenderInfo>? lenderInfo;
  bool? isToggleOn;

  ViewVaultDetailsViewScreen(this.selectedSecurityList, this.holdingSecurityList, this.selectedDematAccount, this.lenderInfo, this.isToggleOn);

  @override
  ViewVaultDetailsViewScreenState createState() =>
      ViewVaultDetailsViewScreenState();
}

class ViewVaultDetailsViewScreenState
    extends State<ViewVaultDetailsViewScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Widget appBarTitle = new Text("Eligibility", style: mediumTextStyle_18_gray_dark);

  PageController controller = PageController();
  // GlobalKey<PageContainerState> key = GlobalKey();
  bool isToggleSelect = false;
  bool? isDefaultBottomDialog = true;
  bool? isEligibleBottomDialog = false;
  String? currentLenderSortBy;
  FocusNode focusNodes = FocusNode();


  List<DropdownMenuItem<String>>? dropDownSortBy;
  List<Atrina> cartViewList = [];
  var sortingList = [
    'Interest (Low to High)',
    'Interest (High to Low)',
    'Minimum Limit',
    'Maximum Limit'
  ];
  List<TextEditingController> schemeTextControllerList = [];
  List<SecuritiesListData> catAList = [];
  List<SecuritiesListData> catBList = [];
  List<SecuritiesListData> catCList = [];
  List<SecuritiesListData> catDList = [];
  List<SecuritiesListData> superCatAList = [];
  List<CategoryWiseSecurityList> categoryWiseList = [];
  List<SecuritiesListData> securityList = [];
  List<FocusNode> focusNode = [];
  double securityValue = 0.0;
  double eligibleLoanAmount = 0.0;
  bool isOutOfHoldingExist = false;
  LoanApplicationBloc loanApplicationBloc = LoanApplicationBloc();


  void changedSortByItem(String? selectedStatus) {
    setState(() {
      currentLenderSortBy = selectedStatus;
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
    dropDownSortBy = getSortByItems();
    cartViewList.add(Atrina(widget.lenderInfo![0].name,
        widget.lenderInfo![0].rateOfInterest,
        widget.lenderInfo![0].minimumSanctionedLimit,
        widget.lenderInfo![0].maximumSanctionedLimit));
    reArrangeSecurityList();
    super.initState();
  }

  createAndProcessCart(){
    List<SecuritiesList> securitiesList = [];
    securityList.forEach((element) {
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
        loamName: "",
        loan_margin_shortfall_name: "",
        pledgor_boid: widget.selectedDematAccount!.stockAt,
        schemeType: "",
        securities: securities
    );

    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    loanApplicationBloc.myCart(cartRequestBean).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        Navigator.push(context, MaterialPageRoute(
            builder: (BuildContext context) => TermsConditionsScreen(
                roundDownTo(eligibleLoanAmount).toString(), value.myCartData!.cart!.name!, widget.selectedDematAccount!.stockAt!,
                Strings.shares, "", "")));
      } else if(value.errorCode == 403){
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  reArrangeSecurityList(){
    schemeTextControllerList.clear();
    catAList.clear();
    catBList.clear();
    catCList.clear();
    catDList.clear();
    superCatAList.clear();
    categoryWiseList.clear();
    securityList.addAll(widget.selectedSecurityList);
    for (int i = 0; i < securityList.length; i++) {

      bool isExist = false;
      if(widget.selectedDematAccount!.isAtrina == 1 && !widget.isToggleOn!) {
        widget.holdingSecurityList.forEach((element) {
          if(element.iSIN == securityList[i].iSIN){
            isExist = true;
          }
        });
      } else {
        isExist = true;
      }
      if(isExist){
        securityList[i].isShowWarning = false;
      } else {
        securityList[i].isShowWarning = true;
      }

      schemeTextControllerList.add(TextEditingController(text: securityList[i].quantity.toString()));
      focusNode.add(FocusNode());
      switch (securityList[i].category!) {
        case Strings.cat_a:
          catAList.add(securityList[i]);
          break;
        case Strings.cat_b:
          catBList.add(securityList[i]);
          break;
        case Strings.cat_c:
          catCList.add(securityList[i]);
          break;
        case Strings.cat_d:
          catDList.add(securityList[i]);
          break;
        case Strings.super_cat_a:
          superCatAList.add(securityList[i]);
          break;
      }
    }
    categoryWiseList.add(CategoryWiseSecurityList(Strings.cat_a, catAList));
    categoryWiseList.add(CategoryWiseSecurityList(Strings.cat_b, catBList));
    categoryWiseList.add(CategoryWiseSecurityList(Strings.cat_c, catCList));
    categoryWiseList.add(CategoryWiseSecurityList(Strings.cat_d, catDList));
    categoryWiseList.add(CategoryWiseSecurityList(Strings.super_cat_a, superCatAList));
    for(int i=0; i<catAList.length; i++){
      schemeTextControllerList[i].text = int.parse(catAList[i].quantity!.toString().split(".")[1]) == 0 ? catAList[i].quantity!.toString().split(".")[0] : catAList[i].quantity!.toString();
    }
    for(int i=0; i<catBList.length; i++){
      schemeTextControllerList[catAList.length + i].text = int.parse(catBList[i].quantity!.toString().split(".")[1]) == 0 ? catBList[i].quantity!.toString().split(".")[0] : catBList[i].quantity!.toString();
    }
    for(int i=0; i<catCList.length; i++){
      schemeTextControllerList[catAList.length + catBList.length + i].text = int.parse(catCList[i].quantity!.toString().split(".")[1]) == 0 ? catCList[i].quantity!.toString().split(".")[0] : catCList[i].quantity!.toString();
    }
    for(int i=0; i<catDList.length; i++){
      schemeTextControllerList[catAList.length + catBList.length + catCList.length + i].text = int.parse(catDList[i].quantity!.toString().split(".")[1]) == 0 ? catDList[i].quantity!.toString().split(".")[0] : catDList[i].quantity!.toString();
    }
    for(int i=0; i<superCatAList.length; i++){
      schemeTextControllerList[catAList.length + catBList.length + catCList.length+ catDList.length + i].text = int.parse(superCatAList[i].quantity!.toString().split(".")[1]) == 0 ? superCatAList[i].quantity!.toString().split(".")[0] : superCatAList[i].quantity!.toString();
    }
    calculationHandling();
    if(isOutOfHoldingExist){
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) outOfHoldingDialog(context);
      });
    }
  }

  Future<bool> _onBackPressed() async {
    Navigator.pop(context, securityList);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
          key: _scaffoldKey,
          resizeToAvoidBottomInset: false,
          backgroundColor: colorBg,
          appBar: buildBar(context),
          body: viewVaultScreenBody(),
        ),
      ),
    );
  }

  Widget viewVaultScreenBody() {
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
        SizedBox(height: 10),
        sortBy(),
        SizedBox(height: 10),
        isToggleSelect
            ? lenderCardViewList()
            : Expanded(child: securitiesDetailsViewList()),
        isToggleSelect
            ? Container()
                : isDefaultBottomDialog!
                ? bottomSheetDialog()
            : eligibleLimitViewVaultDialog(),
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
                            scripsValueText("₹${numberToString(atrina.minLimit!.toStringAsFixed(2))}"),
                            SizedBox(
                              height: 16,
                            ),
                            mediumHeadingText(Strings.max_limit),
                            SizedBox(
                              height: 5,
                            ),
                            scripsValueText("₹${numberToString(atrina.maxLimit!.toStringAsFixed(2))}"),
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
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.only(
                                          bottomLeft: Radius.circular(10.0),
                                          bottomRight: Radius.circular(10.0))),
                                  foregroundColor: Colors.white,
                                  backgroundColor: appTheme,
                                  ),
                                  child: Text(
                                    "Select",
                                    textAlign: TextAlign.center,
                                  ),
                                  
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
        ));
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
                      Container(
                        alignment: Alignment.center,
                        child: Text(cartViewList[0].lender!, style: boldTextStyle_18),
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

              int actualIndex = securityList.indexWhere((element) => element.iSIN == categoryWiseList[index].items![i].iSIN);

              // String pledgeQty = securityList[actualIndex].quantity!.toInt().toString();
              // schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)] = TextEditingController(text: pledgeQty);
              // schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].selection = TextSelection.fromPosition(
              //     TextPosition(offset: schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text.length));

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(categoryWiseList[index].items![i].scripName!,
                                style: boldTextStyle_18),
                            ),
                            categoryWiseList[index].items![i].isShowWarning! ?
                            Image.asset(AssetsImagePath.warning_icon, height: 20,
                                width: 20, fit: BoxFit.fill, color: red) : SizedBox()
                          ],
                        ),
                        SizedBox(height: 2),
                        Text("${categoryWiseList[index].items![i].category!} (LTV: ${categoryWiseList[index].items![i].eligiblePercentage!.toStringAsFixed(2)}%)",
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
                                          String fieldText = schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase().split("_")[0], i)].text.toString();
                                          if(fieldText.isEmpty || int.parse(fieldText) == 1 || int.parse(fieldText) == 0){
                                            schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text = "1";
                                            securityList[actualIndex].quantity = 1;
                                            Utility.showToastMessage(Strings.message_quantity_not_less_1);
                                          } else {
                                            int txt = fieldText.isNotEmpty ? int.parse(fieldText.toString()) - 1 : 0;
                                            schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase().split("_")[0], i)].text = txt.toString();
                                            securityList[actualIndex].quantity = txt.toDouble();
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
                                    controller: schemeTextControllerList[
                                    getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)],
                                    focusNode: focusNode[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)],
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(counterText: ""),
                                    keyboardType: TextInputType.numberWithOptions(decimal: false),
                                    inputFormatters: [
                                      FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                                    ],
                                    style: TextStyle(fontWeight: FontWeight.w600),
                                    onChanged: (value) {
                                      String text = schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text;
                                      if(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text.isNotEmpty){
                                        if(int.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text) >= 1){
                                          if(widget.isToggleOn! && int.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text) > securityList[actualIndex].totalQty!.toInt()){
                                            FocusScope.of(context).unfocus();
                                            Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${securityList[actualIndex].totalQty!.toInt()} quantity.");
                                            setState(() {
                                              schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text = securityList[actualIndex].totalQty!.toInt().toString();
                                              securityList[actualIndex].quantity = securityList[actualIndex].totalQty!;
                                            });
                                          }else{
                                            securityList[actualIndex].quantity = double.parse(text);
                                          }
                                        }
                                      }else if(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text.isEmpty || int.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text) == 0 || schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text == " "){
                                        focusNode[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].addListener(() {
                                          if(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text.isEmpty || int.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text) == 0 || schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text == " "){
                                            if(focusNode[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].hasFocus){

                                            }else{
                                              FocusScope.of(context).unfocus();
                                              Utility.showToastMessage(Strings.message_quantity_not_less_1);
                                              schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text = "1";
                                              securityList[actualIndex].quantity = 1;
                                            }
                                          }
                                        });
                                      }
                                      // if(widget.selectedDematAccount!.isAtrina == 1 && securityList[actualIndex].totalQty != null && (int.parse(text) >= securityList[actualIndex].totalQty!)){
                                      //   FocusScope.of(context).unfocus();
                                      //   Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${securityList[actualIndex].totalQty!.toInt()} quantity.");
                                      //   setState(() {
                                      //     schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text = securityList[actualIndex].totalQty!.toInt().toString();
                                      //     securityList[actualIndex].quantity = securityList[actualIndex].totalQty!;
                                      //   });
                                      // } else {
                                      //   if(value.isNotEmpty){
                                      //     if (double.parse(text) != 0) {
                                      //       securityList[actualIndex].quantity = double.parse(text);
                                      //     } else {
                                      //       FocusScope.of(context).unfocus();
                                      //       Utility.showToastMessage(Strings.message_quantity_not_less_1);
                                      //       setState(() {
                                      //         schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text = "1";
                                      //         securityList[actualIndex].quantity = 1;
                                      //       });
                                      //     }
                                      //   }
                                      // }
                                      calculationHandling();
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
                                    Utility.isNetworkConnection().then((isNetwork) {
                                      if (isNetwork) {
                                        FocusScope.of(context).unfocus();
                                        String fieldText = schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase().split("_")[0], i)].text.toString();
                                        setState(() {
                                          if(fieldText.isNotEmpty && widget.selectedDematAccount!.isAtrina == 1 && securityList[actualIndex].totalQty != null && (int.parse(fieldText) >= securityList[actualIndex].totalQty!)){
                                            Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${securityList[actualIndex].totalQty!.toInt()} quantity.");
                                            securityList[actualIndex].quantity = double.parse(fieldText);
                                          } else {
                                            if(fieldText.isEmpty || int.parse(fieldText) == 0 || fieldText == " "){
                                              fieldText = "1";
                                              schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text = "1";
                                              securityList[actualIndex].quantity = double.parse(fieldText);
                                            } else {
                                              int txt = fieldText.isNotEmpty ? int.parse(fieldText.toString()) + 1 : 0;
                                              schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase().split("_")[0], i)].text = txt.toString();
                                              securityList[actualIndex].quantity = txt.toDouble();
                                            }
                                          }
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
                                      FocusScope.of(context).unfocus();
                                      if(securityList.length <= 1){
                                        Utility.showToastMessage(Strings.at_least_one_script);
                                      } else {
                                        deleteDialogBox(index, i, categoryWiseList[index].items![i].iSIN!);
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
                        FocusScope.of(context).unfocus();
                        Navigator.pop(context);
                        setState(() {
                          int actualIndex = securityList.indexWhere((element) => element.iSIN == isin);
                          securityList[actualIndex].quantity = double.parse(schemeTextControllerList[getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i)].text);
                          schemeTextControllerList.removeAt(getIndexOfSchemeUnit(categoryWiseList[index].items![i].category!.toLowerCase(), i));
                          securityList.removeWhere((element) => element.iSIN == isin);
                          categoryWiseList[index].items!.removeAt(i);
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
                  style: isToggleSelect ? semiBoldTextStyle_18_gray: semiBoldTextStyle_18),
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
                switchBorder: Border.all(color: appTheme, width: 3.0),
                toggleBorder: Border.all(color: appTheme, width: 2.5),
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
                  style: isToggleSelect ? semiBoldTextStyle_18 : semiBoldTextStyle_18_gray),
            ],
          ),
        ),
      ),
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
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            Strings.security_value,
                            style: mediumTextStyle_18_gray,
                          ),
                          Text("₹${numberToString(securityValue.toStringAsFixed(2))}",
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
                          Text(eligibleLoanAmount >= widget.lenderInfo![0].maximumSanctionedLimit!
                              ? '₹' + numberToString(widget.lenderInfo![0].maximumSanctionedLimit!.toStringAsFixed(2))
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
                      color: widget.lenderInfo![0].minimumSanctionedLimit! <= eligibleLoanAmount
                          ? securityValue <= 999999999999
                          ? isOutOfHoldingExist
                          ? colorLightGray
                          : appTheme
                          : colorLightGray
                          : colorLightGray,
                      child: AbsorbPointer(
                        absorbing:widget.lenderInfo![0].minimumSanctionedLimit! <= eligibleLoanAmount
                            ? securityValue <= 999999999999
                            ? isOutOfHoldingExist
                            ? true
                            : false
                            : true
                            : true,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          minWidth: MediaQuery.of(context).size.width,
                          onPressed: () async {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                if(widget.selectedDematAccount!.isAtrina == 1){
                                  createAndProcessCart();
                                } else {
                                  commonDialog(context, Strings.coming_soon, 5);
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
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          child: Row(
                            children: <Widget>[
                              Text(eligibleLoanAmount >= widget.lenderInfo![0].maximumSanctionedLimit!
                                  ? '₹' + numberToString(widget.lenderInfo![0].maximumSanctionedLimit!.toStringAsFixed(2))
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
                          ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0),
                        child: Container(
                          height: 50,
                          width: 140,
                          child: Material(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                            elevation: 1.0,
                            color: widget.lenderInfo![0].minimumSanctionedLimit! <= eligibleLoanAmount
                                ? securityValue <= 999999999999
                                ? isOutOfHoldingExist
                                ? colorLightGray
                                : appTheme
                                : colorLightGray
                                : colorLightGray,
                            child: AbsorbPointer(
                              absorbing:widget.lenderInfo![0].minimumSanctionedLimit! <= eligibleLoanAmount
                                  ? securityValue <= 999999999999
                                  ? isOutOfHoldingExist
                                  ? true
                                  : false
                                  : true
                                  : true,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  Utility.isNetworkConnection().then((isNetwork) {
                                    if (isNetwork) {
                                      if(widget.selectedDematAccount!.isAtrina == 1){
                                        createAndProcessCart();
                                      } else {
                                        commonDialog(context, Strings.coming_soon, 0);
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
        ));
  }

  calculationHandling(){
    securityValue = 0;
    eligibleLoanAmount = 0;
    for(int i=0; i < securityList.length; i++){
      securityValue +=  (securityList[i].price! * securityList[i].quantity!);
      eligibleLoanAmount += (securityList[i].price! * securityList[i].quantity! * securityList[i].eligiblePercentage!) / 100;
    }

    isOutOfHoldingExist = false;
    for(int i=0; i<securityList.length; i++){
      setState(() {
        if(securityList[i].isShowWarning!){
          isOutOfHoldingExist = true;
          return;
        // } else {
        //   isOutOfHoldingExist = false;
        }
      });
    }
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
                          Text(Strings.sort_by,style: regularTextStyle_14_gray),
                          Icon(Icons.arrow_downward,color: colorLightGray, size: 23),
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
    return new AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: appBarTitle,
      backgroundColor: colorBg,
      leading: IconButton(
        icon: ArrowToolbarBackwardNavigation(),
        onPressed: _onBackPressed,
      ),
    );
  }

  outOfHoldingDialog(BuildContext context)  {
    return  showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text("Scrips marked as (error icon) are not available in your holding. Do you want to turn on My Holdings toggle on the Eligibility Screen or remove those scrips",
                        style: regularTextStyle_16_dark),
                  ), //
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
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
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                Navigator.pop(context);
                              } else {
                                Utility.showToastMessage(Strings.no_internet_message);
                              }
                            });
                          },
                          child: Text(
                            Strings.no,
                            style: buttonTextRed,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Container(
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
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              }else{
                                Utility.showToastMessage(Strings.no_internet_message);
                              }
                            });
                          },
                          child: Text(
                            Strings.yes,
                            style: buttonTextWhite,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
