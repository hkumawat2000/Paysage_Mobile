// import 'dart:convert';
// import 'dart:math';
//
// import 'package:lms/Eligibility/MyEligibleCartScreen.dart';
// import 'package:lms/dummy/constants.dart';
// import 'package:lms/login/LoginDao.dart';
// import 'package:lms/network/requestbean/MyCartRequestBean.dart';
// import 'package:lms/network/responsebean/ApprovedListResponseBean.dart';
// import 'package:lms/network/responsebean/MyCartResponseBean.dart';
// import 'package:lms/shares/LoanApplicationBloc.dart';
// import 'package:lms/util/Colors.dart';
// import 'package:lms/util/Preferences.dart';
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
//
// class EligibilityScreen extends StatefulWidget {
//   @override
//   EligibilityScreenState createState() => EligibilityScreenState();
// }
//
// class EligibilityScreenState extends State<EligibilityScreen> {
//   final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
//   List<int> _counter = List();
//   int counterValue = 0;
//   final loanApplicationBloc = LoanApplicationBloc();
//   ScrollController _scrollController = new ScrollController();
//   Preferences preferences;
//   bool checkBoxValue = true;
//   bool singlecheckBoxValue = true;
//   List<bool> checkBoxValues = [];
//   List<TextEditingController> _controllers = [];
//   List<SecuritiesList> securitiesListItems = [];
//   MyCartData myCartData = new MyCartData();
//   List<ShareListData> tempList = [];
//   bool isLoading = true;
//   List<CartItems> myCartList = [];
//   List<ShareListData> securities = [];
//
//   List<ShareListData> sharesList = [];
//   int decimalRange;
//   List<String> scripNameList;
//
//   Widget appBarTitle = new Text(
//     "",
//     style: new TextStyle(color: Colors.white),
//   );
//   Icon actionIcon = new Icon(
//     Icons.search,
//     color: appTheme,
//     size: 17,
//   );
//
//   TextEditingController _textController = TextEditingController();
//
//   static List<String> mainDataList = [];
//
//   void getDetails() async {
//     ApprovedListResponseBean temp = await loanApplicationBloc.getUserDetailsSecurities("");
//     sharesList = temp.data;
//     scripNameList = List.generate(sharesList.length, (index) => sharesList[index].scripName);
//     printLog("list::: ${scripNameList.length}");
//     mainDataList.addAll(scripNameList);
//     printLog("listMain::: ${mainDataList.length}");
//   }
//
//   List<String> newDataList = List.from(mainDataList);
//
//   onItemChanged(String value) {
//     setState(() {
//       newDataList.clear();
//       newDataList = scripNameList
//           .where((string) => string.toLowerCase().contains(value.toLowerCase()))
//           .toList();
//       printLog("listNew::: ${newDataList.length}");
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
//     preferences = Preferences();
//     Utility.isNetworkConnection().then((isNetwork) {
//       if (isNetwork) {
//         getDetails();
//       } else {
//         final scaffold = Scaffold.of(context);
//         showSnackBarWithScaffold(scaffold, Strings.no_internet_message);
//       }
//     });
//
//     super.initState();
//   }
//
//   void _incrementCounter(int index) {
//     setState(() {
//       counterValue++;
//       _counter.add(counterValue);
//     });
//   }
//
//   void _decrementCounter(val) {
//     setState(() {
//       counterValue--;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         key: _scaffoldkey,
//         resizeToAvoidBottomPadding: false,
//         backgroundColor: Color(0xFFF8F9FE),
//         appBar: buildBar(context),
//         body: NestedScrollView(
//           physics: ScrollPhysics(),
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverList(
//                 delegate: SliverChildListDelegate([
//                   pledgeCart(),
//                 ]),
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
//                     Text('Shares', style: kDefaultTextStyle.copyWith(fontWeight: FontWeight.bold)),
//                   ],
//                 ),
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: getSecuritiesList(),
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
//   Widget buildBar(BuildContext context) {
//     final theme = Theme.of(context);
//     return new AppBar(
//       elevation: 0.0,
//       centerTitle: true,
//       title: appBarTitle,
//       backgroundColor: Color(0xFFF8F9FE),
//       leading: IconButton(
//         icon: Icon(
//           Icons.arrow_back_ios,
//           color: appTheme,
//           size: 15,
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
//                     size: 17,
//                   );
//                   this.appBarTitle = new TextField(
//                     controller: _textController,
//                     style: new TextStyle(
//                       color: appTheme,
//                     ),
//                     cursorColor: appTheme,
//                     decoration: new InputDecoration(
//                         prefixIcon: new Icon(
//                           Icons.search,
//                           color: appTheme,
//                           size: 17,
//                         ),
//                         hintText: "Search...",
//                         focusColor: appTheme,
//                         border: InputBorder.none,
//                         hintStyle: new TextStyle(color: appTheme)),
//                     onChanged: onItemChanged,
//                   );
//                 } else {
//                   _handleSearchEnd();
//                 }
//               });
//             },
//           ),
//         ),
//         IconButton(
//             icon: Icon(
//               Icons.add_shopping_cart,
//               color: appTheme,
//               size: 15,
//             ),
//             onPressed: () {})
//       ],
//     );
//   }
//
//   void _handleSearchEnd() {
//     setState(() {
//       this.actionIcon = new Icon(Icons.search, color: appTheme, size: 17);
//       this.appBarTitle = new Text(
//         "",
//         style: new TextStyle(color: appTheme),
//       );
//       _textController.clear();
//       newDataList.clear();
//     });
//   }
//
//   Widget bottomSection() {
//     return StreamBuilder(
//       stream: loanApplicationBloc.myCartList,
//       builder: (context, AsyncSnapshot<MyCartData> snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data != null && snapshot.data.cart.items.length > 0) {
//             myCartData = snapshot.data;
//             var eligible_loan = roundDouble(double.parse(snapshot.data.cart.eligibleLoan.toString()), 2);
//             var selected_securities = roundDouble(double.parse(snapshot.data.cart.totalCollateralValue.toString()), 2);
//             return Container(
//               height: 150,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   border: Border.all(color: Colors.white, width: 3.0), // set border width
//                   borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(40.0),
//                       topLeft: Radius.circular(40.0)), // set rounded corner radius
//                   boxShadow: [
//                     BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 3))
//                   ] // make rounded corner of border
//                   ),
//               child: Container(
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   mainAxisSize: MainAxisSize.min,
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
//                       child: Column(
//                         children: <Widget>[
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text(
//                                 'Security Value',
//                                 style: kDefaultTextStyle,
//                               ),
//                               Text(
//                                 selected_securities.toString(),
//                                 style: kDefaultTextStyle.copyWith(fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: <Widget>[
//                               Text(
//                                 'Eligible Loan',
//                                 style: kDefaultTextStyle,
//                               ),
//                               Text(
//                                 "\u20B9" + eligible_loan.toString(),
//                                 style: TextStyle(
//                                     fontSize: 17.0,
//                                     color: Colors.green,
//                                     fontWeight: FontWeight.bold),
//                               )
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         IconButton(
//                           icon: Icon(
//                             Icons.arrow_back,
//                             color: Colors.grey,
//                             size: 20,
//                           ),
//                           onPressed: () {
//                             Navigator.pop(context);
//                           },
//                         ),
//                         Container(
//                           height: 40,
//                           width: 80,
//                           child: Material(
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                             elevation: 1.0,
//                             color: appTheme,
//                             child: MaterialButton(
//                               minWidth: MediaQuery.of(context).size.width,
//                               onPressed: () async {
//                                 Navigator.push(
//                                     context,
//                                     MaterialPageRoute(
//                                         builder: (BuildContext context) =>
//                                             MyEligibleCartScreen(myCartList, sharesList, myCartData)));
//                               },
//                               child: Icon(
//                                 Icons.arrow_forward,
//                                 color: Colors.white,
//                                 size: 20,
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         }
//         return Container();
//       },
//     );
//   }
//
//   Widget titleCart() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, top: 10),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: <Widget>[
//           Text(
//             'Pledge Securities',
//             style: TextStyle(color: appTheme, fontSize: 20, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(
//             height: 5,
//           ),
//           Text(
//             '12XXXXXXXXXXX45',
//             style: TextStyle(color: Colors.grey.shade800, fontSize: 15),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget pledgeCart() {
//     return StreamBuilder(
//       stream: loanApplicationBloc.myCartList,
//       builder: (context, AsyncSnapshot<MyCartData> snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data != null && snapshot.data.cart.items.length > 0) {
//             var total_value = roundDouble(double.parse(snapshot.data.cart.totalCollateralValue.toString()), 2);
//             return Padding(
//               padding: const EdgeInsets.only(left: 20.0, top: 10, right: 20),
//               child: Container(
//                 decoration: BoxDecoration(
//                   color: Color(0xFFE2ECFF),
//                   border: Border.all(color: Color(0xFFE2ECFF), width: 3.0), // set border width
//                   borderRadius:
//                       BorderRadius.all(Radius.circular(15.0)), // set rounded corner radius
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       '₹' + total_value.toString(),
//                       style: TextStyle(
//                           color: appTheme, fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       'TOTAL VALUE',
//                       style: TextStyle(color: Colors.grey.shade800, fontSize: 12),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                     Text(
//                       snapshot.data.cart.items.length.toString(),
//                       style: boldTextStyle_30,
//                     ),
//                     SizedBox(
//                       height: 5,
//                     ),
//                     Text(
//                       'COMPANY',
//                       style: TextStyle(color: Colors.grey.shade800, fontSize: 12),
//                     ),
//                     SizedBox(
//                       height: 10,
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         }
//         return Container();
//       },
//     );
//   }
//
//   Widget getSecuritiesList() {
//     return StreamBuilder(
//       stream: loanApplicationBloc.myCartList,
//       builder: (context, AsyncSnapshot<MyCartData> snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data == null || snapshot.data.cart.items.length == 0) {
//             return _buildNoDataWidget();
//           } else {
//             return pledgeSecuritiesList(snapshot);
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
//   Widget pledgeSecuritiesList(AsyncSnapshot<MyCartData> snapshot) {
//     return Padding(
//       padding: const EdgeInsets.only(left: 20.0, top: 0, right: 20),
//       child: ListView.builder(
//         physics: NeverScrollableScrollPhysics(),
//         shrinkWrap: true,
//         itemCount: newDataList.length != 0 ? newDataList.length : snapshot.data.cart.items.length,
//         itemBuilder: (context, index) {
//           myCartList = snapshot.data.cart.items;
//           checkBoxValues.add(true);
//           myCartList[index].check = true;
//
//           for (int i = 0; i > myCartList.length; i++) {
//             if (myCartList.length != 0) {
//               newDataList.add(myCartList[i].securityName);
//             }
//           }
//
//           printLog("newDataList1234:: ${newDataList}");
//           var pledge_qty = myCartList[index].pledgedQuantity.toString();
//           _controllers.add(new TextEditingController(text: pledge_qty));
//           var category;
//           if (category.toString() == "null") {
//             category = "";
//           } else {
//             category == snapshot.data.cart.items[index].securityCategory;
//           }
//           var script_value, remainingValue;
//
//           if (myCartList[index].amount.toString() == "null") {
//             script_value = "0";
//           } else {
//             script_value = roundDouble(myCartList[index].amount.toDouble(), 2);
//           }
//
//           var qty;
//           String str = sharesList[index].quantity.toString();
//           var qtyArray = str.split('.');
//
//           printLog(qtyArray[0]); //will print 466
//           printLog(qtyArray[1]);
//           qty = qtyArray[0];
//           var val1 = sharesList[index].quantity;
//           var val2 = snapshot.data.cart.items[index].pledgedQuantity;
//           remainingValue = val1 - val2;
//           printLog("Subtraction: ${remainingValue}");
//
//           var remainingAmount;
//           String remainingStr = remainingValue.toString();
//           var remainingArray = remainingStr.split('.');
//
//           printLog(remainingArray[0]); //will print 466
//           printLog(remainingArray[1]);
//           remainingAmount = remainingArray[0];
//           return Container(
//             margin: EdgeInsets.symmetric(vertical: 10.0),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               border: Border.all(color: Colors.white, width: 3.0), // set border width
//               borderRadius: BorderRadius.all(Radius.circular(10.0)), // set rounded corner radius
//             ),
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: <Widget>[
//                     Padding(
//                       padding: EdgeInsets.all(10.0),
//                       child: Text(
//                         newDataList.length != 0 ? newDataList[index] : scripNameList[index],
//                         style: kSecurityNameTextSTyle,
//                       ),
//                     ),
//                     Padding(
//                         padding: EdgeInsets.only(right: 10.0),
//                         child: Icon(
//                           Icons.add_circle_outline,
//                           color: Colors.green,
//                           size: 25.0,
//                         )),
//                   ],
//                 ),
//                 Table(children: [
//                   TableRow(children: [
//                     Column(
//                       children: <Widget>[
//                         Text(qty.toString(), style: kSecurityAmountTextStyle),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text("Qty", style: kSecurityLiteStyle),
//                       ],
//                     ),
//                     Column(
//                       children: <Widget>[
//                         Text(myCartList[index].price.toString(), style: kSecurityAmountTextStyle),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text("CMP", style: kSecurityLiteStyle),
//                       ],
//                     ),
//                     Column(
//                       children: <Widget>[
//                         Text(script_value.toString(), style: kSecurityAmountTextStyle),
//                         SizedBox(
//                           height: 5,
//                         ),
//                         Text("Total Value", style: kSecurityLiteStyle),
//                       ],
//                     ),
//                   ]),
//                 ]),
//                 Padding(
//                   padding: EdgeInsets.only(left: 10, right: 10),
//                   child: Divider(
//                     thickness: 0.5,
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(5.0),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: <Widget>[
//                           Text(
//                             'Pledge Qty',
//                             style: kSecurityNameTextSTyle,
//                           ),
//                           SizedBox(
//                             height: 5,
//                           ),
//                           Text(
//                             "Remaining ${remainingAmount.toString()}",
//                             style: kSecurityLiteStyle,
//                           )
//                         ],
//                       ),
//                       Row(
//                         children: <Widget>[
//                           Padding(
//                             padding: EdgeInsets.only(left: 0.0),
//                             child: IconButton(
//                               iconSize: 20.0,
//                               icon: Container(
//                                 padding: EdgeInsets.all(2),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(100),
//                                     border: Border.all(width: 1, color: Colors.grey)),
//                                 child: Icon(
//                                   Icons.remove,
//                                   color: Colors.grey.shade600,
//                                   size: 18,
//                                 ),
//                               ),
//                               onPressed: () async {
//                                 Utility.isNetworkConnection().then((isNetwork) {
//                                   if (isNetwork) {
//                                     int txt = int.parse(_controllers[index].text) - 1;
//                                     setState(() {
//                                       _controllers[index].text = txt.toString();
//                                       myCartList[index].pledgedQuantity--;
//                                     });
//                                     sendMyCart();
//                                   } else {
//                                     showSnackBar(_scaffoldkey);
//                                   }
//                                 });
//
// //                                setState(() {
// //                                  counterValue = myCartList[index].pledgedQuantity--;
// //                                  printLog("value:$counterValue");
// //                                  if (counterValue >
// //                                      sharesList[index].quantity) {
// //                                    showToastMessage(
// //                                        "Please check your quantity");
// //                                  } else {
// //                                    myCartList[index].pledgedQuantity =
// //                                        counterValue;
// //                                    sendMyCart();
// //                                  }
// // //                                 _decrementCounter(_controllers[index]);
// //                                });
//                               },
//                             ),
//                           ),
//                           Container(
//                             width: 50,
//                             height: 30,
//                             child: TextFormField(
//                               textAlign: TextAlign.center,
//                               decoration:
//                                   InputDecoration(border: InputBorder.none, counterText: ""),
//                               maxLength: 4,
//                               keyboardType: TextInputType.number,
//                               controller: _controllers[index],
//                               style: TextStyle(
//                                 fontWeight: FontWeight.w600,
//                               ),
//                               onChanged: (text) {
// //                                printLog(text);
// //                                if (double.parse(text) >
// //                                    sharesList[index].quantity) {
// //                                  showToastMessage(
// //                                      "Please check your quantity");
// //                                } else {
// //                                  myCartList[index].pledgedQuantity =
// //                                      int.parse(text);
// ////                                  sendMyCart();
// //                                }
//                               },
//                             ),
//                           ),
//                           Padding(
//                             padding: EdgeInsets.only(left: 0.0),
//                             child: IconButton(
//                               icon: Container(
//                                 padding: EdgeInsets.all(2),
//                                 decoration: BoxDecoration(
//                                     borderRadius: BorderRadius.circular(100),
//                                     border: Border.all(width: 1, color: Colors.grey)),
//                                 child: Icon(
//                                   Icons.add,
//                                   color: Colors.grey.shade600,
//                                   size: 18,
//                                 ),
//                               ),
//                               onPressed: () async {
//                                 Utility.isNetworkConnection().then((isNetwork) {
//                                   if (isNetwork) {
//                                     if (int.parse(_controllers[index].text) < int.parse(qty)) {
//                                       int txt = int.parse(_controllers[index].text) + 1;
//                                       setState(() {
//                                         _controllers[index].text = txt.toString();
//                                         myCartList[index].pledgedQuantity++;
//                                       });
//                                       sendMyCart();
//                                     }
//                                   } else {
//                                     showSnackBar(_scaffoldkey);
//                                   }
//                                 });
// //                                _incrementCounter(index);
//                               },
//                             ),
//                           ),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
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
//   double roundDouble(double value, int places) {
//     double mod = pow(10.0, places);
//     return ((value * mod).round().toDouble() / mod);
//   }
//
//   void sendMyCart() {
//     LoadingDialogWidget.showDialogLoading(context, "Please wait");
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
//     myCartRequestBean.cartName = myCartData.cart.name;
//     myCartRequestBean.pledgor_boid = "";
//     myCartRequestBean.loamName = "";
//     myCartRequestBean.loan_margin_shortfall_name = "";
//     myCartRequestBean.lender = "";
//     loanApplicationBloc.myCart(myCartRequestBean).then((value) {
//       Navigator.pop(context);
//       if (value.isSuccessFull) {
//         getSecuritiesList();
//         Utility.showToastMessage(Strings.success);
//       } else {
//         Navigator.pop(context);
//         Utility.showToastMessage(Strings.fail);
//       }
//     });
//   }
// }
