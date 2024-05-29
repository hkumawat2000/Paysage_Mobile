// import 'package:lms/common_widgets/constants.dart';
// import 'package:lms/myloan/MarginShortfallEligibleDialog.dart';
// import 'package:lms/network/requestbean/MyCartRequestBean.dart';
// import 'package:lms/network/responsebean/ApprovedListResponseBean.dart';
// import 'package:lms/network/responsebean/MyCartResponseBean.dart';
// import 'package:lms/network/responsebean/SecuritiesResponseBean.dart';
// import 'package:lms/pledge_eligibility/mutual_fund/MF_ViewVaultDetailsViewScreen.dart';
// import 'package:lms/shares/EligibleDialog.dart';
// import 'package:lms/shares/LoanApplicationBloc.dart';
// import 'package:lms/shares/LoanOTPVerification.dart';
// import 'package:lms/shares/webviewScreen.dart';
// import 'package:lms/util/AssetsImagePath.dart';
// import 'package:lms/util/Colors.dart';
// import 'package:lms/util/Style.dart';
// import 'package:lms/util/Utility.dart';
// import 'package:lms/util/strings.dart';
// import 'package:lms/widgets/ErrorMessageWidget.dart';
// import 'package:lms/widgets/LoadMoreWidget.dart';
// import 'package:lms/widgets/LoadingDialogWidget.dart';
// import 'package:lms/widgets/LoadingWidget.dart';
// import 'package:lms/widgets/NoDataWidget.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// import 'MyLoansBloc.dart';
//
// class MarginShortFallMyCartScreen extends StatefulWidget {
//   MyCartData myCartData;
//   List<SecuritiesList> sharesList;
//   String marginShortfallLoanName, stockAt;
//   List<LenderInfo>? lenderInfo;
//
//   MarginShortFallMyCartScreen(this.sharesList, this.myCartData,
//       this.marginShortfallLoanName, this.stockAt, this.lenderInfo);
//
//   @override
//   MarginShortfallPledgeScreenState createState() =>
//       MarginShortfallPledgeScreenState();
// }
//
// class MarginShortfallPledgeScreenState
//     extends State<MarginShortFallMyCartScreen> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final loanApplicationBloc = LoanApplicationBloc();
//   List<SecuritiesList> securitiesListItems = [];
//   List<CartItems> myCartList = [];
//   var eligibleAmount, selectedSecurities, totalCompany, stockAt, fileId;
//   List<TextEditingController> pledgeController = [];
//   List<bool> pledgeControllerEnable = [];
//   List<bool> pledgeControllerAutoFocus = [];
//   List<bool> pledgeControllerShowCursor = [];
//   List<FocusNode> myFocusNode = [];
//   List<ShareListData> getSharesList = [];
//   bool isEdit = false;
//   Utility utility = Utility();
//   bool isScripsSelect = true;
//   Cart cartData = new Cart();
//   MyCartData? myCartData;
//   String? cartName;
//   List<CategoryWiseList> categoryWiseList = [];
//   List<CartItems> catAList = [];
//   List<CartItems> catBList = [];
//   List<CartItems> catCList = [];
//   List<CartItems> catDList = [];
//   List<CartItems> superCatAList = [];
//   List<Choice> cartViewList = [];
//   bool hideSecurityValue = false;
//   bool showSecurityValue = true;
//
//   @override
//   void initState() {
//     myCartList = widget.myCartData.cart!.items!;
//     Utility.isNetworkConnection().then((isNetwork) {
//       if (isNetwork) {
//         cartViewList.add(Choice(widget.lenderInfo![0].name,
//             widget.lenderInfo![0].rateOfInterest,
//             widget.lenderInfo![0].minimumSanctionedLimit,
//             widget.lenderInfo![0].maximumSanctionedLimit));
//         sendMyCart(false);
//       } else {
//         Utility.showToastMessage(Strings.no_internet_message);
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//         child: GestureDetector(
//           onTap: () {
//             FocusScope.of(context).unfocus();
//           },
//           child: Scaffold(
//               key: _scaffoldKey,
//               resizeToAvoidBottomInset: false,
//               backgroundColor: colorbg,
//               appBar: AppBar(
//                 leading: IconButton(
//                     icon: Icon(
//                       Icons.arrow_back_ios,
//                       color: appTheme,
//                       size: 15,
//                     ),
//                     onPressed: () {
//                       backConfirmationDialog(context);
//                     }),
//                 backgroundColor: colorbg,
//                 elevation: 0.0,
//                 centerTitle: true,
//                 title: Text(
//                   Strings.my_vault,
//                   style: mediumTextStyle_18_gray_dark,
//                 ),
//                 // actions: [
//                 //   IconButton(
//                 //       icon: Image.asset(
//                 //         AssetsImagePath.new_cart,
//                 //         height: 25,
//                 //         width: 25,
//                 //         color: appTheme,
//                 //       ),
//                 //       onPressed: () {})
//                 // ],
//               ),
//               body: myCartData != null
//                   ? allMyCartData(myCartData!)
//                   : Container()),
//         ),
//         onWillPop: _onBackPressed);
//   }
//
//   Future<bool> _onBackPressed() {
//     return backConfirmationDialog(context);
//   }
//
// //  Widget getMyCartList() {
// //    return StreamBuilder(
// //      stream: loanApplicationBloc.myCartList,
// //      builder: (context, AsyncSnapshot<MyCartData> snapshot) {
// //        if (snapshot.hasData) {
// //          if (snapshot.data == null || snapshot.data.cart.items.length == 0) {
// //            return _buildNoDataWidget();
// //          } else {
// //            return allMyCartData(snapshot);
// //          }
// //        } else if (snapshot.hasError) {
// //          return _buildErrorWidget(snapshot.error);
// //        } else {
// //          return _buildLoadingWidget();
// //        }
// //      },
// //    );
// //  }
//
//   Widget allMyCartData(MyCartData snapshot) {
//     return NestedScrollView(
//       physics: NeverScrollableScrollPhysics(),
//       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//         return <Widget>[
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 SizedBox(
//                     height : 0.5
//                 ),
//                 // Padding(
//                 //   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   // child: headingText(Strings.my_vault),
//                 // ),
//                 // pledgeCart(snapshot.cart!),
//               ],
//             ),
//           )
//         ];
//       },
//       body: Column(
//         children: <Widget>[
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Center(
//                   child: Text(cartViewList[0].lender!.toString(),
//                       style: boldTextStyle_18),
//                 ),
//
//               ],
//             ),
//           ),
//           Expanded(
//             child: securitiesDetailsViewList(),
//           ),
//
//           showSecurityValue ? bottomSection(snapshot.cart!) : bottomSectionShortFall(snapshot.cart!),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildLoadingWidget() {
//     return LoadingWidget();
//   }
//
//   Widget _buildErrorWidget(String error) {
//     return ErrorMessageWidget(error: error);
//   }
//
//   Widget _buildNoDataWidget() {
//     return NoDataWidget();
//   }
//
//   Widget bottomSection(Cart cart) {
//     var selected_securities;
//     eligibleAmount = roundDouble(cart.eligibleLoan!, 2);
//     selected_securities = roundDouble(cartData.totalCollateralValue!, 2);
//     var requiredAmount = roundDouble(
//         double.parse(widget.myCartData.loanMarginShortfallObj!.minimumCashAmount!.toString())
//             + double.parse(widget.myCartData.loanMarginShortfallObj!.totalCollateralValue!.toString()), 2);
//     var availableAmount = roundDouble(
//         double.parse(widget.myCartData.loanMarginShortfallObj!.totalCollateralValue.toString()), 2);
//
//     if (selected_securities >= double.parse(widget.myCartData.loanMarginShortfallObj!.shortfallC.toString())) {
//       isScripsSelect = false;
//     } else {
//       isScripsSelect = true;
//     }
//     return Visibility(
//       visible: showSecurityValue,
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.white, width: 3.0),
//             // set border width
//             borderRadius:
//             BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
//             // set rounded corner radius
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
//                 children: [
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
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Expanded(child: Text(
//                               Strings.security_value,
//                               style: mediumTextStyle_18_gray,
//                             ),),
//                             scripsValueText('₹' + numberToString(selected_securities.toStringAsFixed(2)))
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
//                             Text('₹' + numberToString(eligibleAmount.toStringAsFixed(2)), style: textStyleGreenStyle_18)
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Expanded(child: Text(
//                               "Required collateral value",
//                               style: mediumTextStyle_18_gray,
//                             ),),
//                             scripsValueText('₹' + numberToString(requiredAmount.toStringAsFixed(2)))
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Expanded(child: Text(
//                               "Available collateral value",
//                               style: mediumTextStyle_18_gray,
//                             ),),
//                             scripsValueText('₹' + numberToString(availableAmount.toStringAsFixed(2)))
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
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
//                                 sendMyCart(true);
//                               } else {
//                                 Utility.showToastMessage(Strings.no_internet_message);
//                               }
//                             });
//                           },
//                           child: Text(Strings.submit, style: buttonTextWhite),
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
//   Widget bottomSectionShortFall(Cart cart) {
//     var selected_securities;
//     eligibleAmount = roundDouble(cart.eligibleLoan!, 2);
//     selected_securities = roundDouble(cartData.totalCollateralValue!, 2);
//     var requiredAmount = roundDouble(
//         double.parse(widget.myCartData.loanMarginShortfallObj!.minimumCashAmount!.toString())
//             + double.parse(widget.myCartData.loanMarginShortfallObj!.totalCollateralValue!.toString()), 2);
//     var availableAmount = roundDouble(
//         double.parse(widget.myCartData.loanMarginShortfallObj!.totalCollateralValue.toString()), 2);
//
//     if (selected_securities >= double.parse(widget.myCartData.loanMarginShortfallObj!.shortfallC.toString())) {
//       isScripsSelect = false;
//     } else {
//       isScripsSelect = true;
//     }
//     return Visibility(
//       visible: hideSecurityValue,
//       child: Container(
//         decoration: BoxDecoration(
//             color: Colors.white,
//             border: Border.all(color: Colors.white, width: 3.0),
//             // set border width
//             borderRadius:
//             BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
//             // set rounded corner radius
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
//                 children: [
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
//                             hideSecurityValue = false;
//                             showSecurityValue = true;
//                           });
//                         },
//                       )
//                     ],
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               "Shortfall",
//                               style: TextStyle(
//                                   color: appTheme,
//                                   fontWeight: FontWeight.bold,
//                                   fontSize: 18),
//                             ),
//                             SizedBox(
//                               width: 15,
//                             ),
//                             Text(
//                               "Rs.${numberToString(widget.myCartData.loanMarginShortfallObj!.shortfallC!.toStringAsFixed(2))}",
//                               style: TextStyle(
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   color: red),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
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
//                                 sendMyCart(true);
//                               } else {
//                                 Utility.showToastMessage(Strings.no_internet_message);
//                               }
//                             });
//                           },
//                           child: Text(Strings.submit, style: buttonTextWhite),
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
//   Widget pledgeCart(Cart cart) {
//     eligibleAmount = roundDouble(cart.eligibleLoan!, 2);
//     selectedSecurities = roundDouble(cart.totalCollateralValue!, 2);
//     totalCompany = cart.items!.length.toString();
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
//       child: Container(
//         decoration: BoxDecoration(
//           color: colorlightBlue,
//           border: Border.all(color: colorlightBlue, width: 3.0),
//           // set border width
//           borderRadius: BorderRadius.all(Radius.circular(15.0)), // set rounded corner radius
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               height: 10,
//             ),
//             largeHeadingText('₹' + numberToString(selectedSecurities.toStringAsFixed(2))),
//             SizedBox(
//               height: 5,
//             ),
//             Text(Strings.values_selected_securities, style: subHeading),
//             SizedBox(
//               height: 10,
//             ),
//             subHeadingText(totalCompany.toString()),
//             SizedBox(
//               height: 5,
//             ),
//             Text(Strings.scrips, style: subHeading),
//             SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget securitiesDetailsViewList() {
//     return Column(
//       children: [
//         Flexible(
//           flex: 1,
//           child: PageView.builder(
//             itemCount: 1,
//             itemBuilder: (context, position) {
//               return Container(
//                 margin: const EdgeInsets.only(left: 20, right: 20),
//                 padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       // Container(
//                       //   alignment: Alignment.center,
//                       //   child: Text(cartViewList[0].lender!, style: boldTextStyle_18),
//                       // ),
//                       Column(
//                         children: [
//                           Container(
//                             child: ListView.builder(
//                               physics: NeverScrollableScrollPhysics(),
//                               shrinkWrap: true,
//                               itemCount: categoryWiseList.length,
//                               itemBuilder: (context, index) {
//                                 if (categoryWiseList[index].items!.length == 0) {
//                                   return Container();
//                                 } else {
//                                   return categoryWiseScheme(index);
//                                 }
//                               },
//                             ),
//                           ),
//                         ],
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(color: Colors.white, width: 3.0),
//                           borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                         ),
//                         child: Column(
//                           children: [
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Expanded(
//                                   child: Text(Strings.rate_of_interest,
//                                     style: mediumTextStyle_18_gray,
//                                   ),
//                                 ),
//                                 Text("${cartViewList[0].roi!.toStringAsFixed(2)}%",
//                                   style: boldTextStyle_18_gray_dark,
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Text(Strings.min_limit,
//                                   style: mediumTextStyle_18_gray,
//                                 ),
//                                 Text("₹${numberToString(cartViewList[0].minLimit!.toStringAsFixed(2))}",
//                                   style: boldTextStyle_18_gray_dark,
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Row(
//                               mainAxisAlignment:
//                               MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Expanded(
//                                   child: Text(Strings.max_limit, style: mediumTextStyle_18_gray),
//                                 ),
//                                 Text("₹${numberToString(cartViewList[0].maxLimit!.toStringAsFixed(2))}",
//                                     style: boldTextStyle_18_gray_dark)
//                               ],
//                             ),
//                           ],
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _myCart() {
//     return Padding(
//         padding: const EdgeInsets.only(left: 20.0, right: 20),
//         child: ListView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: categoryWiseList.length,
//             itemBuilder: (context, index) {
//               if (categoryWiseList[index].items!.length == 0) {
//                 return Container();
//               } else {
//                 return categoryWiseScheme(index);
//               }
//             }
//         ));
//   }
//
//   categoryWiseScheme(index){
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 10.0),
//       decoration: BoxDecoration(
//         color: colorWhite,
//         border: Border.all(color: colorWhite, width: 3.0),
//         borderRadius: BorderRadius.all(Radius.circular(10.0)),
//       ),
//       child: Column(
//         children: [
//           SizedBox(height: 10),
//           Padding(
//             padding: const EdgeInsets.only(left: 15),
//             child: Table(children: [
//               TableRow(children: [
//                 Container(),
//                 Container(
//                   decoration: BoxDecoration(
//                     color: colorLightGray2,
//                     borderRadius: BorderRadius.all(Radius.circular(25.0)),
//                   ),
//                   child: Center(
//                     child: Padding(
//                       padding: EdgeInsets.all(10),
//                       child: Text(categoryWiseList[index].categoryName!,
//                         style: mediumTextStyle_14_gray_dark,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Container()
//               ]),
//             ]),
//           ),
//           ListView.builder(
//               key: Key(categoryWiseList[index].items!.length.toString()),
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: categoryWiseList[index].items!.length,
//               itemBuilder: (context, i) {
//                 var pleqty, scrip_name, valueSelected;
//             pleqty = categoryWiseList[index].items![i].pledgedQuantity!.toInt().toString();
//             scrip_name = categoryWiseList[index].items![i].securityName;
//
//             valueSelected = roundDouble(categoryWiseList[index].items![i].amount!, 2);
//             pledgeController.add(TextEditingController(text: pleqty));
// //            pledgeControllerEnable.add(false);
//             myFocusNode.add(FocusNode());
//             // printLog("widget.sharesList[index].quantity${widget.sharesList[index].qty}");
//             // printLog("myCartList[index].pledgedQuantity${myCartList[index].pledgedQuantity}");
//             var val1 = widget.sharesList[i].qty;
//             var val2 = categoryWiseList[index].items![i].pledgedQuantity;
//             var remainingValue = val1! - val2!;
//             var remainingAmount;
//             String remainingStr = remainingValue.toString();
//             var remainingArray = remainingStr.split('.');
//             remainingAmount = remainingArray[0];
//                 return Column(
//                   children: [
//                     Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Text(categoryWiseList[index].items![i].securityName!,
//                             style: boldTextStyle_18,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.end,
//                             children: [
//                               Row(
//                                 children: [
//                                   IconButton(
//                                     iconSize: 20.0,
//                                     icon: Container(
//                                       padding: EdgeInsets.all(2),
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(100),
//                                           border: Border.all(width: 1, color: colorBlack)),
//                                       child: Icon(
//                                         Icons.remove,
//                                         color: colorBlack,
//                                         size: 18,
//                                       ),
//                                     ),
//                                     onPressed: () async {
//                                       Utility.isNetworkConnection().then((isNetwork) {
//                                         if (isNetwork) {
//                                           setState(() {
//                                             FocusScope.of(context).unfocus();
//                                             String fieldText = pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text.toString();
//                                             if(fieldText.isEmpty || int.parse(fieldText) == 1 || int.parse(fieldText) == 0){
//                                               Utility.showToastMessage(Strings.message_quantity_not_less_1);
//                                               pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = "1";
//                                               categoryWiseList[index].items![i].pledgedQuantity = double.parse(pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
//                                             } else {
//                                               int txt = fieldText.isNotEmpty ? int.parse(fieldText.toString()) - 1 : 0;
//                                               pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = txt.toString();
//                                               categoryWiseList[index].items![i].pledgedQuantity = double.parse(pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
//                                               sendMyCart(false);
//                                             }
//                                           });
//                                         } else {
//                                           Utility.showToastMessage(Strings.no_internet_message);
//                                         }
//                                       });
//                                     },
//                                   ),
//                                   Container(
//                                     width: 60,
//                                     height: 65,
//                                     child: TextField(
//                                       style: boldTextStyle_18_gray_dark,
//                                       keyboardType: TextInputType.numberWithOptions(decimal: true),
//                                       inputFormatters: [
//                                         FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//                                       ],
//                                       textAlign: TextAlign.center,
//                                       enabled: true,
//                                       controller: pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)],
//                                       onChanged: (text) async {
//                                         pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].selection = new TextSelection(
//                                             baseOffset: text.length, extentOffset: text.length);
//                                         Utility.isNetworkConnection().then((isNetwork) {
//                                           if (isNetwork) {
//                                             if (int.parse(pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text) < 1) {
//                                               Utility.showToastMessage(Strings.message_quantity_not_less_1);
//                                               pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = pleqty;
//                                             }
//                                             if (double.parse(pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text) > widget.sharesList[i].qty!) {
//                                               Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${widget.sharesList[i].qty} quantity .");
//                                               pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = pleqty;
//                                             } else {
//                                               categoryWiseList[index].items![i].pledgedQuantity = double.parse(pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
//                                               sendMyCart(false);
//                                             }
//                                           } else {
//                                             showSnackBar(_scaffoldKey);
//                                           }
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                   IconButton(
//                                     iconSize: 20.0,
//                                     icon: Container(
//                                       padding: EdgeInsets.all(2),
//                                       decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(100),
//                                           border: Border.all(width: 1, color: colorBlack)),
//                                       child: Icon(
//                                         Icons.add,
//                                         color: colorBlack,
//                                         size: 18,
//                                       ),
//                                     ),
//                                     onPressed: () async {
//                                       Utility.isNetworkConnection().then((isNetwork) {
//                                         if (isNetwork) {
//                                           setState(() {
//                                             FocusScope.of(context).unfocus();
//                                             String fieldText = pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text.toString();
//                                             if(fieldText.isNotEmpty && (int.parse(fieldText) >= widget.sharesList[i].qty!.toInt())){
//                                               Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${widget.sharesList[i].qty} quantity .");
//                                               pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = pleqty;
//                                             }else{
//                                               if(fieldText.isEmpty || int.parse(fieldText) == 0 || fieldText == " "){
//                                                 fieldText = "1";
//                                                 pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = "1";
//                                               }else{
//                                                 int txt = fieldText.isNotEmpty ? int.parse(fieldText.toString()) + 1 : 0;
//                                                 pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text = txt.toString();
//                                               }
//                                               categoryWiseList[index].items![i].pledgedQuantity = double.parse(pledgeController[getIndexOfSchemeUnit(categoryWiseList[index].items![i].securityCategory!.toLowerCase(), i)].text);
//                                               sendMyCart(false);
//                                             }
//                                           });
//                                         } else {
//                                           Utility.showToastMessage(Strings.no_internet_message);
//                                         }
//                                       });
//                                     },
//                                   ),
//                                 ],
//                               ),
//                               Container(
//                                 width: MediaQuery.of(context).size.width * 0.19,
//                                 child: IconButton(
//                                   iconSize: 20,
//                                   icon: Image.asset(
//                                     AssetsImagePath.delete_icon_bg_red,
//                                   ),
//                                   onPressed: () async {
//                                     Utility.isNetworkConnection().then((isNetwork) {
//                                       if (isNetwork) {
//                                         if (myCartList.length > 1) {
//                                           deleteDialogBox(index, i, categoryWiseList[index].items![i].isin!);
//                                         } else {
//                                           Utility.showToastMessage(Strings.at_least_one_script);
//                                         }
//                                       } else {
//                                         Utility.showToastMessage(Strings.no_internet_message);
//                                       }
//                                     });
//                                   },
//                                 ),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     categoryWiseList[index].items!.length != i + 1
//                         ? Divider(thickness: 0.2, color: colorBlack)
//                         : SizedBox()
//                   ],
//                 );
//               })
//         ],
//       ),
//     );
//   }
//
//   getIndexOfSchemeUnit(String categoryName, int index){
//     if(categoryName == Strings.cat_a.toLowerCase()){
//       return index;
//     } else if(categoryName == Strings.cat_b.toLowerCase()){
//       return catAList.length + index;
//     } else if(categoryName == Strings.cat_c.toLowerCase()){
//       return catAList.length + catBList.length + index;
//     } else if(categoryName == Strings.cat_d.toLowerCase()){
//       return catAList.length + catBList.length+ catCList.length + index;
//     } else {
//       return catAList.length + catBList.length + catCList.length + catDList.length + index;
//     }
//   }
//
//
//   void sendMyCart(bool isFinalCart) {
//     LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//     securitiesListItems.clear();
//
//     for (int i = 0; i < myCartList.length; i++) {
//       securitiesListItems.add(new SecuritiesList(
//           quantity: double.parse(myCartList[i].pledgedQuantity.toString()),
//           isin: myCartList[i].isin,
//           price: myCartList[i].price));
//     }
//     Securities securitiesObj = new Securities();
//     securitiesObj.list = securitiesListItems;
//     MyCartRequestBean myCartRequestBean = new MyCartRequestBean();
//     myCartRequestBean.securities = securitiesObj;
//     myCartRequestBean.cartName = widget.myCartData.cart!.name;
//     myCartRequestBean.loamName = widget.myCartData.cart!.loan;
//     myCartRequestBean.pledgor_boid = widget.stockAt;
//     myCartRequestBean.loan_margin_shortfall_name = widget.marginShortfallLoanName;
//     myCartRequestBean.lender = "";
//     loanApplicationBloc.myCart(myCartRequestBean).then((value) {
//       Navigator.pop(context);
//       if (value.isSuccessFull!) {
//         if (isFinalCart) {
//           showModalBottomSheet(
//               backgroundColor: Colors.transparent,
//               context: context,
//               isScrollControlled: true,
//               builder: (BuildContext bc) {
//                 return MarginShortfallEligibleDialog(
//                     value.data!.cart!.eligibleLoan!,
//                     value.data!.cart!.name!,
//                     "",
//                     widget.stockAt,
//                     value.data!.cart!.loan!,
//                     value.data!.cart!.totalCollateralValue!,
//                     "");
//               });
//         } else {
//           myCartList.clear();
//           pledgeController.clear();
//           catAList.clear();
//           catBList.clear();
//           catCList.clear();
//           catDList.clear();
//           superCatAList.clear();
//           categoryWiseList.clear();
//           setState(() {
//             myCartData = value.data;
//             cartData = myCartData!.cart!;
//             myCartList = cartData.items!;
//             cartName = value.data!.cart!.name;
//             // myCartList.addAll(value.data!.cart!.items!);
//             // schemeValue = value.data!.cart!.totalCollateralValue!;
//             // eligibleLoanAmount = value.data!.cart!.eligibleLoan!;
//             for (int i = 0; i < value.data!.cart!.items!.length; i++) {
//               pledgeController.add(TextEditingController(text: value.data!.cart!.items![i].pledgedQuantity.toString()));
//               // focusNode.add(FocusNode());
//               switch (value.data!.cart!.items![i].securityCategory!) {
//                 case Strings.cat_a:
//                   catAList.add(value.data!.cart!.items![i]);
//                   break;
//                 case Strings.cat_b:
//                   catBList.add(value.data!.cart!.items![i]);
//                   break;
//                 case Strings.cat_c:
//                   catCList.add(value.data!.cart!.items![i]);
//                   break;
//                 case Strings.cat_d:
//                   catDList.add(value.data!.cart!.items![i]);
//                   break;
//                 case Strings.super_cat_a:
//                   superCatAList.add(value.data!.cart!.items![i]);
//                   break;
//               }
//             }
//             categoryWiseList.add(CategoryWiseList(Strings.cat_a, catAList));
//             categoryWiseList.add(CategoryWiseList(Strings.cat_b, catBList));
//             categoryWiseList.add(CategoryWiseList(Strings.cat_c, catCList));
//             categoryWiseList.add(CategoryWiseList(Strings.cat_d, catDList));
//             categoryWiseList.add(CategoryWiseList(Strings.super_cat_a, superCatAList));
//             for(int i=0; i<catAList.length; i++){
//               pledgeController[i].text = int.parse(catAList[i].pledgedQuantity!.toString().split(".")[1]) == 0 ? catAList[i].pledgedQuantity!.toString().split(".")[0] : catAList[i].pledgedQuantity!.toString();
//             }
//             for(int i=0; i<catBList.length; i++){
//               pledgeController[catAList.length + i].text = int.parse(catBList[i].pledgedQuantity!.toString().split(".")[1]) == 0 ? catBList[i].pledgedQuantity!.toString().split(".")[0] : catBList[i].pledgedQuantity!.toString();
//             }
//             for(int i=0; i<catCList.length; i++){
//               pledgeController[catAList.length + catBList.length + i].text = int.parse(catCList[i].pledgedQuantity!.toString().split(".")[1]) == 0 ? catCList[i].pledgedQuantity!.toString().split(".")[0] : catCList[i].pledgedQuantity!.toString();
//             }
//             for(int i=0; i<catDList.length; i++){
//               pledgeController[catAList.length + catBList.length + catCList.length + i].text = int.parse(catDList[i].pledgedQuantity!.toString().split(".")[1]) == 0 ? catDList[i].pledgedQuantity!.toString().split(".")[0] : catDList[i].pledgedQuantity!.toString();
//             }
//             for(int i=0; i<superCatAList.length; i++){
//               pledgeController[catAList.length + catBList.length + catCList.length+ catDList.length + i].text = int.parse(superCatAList[i].pledgedQuantity!.toString().split(".")[1]) == 0 ? superCatAList[i].pledgedQuantity!.toString().split(".")[0] : superCatAList[i].pledgedQuantity!.toString();
//             }
//
//
//           });
//         }
// //        getMyCartList();
//       } else if (value.errorCode == 403) {
//         commonDialog(context, Strings.session_timeout, 4);
//       } else {
//         Utility.showToastMessage(value.errorMessage!);
//       }
//     });
//   }
//
//   Future<bool> deleteDialogBox(index, i, String isin)async {
//     return await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
//           title: Row(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             mainAxisAlignment: MainAxisAlignment.end,
//             children: <Widget>[
//               GestureDetector(
//                 child: Icon(
//                   Icons.cancel,
//                   color: Colors.grey,
//                   size: 20,
//                 ),
//                 onTap: () {
//                   Navigator.pop(context);
//                 },
//               ),
//             ],
//           ),
//           content: Container(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Text("Are you sure",
//                     style: TextStyle(
//                         fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: new Text("Would you like to remove your selection?",
//                       style: TextStyle(fontSize: 16.0, color: Colors.grey)),
//                 ),
//                 Container(
//                   height: 40,
//                   width: 100,
//                   child: Material(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                     elevation: 1.0,
//                     color: appTheme,
//                     child: MaterialButton(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                       minWidth: MediaQuery.of(context).size.width,
//                       onPressed: () async {
//                         Navigator.pop(context);
//                         printLog("beforelength:: ${myCartList.length}");
//                         setState(() {
//                           categoryWiseList[index].items!.removeAt(i);
//                           widget.sharesList.removeWhere((element) => element.isin == isin);
//                           myCartList.removeWhere((element) => element.isin == isin);
//                           pledgeController.clear();
//                           sendMyCart(false);
//                         });
//                         printLog("afterlength:: ${myCartList.length}");
// //                        sendMyCart();
//                       },
//                       child: Text(
//                         Strings.yes,
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
