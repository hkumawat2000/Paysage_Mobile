// import 'dart:math';
//
// import 'package:lms/dummy/ReusableAmountWithTextAndDivider.dart';
// import 'package:lms/dummy/constants.dart';
// import 'package:lms/network/requestbean/MyCartRequestBean.dart';
// import 'package:lms/network/responsebean/ApprovedListResponseBean.dart';
// import 'package:lms/network/responsebean/MyCartResponseBean.dart';
// import 'package:lms/shares/EligibleDialog.dart';
// import 'package:lms/shares/LoanApplicationBloc.dart';
// import 'package:lms/shares/webviewScreen.dart';
// import 'package:lms/util/Colors.dart';
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
//
// class MyEligibleCartScreen extends StatefulWidget {
//   final MyCartData myCartData;
//   List<CartItems> myCartList;
//   List<ShareListData> sharesList;
//
//   MyEligibleCartScreen(this.myCartList, this.sharesList, this.myCartData);
//
//   @override
//   MyEligibleCartScreenState createState() => MyEligibleCartScreenState();
// }
//
// class MyEligibleCartScreenState extends State<MyEligibleCartScreen> {
//   final loanApplicationBloc = LoanApplicationBloc();
//   final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
//   List<SecuritiesList> securitiesListItems = [];
//   List<CartItems> myCartList = [];
//   var eligible_amount, selected_securitis, total_company, stock_at, fileId;
//   List<TextEditingController> pledgeController = [];
//   List<bool> pledgeControllerEnable = [];
//   List<bool> pledgeControllerAutoFocus = [];
//   List<bool> pledgeControllerShowCursor = [];
//   List<bool> isVisibleSaveButton = [];
//   List<bool> isVisibleEditOption = [];
//   String pledgeText;
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldkey,
//         resizeToAvoidBottomPadding: false,
//         backgroundColor: Color(0xFFF8F9FE),
//         appBar: AppBar(
//           leading: IconButton(
//             icon: Icon(
//               Icons.arrow_back_ios,
//               color: appTheme,
//               size: 15,
//             ),
//             onPressed: () => Navigator.of(context).pop(),
//           ),
//           backgroundColor: Color(0xFFF8F9FE),
//           elevation: 0.0,
//           centerTitle: true,
//           title: Text(
//             'SPA1234',
//             style: kDefaultTextStyle,
//           ),
//         ),
//         body: NestedScrollView(
//           physics: ScrollPhysics(),
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverList(
//                 delegate: SliverChildListDelegate(
//                   [
//                     titleCart(),
//                     pledgeCart(),
//                   ],
//                 ),
//               )
//             ];
//           },
//           body: Column(
//             children: <Widget>[
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: <Widget>[
//                     Text('Shares Selected',
//                         style: kDefaultTextStyle.copyWith(fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: _myCart(),
//                 ),
//               ),
//               bottomSection(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget getMyCartList() {
//     return StreamBuilder(
//       stream: loanApplicationBloc.myCartList,
//       builder: (context, AsyncSnapshot<MyCartData> snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data == null || snapshot.data.cart.items == 0) {
//             return _buildNoDataWidget();
//           } else {
//             return _myCart();
//           }
//         } else if (snapshot.hasError) {
//           return _buildErrorWidget(snapshot.error);
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
//   Widget _buildLoadMoreWidget() {
//     return StreamBuilder(
//       stream: loanApplicationBloc.loadMore,
//       initialData: false,
//       builder: (context, snapshot) {
//         return snapshot.data == true ? LoadMoreWidget() : Container();
//       },
//     );
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
//           var eligible_amount;
//           if (snapshot.data != null) {
//             eligible_amount = roundDouble(snapshot.data.cart.eligibleLoan.toDouble(), 2);
//           } else {
//             eligible_amount = roundDouble(widget.myCartData.cart.eligibleLoan.toDouble(), 2);
//           }
//
//           return Container(
//             height: 120,
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.white, width: 3.0), // set border width
//               borderRadius: BorderRadius.only(
//                   topRight: Radius.circular(40.0),
//                   topLeft: Radius.circular(40.0)), // set rounded corner radius
//               boxShadow: [
//                 BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
//               ], // make rounded corner of border
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         'Eligible Loan',
//                         style: kDefaultTextStyle,
//                       ),
//                       Text(
//                         '₹' + eligible_amount.toString(),
//                         style: kDefaultTextStyle.copyWith(
//                             color: Colors.green, fontWeight: FontWeight.bold),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(
//                         Icons.arrow_back,
//                         color: Colors.grey,
//                         size: 20,
//                       ),
//                       onPressed: () {
//                         Navigator.pop(context);
//                       },
//                     ),
//                     Container(
//                       height: 40,
//                       width: 80,
//                       child: Material(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                         elevation: 1.0,
//                         color: appTheme,
//                         child: MaterialButton(
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () async {
//                             customDialogBox(context, _scaffoldkey);
//                           },
//                           child: Icon(
//                             Icons.arrow_forward,
//                             color: Colors.white,
//                             size: 20,
//                           ),
//                         ),
//                       ),
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           );
//         });
//   }
//
//   Widget titleCart() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, top: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             'My Cart',
//             style: TextStyle(color: appTheme, fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           Text(
//             '12XXXXXXXX45',
//             style: TextStyle(color: appTheme, fontSize: 15, fontWeight: FontWeight.bold),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget pledgeCart() {
//     return StreamBuilder(
//         stream: loanApplicationBloc.myCartList,
//         builder: (context, AsyncSnapshot<MyCartData> snapshot) {
//           if (snapshot.data != null) {
//             eligible_amount = roundDouble(snapshot.data.cart.eligibleLoan.toDouble(), 2);
//             selected_securitis = roundDouble(snapshot.data.cart.totalCollateralValue.toDouble(), 2);
//             total_company = snapshot.data.cart.items.length.toString();
//           } else {
//             eligible_amount = roundDouble(widget.myCartData.cart.eligibleLoan.toDouble(), 2);
//             selected_securitis = roundDouble(widget.myCartData.cart.totalCollateralValue.toDouble(), 2);
//             total_company = widget.myCartList.length.toString();
//           }
//
//           return Padding(
//             padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
//             child: Container(
//               decoration: BoxDecoration(
//                 color: Color(0xFFE2ECFF),
//                 border: Border.all(color: Color(0xFFE2ECFF), width: 3.0),
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
//                     '₹' + selected_securitis.toString(),
//                     style: TextStyle(color: appTheme, fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   SizedBox(
//                     height: 5,
//                   ),
//                   Text(
//                     'TOTAL VALUE',
//                     style: TextStyle(color: Colors.grey.shade800, fontSize: 12),
//                   ),
//                   SizedBox(
//                     height: 10,
//                   ),
//                   ReusableAmountWithTextAndDivider(
//                     leftAmount: total_company,
//                     leftText: 'COMPANIES',
//                     rightAmount: '₹' + eligible_amount.toString(),
//                     rightText: 'ELIGIBLE LOAN',
//                   ),
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
//   double roundDouble(double value, int places) {
//     double mod = pow(10.0, places);
//     return ((value * mod).round().toDouble() / mod);
//   }
//
//   Widget _myCart() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, right: 20),
//       child: StreamBuilder(
//         stream: loanApplicationBloc.myCartList,
//         builder: (context, AsyncSnapshot<MyCartData> snapshot) {
//           return ListView.builder(
//             physics: NeverScrollableScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: widget.myCartData.cart.items.length,
//             itemBuilder: (context, index) {
//               myCartList = widget.myCartList;
//               var pledge_qty, scrip_name, pledge_og;
//               String pleqty;
//               int cart_index;
//               if (snapshot.data != null) {
//                 pleqty = snapshot.data.cart.items[index].pledgedQuantity.toString();
//                 cart_index = snapshot.data.cart.items.length;
//                 scrip_name = snapshot.data.cart.items[index].securityName;
//               } else {
//                 pleqty = widget.myCartList[index].pledgedQuantity.toString();
//                 cart_index = widget.myCartList.length;
//                 scrip_name = widget.sharesList[index].scripName;
//               }
//
//               var eligibleloan = roundDouble(myCartList[index].amount.toDouble(), 2);
//               pledgeController.add(TextEditingController(text: pleqty));
//               pledgeControllerEnable.add(false);
//               pledgeControllerAutoFocus.add(false);
//               pledgeControllerShowCursor.add(false);
//               isVisibleSaveButton.add(false);
//               isVisibleEditOption.add(true);
//               return Container(
//                 margin: EdgeInsets.symmetric(vertical: 10.0),
// //                    padding: EdgeInsets.all(5),
//                 decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(color: Colors.white, width: 3.0),
//                   // set border width
//                   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(10.0),
//                   child: Column(
//                     children: <Widget>[
//                       Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: Text(
//                               scrip_name,
//                               style: kSecurityNameTextSTyle,
//                             ),
//                           ),
//                           Row(
//                             children: <Widget>[
//                               Visibility(
//                                 visible: isVisibleEditOption[index],
//                                 child: IconButton(
//                                   onPressed: () {
//                                     setState(() {
//                                       pledgeControllerEnable[index] = true;
//                                       pledgeControllerAutoFocus[index] = true;
//                                       pledgeControllerShowCursor[index] = true;
//                                       isVisibleEditOption[index] = false;
//                                       isVisibleSaveButton[index] = true;
//                                     });
//                                   },
//                                   icon: Icon(
//                                     Icons.create,
//                                     color: Colors.grey,
//                                     size: 25.0,
//                                   ),
//                                 ),
//                               ),
//                               IconButton(
//                                 icon: Icon(
//                                   Icons.clear,
//                                   color: Colors.red,
//                                   size: 25.0,
//                                 ),
//                                 onPressed: () async {
//                                   Utility.isNetworkConnection().then((isNetwork) {
//                                     if (isNetwork) {
//                                       deleteDialogBox(index);
//                                     } else {
//                                       showSnackBar(_scaffoldkey);
//                                     }
//                                   });
//                                 },
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: <Widget>[
//                           Container(
//                             width: 50,
//                             child: TextFormField(
//                               keyboardType: TextInputType.number,
//                               decoration: InputDecoration(border: InputBorder.none),
//                               autofocus: pledgeControllerAutoFocus[index],
//                               controller: pledgeController[index],
//                               enabled: pledgeControllerEnable[index],
//                               showCursor: pledgeControllerShowCursor[index],
//                               onChanged: (text) async {
//                                 pledgeText = text;
//                               },
//                             ),
//                           ),
//                           Visibility(
//                             visible: isVisibleSaveButton[index],
//                             child: Container(
//                               width: 55,
//                               height: 20,
//                               child: TextButton(
//                                 color: appTheme,
//                                 textColor: Colors.white,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(10.0),
//                                 ),
//                                 child: Text(
//                                   'SAVE',
//                                   style: TextStyle(fontSize: 10),
//                                 ),
//                                 onPressed: () {
//                                   Utility.isNetworkConnection().then((isNetwork) {
//                                     if (isNetwork) {
//                                       if (double.parse(pledgeText) >
//                                           widget.sharesList[index].quantity) {
//                                         Utility.showToastMessage(Strings.check_quantity);
//                                       } else {
//                                         myCartList[index].pledgedQuantity = int.parse(pledgeText);
//                                         sendMyCart(index);
//                                       }
//                                     } else {
//                                       showSnackBar(_scaffoldkey);
//                                     }
//                                   });
//                                 },
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Text(
//                             'Pledge',
//                             style: kSecurityLiteStyle,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
//
//   void sendMyCart(index) {
//     LoadingDialogWidget.showDialogLoading(context, "Please wait");
//     securitiesListItems.clear();
//
//     for (int i = 0; i < myCartList.length; i++) {
//       if (myCartList[i].check) {
//         securitiesListItems.add(new SecuritiesList(
//             quantity: double.parse(myCartList[i].pledgedQuantity.toString()),
//             isin: myCartList[i].isin,
//             price: myCartList[i].price));
//       }
//     }
//     Securities securitiesObj = new Securities();
//     securitiesObj.list = securitiesListItems;
//     MyCartRequestBean myCartRequestBean = new MyCartRequestBean();
//     myCartRequestBean.securities = securitiesObj;
//     myCartRequestBean.cartName = widget.myCartData.cart.name;
//     myCartRequestBean.pledgor_boid = "";
//     myCartRequestBean.loamName = "";
//     myCartRequestBean.loan_margin_shortfall_name = "";
//     myCartRequestBean.lender = "";
//     loanApplicationBloc.myCart(myCartRequestBean).then((value) {
//       Navigator.pop(context);
//       if (value.isSuccessFull) {
//         getMyCartList();
//         Utility.showToastMessage(Strings.success);
//       } else {
//         Navigator.pop(context);
//         Utility.showToastMessage(Strings.fail);
//       }
//     });
//   }
//
//   customDialogBox(BuildContext context, GlobalKey<ScaffoldState> _scaffoldkey) {
//     return showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
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
//                     Text("Terms & Conditions",
//                         textAlign: TextAlign.center,
//                         style:
//                             TextStyle(color: appTheme, fontSize: 20, fontWeight: FontWeight.bold)),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: new Text(
//                             "The Request Account info feature allows you to request and export a "
//                             "report of your account information and settings. Examples of this information "
//                             "include your profile photo and group names.",
//                             style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600))),
//                     Padding(
//                         padding: const EdgeInsets.all(10.0),
//                         child: new Text(
//                             "Please note that the report doesn't include your messages. "
//                             "If you wish to export your chat history intead, you can learn how in our \nHelp Center.",
//                             style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600))),
//                     Padding(
//                         padding: const EdgeInsets.all(10),
//                         child: new Text("Your report will be availbale",
//                             style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600))),
//                     CheckboxListTile(
//                       controlAffinity: ListTileControlAffinity.leading,
//                       checkColor: Colors.white,
//                       activeColor: appTheme,
//                       title: Text("I accept the Terms & Conditions",
//                           style: TextStyle(fontSize: 15.0, color: Colors.grey.shade600)),
//                       value: true,
//                       onChanged: (val) {
//                         // setState(() {
//                         //   isAcceptTnC = val;
//                         // });
//                       },
//                     )
//                   ],
//                 ),
//               ),
//               Container(
//                 height: 40,
//                 width: 100,
//                 child: Material(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                   elevation: 1.0,
//                   color: appTheme,
//                   child: MaterialButton(
//                     minWidth: MediaQuery.of(context).size.width,
//                     onPressed: () async {
//                       Utility.isNetworkConnection().then((isNetwork) {
//                         if (isNetwork) {
//                           eSignVerification();
//                         } else {
//                           showSnackBar(_scaffoldkey);
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
//                       "Accept",
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<bool> deleteDialogBox(index) {
//     return showDialog<void>(
//           context: context,
//           builder: (BuildContext context) {
//             return AlertDialog(
//               backgroundColor: Colors.white,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
//               title: Row(
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   GestureDetector(
//                     child: Icon(
//                       Icons.cancel,
//                       color: Colors.grey,
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
//                     Text("Are you sure",
//                         style: TextStyle(
//                             fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
//                     Padding(
//                       padding: const EdgeInsets.all(10.0),
//                       child: new Text("You want to delete",
//                           style: TextStyle(fontSize: 16.0, color: Colors.grey)),
//                     ),
//                     Container(
//                       height: 40,
//                       width: 100,
//                       child: Material(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                         elevation: 1.0,
//                         color: appTheme,
//                         child: MaterialButton(
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () async {
//                             Navigator.pop(context);
//                             myCartList.removeAt(index);
//                             sendMyCart(index);
//                           },
//                           child: Text(
//                             "Yes",
//                             style: TextStyle(color: Colors.white),
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
//
//   void eSignVerification() {
//     LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//     loanApplicationBloc.esignVerification( "").then((value) async {
//       Navigator.pop(context);
//       if (value.isSuccessFull) {
//         Utility.showToastMessage(value.message);
//         //fileId = value.message.data.fileId;
//
//         eSignProcess(value, value.data.fileId);
//       }
//     });
//   }
//
//   eSignProcess(value, fileId) async {
//     String result = await Navigator.push(
//         context,
//         MaterialPageRoute(
//             builder: (context) => WebViewScreenWidget(value.message.data.esignUrl, fileId)));
//     if (result == "success") {
//       Navigator.pop(context);
//       _showSuccessDialog(value, fileId);
//       // Navigator.push(context, MaterialPageRoute(
//       //   builder: (BuildContext contect) => EsignVerification(widget.myCartData.eligibleAmount.toString(),widget.myCartData.name,"E-Sign",value.message.data.esignUrl)
//       // ));
//
//     } else if (result == "fail") {
//       Navigator.pop(context);
//       _showFailDialog(value);
//     } else if (result == "cancel") {
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
//           title: Text('E-Sign Cancelled'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('E-Sign cancelled'),
//                 Text('Do you want to try again?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('No'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Yes'),
//               onPressed: () {
//                 Navigator.pop(context);
//                 eSignProcess(value, fileId);
//               },
//             ),
//           ],
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
//           title: Text('E-Sign Successful'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text(''),
//                 Text(''),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('Ok'),
//               onPressed: () {
//                 Navigator.pop(context);
//                 showModalBottomSheet(
//                     backgroundColor: Colors.transparent,
//                     context: context,
//                     isScrollControlled: true,
//                     builder: (BuildContext context) {
//                       return EligibleCDialog(widget.myCartData.cart.eligibleLoan.toString(),
//                           widget.myCartData.cart.name, fileId, "");
//                     });
//               },
//             ),
//           ],
//         );
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
//           title: Text('E-Sign Failed'),
//           content: SingleChildScrollView(
//             child: ListBody(
//               children: <Widget>[
//                 Text('E-Sign failed'),
//                 Text('Do you want to try again?'),
//               ],
//             ),
//           ),
//           actions: <Widget>[
//             TextButton(
//               child: Text('No'),
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//             ),
//             TextButton(
//               child: Text('Yes'),
//               onPressed: () {
//                 Navigator.pop(context);
//                 eSignProcess(value, fileId);
//               },
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
