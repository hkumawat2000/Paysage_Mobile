//
// import 'package:lms/common_widgets/constants.dart';
// import 'package:lms/increaseloanlimit/IncreaseLimitDialog.dart';
// import 'package:lms/network/requestbean/MyCartRequestBean.dart';
// import 'package:lms/network/responsebean/ApprovedListResponseBean.dart';
// import 'package:lms/network/responsebean/MyCartResponseBean.dart';
// import 'package:lms/shares/EligibleDialog.dart';
// import 'package:lms/shares/LoanApplicationBloc.dart';
// import 'package:lms/shares/LoanOTPVerification.dart';
// import 'package:lms/shares/webviewScreen.dart';
// import 'package:lms/util/Colors.dart';
// import 'package:lms/util/Utility.dart';
// import 'package:lms/util/strings.dart';
// import 'package:lms/widgets/ErrorMessageWidget.dart';
// import 'package:lms/widgets/LoadingDialogWidget.dart';
// import 'package:lms/widgets/LoadingWidget.dart';
// import 'package:lms/widgets/NoDataWidget.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class IncreaseLoanMyCartScreen extends StatefulWidget {
//   final MyCartData myCartData;
//   List<CartItems> myCartList;
//   List<ShareListData> sharesList;
//   String odLimit;
//
//   IncreaseLoanMyCartScreen(this.myCartList, this.sharesList, this.myCartData,this.odLimit);
//
//   @override
//   IncreaseLoanMyCartScreenState createState() => IncreaseLoanMyCartScreenState();
// }
//
// class IncreaseLoanMyCartScreenState extends State<IncreaseLoanMyCartScreen> {
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
//   bool isEdit = false;
//
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       child: SafeArea(
//         child: Scaffold(
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
//               },
//             ),
//             backgroundColor:colorbg,
//             elevation: 0.0,
//             centerTitle: true,
//             title: Text(
//               '',
//               style: kDefaultTextStyle,
//             ),
//           ),
//           body: NestedScrollView(
//             physics: ScrollPhysics(),
//             headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//               return <Widget>[
//                 SliverList(
//                   delegate: SliverChildListDelegate(
//                     [
//                       StockAtCart(Strings.my_vault,widget.sharesList[0].stockAt!),
//                       pledgeCart(),
//                     ],
//                   ),
//                 )
//               ];
//             },
//             body: Column(
//               children: <Widget>[
//                 Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: <Widget>[
//                       Text(Strings.shares_selected,
//                           style: kDefaultTextStyle.copyWith(fontWeight: FontWeight.bold)),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: SingleChildScrollView(
//                     child: _myCart(),
//                   ),
//                 ),
//                 bottomSection(),
//               ],
//             ),
//           ),
//         ),
//       ),
//       onWillPop: _onBackPressed,
//     );
//   }
//
//   Future<bool> _onBackPressed() {
//     return backConfirmationDialog(context);
//   }
//
//   Widget getMyCartList() {
//     return StreamBuilder(
//       stream: loanApplicationBloc.myCartList,
//       builder: (context, AsyncSnapshot<MyCartData> snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data == null || snapshot.data!.cart!.items == 0) {
//             return _buildNoDataWidget();
//           } else {
//             return _myCart();
//           }
//         } else if (snapshot.hasError) {
//           return _buildErrorWidget(snapshot.error.toString());
//         } else {
//           return _buildLoadingWidget();
//         }
//       },
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
//   Widget bottomSection() {
//     return StreamBuilder(
//         stream: loanApplicationBloc.myCartList,
//         builder: (context, AsyncSnapshot<MyCartData> snapshot) {
//           var eligible_amount,selected_value;
//           if (snapshot.data != null) {
//             eligible_amount = roundDouble(snapshot.data!.cart!.eligibleLoan!.toDouble(), 2);
//             selected_value = roundDouble(snapshot.data!.cart!.totalCollateralValue!.toDouble(), 2);
//           } else {
//             eligible_amount = roundDouble(widget.myCartData.cart!.eligibleLoan!.toDouble(), 2);
//             selected_value = roundDouble(widget.myCartData.cart!.totalCollateralValue!.toDouble(), 2);
//           }
//
//           return Container(
//             height: 150,
//             decoration: BoxDecoration(
//                 color: Colors.white,
//                 border: Border.all(color: Colors.white, width: 3.0),
//                 // set border width
//                 borderRadius:
//                 BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
//                 // set rounded corner radius
//                 boxShadow: [
//                   BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
//                 ] // make rounded corner of border
//             ),
//             child: Container(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15.0),
//                     child: Column(
//                       children: <Widget>[
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               'Selected Security Value',
//                               style: kDefaultTextStyle,
//                             ),
//                             Text(
//                               "₹" + selected_value.toString(),
//                               style: kDefaultTextStyle.copyWith(fontWeight: FontWeight.bold),
//                             )
//                           ],
//                         ),
//                         SizedBox(
//                           height: 10,
//                         ),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: <Widget>[
//                             Text(
//                               'Additional Eligible Limit',
//                               style: kDefaultTextStyle,
//                             ),
//                             Text(
//                               "₹" + eligible_amount.toString(),
//                               style: kDefaultTextStyle.copyWith(
//                                   fontWeight: FontWeight.bold, color: Colors.green),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       IconButton(
//                         icon: ArrowBackwardNavigation(),
//                         onPressed: () {
//                           Navigator.pop(context);
//                         },
//                       ),
//                       Container(
//                         height: 45,
//                         width: 100,
//                         child: Material(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                           elevation: 1.0,
//                           color: appTheme,
//                           child: MaterialButton(
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(35)),
//                             minWidth: MediaQuery.of(context).size.width,
//                             onPressed: () async {
//                               termsCondition(context);
//
//                             },
//                             child: ArrowForwardNavigation(),
//                           ),
//                         ),
//                       )
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   Widget pledgeCart() {
//     return StreamBuilder(
//         stream: loanApplicationBloc.myCartList,
//         builder: (context, AsyncSnapshot<MyCartData> snapshot) {
//           if (snapshot.data != null) {
//             eligibleAmount = roundDouble(snapshot.data!.cart!.eligibleLoan!.toDouble(), 2);
//             selectedSecurities = roundDouble(snapshot.data!.cart!.totalCollateralValue!.toDouble(), 2);
//             totalCompany = snapshot.data!.cart!.items!.length.toString();
//           } else {
//             eligibleAmount = roundDouble(widget.myCartData.cart!.eligibleLoan!.toDouble(), 2);
//             selectedSecurities = roundDouble(widget.myCartData.cart!.totalCollateralValue!.toDouble(), 2);
//             totalCompany = widget.myCartList.length.toString();
//           }
//
//           return Padding(
//             padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: colorlightBlue,
//                 border: Border.all(color: colorlightBlue, width: 3.0),
//                 // set border width
//                 borderRadius: BorderRadius.all(Radius.circular(15.0)), // set rounded corner radius
//               ),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     '₹' + selectedSecurities.toString(),
//                     style: TextStyle(
//                         color: appTheme, fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     Strings.values_selected_securities,
//                     style: TextStyle(color: colorLightGray, fontSize: 12),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Text(
//                     totalCompany.toString(),
//                     style: TextStyle(
//                         color: appTheme,
//                         fontSize: 24,
//                         fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     Strings.scrips,
//                     style: TextStyle(color: colorLightGray, fontSize: 12),
//                   ),
// //                  ReusableAmountWithTextAndDivider(
// //                    leftAmount: total_company,
// //                    leftText: Strings.companies,
// //                    rightAmount: '₹' + eligible_amount.toString(),
// //                    rightText: Strings.eligible_loan,
// //                  ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                 ],
//               ),
//             ),
//           );
//         });
//   }
//
//   Widget _myCart() {
//     return Padding(
//         padding: const EdgeInsets.only(left: 20.0, right: 20),
//         child: StreamBuilder(
//           stream: loanApplicationBloc.myCartList,
//           builder: (context, AsyncSnapshot<MyCartData> snapshot) {
//             return ListView.builder(
//               physics: NeverScrollableScrollPhysics(),
//               shrinkWrap: true,
//               itemCount: widget.myCartData.cart!.items!.length,
//               itemBuilder: (context, index) {
//                 myCartList = widget.myCartList;
//                 var pledge_qty, scrip_name, pledge_og;
//                 String pleqty;
//                 int cart_index;
//                 if (snapshot.data != null) {
//                   pleqty = snapshot.data!.cart!.items![index].pledgedQuantity.toString();
//                   cart_index = snapshot.data!.cart!.items!.length;
//                   scrip_name = snapshot.data!.cart!.items![index].securityName;
//                 } else {
//                   pleqty = widget.myCartList[index].pledgedQuantity.toString();
//                   cart_index = widget.myCartList.length;
//                   scrip_name = widget.sharesList[index].scripName;
//                 }
//                 var eligibleloan = roundDouble(myCartList[index].amount!.toDouble(), 2);
//                 pledgeController.add(TextEditingController(text: pleqty));
//                 pledgeControllerEnable.add(false);
//                 myFocusNode.add(FocusNode());
// //                pledgeControllerAutoFocus.add(false);
// //                pledgeControllerShowCursor.add(false);
//                 return Container(
//                   margin: EdgeInsets.symmetric(vertical: 10.0),
// //                    padding: EdgeInsets.all(5),
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     border: Border.all(color: Colors.white, width: 3.0),
//                     // set border width
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(10.0),
//                     child: Column(
//                       children: <Widget>[
//                         Row(
//                           children: <Widget>[
//                             Expanded(
//                               child: Text(
//                                 scrip_name,
//                                 style: kSecurityNameTextSTyle,
//                               ),
//                             ),
//                             Row(
//                               children: <Widget>[
//                                 IconButton(
//                                   onPressed: () async {
//                                     setState(() {
//                                       isEdit = true;
//                                       pledgeControllerEnable[index] = true;
// //                                      myFocusNode[index].requestFocus();
// //                                      pledgeControllerAutoFocus[index] = true;
// //                                      pledgeControllerShowCursor[index] = true;
//                                     });
//                                     FocusScope.of(context).requestFocus(myFocusNode[index]);
//                                   },
//                                   icon: Icon(
//                                     Icons.create,
//                                     color: Colors.grey,
//                                     size: 25.0,
//                                   ),
//                                 ),
//                                 IconButton(
//                                   icon: Icon(
//                                     Icons.clear,
//                                     color: Colors.red,
//                                     size: 25.0,
//                                   ),
//                                   onPressed: () async {
//                                     Utility.isNetworkConnection().then((isNetwork) {
//                                       if (isNetwork) {
//                                         deleteDialogBox(index);
//                                       } else {
//                                         Utility.showToastMessage(Strings.no_internet_message);
//                                       }
//                                     });
//                                   },
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                         Column(
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.only(top: 0.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: <Widget>[
//                                   Container(
//                                     width: 50,
//                                     child: TextField(
//
//                                       focusNode: myFocusNode[index],
// //                                  autofocus: pledgeControllerAutoFocus[index],
//                                       controller: pledgeController[index],
//                                       enabled: pledgeControllerEnable[index],
// //                                  showCursor: pledgeControllerShowCursor[index],
//                                       onEditingComplete: (){
//                                         Utility.isNetworkConnection().then((isNetwork) {
//                                           if (isNetwork) {
//                                             if (double.parse(pledgeController[index].text) >
//                                                 widget.sharesList[index].quantity!) {
//                                               Utility.showToastMessage(Strings.check_quantity);
//                                             } else {
//                                               myCartList[index].pledgedQuantity = double.parse(pledgeController[index].text);
//                                               sendMyCart(index);
//                                             }
//                                           } else {
//                                             Utility.showToastMessage(Strings.no_internet_message);
//                                           }
//                                         });
//                                       },
//                                     ),
//                                   ),
//                                   Text(
//                                     '₹' + eligibleloan.toString(),
//                                     style: kSecurityAmountTextStyle.copyWith(fontSize: 18.0),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             SizedBox(height: 10,),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: <Widget>[
//                                 Text(
//                                   'Pledge',
//                                   style: kSecurityLiteStyle,
//                                 ),
//                                 Text(
//                                   Strings.eligible_loan_small,
//                                   style: kSecurityLiteStyle,
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             );
//           },
//         ));
//   }
//
//   void sendMyCart(index) {
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
//     myCartRequestBean.loan_margin_shortfall_name = "";
//     myCartRequestBean.loamName = "";
//     myCartRequestBean.pledgor_boid = "";
//     myCartRequestBean.lender = "";
//     loanApplicationBloc.myCart(myCartRequestBean).then((value) {
//       Navigator.pop(context);
//       if (value.isSuccessFull!) {
//         getMyCartList();
//         Utility.showToastMessage(Strings.success);
//       } else if (value.errorCode == 403) {
//         commonDialog(context, Strings.session_timeout, 4);
//       } else {
//         Navigator.pop(context);
//         Utility.showToastMessage(Strings.fail);
//       }
//     });
//   }
//
//   termsCondition(BuildContext context) {
//     bool checkBoxValue = true;
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(15.0))),
//           content: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   GestureDetector(
//                     child: Icon(
//                       Icons.close,
//                       color: Colors.grey,
//                       size: 23,
//                     ),
//                     onTap: () {
//                       Navigator.pop(context);
//                     },
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: ListView(
//                   padding: EdgeInsets.symmetric(vertical: 15),
//                   shrinkWrap: true,
//                   children: <Widget>[
//                     Text(Strings.terms_condition,
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                             color: appTheme,
//                             fontSize: 22,
//                             fontWeight: FontWeight.bold)),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: new Text(Strings.terms1,
//                             style: TextStyle(
//                                 fontSize: 16.0, color: colorDarkGray))),
//                     Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: new Text(Strings.terms2,
//                             style: TextStyle(
//                                 fontSize: 16.0, color: colorDarkGray))),
//                     Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: new Text(Strings.terms3,
//                             style: TextStyle(
//                                 fontSize: 16.0, color: colorDarkGray))),
//                     CheckboxListTile(
//                       controlAffinity: ListTileControlAffinity.leading,
//                       checkColor: Colors.white,
//                       activeColor: appTheme,
//                       title: Text(Strings.accept_terms_condition,
//                           style:
//                           TextStyle(fontSize: 16.0, color: colorDarkGray)),
//                       value: checkBoxValue,
//                       onChanged: (val) {
//                         setState(() {
//                           checkBoxValue = val!;
//                         });
//                       },
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 45,
//                 width: 100,
//                 child: Material(
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(35)),
//                   elevation: 1.0,
//                   color: appTheme,
//                   child: MaterialButton(
//                     minWidth: MediaQuery.of(context).size.width,
//                     onPressed: () async {
//                       Utility.isNetworkConnection().then((isNetwork) {
//                         if (isNetwork) {
//                           eSignVerification();
//                         } else {
//                           Utility.showToastMessage(Strings.no_internet_message);
//                         }
//                       });
// //                      Navigator.pop(context);
// //                      showModalBottomSheet(
// //                          backgroundColor: Colors.transparent,
// //                          context: context,
// //                          isScrollControlled: true,
// //                          builder: (BuildContext bc) {
// //                            return EsignVerification(widget.myCartData.eligibleAmount.toString(),widget.myCartData.name);
// //                          });
//                     },
//                     child: Text(
//                       Strings.accept,
//                       style: TextStyle(
//                           color: colorWhite, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
// //        return AlertDialog(
// //          backgroundColor: Colors.white,
// //          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
// //          content: Column(
// //            mainAxisAlignment: MainAxisAlignment.center,
// //            crossAxisAlignment: CrossAxisAlignment.center,
// //            mainAxisSize: MainAxisSize.min,
// //            children: <Widget>[
// //              Row(
// //                crossAxisAlignment: CrossAxisAlignment.end,
// //                mainAxisAlignment: MainAxisAlignment.end,
// //                children: <Widget>[
// //                  GestureDetector(
// //                    child: Icon(
// //                      Icons.close,
// //                      color: Colors.grey,
// //                      size: 23,
// //                    ),
// //                    onTap: () {
// //                      Navigator.pop(context);
// //                    },
// //                  ),
// //                ],
// //              ),
// //              SizedBox(
// //                height: 10,
// //              ),
// //              Expanded(
// //                child: ListView(
// //                  padding: EdgeInsets.symmetric(vertical: 15),
// //                  shrinkWrap: true,
// //                  children: <Widget>[
// //                    Text(Strings.terms_condition,
// //                        textAlign: TextAlign.center,
// //                        style: TextStyle(
// //                            color: appTheme, fontSize: 20, fontWeight: FontWeight.bold)),
// //                    SizedBox(
// //                      height: 5,
// //                    ),
// //                    Padding(
// //                        padding: const EdgeInsets.all(10.0),
// //                        child: new Text(
// //                            Strings.terms1,
// //                            style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600))),
// //                    Padding(
// //                        padding: const EdgeInsets.all(10.0),
// //                        child: new Text(
// //                            Strings.terms2,
// //                            style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600))),
// //                    Padding(
// //                        padding: const EdgeInsets.all(10),
// //                        child: new Text(Strings.terms3,
// //                            style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600))),
// //                    CheckboxListTile(
// //                      controlAffinity: ListTileControlAffinity.leading,
// //                      checkColor: Colors.white,
// //                      activeColor: appTheme,
// //                      title: Text(Strings.accept_terms_condition,
// //                          style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600)),
// //                      value: true,
// //                      onChanged: (val) {
// //                        // setState(() {
// //                        //   isAcceptTnC = val;
// //                        // });
// //                      },
// //                    )
// //                  ],
// //                ),
// //              ),
// //              Container(
// //                height: 40,
// //                width: 100,
// //                child: Material(
// //                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
// //                  elevation: 1.0,
// //                  color: appTheme,
// //                  child: MaterialButton(
// //                    minWidth: MediaQuery.of(context).size.width,
// //                    onPressed: () async {
// //                      Utility.isNetworkConnection().then((isNetwork) {
// //                        if (isNetwork) {
// //                          eSignVerification();
// //                        } else {
// //                          showSnackBar(_scaffoldKey);
// //                        }
// //                      });
// ////                      Navigator.pop(context);
// ////                      showModalBottomSheet(
// ////                          backgroundColor: Colors.transparent,
// ////                          context: context,
// ////                          isScrollControlled: true,
// ////                          builder: (BuildContext bc) {
// ////                            return EsignVerification(widget.myCartData.eligibleAmount.toString(),widget.myCartData.name);
// ////                          });
// //                    },
// //                    child: Text(
// //                      Strings.accept,
// //                      style: TextStyle(color: Colors.white),
// //                    ),
// //                  ),
// //                ),
// //              ),
// //            ],
// //          ),
// //        );
//       },
//     );
//   }
//
//   Future<bool> deleteDialogBox(index) async{
//     return await showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: colorWhite,
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
//                         fontSize: 22,
//                         color: appTheme,
//                         fontWeight: FontWeight.bold)),
//                 Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: new Text("Would you like to remove your selection?",
//                       style: TextStyle(fontSize: 16.0, color: colorLightGray)),
//                 ),
//                 Container(
//                   height: 45,
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
//                         myCartList.removeAt(index);
//                         printLog("length:: ${myCartList.length}");
//                         sendMyCart(index);
//                       },
//                       child: Text(
//                         Strings.yes,
//                         style: TextStyle(color: colorWhite,fontWeight: FontWeight.bold),
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
//
//   void eSignVerification() {
//     LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//     loanApplicationBloc.esignVerification("").then((value) async {
//       Navigator.pop(context);
//       if (value.isSuccessFull!) {
//         Utility.showToastMessage(value.message!);
//         //fileId = value.message.data.fileId;
//         eSignProcess(value, value.data!.fileId!);
//       }else{
//         Utility.showToastMessage(value.message!);
//       }
//     });
//   }
//
//   eSignProcess(value, fileId) async {
//     String result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => WebViewScreenWidget(value.message.data.esignUrl, fileId, Strings.increase_loan)));
//     if (result == Strings.success) {
//       Navigator.pop(context);
//       _showSuccessDialog(value, fileId);
//       // Navigator.push(context, MaterialPageRoute(
//       //   builder: (BuildContext contect) => EsignVerification(widget.myCartData.eligibleAmount.toString(),widget.myCartData.name,"E-Sign",value.message.data.esignUrl)
//       // ));
//
//     } else if (result == Strings.fail) {
//       Navigator.pop(context);
//       _showFailDialog(value);
//     } else if (result == Strings.cancel) {
//       Navigator.pop(context);
//       _showCancelDialog(value);
//     } else {
//       Utility.showToastMessage(value.message.message);
//     }
//   }
//
//   Future<void> _showCancelDialog(value) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(15.0))),
//           content: Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     GestureDetector(
//                       child: Icon(
//                         Icons.cancel,
//                         color: Colors.grey,
//                         size: 20,
//                       ),
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//                 Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: new Text(Strings.esign_cancelled,
//                           style: TextStyle(fontSize: 16.0, color: colorDarkGray)),
//                     ) //
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 40,
//                   width: 100,
//                   child: Material(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(35)),
//                     elevation: 1.0,
//                     color: appTheme,
//                     child: MaterialButton(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                       minWidth: MediaQuery.of(context).size.width,
//                       onPressed: () async {
//                         Navigator.pop(context);
//                         eSignProcess(value, fileId);
//                       },
//                       child: Text(
//                         Strings.ok,
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
//
//   Future<void> _showSuccessDialog(value, fileId) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(15.0))),
//           content: Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//
//                 Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: new Text(Strings.esign_successful,
//                           style: TextStyle(fontSize: 16.0, color: colorDarkGray)),
//                     ) //
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 40,
//                   width: 100,
//                   child: Material(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(35)),
//                     elevation: 1.0,
//                     color: appTheme,
//                     child: MaterialButton(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                       minWidth: MediaQuery.of(context).size.width,
//                       onPressed: () async {
//                         Navigator.pop(context);
//                         showModalBottomSheet(
//                             backgroundColor: Colors.transparent,
//                             context: context,
//                             isScrollControlled: true,
//                             builder: (BuildContext context) {
//                               return IncreaseLimitCDialog(widget.myCartData.cart!.eligibleLoan.toString(),widget.myCartData.cart!.name!,widget.odLimit,fileId,widget.sharesList[0].stockAt!);
//                             });
//                       },
//                       child: Text(
//                         Strings.ok,
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         );
//
//       },
//     );
//   }
//
//   Future<void> _showFailDialog(value) async {
//     return showDialog<void>(
//       context: context,
//       barrierDismissible: false, // user must tap button!
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(15.0))),
//           content: Container(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.end,
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     GestureDetector(
//                       child: Icon(
//                         Icons.cancel,
//                         color: Colors.grey,
//                         size: 20,
//                       ),
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                   ],
//                 ),
//                 Center(
//                     child: Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: new Text(Strings.esign_failed,
//                           style: TextStyle(fontSize: 16.0, color: colorDarkGray)),
//                     ) //
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Container(
//                   height: 40,
//                   width: 100,
//                   child: Material(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(35)),
//                     elevation: 1.0,
//                     color: appTheme,
//                     child: MaterialButton(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                       minWidth: MediaQuery.of(context).size.width,
//                       onPressed: () async {
//                         Navigator.pop(context);
//                         eSignProcess(value, fileId);
//                       },
//                       child: Text(
//                         Strings.ok,
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
