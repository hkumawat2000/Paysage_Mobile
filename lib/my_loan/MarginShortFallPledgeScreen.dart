// import 'dart:convert';
// import 'package:choice/common_widgets/constants.dart';
// import 'package:choice/lender/LenderBloc.dart';
// import 'package:choice/network/requestbean/MyCartRequestBean.dart';
// import 'package:choice/network/requestbean/SecuritiesRequest.dart';
// import 'package:choice/network/responsebean/ApprovedListResponseBean.dart';
// import 'package:choice/network/responsebean/MyCartResponseBean.dart';
// import 'package:choice/network/responsebean/SecuritiesResponseBean.dart';
// import 'package:choice/shares/LoanApplicationBloc.dart';
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
// import 'MarginShortFallMyCartScreen.dart';
//
// class MarginShortFallPledgeScreen extends StatefulWidget {
//   List<SecuritiesListData> securities = [];
//   String stockAt;
//   String loan_name,loanMarginshortfallName;
//   List<LenderInfo>? lenderInfo;
//   List<String> lenderList;
//   List<String> levelList;
//
//   @override
//   MarginShortFallPledgeScreenState createState() =>
//       MarginShortFallPledgeScreenState();
//   MarginShortFallPledgeScreen(this.loan_name,this.securities, this.stockAt,this.loanMarginshortfallName, this.lenderInfo, this.lenderList, this.levelList);
// }
//
// class MarginShortFallPledgeScreenState extends State<MarginShortFallPledgeScreen> {
//   final loanApplicationBloc = LoanApplicationBloc();
//   ScrollController _scrollController = new ScrollController();
//   Preferences? preferences;
//   Map<String, TextEditingController> _controllers = {};
//   // List<int> remainingValues = [];
//   List<SecuritiesList> securitiesListItems = [];
//   Cart cartData = new Cart();
//   List<CartItems> myCartList = [];
//   List<String>? scripNameList;
//   List<bool> pledgeControllerEnable = [];
//   List<bool> pledgeControllerAutoFocus = [];
//   List<bool> pledgeControllerShowCursor = [];
//   List<FocusNode> myFocusNode = [];
//   bool checkBoxValue = true;
//   bool singlecheckBoxValue = true;
//   List<bool> checkBoxValues = [];
//   var scriptValue, remainingValue, totalValue, totalScrips,eligibleLoan,pledgeQTY;
//   var eligible_loan, status;
//   var selected_securities;
//   var drawingPower;
//   bool? resetValue;
//   bool? isScripsSelect = true;
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   MyCartResponseBean? myCartData;
//   LoanMarginShortfallObj? marginShortfallObj;
//   bool isUpateBtnClickable = true;
//   double? minSanctionedLimit, maxSanctionedLimit;
//   List<bool> isUpateBtnClickableList = [];
//   int tempLength = 0;
//   List<SecuritiesList> shareSecuritiesListItems = [];
//   List<CartItems> searchMyCartList = [];
//   List<bool> isAddBtnShow = [];
//   List<bool> selectedBoolLenderList = [];
//   List<bool> selectedBoolLevelList = [];
//   List<String> selectedLenderList = [];
//   List<String> selectedLevelList = [];
//   List<String> lenderList = [];
//   List<String> levelList = [];
//   final lenderBloc = LenderBloc();
//   bool hideSecurityValue = false;
//   bool showSecurityValue = true;
//   Widget appBarTitle = new Text(
//     "",
//     style: new TextStyle(color: Colors.white),
//   );
//
//   Icon actionIcon = new Icon(
//     Icons.search,
//     color: appTheme,
//     size: 25,
//   );
//
//   TextEditingController _textController = TextEditingController();
//   FocusNode focusNode = FocusNode();
//
//
//   void getDetails() async {
//     Securities securitiesObj = new Securities();
//
//     setState(() {
//
//         lenderList.addAll(widget.lenderList);
//         selectedLenderList.addAll(widget.lenderList);
//         selectedBoolLenderList.add(true);
//         levelList.addAll(widget.levelList);
//         widget.levelList.forEach((element) {
//           selectedLevelList.add(element.toString().split(" ")[1]);
//           selectedBoolLevelList.add(true);
//         });
//     });
//
//     for (int i = 0; i < widget.securities.length; i++) {
//         shareSecuritiesListItems.add(new SecuritiesList(
//             quantity: widget.securities[i].quantity,
//             isin: widget.securities[i].iSIN,
//             price: widget.securities[i].price,
//             qty: widget.securities[i].quantity!));
//         print("quantity remaining --> ${widget.securities[i].quantity}");
//     }
//     securitiesObj.list = shareSecuritiesListItems;
//     MyCartRequestBean myCartRequestBean = MyCartRequestBean();
//     myCartRequestBean.securities = securitiesObj;
//     myCartRequestBean.pledgor_boid = widget.stockAt;
//     myCartRequestBean.loamName = widget.loan_name;
//     myCartRequestBean.loan_margin_shortfall_name = widget.loanMarginshortfallName;
//     myCartRequestBean.lender = "";
//     myCartRequestBean.cartName = "";
//     LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//     myCartData = await loanApplicationBloc.myCart(myCartRequestBean);
//     if(myCartData !=null){
//       Navigator.pop(context);
//       setState(() {
//         if (myCartData!.isSuccessFull!) {
//           marginShortfallObj = myCartData!.data!.loanMarginShortfallObj;
//           cartData = myCartData!.data!.cart!;
//           drawingPower = myCartData!.data!.loanMarginShortfallObj!.drawingPower;
//           minSanctionedLimit = myCartData!.data!.minSanctionedLimit;
//           maxSanctionedLimit = myCartData!.data!.maxSanctionedLimit;
//           for(int i=0; i<myCartData!.data!.cart!.items!.length; i++){
//             if(myCartData!.data!.cart!.items![i].amount != 0){
//               myCartList.add(myCartData!.data!.cart!.items![i]);
//               isAddBtnShow.add(true);
//             }
//           }
//           searchMyCartList.addAll(myCartList);
//           totalValue = 0.0;
//           tempLength = myCartList.length;
//           totalScrips = 0;
//           eligibleLoan = 0.0;
//           // totalValue = cartData.totalCollateralValue;
//           // tempLength = myCartList.length;
//           // totalScrips = tempLength;
//           // eligibleLoan = cartData.totalCollateralValue! / 2;
//           scripNameList = List.generate(cartData.items!.length, (index) => cartData.items![index].securityName!);
//         } else if (myCartData!.errorCode == 403) {
//           commonDialog(context, Strings.session_timeout, 4);
//         } else {
//           status = myCartData!.errorCode;
//           Utility.showToastMessage(myCartData!.errorMessage!);
//         }
//       });
//     } else {
//       Navigator.pop(context);
//       Utility.showToastMessage(myCartData!.errorMessage!);
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
//       this.appBarTitle = subHeadingText("Pledge Securities");
//       _textController.clear();
//       myCartList.clear();
//       myCartList.addAll(searchMyCartList);
//     });
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
//   void initState() {
//     resetValue = true;
//     preferences = Preferences();
//     appBarTitle = subHeadingText("Pledge Securities");
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
//           body: myCartData != null ? allPledgeData(myCartData!.data!):Container()),
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
//         icon: Icon(
//           Icons.arrow_back_ios,
//           color: colorDarkGray,
//           size: 17,
//         ),
//         onPressed: () {
//           Navigator.pop(context);
//         },
//       ),
//       actions: <Widget>[
//         Theme(
//           data: theme.copyWith(primaryColor: Colors.white),
//           child: new IconButton(
//             icon: actionIcon,
//             onPressed: () {
//               setState(() {
//                 if (this.actionIcon.icon == Icons.search) {
//                   this.actionIcon = new Icon(
//                     Icons.close,
//                     color: appTheme,
//                     size: 25,
//                   );
//                   this.appBarTitle = new TextField(
//                     controller: _textController,
//                     focusNode: focusNode,
//                     style: new TextStyle(
//                       color: appTheme,
//                     ),
//                     cursorColor: appTheme,
//                     decoration: new InputDecoration(
//                         prefixIcon: new Icon(
//                           Icons.search,
//                           color: appTheme,
//                           size: 25,
//                         ),
//                         hintText: "Search...",
//                         focusColor: appTheme,
//                         border: InputBorder.none,
//                         hintStyle: new TextStyle(color: appTheme)),
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
// //        IconButton(
// //            icon: Image.asset(
// //              AssetsImagePath.new_cart,
// //              height: 25,
// //              width: 25,
// //              color: appTheme,
// //            ),
// //            onPressed: () {
// //              sendMyCart();
// //            })
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
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
//                   child: marginShortFall(context,
//                       marginShortfallObj!.loanBalance,
//                       marginShortfallObj!.minimumPledgeAmount,
//                       marginShortfallObj!.minimumCashAmount,
//                       drawingPower,
//                       AssetsImagePath.business_finance,
//                       colorLightRed,
//                       false, Strings.shares),
//                 ),
//                 // pledgeCart(totalValue,totalScrips,resetValue!,"TOTAL VALUE OF SELECTED SECURITIES"),
//               ]),
//             )
//           ];
//         },
//         body: Column(
//           children: <Widget>[
//             _textController.text.isNotEmpty ? SizedBox() : Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   scripsNameText(encryptAcNo(widget.stockAt)),
//                   SizedBox(height: 10),
//                   SizedBox(
//                     child: GestureDetector(
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Text(Strings.filter, style: regularTextStyle_14),
//                           SizedBox(width: 4),
//                           Icon(Icons.filter_alt_rounded, size: 24, color: appTheme)
//                         ],
//                       ),
//                       onTap: () {
//                         showModalBottomSheet(
//                           backgroundColor: Colors.transparent,
//                           context: context,
//                           isScrollControlled: true,
//                           builder: (BuildContext context) {
//                             return filerDialogShare();
//                           },
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             // Padding(
//             //   padding: const EdgeInsets.fromLTRB(5, 1, 5, 5),
//             //   child: marginShortFall(context,
//             //       marginShortfallObj!.loanBalance,
//             //       marginShortfallObj!.minimumCollateralValue,
//             //       marginShortfallObj!.minimumPledgeAmount,
//             //       marginShortfallObj!.minimumCashAmount,
//             //       marginShortfallObj!.totalCollateralValue,
//             //       drawingPower,
//             //       AssetsImagePath.business_finance,
//             //       colorLightRed,
//             //       false, Strings.shares),
//             // ),
//             Expanded(
//               child: SingleChildScrollView(
//                 physics: NeverScrollableScrollPhysics(),
//                 child: pledgeSecuritiesList(),
//               ),
//             ),
//             showSecurityValue ? bottomSection(myCartData) : bottomSectionEL(myCartData),
//           ],
//         )
//     );
//   }
//
//   filerDialogShare() {
//     List<bool> lenderCheckBox = [];
//     lenderCheckBox.addAll(selectedBoolLenderList);
//     List<bool> levelCheckBox = [];
//     levelCheckBox.addAll(selectedBoolLevelList);
//
//     return Container(
//       height: MediaQuery.of(context).size.height - 200,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.white, width: 3.0),
//         borderRadius: BorderRadius.only(topRight: Radius.circular(16.0), topLeft: Radius.circular(16.0)),
//         boxShadow: [
//           BoxShadow(blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
//         ],
//       ),
//       child: NestedScrollView(
//         physics: NeverScrollableScrollPhysics(),
//         headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//           return <Widget>[
//             SliverList(
//               delegate: SliverChildListDelegate([SizedBox(height: 1)]),
//             )
//           ];
//         },
//         body: Padding(
//           padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: <Widget>[
//               Expanded(
//                 child: SingleChildScrollView(
//                   physics: NeverScrollableScrollPhysics(),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(height: 10),
//                       Text(Strings.lender, style: boldTextStyle_18.copyWith(fontSize: 20)),
//                       StatefulBuilder(
//                         builder: (BuildContext context, StateSetter s) {
//                           return ListView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: lenderList.length,
//                             itemBuilder: (context, index) {
//                               return CheckboxListTile(
//                                 contentPadding: EdgeInsets.zero,
//                                 onChanged: (val) => null,
//                                 value: true,
//                                 title: Text(lenderList[index]),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                       SizedBox(height: 20),
//                       Text(Strings.level, style: boldTextStyle_18.copyWith(fontSize: 20)),
//                       StatefulBuilder(
//                         builder: (BuildContext context, StateSetter s) {
//                           return ListView.builder(
//                             physics: NeverScrollableScrollPhysics(),
//                             shrinkWrap: true,
//                             itemCount: levelList.length,
//                             itemBuilder: (context, index) {
//                               return CheckboxListTile(
//                                 contentPadding: EdgeInsets.zero,
//                                 onChanged: (val) {
//                                   s(() {
//                                     levelCheckBox[index] = val!;
//                                     if(!levelCheckBox.contains(true)){
//                                       Utility.showToastMessage("Atleast one level is mandatory");
//                                       levelCheckBox[index] = !val;
//                                     }
//                                   });
//                                 },
//                                 value: levelCheckBox[index],
//                                 title: Text(levelList[index]),
//                               );
//                             },
//                           );
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Expanded(
//                     child: Container(
//                       height: 40,
//                       width: 100,
//                       child: Material(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(35),
//                             side: BorderSide(color: red)),
//                         elevation: 1.0,
//                         color: colorWhite,
//                         child: MaterialButton(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () async {
//                             Navigator.pop(context);
//                           },
//                           child: Text(
//                             Strings.cancel,
//                             style: buttonTextRed,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   SizedBox(width: 10),
//                   Expanded(
//                     child: Container(
//                       height: 40,
//                       width: 100,
//                       child: Material(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(35)),
//                         elevation: 1.0,
//                         color: appTheme,
//                         child: MaterialButton(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () async {
//                             Utility.isNetworkConnection()
//                                 .then((isNetwork){
//                               if (isNetwork){
//                                 setState(() {
//                                   if(!levelCheckBox.contains(true)){
//                                     Utility.showToastMessage("Atleast one level is mandatory");
//                                   } else {
//                                     selectedLenderList.clear();
//                                     selectedLevelList.clear();
//                                     for (int i = 0; i < lenderList.length; i++) {
//                                       if (lenderCheckBox[i]) {
//                                         selectedLenderList.add(lenderList[i]);
//                                         selectedBoolLenderList[i] = true;
//                                       } else {
//                                         selectedBoolLenderList[i] = false;
//                                       }
//                                     }
//
//                                     for (int i = 0; i < levelList.length; i++) {
//                                       if (levelCheckBox[i]) {
//                                         selectedLevelList.add(levelList[i].toString().split(" ")[1]);
//                                         selectedBoolLevelList[i] = true;
//                                       } else {
//                                         selectedBoolLevelList[i] = false;
//                                       }
//                                     }
//                                     Navigator.pop(context);
//                                     shareSecuritiesListItems.clear();
//                                     myCartList.clear();
//                                     isAddBtnShow.clear();
//                                     searchMyCartList.clear();
//                                     LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//                                     _handleSearchEnd();
//                                     loanApplicationBloc.getSecurities(SecuritiesRequest(
//                                         lender: selectedLenderList.join(","),
//                                         level: selectedLevelList.join(","),
//                                         demat:  widget.stockAt)).then((
//                                         value) async {
//                                       Navigator.pop(context);
//                                       if (value.isSuccessFull!) {
//                                         Securities securitiesObj = new Securities();
//                                         for (int i = 0; i < value.securityData!.securities!.length; i++) {
//                                           if(value.securityData!.securities != null){
//                                             if (value.securityData!.securities![i].isEligible == true && value.securityData!.securities![i].quantity != 0
//                                                 && value.securityData!.securities![i].price != 0 && value.securityData!.securities![i].stockAt == widget.stockAt){
//                                               shareSecuritiesListItems.add(new SecuritiesList(
//                                                   quantity: value.securityData!.securities![i].quantity,
//                                                   isin: value.securityData!.securities![i].iSIN,
//                                                   price: value.securityData!.securities![i].price,
//                                                   qty: value.securityData!.securities![i].quantity));
//                                             }
//                                           }
//                                         }
//
//                                         securitiesObj.list = shareSecuritiesListItems;
//                                         MyCartRequestBean myCartRequestBean = MyCartRequestBean();
//                                         myCartRequestBean.securities = securitiesObj;
//                                         myCartRequestBean.pledgor_boid = widget.stockAt;
//                                         myCartRequestBean.loamName = widget.loan_name;
//                                         myCartRequestBean.loan_margin_shortfall_name = widget.loanMarginshortfallName;
//                                         myCartRequestBean.lender = "";
//                                         myCartRequestBean.cartName = "";
//                                         print("length of list ==> ${shareSecuritiesListItems.length}");
//                                         if(shareSecuritiesListItems.length != 0){
//                                           LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//                                           myCartData = await loanApplicationBloc.myCart(myCartRequestBean);
//                                           if(myCartData !=null){
//                                             Navigator.pop(context);
//                                             setState(() {
//                                               if (myCartData!.isSuccessFull!) {
//                                                 marginShortfallObj = myCartData!.data!.loanMarginShortfallObj;
//                                                 cartData = myCartData!.data!.cart!;
//                                                 drawingPower = myCartData!.data!.loanMarginShortfallObj!.drawingPower;
//                                                 minSanctionedLimit = myCartData!.data!.minSanctionedLimit;
//                                                 maxSanctionedLimit = myCartData!.data!.maxSanctionedLimit;
//                                                 for(int i=0; i<myCartData!.data!.cart!.items!.length; i++){
//                                                   if(myCartData!.data!.cart!.items![i].amount != 0){
//                                                     myCartList.add(myCartData!.data!.cart!.items![i]);
//                                                     isAddBtnShow.add(true);
//                                                   }
//                                                 }
//                                                 searchMyCartList.addAll(myCartList);
//                                                 totalValue = 0.0;
//                                                 tempLength = myCartList.length;
//                                                 totalScrips = 0;
//                                                 eligibleLoan = 0.0;
//                                                 scripNameList = List.generate(cartData.items!.length, (index) => cartData.items![index].securityName!);
//                                               } else if (myCartData!.errorCode == 403) {
//                                                 commonDialog(context, Strings.session_timeout, 4);
//                                               } else {
//                                                 status = myCartData!.errorCode;
//                                                 Utility.showToastMessage(myCartData!.errorMessage!);
//                                               }
//                                             });
//                                           } else {
//                                             Navigator.pop(context);
//                                             Utility.showToastMessage(myCartData!.errorMessage!);
//                                           }
//                                         }
//                                       } else if (value.errorCode == 403) {
//                                         commonDialog(context, Strings.session_timeout, 4);
//                                       } else if (value.errorCode == 404) {
//                                         commonDialog(context, Strings.not_fetch, 0);
//                                       } else {
//                                         Utility.showToastMessage(value.errorMessage!);
//                                       }
//                                     });
//                                   }
//                                 });
//                               } else {
//                                 Utility.showToastMessage(Strings.no_internet_message);
//                               }
//                             });
//                           },
//                           child: Text(
//                             Strings.apply,
//                             style: buttonTextWhite,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget pledgeSecuritiesList() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, top: 0, right: 20,bottom: 60),
//       child: myCartList.length == 0 ? Padding(
//         padding: const EdgeInsets.only(top: 50.0),
//         child: Text("No Data"),
//       ) :ListView.builder(
//         key: Key(myCartList.length.toString()),
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: myCartList.length,
//         itemBuilder: (context, index) {
//           int actualIndex = searchMyCartList.indexWhere((element) => element.securityName == myCartList[index].securityName);
//           isAddBtnShow.add(true);
//           checkBoxValues.add(true);
//           isUpateBtnClickableList.add(true);
//           myCartList[index].check = true;
//           myCartList[index].remaningQty = widget.securities[actualIndex].quantity!.toInt();
//
//           var pledge_qty;
//           pledge_qty = myCartList[index].pledgedQuantity!.toInt().toString();
//           _controllers[myCartList[index].isin!] = TextEditingController(text: pledge_qty);
//           _controllers[myCartList[index].isin]!.selection = TextSelection.fromPosition(
//               TextPosition(offset: _controllers[myCartList[index].isin]!.text.length));
//           pledgeControllerEnable.add(false);
//           scriptValue = roundDouble(myCartList[index].amount!.toDouble(), 2);
//
//           var qty;
//           String str = widget.securities[actualIndex].quantity.toString();
//           var qtyArray = str.split('.');
//           qty = qtyArray[0];
//           var remainingAmount;
//           remainingAmount = _controllers[myCartList[index].isin]!.text != ""
//               ? int.parse(qty) - int.parse(_controllers[myCartList[index].isin]!.text)
//               : 0;
//
//           return Container(
//             margin: EdgeInsets.symmetric(vertical: 10.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.white, width: 3.0),
//               // set border width
//               borderRadius: BorderRadius.all(Radius.circular(10.0)), // set rounded corner radius
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 // CheckboxListTile(
//                 //     controlAffinity: ListTileControlAffinity.trailing,
//                 //     activeColor: colorGreen,
//                 //     checkColor: colorWhite,
//                 //     onChanged: (bool? value) {
//                 //       checkBoxValues[actualIndex] = value!;
//                 //       setState(() {
//                 //         if (checkBoxValues[actualIndex]) {
//                 //           // _controllers2[myCartList[index].isin].text =
//                 //           //     myCartList[index].pledgedQuantity.toString();
//                 //           myCartList[index].pledgedQuantity = widget.securities[actualIndex].quantity!.toDouble();
//                 //           _controllers2[myCartList[index].isin]!.text = myCartList[index].pledgedQuantity.toString();
//                 //           // myCartList[index].amount = double.parse(_controllers2[myCartList[index].isin].text) *
//                 //           //     myCartList[index].price;
//                 //           myCartList[index].amount = double.parse(_controllers2[myCartList[index].isin]!.text) * myCartList[index].price!;
//                 //           if (totalScrips == 0) {
//                 //             totalScrips = 0;
//                 //             totalValue = 0.0 + myCartList[index].amount!;
//                 //           } else {
//                 //             totalValue = cartData.totalCollateralValue! + myCartList[index].amount!;
//                 //           }
//                 //           cartData.totalCollateralValue = totalValue;
//                 //           eligibleLoan = cartData.totalCollateralValue! / 2;
//                 //           myCartList[index].check = true;
//                 //           setState(() {
//                 //             totalScrips = totalScrips + 1;
//                 //           });
//                 //           if(myCartList.length == totalScrips){
//                 //             checkBoxValue = true;
//                 //           }
//                 //         } else {
//                 //           totalValue = cartData.totalCollateralValue! - myCartList[index].amount!;
//                 //           cartData.totalCollateralValue = totalValue;
//                 //           myCartList[index].amount = 0.0;
//                 //           _controllers2[myCartList[index].isin]!.text = "0";
//                 //           myCartList[index].pledgedQuantity = double.parse(_controllers2[myCartList[index].isin]!.text);
//                 //           eligibleLoan = cartData.totalCollateralValue! / 2;
//                 //           // totalScrips = tempList.length - 1;
//                 //           // tempList.length = totalScrips;
//                 //           setState(() {
//                 //             totalScrips = totalScrips - 1;
//                 //             checkBoxValue = false;
//                 //           });
//                 //         }
//                 //         if (tempLength == myCartList.length) {
//                 //           isScripsSelect = false;
//                 //         } else {
//                 //           isScripsSelect = true;
//                 //         }
//                 //       });
//                 //     },
//                 //     value: checkBoxValues[actualIndex],
//                 //     title: scripsNameText(myCartList[index].securityName)),
//                 Text(myCartList[index].securityName!, style: boldTextStyle_18),
//                 SizedBox(height: 4),
//                 Text("${myCartList[index].securityCategory!} (LTV: ${myCartList[index].eligiblePercentage!.toStringAsFixed(2)}%)",
//                     style: boldTextStyle_12_gray),
//                 SizedBox(height: 4),
//                 Padding(
//                   padding: const EdgeInsets.only(left: 5, right: 5, bottom: 5),
//                   // child: Table(children: [
//                   //   TableRow(children: [
//                   //     Column(
//                   //       crossAxisAlignment: CrossAxisAlignment.start,
//                   //       children: <Widget>[
//                   //         scripsValueText(qty.toString()),
//                   //         SizedBox(
//                   //           height: 5,
//                   //         ),
//                   //         mediumHeadingText(Strings.qty),
//                   //       ],
//                   //     ),
//                   //     Column(
//                   //       crossAxisAlignment: CrossAxisAlignment.start,
//                   //       children: <Widget>[
//                   //         scripsValueText(myCartList[index].price!.toStringAsFixed(2)),
//                   //         SizedBox(
//                   //           height: 5,
//                   //         ),
//                   //         mediumHeadingText(Strings.price),
//                   //       ],
//                   //     ),
//                   //     Column(
//                   //       crossAxisAlignment: CrossAxisAlignment.start,
//                   //       children: <Widget>[
//                   //         scripsValueText(scriptValue.toStringAsFixed(2)),
//                   //         SizedBox(
//                   //           height: 5,
//                   //         ),
//                   //         mediumHeadingText(Strings.value),
//                   //       ],
//                   //     ),
//                   //   ]),
//                   // ]),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Container(
//                         width: (MediaQuery.of(context).size.width - 150) / 3,
//                         child: Row(
//                           children: [
//                             Expanded(
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   scripsValueText("₹${myCartList[index].price!.toStringAsFixed(2)}"),
//                                   SizedBox(height: 8),
//                                   Row(
//                                     children: [
//                                       Expanded(child: Text("${myCartList[index].remaningQty.toString()} QTY", style: mediumTextStyle_12_gray)),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                       isAddBtnShow[actualIndex] ?
//                       Container(
//                         height: 30,
//                         width: 70,
//                         child: Material(
//                           color: appTheme,
//                           shape:
//                           RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           elevation: 1.0,
//                           child: MaterialButton(
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                             minWidth: MediaQuery.of(context).size.width,
//                             onPressed: () {
//                               Utility.isNetworkConnection().then((isNetwork) {
//                                 if (isNetwork) {
//                                   setState(() {
//                                     FocusScope.of(context).unfocus();
//                                     isAddBtnShow[actualIndex] = false;
//                                     _controllers[myCartList[index].isin]!.text = "1";
//                                     myCartList[index].pledgedQuantity = 1.0;
//                                     totalValue = 0;
//                                     eligibleLoan = 0;
//                                     for(int i =0; i< searchMyCartList.length; i++){
//                                       if(!isAddBtnShow[i]){
//                                         totalValue += searchMyCartList[i].price! * double.parse(_controllers[searchMyCartList[i].isin]!.text);
//                                         eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers[myCartList[i].isin]!.text) * searchMyCartList[i].eligiblePercentage! / 100;
//                                       }
//                                     }
//                                     totalScrips = totalScrips + 1;
//                                     print("totalcrips --> ${totalScrips.toString()}");
//                                     print("mycart list --> ${myCartList.length.toString()}");
//                                     if(myCartList.length == totalScrips){
//                                       checkBoxValue = true;
//                                     }else{
//                                       checkBoxValue = false;
//                                     }
//                                   });
//                                 } else {
//                                   Utility.showToastMessage(Strings.no_internet_message);
//                                 }
//                               });
//                             },
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Text("Add +",
//                                   style: TextStyle(color: colorWhite, fontSize: 10, fontWeight: bold),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ),
//                       ) : Column(
//                         children: [
//                           Row(
//                             children: <Widget>[
//                               IconButton(
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
//                                       int txt = int.parse(_controllers[myCartList[index].isin]!.text) - 1;
//                                       setState(() {
//                                         FocusScope.of(context).requestFocus(new FocusNode());
//                                         if (!isAddBtnShow[actualIndex]) {
//                                           if (txt != 0) {
//                                             if ((double.parse(_controllers[myCartList[index].isin]!.text) <= widget.securities[actualIndex].quantity!)) {
//                                               _controllers[myCartList[index].isin]!.text = txt.toString();
//                                               myCartList[index].pledgedQuantity = myCartList[index].pledgedQuantity! - 1;
//                                               myCartList[index].amount = txt * myCartList[index].price!;
//                                               totalValue = 0;
//                                               eligibleLoan = 0;
//                                               for(int i =0; i< searchMyCartList.length; i++){
//                                                 if(!isAddBtnShow[i]){
//                                                   totalValue += searchMyCartList[i].price! * double.parse(_controllers[searchMyCartList[i].isin]!.text);
//                                                   eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers[myCartList[i].isin]!.text) * searchMyCartList[i].eligiblePercentage! / 100;
//                                                 }
//                                               }
//                                               cartData.totalCollateralValue = totalValue;
//                                             } else {
//                                               Utility.showToastMessage(Strings.check_quantity);
//                                             }
//                                           }else{
//                                             setState(() {
//                                               FocusScope.of(context).unfocus();
//                                               isAddBtnShow[actualIndex] = true;
//                                               totalScrips = totalScrips - 1;
//                                               checkBoxValue = false;
//                                               _controllers[myCartList[index].isin]!.text = "0";
//                                               myCartList[index].pledgedQuantity = 0;
//                                               totalValue = 0;
//                                               eligibleLoan = 0;
//                                               for(int i =0; i< searchMyCartList.length; i++){
//                                                 if(!isAddBtnShow[i]){
//                                                   totalValue += searchMyCartList[i].price! * double.parse(_controllers[searchMyCartList[i].isin]!.text);
//                                                   eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers[myCartList[i].isin]!.text) * searchMyCartList[i].eligiblePercentage! / 100;
//                                                 }
//                                               }
//                                             });
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
//                               Container(
//                                 width: 50,
//                                 height: 15,
//                                 child: TextField(
//                                   textAlign: TextAlign.center,
//                                   decoration: InputDecoration(counterText: ""),
//                                   maxLength: 4,
//                                   keyboardType: TextInputType.numberWithOptions(decimal: true),
//                                   inputFormatters: [
//                                     FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//                                   ],
//                                   controller: _controllers[myCartList[index].isin],
//                                   style: TextStyle(
//                                     fontWeight: FontWeight.w600,
//                                   ),
//                                   onChanged: (value) {
//                                     if (!isAddBtnShow[actualIndex]) {
//                                       if (_controllers[myCartList[index].isin]!.text.isNotEmpty) {
//                                         if (_controllers[myCartList[index].isin]!.text != "0") {
//                                           if (int.parse(_controllers[myCartList[index].isin]!.text) < 1) {
//                                             Utility.showToastMessage(Strings.message_quantity_not_less_1);
//                                             FocusScope.of(context).requestFocus(new FocusNode());
//                                           } else if (double.parse(_controllers[myCartList[index].isin]!.text) > widget.securities[actualIndex].quantity!) {
//                                             Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${qty} quantity.");
//                                             FocusScope.of(context).requestFocus(new FocusNode());
//                                             setState(() {
//                                               _controllers[myCartList[index].isin]!.text = myCartList[index].pledgedQuantity.toString();
//                                               myCartList[index].pledgedQuantity = double.parse(_controllers[myCartList[index].isin]!.text);
//                                               var updateAmount = double.parse(_controllers[myCartList[index].isin]!.text) * myCartList[index].price!;
//                                               var updateValue = cartData.totalCollateralValue! - myCartList[index].amount!;
//                                               myCartList[index].amount = updateAmount;
//                                               totalValue = 0;
//                                               eligibleLoan = 0;
//                                               for(int i =0; i< searchMyCartList.length; i++){
//                                                 if(!isAddBtnShow[i]){
//                                                   totalValue += searchMyCartList[i].price! * double.parse(_controllers[searchMyCartList[i].isin]!.text);
//                                                   eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers[myCartList[i].isin]!.text) * searchMyCartList[i].eligiblePercentage! / 100;
//                                                 }
//                                               }
//                                               cartData.totalCollateralValue = totalValue;
//                                             });
//                                             // remainingValues[index] = 0;
//                                           } else {
//                                             myCartList[index].pledgedQuantity = double.parse(_controllers[myCartList[index].isin]!.text);
//                                             var updateAmount = double.parse(_controllers[myCartList[index].isin]!.text) * myCartList[index].price!;
//                                             var updateValue = cartData.totalCollateralValue! - myCartList[index].amount!;
//                                             totalValue = 0;
//                                             eligibleLoan = 0;
//                                             for(int i =0; i< searchMyCartList.length; i++){
//                                               if(!isAddBtnShow[i]){
//                                                 totalValue += searchMyCartList[i].price! * double.parse(_controllers[searchMyCartList[i].isin]!.text);
//                                                 eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers[myCartList[i].isin]!.text) * searchMyCartList[i].eligiblePercentage! / 100;
//                                               }
//                                             }
//                                             cartData.totalCollateralValue = totalValue;
//                                             myCartList[index].amount = updateAmount;
//                                           }
//                                         } else {
//                                           setState(() {
//                                             _controllers[myCartList[index].isin]!.text = "";
//                                             _controllers[myCartList[index].isin]!.text = "1";
//                                             myCartList[index].pledgedQuantity = 1;
//                                             totalValue = 0;
//                                             eligibleLoan = 0;
//                                             for(int i =0; i< searchMyCartList.length; i++){
//                                               if(!isAddBtnShow[i]){
//                                                 totalValue += searchMyCartList[i].price! * double.parse(_controllers[searchMyCartList[i].isin]!.text);
//                                                 eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers[myCartList[i].isin]!.text) * searchMyCartList[i].eligiblePercentage! / 100;
//                                               }
//                                             }
//                                             var updateAmount = double.parse(_controllers[myCartList[index].isin]!.text) * myCartList[index].price!;
//                                             myCartList[index].amount = updateAmount;
//                                             FocusScope.of(context).requestFocus(new FocusNode());
//                                           });
//                                         }
//                                       } else {
//                                         // myCartList[index].pledgedQuantity = 0;
//                                       }
//                                     } else {
//                                       FocusScope.of(context).requestFocus(new FocusNode());
//                                       Utility.showToastMessage(Strings.validation_select_checkbox);
//                                     }
//                                   },
//                                 ),
//                               ),
//                               Padding(
//                                 padding: EdgeInsets.only(left: 0.0),
//                                 child: IconButton(
//                                   icon: Container(
//                                     padding: EdgeInsets.all(2),
//                                     decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.circular(100),
//                                         border: Border.all(width: 1, color: colorBlack)),
//                                     child: Icon(
//                                       Icons.add,
//                                       color: colorBlack,
//                                       size: 18,
//                                     ),
//                                   ),
//                                   onPressed: () async {
//                                     Utility.isNetworkConnection().then((isNetwork) {
//                                       if (isNetwork) {
//                                         if (int.parse(_controllers[myCartList[index].isin]!.text) < int.parse(qty)) {
//                                           int txt = int.parse(_controllers[myCartList[index].isin]!.text) + 1;
//                                           setState(() {
//                                             if (!isAddBtnShow[actualIndex]) {
//
//                                               _controllers[myCartList[index].isin]!.text = txt.toString();
//                                               myCartList[index].pledgedQuantity = myCartList[index].pledgedQuantity! + 1;
//                                               myCartList[index].amount = txt * myCartList[index].price!;
//                                               totalValue = 0;
//                                               eligibleLoan = 0;
//                                               for(int i =0; i< searchMyCartList.length; i++){
//                                                 if(!isAddBtnShow[i]){
//                                                   totalValue += searchMyCartList[i].price! * double.parse(_controllers[searchMyCartList[i].isin]!.text);
//                                                   eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers[myCartList[i].isin]!.text) * searchMyCartList[i].eligiblePercentage! / 100;
//                                                 }
//                                               }
//                                               cartData.totalCollateralValue = totalValue;
//                                             } else {
//                                               isAddBtnShow[actualIndex] = true;
//                                               myCartList[index].check = true;
//                                               totalScrips = totalScrips + 1;
//
//                                               _controllers[myCartList[index].isin]!.text = txt.toString();
//                                               myCartList[index].pledgedQuantity = myCartList[index].pledgedQuantity! + 1;
//                                               myCartList[index].amount = txt * myCartList[index].price!;
//                                               totalValue = 0;
//                                               eligibleLoan = 0;
//                                               for(int i =0; i< searchMyCartList.length; i++){
//                                                 if(!isAddBtnShow[i]){
//                                                   totalValue += searchMyCartList[i].price! * double.parse(_controllers[searchMyCartList[i].isin]!.text);
//                                                   eligibleLoan += searchMyCartList[i].price! * double.parse(_controllers[myCartList[i].isin]!.text) * searchMyCartList[i].eligiblePercentage! / 100;
//                                                 }
//                                               }
//                                               cartData.totalCollateralValue = totalValue;
//                                             }
//                                             if(myCartList.length == totalScrips){
//                                               checkBoxValue = true;
//                                             }
//                                           });
//                                         } else {
//                                           Utility.showToastMessage(Strings.check_quantity);
//                                         }
//                                       } else {
//                                         Utility.showToastMessage(Strings.no_internet_message);
//                                       }
//                                     });
//                                   },
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Container(
//                         width: 72,
//                         height: 73,
//                         child: Container(
//                           alignment: Alignment.center,
//                           decoration: BoxDecoration(
//                             color: colorRed,
//                             borderRadius: BorderRadius.all(
//                                 Radius.circular(100.0)),
//                           ),
//                           child:Text(getInitials(myCartList[index].securityName, 1), style: extraBoldTextStyle_30),
//                           // Text(getInitials(showSecurityList[index].scripName, 1), style: extraBoldTextStyle_30),
//                           // : Text(schemesList[index].amcCode!, style: extraBoldTextStyle_30),
//                         ), //Container ,
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 // Padding(
//                 //   padding: EdgeInsets.only(left: 10, right: 10),
//                 //   child: Divider(
//                 //     thickness: 0.5,
//                 //   ),
//                 // ),
//                 // Padding(
//                 //   padding: const EdgeInsets.only(left: 15),
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 //     children: <Widget>[
//                 //       Column(
//                 //         crossAxisAlignment: CrossAxisAlignment.start,
//                 //         children: <Widget>[
//                 //           scripsNameText(Strings.pledge_qty),
//                 //           SizedBox(
//                 //             height: 5,
//                 //           ),
//                 //           Text(
//                 //             "${Strings.remaining + " " + remainingAmount.toString()}",
//                 //             style: kSecurityLiteStyle,
//                 //           )
//                 //         ],
//                 //       ),
//                 //       Padding(
//                 //         padding: const EdgeInsets.only(left: 15),
//                 //         child: Row(
//                 //           children: <Widget>[
//                 //             Padding(
//                 //               padding: EdgeInsets.only(left: 0.0),
//                 //               child: IconButton(
//                 //                 iconSize: 20.0,
//                 //                 icon: Container(
//                 //                   padding: EdgeInsets.all(2),
//                 //                   decoration: BoxDecoration(
//                 //                       borderRadius: BorderRadius.circular(100),
//                 //                       border: Border.all(width: 1, color: Colors.grey)),
//                 //                   child: Icon(
//                 //                     Icons.remove,
//                 //                     color: Colors.grey.shade600,
//                 //                     size: 18,
//                 //                   ),
//                 //                 ),
//                 //                 onPressed: () async {
//                 //                   Utility.isNetworkConnection().then((isNetwork) {
//                 //                     if (isNetwork) {
//                 //                       int txt = int.parse(
//                 //                           _controllers2[myCartList[index].isin]!.text) -
//                 //                           1;
//                 //                       setState(() {
//                 //                         FocusScope.of(context).requestFocus(new FocusNode());
//                 //                         if (checkBoxValues[actualIndex]) {
//                 //                           if (txt != 0) {
//                 //                             if ((double.parse(
//                 //                                 _controllers2[myCartList[index].isin]!
//                 //                                     .text) <=
//                 //                                 widget.securities[actualIndex].quantity!)) {
//                 //                               _controllers2[myCartList[index].isin]!.text =
//                 //                                   txt.toString();
//                 //                               myCartList[index].pledgedQuantity = myCartList[index].pledgedQuantity! - 1;
//                 //                               myCartList[index].amount =
//                 //                                   txt * myCartList[index].price!;
//                 //                               totalValue = cartData.totalCollateralValue! -
//                 //                                   myCartList[index].price!;
//                 //                               cartData.totalCollateralValue = totalValue;
//                 //                               eligibleLoan = cartData.totalCollateralValue! / 2;
//                 //                             } else {
//                 //                               Utility.showToastMessage(Strings.check_quantity);
//                 //                             }
//                 //                           }
//                 //                         } else {
//                 //                           Utility.showToastMessage(Strings.validation_select_checkbox);
//                 //                         }
//                 //                       });
//                 //                     } else {
//                 //                       Utility.showToastMessage(Strings.no_internet_message);
//                 //                     }
//                 //                   });
//                 //                 },
//                 //               ),
//                 //             ),
//                 //             Container(
//                 //               width: 50,
//                 //               height: 15,
//                 //               child: TextField(
//                 //                 textAlign: TextAlign.center,
//                 //                 decoration: InputDecoration(counterText: ""),
//                 //                 maxLength: 4,
//                 //                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 //                 inputFormatters: [
//                 //                   FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//                 //                 ],
//                 //                 controller: _controllers2[myCartList[index].isin],
//                 //                 style: TextStyle(
//                 //                   fontWeight: FontWeight.w600,
//                 //                 ),
//                 //                 onChanged: (value) {
//                 //                   if (checkBoxValues[actualIndex]) {
//                 //                     if (_controllers2[myCartList[index].isin]!.text.isNotEmpty) {
//                 //                       if (_controllers2[myCartList[index].isin]!.text != "0") {
//                 //                         if (int.parse(_controllers2[myCartList[index].isin]!.text) < 1) {
//                 //                           Utility.showToastMessage(Strings.message_quantity_not_less_1);
//                 //                           FocusScope.of(context).requestFocus(new FocusNode());
//                 //                         } else if (double.parse(_controllers2[myCartList[index].isin]!.text) > widget.securities[actualIndex].quantity!) {
//                 //                           Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${qty} quantity.");
//                 //                           FocusScope.of(context).requestFocus(new FocusNode());
//                 //                           setState(() {
//                 //                             _controllers2[myCartList[index].isin]!.text = myCartList[index].pledgedQuantity.toString();
//                 //                             myCartList[index].pledgedQuantity = double.parse(_controllers2[myCartList[index].isin]!.text);
//                 //                             var updateAmount = double.parse(_controllers2[myCartList[index].isin]!.text) * myCartList[index].price!;
//                 //                             var updateValue = cartData.totalCollateralValue! - myCartList[index].amount!;
//                 //                             totalValue = updateValue + updateAmount;
//                 //                             cartData.totalCollateralValue = totalValue;
//                 //                             eligibleLoan = cartData.totalCollateralValue! / 2;
//                 //                             myCartList[index].amount = updateAmount;
//                 //                           });
//                 //                           // remainingValues[index] = 0;
//                 //                         } else {
//                 //                           myCartList[index].pledgedQuantity = double.parse(_controllers2[myCartList[index].isin]!.text);
//                 //                           var updateAmount = double.parse(_controllers2[myCartList[index].isin]!.text) * myCartList[index].price!;
//                 //                           var updateValue = cartData.totalCollateralValue! - myCartList[index].amount!;
//                 //                           totalValue = updateValue + updateAmount;
//                 //                           cartData.totalCollateralValue = totalValue;
//                 //                           eligibleLoan = cartData.totalCollateralValue! / 2;
//                 //                           myCartList[index].amount = updateAmount;
//                 //                         }
//                 //                       } else {
//                 //                         setState(() {
//                 //                           _controllers2[myCartList[index].isin]!.text = "";
//                 //                           _controllers2[myCartList[index].isin]!.text = "1";
//                 //                           myCartList[index].pledgedQuantity = 1;
//                 //                           var updateAmount = double.parse(_controllers2[myCartList[index].isin]!.text) * myCartList[index].price!;
//                 //                           myCartList[index].amount = updateAmount;
//                 //                           FocusScope.of(context).requestFocus(new FocusNode());
//                 //                         });
//                 //                       }
//                 //                     } else {
//                 //                       // myCartList[index].pledgedQuantity = 0;
//                 //                     }
//                 //                   } else {
//                 //                     FocusScope.of(context).requestFocus(new FocusNode());
//                 //                     Utility.showToastMessage(Strings.validation_select_checkbox);
//                 //                   }
//                 //                 },
//                 //               ),
//                 //             ),
//                 //             Padding(
//                 //               padding: EdgeInsets.only(left: 0.0),
//                 //               child: IconButton(
//                 //                 icon: Container(
//                 //                   padding: EdgeInsets.all(2),
//                 //                   decoration: BoxDecoration(
//                 //                       borderRadius: BorderRadius.circular(100),
//                 //                       border: Border.all(width: 1, color: Colors.grey)),
//                 //                   child: Icon(
//                 //                     Icons.add,
//                 //                     color: Colors.grey.shade600,
//                 //                     size: 18,
//                 //                   ),
//                 //                 ),
//                 //                 onPressed: () async {
//                 //                   Utility.isNetworkConnection().then((isNetwork) {
//                 //                     if (isNetwork) {
//                 //                       if (int.parse(_controllers2[myCartList[index].isin]!.text) < int.parse(qty)) {
//                 //                         int txt = int.parse(_controllers2[myCartList[index].isin]!.text) + 1;
//                 //                         setState(() {
//                 //                           if (checkBoxValues[actualIndex]) {
//                 //                             _controllers2[myCartList[index].isin]!.text = txt.toString();
//                 //                             myCartList[index].pledgedQuantity = myCartList[index].pledgedQuantity! + 1;
//                 //                             myCartList[index].amount = txt * myCartList[index].price!;
//                 //                             totalValue = cartData.totalCollateralValue! + myCartList[index].price!;
//                 //                             cartData.totalCollateralValue = totalValue;
//                 //                             eligibleLoan = cartData.totalCollateralValue! / 2;
//                 //                           } else {
//                 //                             checkBoxValues[actualIndex] = true;
//                 //                             myCartList[index].check = true;
//                 //                             totalScrips = totalScrips + 1;
//                 //
//                 //                             _controllers2[myCartList[index].isin]!.text = txt.toString();
//                 //                             myCartList[index].pledgedQuantity = myCartList[index].pledgedQuantity! + 1;
//                 //                             myCartList[index].amount = txt * myCartList[index].price!;
//                 //                             totalValue = cartData.totalCollateralValue! + myCartList[index].price!;
//                 //                             cartData.totalCollateralValue = totalValue;
//                 //                             eligibleLoan = cartData.totalCollateralValue! / 2;
//                 //                           }
//                 //                           if(myCartList.length == totalScrips){
//                 //                             checkBoxValue = true;
//                 //                           }
//                 //                         });
//                 //                       } else {
//                 //                         Utility.showToastMessage(Strings.check_quantity);
//                 //                       }
//                 //                     } else {
//                 //                       Utility.showToastMessage(Strings.no_internet_message);
//                 //                     }
//                 //                   });
//                 //                 },
//                 //               ),
//                 //             ),
//                 //           ],
//                 //         ),
//                 //       )
//                 //     ],
//                 //   ),
//                 // ),
//                 !isAddBtnShow[actualIndex] ? Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(Strings.value + " : ${(myCartList[index].price! * double.parse(_controllers[myCartList[index].isin]!.text.toString())).toStringAsFixed(2)}", style: mediumTextStyle_14_gray),
//
//                   ],
//                 ) : SizedBox(),
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
//   // Widget bottomSection(MyCartData myCartData) {
//   //   var requiredAmount =  roundDouble(double.parse(marginShortfallObj!.minimumCollateralValue.toString()), 2);
//   //   var availableAmount = roundDouble(double.parse(marginShortfallObj!.totalCollateralValue.toString()), 2);
//   //
//   //   if(totalScrips != 0){
//   //     if(totalValue >= double.parse(marginShortfallObj!.minimumPledgeAmount.toString())){
//   //       isScripsSelect = false;
//   //     } else {
//   //       isScripsSelect = true;
//   //     }
//   //   } else {
//   //     isScripsSelect = true;
//   //   }
//   //   return Container(
//   //     decoration: BoxDecoration(
//   //         color: Colors.white,
//   //         border: Border.all(color: Colors.white, width: 3.0),
//   //         borderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
//   //         boxShadow: [
//   //           BoxShadow(blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
//   //         ] // make rounded corner of border
//   //     ),
//   //     child: Container(
//   //       child: Column(
//   //         mainAxisAlignment: MainAxisAlignment.start,
//   //         mainAxisSize: MainAxisSize.min,
//   //         children: <Widget>[
//   //           Padding(
//   //             padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
//   //             child: Column(
//   //               children: <Widget>[
//   //                 SizedBox(
//   //                   height: 10,
//   //                 ),
//   //                 Row(
//   //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                   children: <Widget>[
//   //                     Expanded(child: bottomBoxText("Required collateral value")),
//   //                     scripsValueText('₹' + numberToString(requiredAmount.toStringAsFixed(2)))
//   //                   ],
//   //                 ),
//   //                 SizedBox(
//   //                   height: 10,
//   //                 ),
//   //                 Row(
//   //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                   children: <Widget>[
//   //                     Expanded(child: bottomBoxText("Available collateral value")),
//   //                     scripsValueText('₹' + numberToString(availableAmount.toStringAsFixed(2)))
//   //                   ],
//   //                 ),
//   //                 SizedBox(
//   //                   height: 10,
//   //                 ),
//   //                 Row(
//   //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                   children: <Widget>[
//   //                     Expanded(child: bottomBoxText("Selected securities value")),
//   //                     scripsValueText('₹' + numberToString(totalValue.toStringAsFixed(2)))
//   //                   ],
//   //                 ),
//   //                 Divider(
//   //                   thickness: 1.5,
//   //                 ),
//   //                 SizedBox(
//   //                   height: 10,
//   //                 ),
//   //                 Row(
//   //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//   //                   children: <Widget>[
//   //                     Text(
//   //                       "Shortfall",
//   //                       style: TextStyle(color: appTheme, fontWeight: FontWeight.bold, fontSize: 18),
//   //                     ),
//   //                     SizedBox(
//   //                       width: 15,
//   //                     ),
//   //                     Text(
//   //                       "Rs.${numberToString(marginShortfallObj!.minimumPledgeAmount!.toStringAsFixed(2))}",
//   //                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: red),
//   //                     ),
//   //                   ],
//   //                 ),
//   //               ],
//   //             ),
//   //           ),
//   //           Row(
//   //             mainAxisAlignment: MainAxisAlignment.center,
//   //             children: <Widget>[
//   //               IconButton(
//   //                 icon: ArrowBackwardNavigation(),
//   //                 onPressed: () {
//   //                   Navigator.pop(context);
//   //                 },
//   //               ),
//   //               Container(
//   //                 height: 45,
//   //                 width: 100,
//   //                 child: Material(
//   //                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//   //                   elevation: 1.0,
//   //                   color: isScripsSelect == true ? colorLightGray : appTheme,
//   //                   child: AbsorbPointer(
//   //                     absorbing: isScripsSelect!,
//   //                     child: MaterialButton(
//   //                       minWidth: MediaQuery.of(context).size.width,
//   //                       onPressed: () async {
//   //                         Utility.isNetworkConnection().then((isNetwork) {
//   //                           if (isNetwork) {
//   //                             sendMyCart();
//   //                           } else {
//   //                             Utility.showToastMessage(Strings.no_internet_message);
//   //                           }
//   //                         });
//   //                       },
//   //                       child: ArrowForwardNavigation(),
//   //                     ),
//   //                   ),
//   //                 ),
//   //               )
//   //             ],
//   //           ),
//   //         ],
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   Widget bottomSection(MyCartData myCartData) {
//     // var requiredAmount =  roundDouble(double.parse(marginShortfallObj!.minimumCollateralValue.toString()), 2);
//     // var availableAmount = roundDouble(double.parse(marginShortfallObj!.totalCollateralValue.toString()), 2);
//
//     if(totalScrips != 0){
//       if(totalValue >= double.parse(marginShortfallObj!.minimumCashAmount.toString())){
//         isScripsSelect = false;
//       } else {
//         isScripsSelect = true;
//       }
//     } else {
//       isScripsSelect = true;
//     }
//     return Visibility(
//         visible : showSecurityValue,
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.white, width: 3.0),
//             borderRadius:
//             BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
//             boxShadow: [
//               BoxShadow(blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
//             ] // make rounded corner of border
//         ),
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: Image.asset(
//                           AssetsImagePath.down_arrow_image,
//                           height: 15,
//                           width: 15,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             hideSecurityValue = true;
//                             showSecurityValue = false;
//                           });
//                         },
//                       )
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Expanded(child: Text(
//                               Strings.security_value,
//                               style: mediumTextStyle_18_gray,
//                             ),),
//                             scripsValueText('₹' + numberToString(totalValue.toStringAsFixed(2)))
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Expanded(child: Text(
//                               "Eligible Loan",
//                               style: mediumTextStyle_18_gray,
//                             ),),
//                             Text('₹' + numberToString(eligibleLoan.toStringAsFixed(2)), style: textStyleGreenStyle_18)
//                           ],
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     height: 50,
//                     width: 140,
//                     child: Material(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                       elevation: 1.0,
//                       color: isScripsSelect == true ? colorLightGray : appTheme,
//                       child: AbsorbPointer(
//                         absorbing: isScripsSelect!,
//                         child: MaterialButton(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () async {
//                             Utility.isNetworkConnection().then((isNetwork) {
//                               if (isNetwork) {
//                                 sendMyCart();
//                               } else {
//                                 Utility.showToastMessage(Strings.no_internet_message);
//                               }
//                             });
//                           },
//                           child: Text(Strings.view_vault, style: buttonTextWhite),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget bottomSectionEL(MyCartData myCartData) {
//     // var requiredAmount =  roundDouble(double.parse(marginShortfallObj!.minimumCollateralValue.toString()), 2);
//     // var availableAmount = roundDouble(double.parse(marginShortfallObj!.totalCollateralValue.toString()), 2);
//
//     if(totalScrips != 0){
//       if(totalValue >= double.parse(marginShortfallObj!.minimumCashAmount.toString())){
//         isScripsSelect = false;
//       } else {
//         isScripsSelect = true;
//       }
//     } else {
//       isScripsSelect = true;
//     }
//     return Visibility(
//       visible: hideSecurityValue,
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.white, width: 3.0),
//             borderRadius:
//             BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
//             boxShadow: [
//               BoxShadow(blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
//             ] // make rounded corner of border
//         ),
//         child: Container(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.start,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       IconButton(
//                         icon: Image.asset(
//                           AssetsImagePath.up_arrow,
//                           height: 15,
//                           width: 15,
//                         ),
//                         onPressed: () {
//                           setState(() {
//                             hideSecurityValue = false;
//                             showSecurityValue = true;
//
//                           });
//                         },
//                       )
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Expanded(child: Text(
//                               "Eligible Loan",
//                               style: mediumTextStyle_18_gray,
//                             ),),
//                             Text('₹' + numberToString(eligibleLoan.toStringAsFixed(2)), style: textStyleGreenStyle_18)
//                           ],
//                         ),
//                       ],
//                     ),
//                   )
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Container(
//                     height: 50,
//                     width: 140,
//                     child: Material(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                       elevation: 1.0,
//                       color: isScripsSelect == true ? colorLightGray : appTheme,
//                       child: AbsorbPointer(
//                         absorbing: isScripsSelect!,
//                         child: MaterialButton(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () async {
//                             Utility.isNetworkConnection().then((isNetwork) {
//                               if (isNetwork) {
//                                 sendMyCart();
//                               } else {
//                                 Utility.showToastMessage(Strings.no_internet_message);
//                               }
//                             });
//                           },
//                           child: Text(Strings.view_vault, style: buttonTextWhite),
//                         ),
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//               SizedBox(
//                 height: 15,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
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
//           _controllers[myCartList[index].isin]!.text = myCartList[index].pledgedQuantity.toString();
//           myCartList[index].amount = double.parse(_controllers[myCartList[index].isin]!.text) * myCartList[index].price!;
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
//           _controllers[myCartList[index].isin]!.text = "0";
//           myCartList[index].pledgedQuantity = double.parse(_controllers[myCartList[index].isin]!.text);
//           eligibleLoan = cartData.totalCollateralValue! / 2;
//           totalScrips = 0;
//         }
//         if(totalValue >= double.parse(marginShortfallObj!.minimumPledgeAmount.toString())){
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
//   void sendMyCart() {
//     LoadingDialogWidget.showDialogLoading(context,  Strings.please_wait);
//     _handleSearchEnd();
//     securitiesListItems.clear();
//
//     for (int i = 0; i < myCartList.length; i++) {
//       if (!isAddBtnShow[i]) {
//         if(myCartList[i].amount != 0.0){
//           securitiesListItems.add(new SecuritiesList(
//               quantity: double.parse(myCartList[i].pledgedQuantity.toString()),
//               isin: myCartList[i].isin,
//               price: myCartList[i].price,
//               qty: myCartList[i].remaningQty!.toDouble()));
//         }
//       }
//     }
//     Securities securitiesObj = new Securities();
//     securitiesObj.list = securitiesListItems;
//     MyCartRequestBean myCartRequestBean = new MyCartRequestBean();
//     myCartRequestBean.securities = securitiesObj;
//     myCartRequestBean.cartName = cartData.name;
//     myCartRequestBean.pledgor_boid = widget.stockAt;
//     myCartRequestBean.loamName = widget.loan_name;
//     myCartRequestBean.loan_margin_shortfall_name = widget.loanMarginshortfallName;
//     myCartRequestBean.lender = "";
//     loanApplicationBloc.myCart(myCartRequestBean).then((value) {
//       Navigator.pop(context);
//       if (value.isSuccessFull!) {
//         Navigator.push(context, MaterialPageRoute(
//             builder: (BuildContext context) => MarginShortFallMyCartScreen(
//                 securitiesListItems,
//                 value.data!,
//                 widget.loanMarginshortfallName,
//                 widget.stockAt,
//                 widget.lenderInfo),
//         ));
//       } else if (value.errorCode == 403) {
//         commonDialog(context, Strings.session_timeout, 4);
//       } else {
//         if(eligibleLoan == 0.0){
//           Utility.showToastMessage(Strings.select_security);
//         } else {
//           Utility.showToastMessage(Strings.fail);
//         }
//       }
//     });
//   }
// }
