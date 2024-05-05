// import 'package:choice/common_widgets/constants.dart';
// import 'package:choice/network/requestbean/MyCartRequestBean.dart';
// import 'package:choice/network/responsebean/ApprovedListResponseBean.dart';
// import 'package:choice/network/responsebean/MyCartResponseBean.dart';
// import 'package:choice/shares/LoanApplicationBloc.dart';
// import 'package:choice/shares/MyShareCartScreen.dart';
// import 'package:choice/util/AssetsImagePath.dart';
// import 'package:choice/util/Colors.dart';
// import 'package:choice/util/Preferences.dart';
// import 'package:choice/util/Style.dart';
// import 'package:choice/util/Utility.dart';
// import 'package:choice/util/strings.dart';
// import 'package:choice/widgets/LoadingDialogWidget.dart';
// import 'package:choice/widgets/WidgetCommon.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// double? v;
// int? s;
// List<CartItems> allSelectMyCartList = [];
//
// class SharesSecuritiesScreen extends StatefulWidget {
//   List<ShareListData> securities = [];
//   String stockAt;
//
//   @override
//   SharesSecuritiesScreenState createState() => SharesSecuritiesScreenState();
//
//   SharesSecuritiesScreen(this.securities, this.stockAt);
// }
//
// class SharesSecuritiesScreenState extends State<SharesSecuritiesScreen> {
//   final loanApplicationBloc = LoanApplicationBloc();
//   ScrollController _scrollController = new ScrollController();
//   Preferences? preferences;
//   Map<String, TextEditingController> _controllers2 = {};
//   // List<int> remainingValues = [];
//   List<SecuritiesList> securitiesListItems = [];
//   Cart cartData = new Cart();
//   List<CartItems> myCartList = [];
//   List<CartItems> searchMyCartList = [];
//   List<String>? scripNameList;
//   List<bool> pledgeControllerEnable = [];
//   List<bool> pledgeControllerAutoFocus = [];
//   List<bool> pledgeControllerShowCursor = [];
//   List<FocusNode> myFocusNode = [];
//   bool checkBoxValue = true;
//   List<bool> checkBoxValues = [];
//   List<SecuritiesList> shareSecuritiesListItems = [];
//   var scriptValue, totalValue, totalScrips, eligibleLoan, pledgeQTY;
//   var eligible_loan, status;
//   var selected_securities;
//   double? minSanctionedLimit, maxSanctionedLimit;
//   bool? resetValue;
//   bool isScripsSelect = true;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   MyCartResponseBean? myCartData;
//   bool isUpateBtnClickable = true;
//   List<bool> isUpateBtnClickableList = [];
//   // List<bool> tempList = [];
//   int tempLength = 0;
//   Widget appBarTitle = new Text("", style: new TextStyle(color: Colors.white));
//   Icon actionIcon = new Icon(
//     Icons.search,
//     color: appTheme,
//     size: 25,
//   );
//   TextEditingController _textController = TextEditingController();
//   FocusNode focusNode = FocusNode();
//
//   void getDetails() async {
//     Securities securitiesObj = new Securities();
//     for (int i = 0; i < widget.securities.length; i++) {
//       if (widget.securities[i].quantity != 0.0 && widget.securities[i].price != 0.0) {
//         shareSecuritiesListItems.add(new SecuritiesList(
//             quantity: widget.securities[i].pledge_qty,
//             isin: widget.securities[i].iSIN,
//             price: widget.securities[i].price,
//             qty: widget.securities[i].pledge_qty!));
//       }
//     }
//     securitiesObj.list = shareSecuritiesListItems;
//     MyCartRequestBean myCartRequestBean = MyCartRequestBean();
//     myCartRequestBean.securities = securitiesObj;
//     myCartRequestBean.pledgor_boid = widget.stockAt;
//     myCartRequestBean.loamName = "";
//     myCartRequestBean.cartName = "";
//     myCartRequestBean.loan_margin_shortfall_name = "";
//     myCartRequestBean.lender = "";
//     LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//     myCartData = await loanApplicationBloc.myCart(myCartRequestBean);
//     if (myCartData != null) {
//       Navigator.pop(context);
//       setState(() {
//         if (myCartData!.isSuccessFull!) {
//           cartData = myCartData!.data!.cart!;
//           minSanctionedLimit = myCartData!.data!.minSanctionedLimit;
//           maxSanctionedLimit = myCartData!.data!.maxSanctionedLimit;
//           // for(int i=0; i<myCartData.data.cart.items.length; i++){
//           //   if(myCartData.data.cart.items[i].amount != 0){
//           //     myCartList.add(myCartData.data.cart.items[i]);
//           //   }
//           // }
//           myCartList = myCartData!.data!.cart!.items!;
//           // allSelectMyCartList.addAll(myCartData.data.cart.items);
//           searchMyCartList.addAll(myCartList);
//           totalValue = cartData.totalCollateralValue;
//           // v = totalValue;
//           // tempList.length = myCartList.length;
//           tempLength = myCartList.length;
//           totalScrips = tempLength;
//           // s = totalScrips;
//           eligibleLoan = cartData.totalCollateralValue! / 2;
//           scripNameList = List.generate(cartData.items!.length, (index) => cartData.items![index].securityName!);
//         } else if (myCartData!.errorCode == 403) {
//           commonDialog(context, Strings.session_timeout, 4);
//         } else {
//           status = myCartData!.errorCode;
//           Navigator.pop(context);
//           Utility.showToastMessage(myCartData!.errorMessage!);
//         }
//       });
//     } else {
//       Navigator.pop(context);
//     }
//   }
//
//   void searchResults(String query) {
//     List<CartItems> dummySearchList = <CartItems>[];
//     dummySearchList.addAll(searchMyCartList);
//     if (query.isNotEmpty) {
//       List<CartItems> dummyListData = <CartItems>[];
//       dummySearchList.forEach((item) {
//         if (item.securityName!.toLowerCase().contains(query.toLowerCase())) {
//           dummyListData.add(item);
//         }
//       });
//       setState(() {
//         myCartList.clear();
//         myCartList.addAll(dummyListData);
//       });
//     } else {
//       setState(() {
//         myCartList.clear();
//         myCartList.addAll(searchMyCartList);
//       });
//     }
//   }
//
//   void _handleSearchEnd() {
//     setState(() {
//       focusNode.unfocus();
//       this.actionIcon = Icon(Icons.search, color: appTheme, size: 25);
//       this.appBarTitle = Text(
//         encryptAcNo(widget.stockAt),
//         style: TextStyle(color: colorBlack, fontSize: 16),
//       );
//       _textController.clear();
//       myCartList.clear();
//       myCartList.addAll(searchMyCartList);
//     });
//   }
//
//   @override
//   void initState() {
//     resetValue = true;
//     preferences = Preferences();
//     appBarTitle = new Text(
//       widget.stockAt != null ? encryptAcNo(widget.stockAt) : "",
//       style: TextStyle(color: appTheme,fontSize: 16),
//     );
//     Utility.isNetworkConnection().then((isNetwork) {
//       if (isNetwork) {
//         getDetails();
//       } else {
//         Utility.showToastMessage(Strings.no_internet_message);
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     loanApplicationBloc.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//           key: _scaffoldKey,
//           resizeToAvoidBottomInset: false,
//           backgroundColor: colorbg,
//           appBar: buildBar(context),
//           body: myCartData != null ? allPledgeData(myCartData!.data!) : Container()),
//     );
//   }
//
//   PreferredSizeWidget buildBar(BuildContext context) {
//     final theme = Theme.of(context);
//     return new AppBar(
//       elevation: 0.0,
//       centerTitle: true,
//       title: appBarTitle,
//       backgroundColor: colorbg,
//       leading: IconButton(
//         icon: ArrowToolbarBackwardNavigation(),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       actions: <Widget>[
//         Theme(
//           data: theme.copyWith(primaryColor: Colors.white),
//           child: IconButton(
//             icon: actionIcon,
//             onPressed: () {
//               setState(() {
//                 if (this.actionIcon.icon == Icons.search) {
//                   this.actionIcon = Icon(
//                     Icons.close,
//                     color: appTheme,
//                     size: 25,
//                   );
//                   this.appBarTitle = TextField(
//                     controller: _textController,
//                     focusNode: focusNode,
//                     style: TextStyle(
//                       color: appTheme,
//                     ),
//                     cursorColor: appTheme,
//                     decoration: InputDecoration(
//                         prefixIcon: new Icon(
//                           Icons.search,
//                           color: appTheme,
//                           size: 25,
//                         ),
//                         hintText: "Search...",
//                         focusColor: appTheme,
//                         border: InputBorder.none,
//                         hintStyle: TextStyle(color: appTheme)),
//                     onChanged: (value) => searchResults(value),
//                   );
//                   focusNode.requestFocus();
//                 } else {
//                   _handleSearchEnd();
//                 }
//               });
//             },
//           ),
//         ),
//         IconButton(
//             icon: Image.asset(
//               AssetsImagePath.new_cart,
//               height: 25,
//               width: 25,
//               color: appTheme,
//             ),
//             onPressed: () {
//               sendMyCart(false);
//             })
//       ],
//     );
//   }
//
//   Widget allPledgeData(MyCartData myCartData) {
//     return NestedScrollView(
//         physics: NeverScrollableScrollPhysics(),
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return <Widget>[
//             SliverList(
//               delegate: SliverChildListDelegate([
//                 // dematAccountNo(widget.stockAt),
//                 pledgeCart(totalValue, totalScrips, resetValue!, Strings.values_selected_securities),
//               ]),
//             )
//           ];
//         },
//         body: Column(
//           children: <Widget>[
//             _textController.text.isNotEmpty ? SizedBox() : Padding(
//               padding: const EdgeInsets.only(left: 20, right: 10, top: 12),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   scripsNameText(Strings.shares_selected),
//                   Checkbox(
//                     checkColor: Colors.white,
//                     activeColor: colorGreen,
//                     onChanged: (bool? newValue) {
//                       altercheckBox(newValue);
//                       resetValue = newValue;
//                     },
//                     value: checkBoxValue,
//                   ),
//                 ],
//               ),
//             ),
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: NeverScrollableScrollPhysics(),
//                 child: pledgeSecuritiesList(),
//               ),
//             ),
//             bottomSection(myCartData),
//           ],
//         ));
//   }
//
//
//   Widget pledgeSecuritiesList() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, top: 0, right: 20, bottom: 150),
//       child: myCartList.length == 0
//           ? Padding(
//               padding: const EdgeInsets.only(top: 150.0),
//               child: Center(child: Text(Strings.search_result_not_found)),
//             )
//           : ListView.builder(
//               key: Key(myCartList.length.toString()),
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: myCartList.length,
//               itemBuilder: (context, index) {
//                 int actualIndex = searchMyCartList.indexWhere((element) => element.securityName == myCartList[index].securityName);
//                 checkBoxValues.add(true);
//                 myCartList[index].check = true;
//                 myCartList[index].remaningQty = widget.securities[actualIndex].quantity!.toInt();
//                 var pledge_qty;
//                 pledge_qty = myCartList[index].pledgedQuantity!.toInt().toString();
//                 _controllers2[myCartList[index].isin!] = TextEditingController(text: pledge_qty);
//                 _controllers2[myCartList[index].isin]!.selection = TextSelection.fromPosition(
//                     TextPosition(offset: _controllers2[myCartList[index].isin]!.text.length));
// //                _controllers.add(TextEditingController(text: pledge_qty));
//           pledgeControllerEnable.add(false);
//           scriptValue = roundDouble(myCartList[index].amount!.toDouble(), 2);
//           var qty;
//           String str = widget.securities[actualIndex].quantity.toString();
//           var qtyArray = str.split('.');
//
//           qty = qtyArray[0];
//           var remainingAmount;
//           //remainingAmount = _controllers2[myCartList[index].isin].text != "" ? int.parse(qty) - int.parse(_controllers2[myCartList[index].isin].text): 0;
//           remainingAmount = _controllers2[myCartList[index].isin]!.text != ""
//               ? int.parse(qty) - int.parse(_controllers2[myCartList[index].isin]!.text)
//               : 0;
//
//           return Container(
//             margin: EdgeInsets.symmetric(vertical: 10.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.white, width: 3.0),
//               // set border width
//               borderRadius:
//               BorderRadius.all(Radius.circular(10.0)), // set rounded corner radius
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 CheckboxListTile(
//                     controlAffinity: ListTileControlAffinity.trailing,
//                     activeColor: colorGreen,
//                     checkColor: colorWhite,
//                     onChanged: (bool? value) {
//                       checkBoxValues[actualIndex] = value!;
//                       setState(() {
//                         printLog("Security name ::: ${myCartList[index].securityName}");
//                         printLog("Security Index ::: ${actualIndex}");
//                         if (checkBoxValues[actualIndex]) {
//                           // printLog("_controllers2Check::${myCartList[index].pledgedQuantity}");
//                           myCartList[index].pledgedQuantity = widget.securities[actualIndex].quantity!.toDouble();
//                           _controllers2[myCartList[index].isin]!.text = myCartList[index].pledgedQuantity!.toInt().toString();
//                           myCartList[index].amount =
//                               double.parse(_controllers2[myCartList[index].isin]!.text) * myCartList[index].price!;
//                           if (totalScrips == 0) {
//                             totalScrips = 0;
//                             totalValue = 0.0 + myCartList[index].amount!;
//                           } else {
//                             totalValue = cartData.totalCollateralValue! + myCartList[index].amount!;
//                           }
//                           cartData.totalCollateralValue = totalValue;
//                           eligibleLoan = cartData.totalCollateralValue! / 2;
//                           myCartList[index].check = true;
//                           setState(() {
//                             totalScrips = totalScrips + 1;
//                           });
//                           if(myCartList.length == totalScrips){
//                             checkBoxValue = true;
//                           }
//                         } else {
//                           printLog("_controllers2::${_controllers2[myCartList[index].isin]!.text}");
//                           totalValue = cartData.totalCollateralValue! - myCartList[index].amount!;
//                           cartData.totalCollateralValue = totalValue;
//                           myCartList[index].amount = 0.0;
//                           _controllers2[myCartList[index].isin]!.text = "0";
//                           myCartList[index].pledgedQuantity = double.parse(_controllers2[myCartList[index].isin]!.text);
//                           printLog("_controllers2::${_controllers2[myCartList[index].isin]!.text}");
//                           eligibleLoan = (cartData.totalCollateralValue! / 2);
//                           // totalScrips = tempList.length - 1;
//                           // tempList.length = totalScrips;
//                           setState(() {
//                             totalScrips = totalScrips - 1;
//                             checkBoxValue = false;
//                           });
//                         }
//                         if (tempLength == myCartList.length) {
//                           isScripsSelect = false;
//                         } else {
//                           isScripsSelect = true;
//                         }
//                       });
//                     },
//                     value: checkBoxValues[actualIndex],
//                     title: scripsNameText(myCartList[index].securityName)),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: Table(children: [
//                     TableRow(children: [
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           scripsValueText(qty.toString()),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           mediumHeadingText(Strings.qty),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           scripsValueText(myCartList[index].price!.toStringAsFixed(2)),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           mediumHeadingText(Strings.price),
//                         ],
//                       ),
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           scripsValueText(scriptValue.toStringAsFixed(2)),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           mediumHeadingText(Strings.value),
//                         ],
//                       ),
//                     ]),
//                   ]),
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 10, right: 10),
//                   child: Divider(
//                     thickness: 0.5,
//                   ),
//                 ),
//                 SizedBox(
//                   height: 8,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 15),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           scripsNameText(Strings.pledge_qty),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             "${Strings.remaining + " " + remainingAmount.toString()}",
//                             style: kSecurityLiteStyle,
//                           )
//                         ],
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(left: 15),
//                         child: Row(
//                           children: <Widget>[
//                             Padding(
//                               padding: EdgeInsets.only(left: 0.0),
//                               child: IconButton(
//                                 iconSize: 20.0,
//                                 icon: Container(
//                                   padding: EdgeInsets.all(2),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(100),
//                                       border: Border.all(width: 1, color: colorBlack)),
//                                   child: Icon(
//                                     Icons.remove,
//                                     color: colorBlack,
//                                     size: 18,
//                                   ),
//                                 ),
//                                 onPressed: () async {
//                                   Utility.isNetworkConnection().then((isNetwork) {
//                                     if (isNetwork) {
//                                       int txt = int.parse(_controllers2[myCartList[index].isin]!.text) - 1;
//                                       setState(() {
//                                         FocusScope.of(context).requestFocus(new FocusNode());
//                                         if (checkBoxValues[actualIndex]) {
//                                           if (txt != 0) {
//                                             if ((double.parse(_controllers2[myCartList[index].isin]!.text) <=
//                                                 widget.securities[actualIndex].quantity!)) {
//                                               _controllers2[myCartList[index].isin]!.text = txt.toString();
//                                               myCartList[index].pledgedQuantity = myCartList[index].pledgedQuantity! - 1;
//                                               myCartList[index].amount = txt * myCartList[index].price!;
//                                               totalValue = cartData.totalCollateralValue! - myCartList[index].price!;
//                                               cartData.totalCollateralValue = totalValue;
//                                               eligibleLoan = cartData.totalCollateralValue! / 2;
//                                             } else {
//                                               Utility.showToastMessage(Strings.check_quantity);
//                                             }
//                                           }
//                                         } else {
//                                           Utility.showToastMessage(Strings.validation_select_checkbox);
//                                         }
//                                       });
//                                     } else {
//                                       Utility.showToastMessage(Strings.no_internet_message);
//                                     }
//                                   });
//                                 },
//                               ),
//                             ),
//                             Container(
//                               width: 60,
//                               height: 15,
//                               child: TextField(
//                                 textAlign: TextAlign.center,
//                                 decoration: InputDecoration(counterText: ""),
//                                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//                                 ],
//                                 controller: _controllers2[myCartList[index].isin],
//                                 style: TextStyle(
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                                 onChanged: (value) {
//                                   if (checkBoxValues[actualIndex]) {
//                                     if (_controllers2[myCartList[index].isin]!.text.isNotEmpty) {
//                                       if (_controllers2[myCartList[index].isin]!.text != "0") {
//                                         if (int.parse(_controllers2[myCartList[index].isin]!.text) < 1) {
//                                           Utility.showToastMessage("Please check your quantity, it should be greater than 1 ");
//                                           FocusScope.of(context).requestFocus(new FocusNode());
//                                           // remainingValues[index] = 0;
//                                         } else if (double.parse(_controllers2[myCartList[index].isin]!.text) >
//                                             widget.securities[actualIndex].quantity!) {
//                                           Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${qty} quantity .");
//                                           FocusScope.of(context).requestFocus(new FocusNode());
//                                           setState(() {
//                                             _controllers2[myCartList[index].isin]!.text = myCartList[index].pledgedQuantity!.toInt().toString();
//                                             myCartList[index].pledgedQuantity = double.parse(_controllers2[myCartList[index].isin]!.text);
//                                             var updateAmount = double.parse(_controllers2[myCartList[index].isin]!.text) * myCartList[index].price!;
//                                             var updateValue = cartData.totalCollateralValue! - myCartList[index].amount!;
//                                             totalValue = updateValue + updateAmount;
//                                             cartData.totalCollateralValue = totalValue;
//                                             eligibleLoan = cartData.totalCollateralValue! / 2;
//                                             myCartList[index].amount = updateAmount;
//                                           });
//                                           // remainingValues[index] = 0;
//                                         } else {
//                                           myCartList[index].pledgedQuantity = double.parse(_controllers2[myCartList[index].isin]!.text);
//                                           var updateAmount = double.parse(_controllers2[myCartList[index].isin]!.text) *
//                                               myCartList[index].price!;
//                                           var updateValue = cartData.totalCollateralValue! - myCartList[index].amount!;
//                                           totalValue = updateValue + updateAmount;
//                                           cartData.totalCollateralValue = totalValue;
//                                           eligibleLoan = cartData.totalCollateralValue! / 2;
//                                           myCartList[index].amount = updateAmount;
//                                           // remainingValues[index] = int.parse(qty) - int.parse(_controllers2[myCartList[index].isin]!.text);
//                                         }
//                                       } else {
//                                         setState(() {
//                                           _controllers2[myCartList[index].isin]!.text = "";
//                                           _controllers2[myCartList[index].isin]!.text = "1";
//                                           myCartList[index].pledgedQuantity = 1;
//                                           var updateAmount = double.parse(_controllers2[myCartList[index].isin]!.text)
//                                               * myCartList[index].price!;
//                                           myCartList[index].amount = updateAmount;
//                                           // remainingValues[index] = int.parse(qty) - int.parse(_controllers2[myCartList[index].isin]!.text);
//                                           FocusScope.of(context).requestFocus(new FocusNode());
//                                         });
//                                       }
//                                     } else {
// //                                            myCartList[index].pledgedQuantity = qty;
// //                                            setState(() {
// //                                              _controllers2[myCartList[index].isin].text =  myCartList[index].pledgedQuantity.toString();
// //                                            });
//                                     }
//                                   } else {
//                                     FocusScope.of(context).requestFocus(new FocusNode());
//                                     Utility.showToastMessage(Strings.validation_select_checkbox);
//                                   }
//                                 },
//                               ),
//                             ),
//                             Padding(
//                               padding: EdgeInsets.only(left: 0.0),
//                               child: IconButton(
//                                 icon: Container(
//                                   padding: EdgeInsets.all(2),
//                                   decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(100),
//                                       border: Border.all(width: 1, color: colorBlack)),
//                                   child: Icon(
//                                     Icons.add,
//                                     color: colorBlack,
//                                     size: 18,
//                                   ),
//                                 ),
//                                 onPressed: () async {
//                                   Utility.isNetworkConnection().then((isNetwork) {
//                                     if (isNetwork) {
//                                       if (int.parse(_controllers2[myCartList[index].isin]!.text) < int.parse(qty)) {
//                                         int txt = int.parse(_controllers2[myCartList[index].isin]!.text) + 1;
//                                         setState(() {
//                                           if (checkBoxValues[actualIndex]) {
//                                             _controllers2[myCartList[index].isin]!.text = txt.toString();
//                                             myCartList[index].pledgedQuantity = myCartList[index].pledgedQuantity! + 1;
//                                             myCartList[index].amount = txt * myCartList[index].price!;
//                                             totalValue = cartData.totalCollateralValue! + myCartList[index].price!;
//                                             cartData.totalCollateralValue = totalValue;
//                                             eligibleLoan = cartData.totalCollateralValue! / 2;
//                                           } else {
//                                             checkBoxValues[actualIndex] = true;
//                                             myCartList[index].check = true;
//                                             totalScrips = totalScrips + 1;
//                                             _controllers2[myCartList[index].isin]!.text = txt.toString();
//                                             myCartList[index].pledgedQuantity = myCartList[index].pledgedQuantity! + 1;
//                                             myCartList[index].amount = txt * myCartList[index].price!;
//                                             totalValue = cartData.totalCollateralValue! + myCartList[index].price!;
//                                             cartData.totalCollateralValue = totalValue;
//                                             eligibleLoan = cartData.totalCollateralValue! / 2;
//                                           }
//                                           if(myCartList.length == totalScrips){
//                                             checkBoxValue = true;
//                                           }
//                                         });
//                                       } else {
//                                         Utility.showToastMessage(Strings.check_quantity);
//                                       }
//                                     } else {
//                                       Utility.showToastMessage(Strings.no_internet_message);
//                                     }
//                                   });
//                                 },
//                               ),
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
//
//   Widget bottomSection(MyCartData myCartData) {
//     if (totalScrips != 0) {
//       isScripsSelect = false;
//       eligible_loan = roundDouble(eligibleLoan, 2);
//       selected_securities = roundDouble(totalValue, 2);
//     } else {
//       isScripsSelect = true;
//       eligible_loan = 0.0;
//       selected_securities = 0.0;
//     }
//     return Container(
//       // height: 150,
//       width: double.infinity,
//       decoration: BoxDecoration(
//           color: Colors.white,
//           border: Border.all(color: Colors.white, width: 3.0),
//           borderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
//           boxShadow: [
//             BoxShadow(blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
//           ]
//       ),
//       child: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.fromLTRB(20, 16, 20, 10),
//               child: Column(
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       bottomBoxText(Strings.security_value),
//                       scripsValueText('₹' + numberToString(selected_securities.toStringAsFixed(2)))
//                     ],
//                   ),
//                   SizedBox(
//                     height: 12,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       bottomBoxText(Strings.eligible_loan_small),
//                       scripsValueText(eligible_loan >= maxSanctionedLimit
//                           ? '₹' + numberToString(maxSanctionedLimit!.toStringAsFixed(2))
//                           : '₹' + numberToString(eligible_loan.toStringAsFixed(2)))
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.symmetric(vertical: 10.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   IconButton(
//                     icon: ArrowBackwardNavigation(),
//                     onPressed: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                   Container(
//                     height: 45,
//                     width: 100,
//                     child: Material(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                       elevation: 1.0,
//                       color: isScripsSelect == true ? colorLightGray : appTheme,
//                       child: AbsorbPointer(
//                         absorbing: isScripsSelect,
//                         child: MaterialButton(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () async {
//                             Utility.isNetworkConnection().then((isNetwork) {
//                               if (isNetwork) {
//                                 sendMyCart(false);
//                               } else {
//                                 Utility.showToastMessage(Strings.no_internet_message);
//                               }
//                             });
//                           },
//                           child: ArrowForwardNavigation(),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   void altercheckBox(value) {
//     List<bool> temp = checkBoxValues;
//     setState(() {
//       totalScrips = 0;
//       selected_securities = 0;
//     });
//     for (var index = 0; index < myCartList.length; index++) {
//       temp[index] = value;
//       setState(() {
//         if (value) {
//           myCartList[index].pledgedQuantity = widget.securities[index].quantity!.toDouble();
//           _controllers2[myCartList[index].isin]!.text = myCartList[index].pledgedQuantity!.toInt().toString();
//
//           myCartList[index].amount =
//               double.parse(_controllers2[myCartList[index].isin]!.text) * myCartList[index].price!;
//           if (totalScrips == 0) {
//             totalValue = 0.0 + myCartList[index].amount!;
//           } else {
//             totalValue = cartData.totalCollateralValue! + myCartList[index].amount!;
//           }
//           cartData.totalCollateralValue = totalValue;
//           eligibleLoan = cartData.totalCollateralValue! / 2;
//           myCartList[index].check = true;
//           totalScrips = index + 1;
//         } else {
//           totalValue = cartData.totalCollateralValue! - myCartList[index].amount!;
//           cartData.totalCollateralValue = totalValue;
//           myCartList[index].amount = 0.0;
//           _controllers2[myCartList[index].isin]!.text = "0";
//           myCartList[index].pledgedQuantity = double.parse(_controllers2[myCartList[index].isin]!.text);
//           eligibleLoan = cartData.totalCollateralValue! / 2;
//           totalScrips = 0;
//         }
//         if (tempLength == myCartList.length) {
//           isScripsSelect = false;
//         } else {
//           isScripsSelect = true;
//         }
//         checkBoxValues = temp;
//         checkBoxValue = value;
//       });
//     }
//   }
//
//   void sendMyCart(bool isReturnData) async {
//     LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//     _handleSearchEnd();
//     securitiesListItems.clear();
//
//     String? mobile = await preferences!.getMobile();
//     String? email = await preferences!.getEmail();
//
//     for (int i = 0; i < myCartList.length; i++) {
//       if (myCartList[i].amount != 0.0) {
//         securitiesListItems.add(new SecuritiesList(
//             quantity: double.parse(myCartList[i].pledgedQuantity.toString()),
//             isin: myCartList[i].isin,
//             price: myCartList[i].price,
//             qty: myCartList[i].remaningQty!.toDouble()));
//       }
//     }
//     Securities securitiesObj = new Securities();
//     securitiesObj.list = securitiesListItems;
//     MyCartRequestBean myCartRequestBean = new MyCartRequestBean();
//     myCartRequestBean.securities = securitiesObj;
//     myCartRequestBean.cartName = cartData.name;
//     myCartRequestBean.pledgor_boid = widget.stockAt;
//     myCartRequestBean.loamName = "";
//     myCartRequestBean.loan_margin_shortfall_name = "";
//     myCartRequestBean.lender = "";
//     loanApplicationBloc.myCart(myCartRequestBean).then((value) {
//       Navigator.pop(context);
//       if (value.isSuccessFull!) {
//         // Firebase Event
//         Map<String, dynamic> parameter = new Map<String, dynamic>();
//         parameter[Strings.mobile_no] = mobile;
//         parameter[Strings.email] = email;
//         parameter[Strings.cart_name] = cartData.name;
//         parameter[Strings.demat_ac_no] = widget.stockAt;
//         parameter[Strings.eligible_loan_prm] = numberToString(eligible_loan.toStringAsFixed(2));
//         parameter[Strings.date_time] = getCurrentDateAndTime();
//         firebaseEvent(Strings.upset_card_create, parameter);
//
//         if (!isReturnData) {
//           // _navigateAndDisplaySelection(context, value.data!);
//         } else {
//           setState(() {
//             myCartData = value;
//             cartData = value.data!.cart!;
//             myCartList = value.data!.cart!.items!;
//             searchMyCartList.addAll(myCartList);
//             totalValue = cartData.totalCollateralValue;
//             // tempList.length = myCartList.length;
//             tempLength = myCartList.length;
//             totalScrips = tempLength;
//             eligibleLoan = cartData.eligibleLoan;
//             scripNameList =
//                 List.generate(cartData.items!.length, (index) => cartData.items![index].securityName!);
//             allPledgeData(myCartData!.data!);
//           });
//         }
//       } else if (value.errorCode == 403) {
//         commonDialog(context, Strings.session_timeout, 4);
//       } else {
//         if (eligibleLoan == 0.0) {
//           Utility.showToastMessage("Please select securities");
//         } else {
//           Utility.showToastMessage(value.errorMessage!);
//         }
//       }
//     });
//   }
//
//   // _navigateAndDisplaySelection(BuildContext context, MyCartData data) async {
//   //   Navigator.push(
//   //       context,
//   //       MaterialPageRoute(
//   //           builder: (BuildContext context) =>
//   //               MyShareCartScreen(securitiesListItems, data, widget.stockAt, Strings.loan, [])));
// //    shareSecuritiesListItems = securitiesListItems;
// //    final result = await Navigator.push(
// //        context,
// //        MaterialPageRoute(
// //            builder: (BuildContext context) =>
// //                MyShareCartScreen(shareSecuritiesListItems, data, widget.stockAt)));
// //    // Map<String, TextEditingController> controller = result;
// //    ScripsData scripsData = result;
// //    _controllers2.forEach((key, value) {
// //      if (scripsData.pledgeController[key] != null) {
// //        _controllers2[key].text = scripsData.pledgeController[key].text;
// //      }
// //    });
// //
// //    for (int i = 0; i < myCartList.length; i++) {
// //      if (scripsData.pledgeController[myCartList[i].isin] != null) {
// //        setState(() {
// //          myCartList[i].pledgedQuantity =
// //              int.parse(scripsData.pledgeController[myCartList[i].isin].text);
// //        });
// //      }
// //      if (scripsData.selectedValueInScrips[myCartList[i].isin] != null) {
// //        setState(() {
// //          myCartList[i].amount = scripsData.selectedValueInScrips[myCartList[i].isin];
// //        });
// //      }
// //    }
// //    if (scripsData.totalValueSecurity != null && scripsData.eligibleLoan != null) {
// //      setState(() {
// //        totalValue = scripsData.totalValueSecurity;
// //        eligibleLoan = scripsData.eligibleLoan;
// //      });
// //    }
// //   }
// }
