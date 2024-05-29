// import 'dart:convert';
// import 'package:lms/common_widgets/constants.dart';
// import 'package:lms/network/requestbean/MyCartRequestBean.dart';
// import 'package:lms/network/responsebean/ApprovedListResponseBean.dart';
// import 'package:lms/network/responsebean/MyCartResponseBean.dart';
// import 'package:lms/shares/LoanApplicationBloc.dart';
// import 'package:lms/shares/MyShareCartScreen.dart';
// import 'package:lms/terms_conditions/TermsConditions.dart';
// import 'package:lms/util/AssetsImagePath.dart';
// import 'package:lms/util/Colors.dart';
// import 'package:lms/util/Style.dart';
// import 'package:lms/util/Utility.dart';
// import 'package:lms/util/strings.dart';
// import 'package:lms/widgets/LoadingDialogWidget.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class NewIncreaseLoanCartScreen extends StatefulWidget {
//   final MyCartData myCartData;
//   List<SecuritiesList> sharesList;
//   String stockAt;
//
//   NewIncreaseLoanCartScreen(this.sharesList, this.myCartData, this.stockAt);
//
//   @override
//   NewIncreaseLoanCartScreenState createState() => NewIncreaseLoanCartScreenState();
// }
//
// class NewIncreaseLoanCartScreenState extends State<NewIncreaseLoanCartScreen> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   final loanApplicationBloc = LoanApplicationBloc();
//   List<SecuritiesList> securitiesListItems = [];
//   List<CartItems> myCartList = [];
//   List<ShareListData> getSharesList = [];
//   var eligibleAmount, selectedSecurities, totalCompany, stockAt, fileId;
//   List<TextEditingController> pledgeController = [];
//   Map<String, TextEditingController> pledgeController2 = {};
//   Map<String, double> selectedValueInScrips = {};
//   List<bool> pledgeControllerEnable = [];
//   List<bool> pledgeControllerAutoFocus = [];
//   List<bool> pledgeControllerShowCursor = [];
//   List<FocusNode> myFocusNode = [];
//   bool isEdit = false;
//   Utility utility = Utility();
//   Cart cartData = new Cart();
//   MyCartData? myCartData;
//
//   @override
//   void initState() {
//     myCartList = widget.myCartData.cart!.items!;
//     Utility.isNetworkConnection().then((isNetwork) {
//       if (isNetwork) {
//         sendMyCart(false);
//       } else {
//         Utility.showToastMessage(Strings.no_internet_message);
//       }
//     });
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     printLog("SecondRoute: dispose");
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(child: SafeArea(
//       child: Scaffold(
//           key: _scaffoldKey,
//           resizeToAvoidBottomInset: false,
//           backgroundColor: colorbg,
//           appBar: AppBar(
//             leading: IconButton(
//               icon: Icon(
//                 Icons.arrow_back_ios,
//                 color: appTheme,
//                 size: 15,
//               ),
//               onPressed: () {
//                 backConfirmationDialog(context);
// //                for (int i = 0; i < myCartList.length; i++) {
// //                  myCartList[i].check = true;
// //                }
// //                setState(() {
// //                  myCartData.cart.items = myCartList;
// //                });
// //
// //                Navigator.pop(context, pledgeController2);
//               },
//             ),
//             backgroundColor: colorbg,
//             elevation: 0.0,
//             centerTitle: true,
//             title: Text(
//               widget.stockAt,
//               style: mediumTextStyle_16_dark,
//             ),
//             actions: [
//               IconButton(
//                   icon: Image.asset(
//                     AssetsImagePath.new_cart,
//                     height: 25,
//                     width: 25,
//                     color: appTheme,
//                   ),
//                   onPressed: () {})
//             ],
//           ),
//           body: myCartData != null ? allMyCartData(myCartData!) : Container()),
//     ), onWillPop: _onBackPressed);
//   }
//     Future<bool> _onBackPressed() {
//     return backConfirmationDialog(context);
//   }
//
//   Widget allMyCartData(MyCartData myCartData) {
//     return NestedScrollView(
//       physics: NeverScrollableScrollPhysics(),
//       headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//         return <Widget>[
//           SliverList(
//             delegate: SliverChildListDelegate(
//               [
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0),
//                   child: headingText(Strings.my_vault),
//                 ),
//                 pledgeCart(myCartData.cart!),
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
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: <Widget>[
//                 Text(Strings.shares_selected,
//                     style: kDefaultTextStyle.copyWith(fontWeight: FontWeight.bold)),
//               ],
//             ),
//           ),
//           Expanded(
//             child: SingleChildScrollView(
//               physics: NeverScrollableScrollPhysics(),
//               child: _myCart(),
//             ),
//           ),
//           bottomSection(),
//         ],
//       ),
//     );
//   }
//
//   Widget bottomSection() {
//     var eligible_amount;
//     eligible_amount = roundDouble(cartData.eligibleLoan!, 2);
//     return Container(
//       height: 130,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.white, width: 3.0),
//         // set border width
//         borderRadius:
//             BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
//         // set rounded corner radius
//         boxShadow: [BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))],
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 subHeadingText(Strings.eligible_loan_small),
//                 Text(
//                   '₹' + eligible_amount.toString(),
//                   style: textStyleGreenStyle,
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: <Widget>[
//               IconButton(
//                 icon: ArrowBackwardNavigation(),
//                 onPressed: () {
//                   backConfirmationDialog(context);
// //                  printLog("myCartDataReturn${json.encode(myCartData)}");
// //                  myCartData.cart.items = myCartList;
// //                  Navigator.pop(
// //                      context,
// //                      ScripsData(
// //                          pledgeController: pledgeController2,
// //                          selectedValueInScrips: selectedValueInScrips,
// //                          totalValueSecurity: selected_securitis,
// //                          eligibleLoan: eligible_amount));
//                 },
//               ),
//               Container(
//                 height: 45,
//                 width: 100,
//                 child: Material(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                   elevation: 1.0,
//                   color: appTheme,
//                   child: MaterialButton(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(35)),
//                     minWidth: MediaQuery.of(context).size.width,
//                     onPressed: () async {
//                       Utility.isNetworkConnection().then((isNetwork) {
//                         if (isNetwork) {
//                           sendMyCart(true);
//                         } else {
//                           Utility.showToastMessage(Strings.no_internet_message);
//                         }
//                       });
//                     },
//                     child: ArrowForwardNavigation(),
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget pledgeCart(Cart cart) {
//     eligibleAmount = roundDouble(cart.eligibleLoan!.toDouble(), 2);
//     selectedSecurities = roundDouble(cart.totalCollateralValue!.toDouble(), 2);
//     totalCompany = cart.items!.length.toString();
//
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
//       child: Container(
//         decoration: BoxDecoration(
//           color: colorlightBlue,
//           border: Border.all(color: colorlightBlue, width: 3.0),
//           borderRadius: BorderRadius.all(Radius.circular(15.0)),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               height: 10,
//             ),
//             largeHeadingText('₹' + selectedSecurities.toString()),
//             SizedBox(
//               height: 5,
//             ),
//             mediumHeadingText(Strings.values_selected_securities),
//             SizedBox(
//               height: 10,
//             ),
//             subHeadingText(totalCompany.toString()),
//             SizedBox(
//               height: 5,
//             ),
//             mediumHeadingText(Strings.scrips),
//             SizedBox(
//               height: 10,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _myCart() {
//     return Padding(
//         padding: const EdgeInsets.only(left: 20.0, right: 20, bottom: 150),
//         child: ListView.builder(
//           physics: NeverScrollableScrollPhysics(),
//           shrinkWrap: true,
//           itemCount: myCartList.length,
//           itemBuilder: (context, index) {
//             var pleqty, scrip_name, valueSelected;
//
//             pleqty = myCartList[index].pledgedQuantity.toString();
//             scrip_name = myCartList[index].securityName;
//             valueSelected = roundDouble(myCartList[index].amount!.toDouble(), 2);
//             selectedValueInScrips[myCartList[index].isin!] = valueSelected;
//             pledgeController.add(TextEditingController(text: pleqty));
//             pledgeController2[myCartList[index].isin!] = TextEditingController(text: pleqty);
//             pledgeController2[myCartList[index].isin]!.selection = TextSelection.fromPosition(
//                 TextPosition(offset: pledgeController2[myCartList[index].isin]!.text.length));
//             var val1 = widget.sharesList[index].qty;
//             var val2 = myCartList[index].pledgedQuantity;
//             var remainingValue = val1! - val2!;
//
//             var remainingAmount;
//             String remainingStr = remainingValue.toString();
//             var remainingArray = remainingStr.split('.');
//             remainingAmount = remainingArray[0];
//             return Container(
//               margin: EdgeInsets.symmetric(vertical: 10.0),
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.white, width: 3.0),
//                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               ),
//               child: Padding(
//                 padding: const EdgeInsets.all(10.0),
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       children: <Widget>[
//                         Expanded(
//                           child: scripsNameText(scrip_name),
//                         ),
//                         Row(
//                           children: <Widget>[
//                             IconButton(
//                               icon: Icon(
//                                 Icons.clear,
//                                 color: Colors.red,
//                                 size: 25.0,
//                               ),
//                               onPressed: () async {
//                                 Utility.isNetworkConnection().then((isNetwork) {
//                                   if (isNetwork) {
//                                     if (myCartList.length > 1) {
//                                       deleteDialogBox(index);
//                                     } else {
//                                       Utility.showToastMessage(Strings.at_least_one_script);
//                                     }
//                                   } else {
//                                     Utility.showToastMessage(Strings.no_internet_message);
//                                   }
//                                 });
//                               },
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Column(
//                           children: [
//                             Container(
//                               width: 50,
//                               child: TextField(
//                                 style: boldTextStyle_18_gray_dark,
//                                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                                 inputFormatters: [
//                                   FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//                                 ],
//                                 controller: pledgeController2[myCartList[index].isin],
//                                 enabled: true,
//                                 onChanged: (value) {
//                                   pledgeController2[myCartList[index].isin]!.selection =
//                                       new TextSelection(
//                                           baseOffset: value.length, extentOffset: value.length);
//                                   Utility.isNetworkConnection().then((isNetwork) {
//                                     if (isNetwork) {
//                                       if (pledgeController2[myCartList[index].isin]!
//                                           .text
//                                           .isNotEmpty) {
//                                         if (int.parse(
//                                                 pledgeController2[myCartList[index].isin]!.text) <
//                                             1) {
//                                           Utility.showToastMessage(Strings.message_quantity_not_less_1);
//                                           pledgeController2[myCartList[index].isin]!.text = pleqty;
//                                         }
//                                         if (double.parse(pledgeController2[myCartList[index].isin]!.text) > widget.sharesList[index].qty!) {
//                                           Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${widget.sharesList[index].qty} quantity .");
//                                           pledgeController2[myCartList[index].isin]!.text = pleqty;
//                                         } else {
//                                           myCartList[index].pledgedQuantity = double.parse(
//                                               pledgeController2[myCartList[index].isin]!.text);
//                                           sendMyCart(false);
//                                         }
//                                       }
// //                                          else {
// //                                            if (int.parse(
// //                                                    pledgeController2[myCartList[index].isin]
// //                                                        .text) <
// //                                                1) {
// //                                              Utility.showToastMessage(
// //                                                  "Pledge QTY should be greater than 0");
// //                                            } else {
// ////                                              FocusScope.of(context).requestFocus(new FocusNode());
// //                                              myCartList[index]
// //                                                      .pledgedQuantity =
// //                                                  int.parse(
// //                                                      pledgeController2[myCartList[index].isin]
// //                                                          .text);
// //                                              sendMyCart(index);
// //                                            }
// //                                          }
//                                     } else {
//                                       Utility.showToastMessage(Strings.no_internet_message);
//                                     }
//                                   });
//                                 },
//                               ),
//                             ),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             mediumHeadingText(Strings.pledge_qty),
//                           ],
//                         ),
//                         Column(
//                           children: [
//                             scripsValueText('₹' + valueSelected.toString()),
//                             mediumHeadingText(Strings.value_selected),
//                             SizedBox(
//                               height: 10,
//                             ),
//                             Text(
//                               "${Strings.remaining + " QTY" + " " + remainingAmount.toString()}",
//                               style: kSecurityLiteStyle,
//                             )
//                           ],
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         ));
//   }
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
//     myCartRequestBean.cartName = widget.myCartData.cart!.name!;
//     myCartRequestBean.pledgor_boid = widget.stockAt;
//     myCartRequestBean.loamName = "";
//     myCartRequestBean.cartName = "";
//     myCartRequestBean.lender = "";
//     loanApplicationBloc.myCart(myCartRequestBean).then((value) {
//       Navigator.pop(context);
//       if (value.isSuccessFull!) {
//         if (isFinalCart) {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (BuildContext context) => TermsConditionsScreen(
//                       eligibleAmount.toString(), widget.myCartData.cart!.name!, stockAt, Strings.increase_loan, "", "")));
//
//         } else {
//           myCartList.clear();
//           setState(() {
//             myCartData = value.data;
//             cartData = myCartData!.cart!;
//             myCartList = cartData.items!;
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
//   Future<bool> deleteDialogBox(index) async{
//     return await showDialog<bool>(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               backgroundColor: colorWhite,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
//               title: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   GestureDetector(
//                     child: Icon(
//                       Icons.cancel,
//                       color: colorLightGray,
//                       size: 20,
//                     ),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               ),
//               content: Container(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Text("Are you sure?", style: textStyleappThemeStyle),
//                     Center(
//                       child: Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: new Text("Would you like to remove your selection?",
//                             style: mediumTextStyle_16_gray),
//                       ),
//                     ),
//                     SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                       height: 45,
//                       width: 100,
//                       child: Material(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                         elevation: 1.0,
//                         color: appTheme,
//                         child: MaterialButton(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () async {
//                             Navigator.pop(context);
//                             printLog("beforelength:: ${myCartList.length}");
//                             setState(() {
//                               myCartList.removeAt(index);
//                               widget.sharesList.removeAt(index);
//                               pledgeController.clear();
//                               sendMyCart(false);
//                             });
// //                            removeItem(myCartList[index].securityName);
//                             printLog("afterlength:: ${myCartList.length}");
// //
//                           },
//                           child: Text(
//                             Strings.yes,
//                             style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold),
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ) ??
//         false;
//   }
// }
