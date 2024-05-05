// import 'package:choice/Eligibility/CheckEligibilityBloc.dart';
// import 'package:choice/approvedsharesandmf/ApprovedShares.dart';
// import 'package:choice/common_widgets/constants.dart';
// import 'package:choice/completekyc/CompleteKYCScreen.dart';
// import 'package:choice/network/responsebean/CheckEligibilityResponseBean.dart';
// import 'package:choice/util/Colors.dart';
// import 'package:choice/util/Preferences.dart';
// import 'package:choice/util/Style.dart';
// import 'package:choice/util/Utility.dart';
// import 'package:choice/util/strings.dart';
// import 'package:choice/widgets/ErrorMessageWidget.dart';
// import 'package:choice/widgets/LoadingWidget.dart';
// import 'package:choice/widgets/NoDataWidget.dart';
// import 'package:choice/widgets/WidgetCommon.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// class CheckEligibilityScreen extends StatefulWidget {
//   final lender;
//   bool isEmailVerified;
//   int canPledge;
//   List<EligibilityData> approvedSecurityList;
//
//   CheckEligibilityScreen(this.lender, this.isEmailVerified, this.canPledge, this.approvedSecurityList);
//
//   @override
//   State<StatefulWidget> createState() {
//     return CheckEligibilityScreenState();
//   }
// }
//
// class CheckEligibilityScreenState extends State<CheckEligibilityScreen> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   Preferences preferences = Preferences();
//   TextEditingController _textController = TextEditingController();
//   List<TextEditingController> _controllerQuantity = [];
//   List<TextEditingController> _controllerQuantitySelectedSecurity = [];
//   final checkEligibilityBloc = CheckEligibilityBloc();
//   List<bool> isApprovedItems = <bool>[];
//   List<bool> isSecurityItems = <bool>[];
//   List<bool> isSecurityViewVisible = <bool>[];
//   List<EligibilityData> selectedSecurityList = [];
//   List<EligibilityData> approvedSecurityList = [];
//   List<EligibilityData> originalEligibilityList = [];
//   List<EligibilityData> whileSearchList = [];
//   bool isSelectedSecurityViewVisible = false;
//   double totalMarketValue = 0;
//   double securitiesValue = 0;
//   double eligibleAmount = 0;
//   bool? userKYC;
//   bool isScripsSelect = true;
//   FocusNode focusNode = FocusNode();
//
//   @override
//   void initState() {
//     getPan();
//
//     setState(() {
//       approvedSecurityList.addAll(widget.approvedSecurityList);
//       originalEligibilityList.addAll(widget.approvedSecurityList);
//       whileSearchList.addAll(approvedSecurityList);
//       for(int i=0;i<approvedSecurityList.length;i++){
//         isApprovedItems.add(false);
//         _controllerQuantity.add(TextEditingController());
//       }
//     });
//     super.initState();
//   }
//
//   void getPan() async {
//     userKYC = await preferences.getUserKYC();
//   //   if(userKYC!){
//   //     checkEligibilityBloc.getEligibilityWithKYC(widget.lender, "", selectedSecurityList);
//   //   } else {
//   //     checkEligibilityBloc.getEligibility(widget.lender, "");
//   //   }
//   //
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: (){
//         FocusScope.of(context).unfocus();
//       },
//       child: Scaffold(
//         key: _scaffoldKey,
//         resizeToAvoidBottomInset: false,
//         backgroundColor: colorBg,
//         appBar: buildBar(context),
//         body: checkEligibilityView(),
//       ),
//     );
//   }
//
//   Widget appBarTitle = Text("", style: new TextStyle(color: appTheme));
//   Icon actionIcon = new Icon(
//     Icons.search,
//     color: appTheme,
//     size: 25,
//   );
//
//   PreferredSizeWidget buildBar(BuildContext context) {
//     final theme = Theme.of(context);
//     return new AppBar(
//       elevation: 0.0,
//       centerTitle: true,
//       title: appBarTitle,
//       backgroundColor: colorBg,
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
//               Utility.isNetworkConnection().then((isNetwork) {
//                 if (isNetwork) {
//                   setState(() {
//                     if (this.actionIcon.icon == Icons.search) {
//                       this.actionIcon = Icon(
//                         Icons.close,
//                         color: appTheme,
//                         size: 25,
//                       );
//                       this.appBarTitle = TextField(
//                         controller: _textController,
//                         focusNode: focusNode,
//                         style: TextStyle(
//                           color: appTheme,
//                         ),
//                         cursorColor: appTheme,
//                         decoration: InputDecoration(
//                             prefixIcon: new Icon(
//                               Icons.search,
//                               color: appTheme,
//                               size: 25,
//                             ),
//                             hintText: Strings.search,
//                             focusColor: appTheme,
//                             border: InputBorder.none,
//                             hintStyle: TextStyle(color: appTheme)),
//                         onChanged: (value) {
//                           setState(() {
//                             filterSearchResults();
//                           });
//                         },
//                       );
//                       focusNode.requestFocus();
//                     } else {
//                       _handleSearchEnd();
//                     }
//                   });
//                 } else {
//                   Utility.showToastMessage(Strings.no_internet_message);
//                 }
//               });
//             },
//           ),
//         ),
//       ],
//     );
//   }
//
//   void _handleSearchEnd() {
//     setState(() {
//       focusNode.unfocus();
//       this.actionIcon = Icon(Icons.search, color: appTheme, size: 25);
//       this.appBarTitle = Text(
//         "",
//         style: TextStyle(color: appTheme),
//       );
//       _textController.clear();
//       approvedSecurityList.clear();
//       approvedSecurityList.addAll(originalEligibilityList);
//       for(int i=0 ; i<selectedSecurityList.length ; i++){
//         approvedSecurityList.removeWhere((element) => element.securityName == selectedSecurityList[i].securityName);
//       }
//       printLog("approvedSecurityList ==> ${approvedSecurityList.length}");
//     });
//     // if(userKYC!){
//     //   checkEligibilityBloc.getEligibilityWithKYC(widget.lender, "", selectedSecurityList);
//     // } else {
//     //   checkEligibilityBloc.getEligibilityForSearch(widget.lender, "", selectedSecurityList);
//     // }
//   }
//
//   void filterSearchResults() {
//     Utility.isNetworkConnection().then((isNetwork) {
//       if (isNetwork) {
//         List<EligibilityData> dummyAllListData = <EligibilityData>[];
//         dummyAllListData.addAll(originalEligibilityList);
//         for(int i=0 ; i<selectedSecurityList.length ; i++){
//           dummyAllListData.removeWhere((element) => element.securityName == selectedSecurityList[i].securityName);
//         }
//
//         whileSearchList.clear();
//         whileSearchList.addAll(dummyAllListData);
//
//         List<EligibilityData> dummyListData = <EligibilityData>[];
//         dummyAllListData.forEach((item) {
//           if (item.securityName!.toLowerCase().contains(_textController.value.text.trim().toLowerCase())) {
//             dummyListData.add(item);
//           }
//         });
//         approvedSecurityList.clear();
//         approvedSecurityList.addAll(dummyListData);
//
//         // if(userKYC!) {
//         //   if (_textController.value.text.trim().isNotEmpty) {
//         //     List<EligibilityData> dummyListData = <EligibilityData>[];
//         //     approvedSecurityList.forEach((item) {
//         //       if (item.securityName!.toLowerCase().contains(_textController.value.text.trim().toLowerCase())) {
//         //         dummyListData.add(item);
//         //       }
//         //     });
//         //     checkEligibilityBloc.getEligibilityWithKYCForSearch(dummyListData, selectedSecurityList);
//         //   } else {
//         //   checkEligibilityBloc.getEligibilityWithKYC(widget.lender, '',selectedSecurityList).then((value) {
//         //     if (value.isSuccessFull!) {}
//         //   });
//         // }
//         // } else {
//         //   checkEligibilityBloc.getEligibilityForSearch(widget.lender, _textController.value.text.trim(), selectedSecurityList).then((value) {
//         //     if (value.isSuccessFull!) {}
//         //   });
//         // }
//       } else {
//         Utility.showToastMessage(Strings.no_internet_message);
//       }
//     });
//   }
//
//   Widget checkEligibilityView() {
//     return Stack(
//       children: [
//         Column(
//           children: [
//             Padding(
//               padding: EdgeInsets.only(left: 14.0, right: 14.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.start,
//                 children: <Widget>[
//                   Expanded(child: headingText(Strings.check_eligible_limit)),
//                 ],
//               ),
//             ),
//             checkEligibilityCart(),
//             Visibility(
//                 visible: isSelectedSecurityViewVisible,
//                 child: Expanded(child: listSelectedSecurities()),
//             ),
//             Expanded(child: listApprovedSecurity()),
//           ],
//         ),
//         widget.canPledge == 1
//             ? Positioned.fill(
//           child: Align(
//             alignment: Alignment.bottomCenter,
//             child: Padding(
//               padding: const EdgeInsets.only(top: 5, bottom: 8.0),
//               child: newLoan(),
//             ),
//           ),
//         )
//             : SizedBox(),
//       ],
//     );
//   }
//
//   Widget checkEligibilityCart() {
//     return Padding(
//       padding: const EdgeInsets.only(left: 14.0, right: 14.0, top: 6, bottom: 4.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: colorLightBlue,
//           border: Border.all(color: colorLightBlue, width: 3.0),
//           borderRadius:
//               BorderRadius.all(Radius.circular(15.0)),
//         ),
//         child: Column(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(top: 8.0),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   subHeadingText('₹${eligibleAmount > 0 ? numberToString(eligibleAmount.toStringAsFixed(2)) : "0.0"}'),
//                   Text(Strings.eligible_loan_amount, style: subHeading),
//                   // mediumHeadingText(Strings.eligible_loan_amount),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(top: 16.0, left: 4.0, right: 4.0,bottom: 8.0),
//               child: Row(
//                 children: <Widget>[
//                   Expanded(
//                     child: Column(
//                       children: [
//                         subHeadingText('₹${securitiesValue > 0 ? numberToString(securitiesValue.toStringAsFixed(2)) : "0.0"}'),
//                         Text(Strings.securities_value, style: subHeading),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: 5.0,right: 5.0),
//                     child: Container(
//                       height: 40.0,
//                       width: 1.0,
//                       color: Colors.grey,
//                     ),
//                   ),
//                   Expanded(
//                     child: Column(
//                       children: [
//                         subHeadingText('${selectedSecurityList.length}'),
//                         Text(Strings.scrips, style: subHeading),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget listSelectedSecurities() {
//     isSecurityItems.add(false);
//     isSecurityViewVisible.add(false);
//     _controllerQuantitySelectedSecurity.add(TextEditingController());
//     return Padding(
//       padding: EdgeInsets.only(top: 8.0),
//       child: Column(
//         children: [
//           Padding(
//             padding: const EdgeInsets.only(left: 14.0, right: 14.0),
//             child: Row(
//               children: [
//                 Text(Strings.selected_securities, style: boldTextStyle_18),
//               ],
//             ),
//           ),
//           Expanded(
//             child: ListView.builder(
//               shrinkWrap: true,
//               itemCount: selectedSecurityList.length,
//               itemBuilder: (context, index) {
//                 _controllerQuantitySelectedSecurity[index] = TextEditingController(
//                     text: selectedSecurityList[index].quantitySelected.toString());
//                 return Padding(
//                   padding: EdgeInsets.only(bottom: 10.0),
//                   child: Column(
//                     children: [
//                       Row(
//                         children: [
//                           Checkbox(
//                             activeColor: colorGreen,
//                             checkColor: colorWhite,
//                             value: selectedSecurityList[index].isSecurityCheck,
//                             onChanged: (val) {
//                               setState(() {
//                                   selectedSecurityList[index].isSecurityCheck = val!;
//                                   if (selectedSecurityList[index].isSecurityCheck!) {
//                                     isSecurityItems[index] = val;
//                                   } else {
//                                     setState(() {
//                                       isSecurityItems[index] = false;
//                                       var minusMarketAmount = selectedSecurityList[index].totalMarketValue;
//                                       securitiesValue = securitiesValue - minusMarketAmount!;
//                                       eligibleAmount = securitiesValue / 2;
//                                       // originalEligibilityList.insert(0, selectedSecurityList[index]);
//                                       // checkEligibilityBloc.addEligibilityList(approvedSecurityList, selectedSecurityList[index]);
//                                       selectedSecurityList.remove(selectedSecurityList[index]);
//                                       if (selectedSecurityList.length == 0) {
//                                         isSelectedSecurityViewVisible = false;
//                                       }
//                                       _handleSearchEnd();
//                                     });
//                                   }
//                                 },
//                               );
//                             },
//                           ),
//                           Expanded(
//                               child: Text(selectedSecurityList[index].securityName!, style: boldTextStyle_18)
//                           ),
//                           IconButton(
//                             icon: Icon(
//                               Icons.edit,
//                               color: colorDarkGray,
//                               size: 17,
//                             ),
//                             onPressed: () {
//                               Utility.isNetworkConnection().then((isNetwork) {
//                                 if (isNetwork) {
//                                   setState(() {
//                                     bool value = false;
//                                     if (isSecurityViewVisible[index]) {
//                                       value = false;
//                                     } else {
//                                       value = true;
//                                     }
//                                     isSecurityViewVisible.clear();
//                                     for(int i=0; i<selectedSecurityList.length; i++){
//                                       if(i == index){
//                                         isSecurityViewVisible.add(value);
//                                       } else {
//                                         isSecurityViewVisible.add(false);
//                                       }
//                                     }
//                                   });
//                                 } else {
//                                   Utility.showToastMessage(Strings.no_internet_message);
//                                 }
//                               });
//                             },
//                           ),
//                         ],
//                       ),
//                       Visibility(
//                         visible: isSecurityViewVisible[index],
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           mainAxisAlignment: MainAxisAlignment.start,
//                           children: [
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(Strings.security_category),
//                                 SizedBoxWidthWidget(30.0),
//                                 Text(selectedSecurityList[index].securityCategory!),
//                               ],
//                             ),
//                             SizedBoxHeightWidget(4.0),
//                             !isSecurityViewVisible[index]
//                                 ? Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(Strings.quantity_selected),
//                                       SizedBoxWidthWidget(30.0),
//                                       Text(selectedSecurityList[index].quantitySelected.toString()),
//                                     ],
//                                   )
//                                 : Row(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(Strings.quantity_selected),
//                                       SizedBoxWidthWidget(10.0),
//                                       updateSelectedSecurityQuantity(selectedSecurityList, index),
//                                     ],
//                                   ),
//                             SizedBoxHeightWidget(4.0),
//                             Row(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(Strings.total_market_value),
//                                 SizedBoxWidthWidget(20.0),
//                                 Text("${selectedSecurityList[index].totalMarketValue!.toStringAsFixed(2)}"),
//                               ],
//                             ),
//                             // Row(
//                             //   mainAxisAlignment: MainAxisAlignment.end,
//                             //   children: [
//                             //     okButton(
//                             //         selectedSecurityList, selectedSecurityList[index], index),
//                             //   ],
//                             // ),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//
//
//   Widget listApprovedSecurity() {
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.only(top: 10.0, bottom: 8, left: 14.0, right: 14.0),
//           child: Row(
//             children: [
//               Expanded(child: Text(Strings.approved_securities_list, style: boldTextStyle_18))
//             ],
//           ),
//         ),
//         Expanded(child: approvedSecurityList.length == 0 ? _buildNoDataWidget() : eligibilityList()
//         // getEligibilityList(),
//         ),
//       ],
//     );
//   }
//
//   // Widget getEligibilityList() {
//   //   return StreamBuilder(
//   //     stream: checkEligibilityBloc.eligibilityList,
//   //     builder: (context, AsyncSnapshot<List<EligibilityData>> snapshot) {
//   //       if (snapshot.hasData) {
//   //         if (snapshot.data == null || snapshot.data!.length == 0) {
//   //           return _buildNoDataWidget();
//   //         } else {
//   //           List<EligibilityData> actualEligibilityList = <EligibilityData>[];
//   //           for(int i=0; i<snapshot.data!.length; i++){
//   //             if(snapshot.data![i].isEligible!){
//   //               actualEligibilityList.add(snapshot.data![i]);
//   //             }
//   //           }
//   //           approvedSecurityList = actualEligibilityList;
//   //           return eligibilityList();
//   //         }
//   //       } else if (snapshot.hasError) {
//   //         return _buildErrorWidget(snapshot.error.toString());
//   //       } else {
//   //         return _buildLoadingWidget();
//   //       }
//   //     },
//   //   );
//   // }
//
//   Widget eligibilityList() {
//     return ListView.builder(
//       shrinkWrap: true,
//       itemCount: approvedSecurityList.length,
//       itemBuilder: (context, index) {
//         int actualIndex = whileSearchList.indexWhere((element) => element.securityName == approvedSecurityList[index].securityName).abs();
//
//         // originalEligibilityList = approvedSecurityList;
//         return Container(
//           margin: EdgeInsets.symmetric(vertical: 5.0),
//           decoration: BoxDecoration(
//             color: colorWhite,
//             border: Border.all(color: Colors.white, width: 2.0),
//             borderRadius: BorderRadius.all(Radius.circular(8.0)), // set rounded corner radius
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
//             child: Column(
//               children: [
//                 CheckboxListTile(
//                   activeColor: colorGreen,
//                   checkColor: colorWhite,
//                   contentPadding: EdgeInsets.only(left: 2),
//                   controlAffinity: ListTileControlAffinity.leading,
//                   title: Text(approvedSecurityList[index].securityName!, style: boldTextStyle_18),
//                   value: isApprovedItems[actualIndex],
//                   onChanged: (bool? val) {
//                     setState(() {
//                       int length = isApprovedItems.length;
//                       isApprovedItems.clear();
//                       for(int i=0;i<length;i++){
//                         isApprovedItems.add(false);
//                       }
//                       isApprovedItems[actualIndex] = val!;
//                     },
//                     );
//                   },
//                 ),
//                 Visibility(
//                   visible: isApprovedItems[actualIndex],
//                   child: Padding(
//                     padding: EdgeInsets.only(left: 58),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       mainAxisAlignment: MainAxisAlignment.start,
//                       children: [
//                         Row(
//                           children: [
//                             Text(Strings.security_category),
//                             SizedBoxWidthWidget(30.0),
//                             Text(approvedSecurityList[index].securityCategory!),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Text(Strings.quantity_selected),
//                             SizedBoxWidthWidget(10.0),
//                             selectQuantity(whileSearchList, actualIndex),
//                           ],
//                         ),
//                         Row(
//                           children: [
//                             Text(Strings.cmp),
//                             SizedBoxWidthWidget(105.0),
//                             Text(approvedSecurityList[index].price!.toStringAsFixed(2)),
//                           ],
//                         ),
//                         SizedBoxHeightWidget(4.0),
//                         Row(
//                           children: [
//                             Text(Strings.total_market_value),
//                             SizedBoxWidthWidget(20.0),
//                             Text("${approvedSecurityList[index].totalMarketValue!.toStringAsFixed(2)}"),
//                           ],
//                         ),
//                         SizedBoxHeightWidget(2.0),
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.end,
//                           children: [
//                             doneButton(whileSearchList[actualIndex], actualIndex),
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//
//   Widget selectQuantity(List<EligibilityData> eligibilityList, int index) {
//     return Row(
//       children: <Widget>[
//         IconButton(
//           icon: Container(
//             padding: EdgeInsets.all(2),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 border: Border.all(width: 1, color: Colors.grey)),
//             child: Icon(
//               Icons.remove,
//               color: Colors.grey.shade600,
//               size: 10,
//             ),
//           ),
//           onPressed: () async {
//             Utility.isNetworkConnection().then((isNetwork) {
//               if (isNetwork) {
//                 FocusScope.of(context).requestFocus(new FocusNode());
//                 if (_controllerQuantity[index].value.text.toString().isEmpty) {
//                   Utility.showToastMessage(Strings.message_quantity);
//                 } else {
//                   if (int.parse(_controllerQuantity[index].value.text) <= 1) {
//                     Utility.showToastMessage(Strings.message_quantity_not_less_1);
//                   } else {
//                     int quantity = int.parse(_controllerQuantity[index].value.text) - 1;
//                     setState(() {
//                       _controllerQuantity[index].text = quantity.toString();
//                       _controllerQuantitySelectedSecurity[index].text = quantity.toString();
//                       eligibilityList[index].totalMarketValue = quantity * eligibilityList[index].price!;
//                     });
//                   }
//                 }
//               } else {
//                 Utility.showToastMessage(Strings.no_internet_message);
//               }
//             });
//           },
//         ),
//         Container(
//           width: 50,
//           height: 15,
//           child: TextField(
//             textAlign: TextAlign.center,
//             decoration: InputDecoration(counterText: ""),
//             maxLength: 4,
//             keyboardType: TextInputType.numberWithOptions(decimal: true),
//             inputFormatters: [
//               FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//             ],
//             controller: _controllerQuantity[index],
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//             ),
//             onChanged: (value) {
//               if(value.isEmpty){
//                 eligibilityList[index].totalMarketValue = 0 * eligibilityList[index].price!;
//               }
//               if(_controllerQuantity[index].text != "0"){
//                 if (int.parse(_controllerQuantity[index].text) < 1) {
//                   Utility.showToastMessage(Strings.message_quantity_not_less_1);
//                   FocusScope.of(context).requestFocus(new FocusNode());
//                 } else {
//                   setState(() {
//                     // _controllerQuantity[index].text = value;
//                     // _controllerQuantitySelectedSecurity[index].text = value;
//                     eligibilityList[index].totalMarketValue = int.parse(_controllerQuantity[index].text) * eligibilityList[index].price!;
//                   });
//                 }
//               } else {
//                 setState((){
//                   _controllerQuantity[index].text = "1";
//                   _controllerQuantitySelectedSecurity[index].text = "1";
//                   eligibilityList[index].totalMarketValue = 1 * eligibilityList[index].price!;
//                 });
//                 FocusScope.of(context).requestFocus(new FocusNode());
//               }
//             },
//           ),
//         ),
//         IconButton(
//           icon: Container(
//             padding: EdgeInsets.all(2),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 border: Border.all(width: 1, color: Colors.grey)),
//             child: Icon(
//               Icons.add,
//               color: Colors.grey.shade600,
//               size: 10,
//             ),
//           ),
//           onPressed: () async {
//             Utility.isNetworkConnection().then((isNetwork) {
//               if (isNetwork) {
//                 FocusScope.of(context).requestFocus(new FocusNode());
//                 int quantity;
//                 if (_controllerQuantity[index].value.text.toString().isEmpty) {
//                   int addQuantity = 1;
//                   quantity = addQuantity++;
//                   setState(() {
//                     _controllerQuantity[index].text = quantity.toString();
//                     // _controllerQuantitySelectedSecurity[index].text = quantity.toString();
//                     eligibilityList[index].totalMarketValue = quantity * eligibilityList[index].price!;
//                   });
//                 } else {
//                   quantity = int.parse(_controllerQuantity[index].value.text) + 1;
//                   setState(() {
//                     _controllerQuantity[index].text = quantity.toString();
//                     // _controllerQuantitySelectedSecurity[index].text = quantity.toString();
//                     eligibilityList[index].totalMarketValue = quantity * eligibilityList[index].price!;
//                   });
//                 }
//               } else {
//                 Utility.showToastMessage(Strings.no_internet_message);
//               }
//             });
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget updateSelectedSecurityQuantity(List<EligibilityData> eligibilityList, int index) {
//     return Row(
//       children: <Widget>[
//         IconButton(
//           icon: Container(
//             padding: EdgeInsets.all(2),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 border: Border.all(width: 1, color: Colors.grey),
//             ),
//             child: Icon(
//               Icons.remove,
//               color: Colors.grey.shade600,
//               size: 10,
//             ),
//           ),
//           onPressed: () async {
//             Utility.isNetworkConnection().then((isNetwork) {
//               if (isNetwork) {
//                 if (eligibilityList[index].quantitySelected.toString().isEmpty) {
//                   Utility.showToastMessage(Strings.message_quantity);
//                 } else {
//                   if (int.parse(eligibilityList[index].quantitySelected.toString()) <= 1) {
//                     Utility.showToastMessage(Strings.message_quantity_not_less_1);
//                   } else {
//                     int quantity = int.parse(selectedSecurityList[index].quantitySelected.toString()) - 1;
//                     setState(() {
//                       _controllerQuantitySelectedSecurity[index].text = quantity.toString();
//                       _controllerQuantity[index].text = quantity.toString();
//                       selectedSecurityList[index].quantitySelected = quantity;
//                       selectedSecurityList[index].totalMarketValue = quantity * selectedSecurityList[index].price!;
//
//                       securitiesValue = 0;
//                       for (var v in selectedSecurityList) {
//                         securitiesValue = v.totalMarketValue! + securitiesValue;
//                       }
//                       eligibleAmount = securitiesValue / 2;
//                     });
//                   }
//                 }
//               } else {
//                 Utility.showToastMessage(Strings.no_internet_message);
//               }
//             });
//           },
//         ),
//         Container(
//           width: 50,
//           height: 15,
//           child: TextField(
//             textAlign: TextAlign.center,
//             decoration: InputDecoration(counterText: ""),
//             maxLength: 4,
//             keyboardType: TextInputType.numberWithOptions(decimal: true),
//             inputFormatters: [
//               FilteringTextInputFormatter.allow(RegExp('[0-9]')),
//             ],
//             readOnly: true,
//             controller: _controllerQuantitySelectedSecurity[index],
//             style: TextStyle(
//               fontWeight: FontWeight.w600,
//             ),
//             // onChanged: (value) {
//             //   int quantity = int.parse(value);
//             //   printLog("quantity$quantity");
//             //   setState(() {
//             //     _controllerQuantitySelectedSecurity[index].text = quantity.toString();
//             //   });
//             // },
//           ),
//         ),
//         IconButton(
//           icon: Container(
//             padding: EdgeInsets.all(2),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(100),
//                 border: Border.all(width: 1, color: Colors.grey),
//             ),
//             child: Icon(
//               Icons.add,
//               color: Colors.grey.shade600,
//               size: 10,
//             ),
//           ),
//           onPressed: () async {
//             Utility.isNetworkConnection().then((isNetwork) {
//               if (isNetwork) {
//                 if (eligibilityList[index].quantitySelected.toString().isEmpty) {
//                   Utility.showToastMessage(Strings.message_quantity);
//                 } else {
//                   int quantity = int.parse(selectedSecurityList[index].quantitySelected.toString()) + 1;
//                   setState(() {
//                     _controllerQuantitySelectedSecurity[index].text = quantity.toString();
//                     _controllerQuantity[index].text = quantity.toString();
//                     selectedSecurityList[index].quantitySelected = quantity;
//                     selectedSecurityList[index].totalMarketValue = quantity * selectedSecurityList[index].price!;
//
//                     securitiesValue = 0;
//                     for (var v in selectedSecurityList) {
//                       securitiesValue = v.totalMarketValue! + securitiesValue;
//                     }
//                     eligibleAmount = securitiesValue / 2;
//                   });
//                 }
//               } else {
//                 Utility.showToastMessage(Strings.no_internet_message);
//               }
//             });
//           },
//         ),
//       ],
//     );
//   }
//
//   Widget doneButton(EligibilityData eligibilityData, int index) {
//     return Container(
//       margin: EdgeInsets.only(right: 20),
//       height: 30,
//       width: 80,
//       child: Material(
//         color: appTheme,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
//         elevation: 1.0,
//         child: MaterialButton(
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//           minWidth: MediaQuery.of(context).size.width,
//           onPressed: () async {
//             Utility.isNetworkConnection().then((isNetwork) {
//               if (isNetwork) {
//                 if (_controllerQuantity[index].value.text.toString().isEmpty) {
//                   Utility.showToastMessage(Strings.message_quantity);
//                 } else if(_controllerQuantity[index].value.text == '0'){
//                   Utility.showToastMessage(Strings.message_quantity_not_less_1);
//                 } else {
//                   setState(() {
//                     isSelectedSecurityViewVisible = true;
//                   });
//                   eligibilityData.quantitySelected = int.parse(_controllerQuantity[index].value.text);
//                   eligibilityData.isSecurityCheck = true;
//                   if (!selectedSecurityList.contains(eligibilityData)) {
//                     selectedSecurityList.add(eligibilityData);
//                   } else {
//                     Utility.showToastMessage(Strings.already_added);
//                     int i = selectedSecurityList.indexOf(eligibilityData);
//                     isSecurityItems[i] = false;
//                     var minusMarketAmount = int.parse(_controllerQuantitySelectedSecurity[i].text) * selectedSecurityList[i].price!;
//                     securitiesValue = securitiesValue - minusMarketAmount;
//                     eligibleAmount = securitiesValue / 2;
//                     selectedSecurityList.removeAt(i);
//                     selectedSecurityList.add(eligibilityData);
//                     // isApprovedItems[index] = false;
//                   }
//                   var securityCalculation = eligibilityData.totalMarketValue;
//                   setState(() {
//                     securitiesValue = securitiesValue + securityCalculation!;
//                     eligibleAmount = securitiesValue / 2;
//                     isApprovedItems[index] = false;
//                     // approvedSecurityList[index].isApprovedCheck = false;
//                   });
//                   checkEligibilityBloc.removeEligibilityList(approvedSecurityList, eligibilityData);
//                   _controllerQuantity[index].text = "";
//                 }
//               } else {
//                 Utility.showToastMessage(Strings.no_internet_message);
//               }
//             });
//           },
//           child: Text(
//             Strings.done,
//             style: TextStyle(color: colorWhite),
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Widget okButton(List<EligibilityData> eligibilityList, EligibilityData eligibilityData, int index) {
//   //   return Container(
//   //     margin: EdgeInsets.only(right: 20),
//   //     height: 30,
//   //     width: 80,
//   //     child: Material(
//   //       color: appTheme,
//   //       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
//   //       elevation: 1.0,
//   //       child: MaterialButton(
//   //         minWidth: MediaQuery.of(context).size.width,
//   //         onPressed: () async {
//   //           Utility.isNetworkConnection().then((isNetwork) {
//   //             if (isNetwork) {
//   //               if (_controllerQuantitySelectedSecurity[index].value.text.toString().isEmpty) {
//   //                 Utility.showToastMessage("Please enter quantity first");
//   //               } else {
//   //                 setState(() {
//   //                   securitiesValue = 0;
//   //                   for (var v in selectedSecurityList) {
//   //                     securitiesValue = v.totalMarketValue + securitiesValue;
//   //                   }
//   //                   eligibleAmount = securitiesValue / 2;
//   //                 });
//   //               }
//   //             } else {
//   //               Utility.showToastMessage(Strings.no_internet_message);
//   //             }
//   //           });
//   //         },
//   //         child: Text(
//   //           "Done",
//   //           style: TextStyle(color: colorWhite),
//   //         ),
//   //       ),
//   //     ),
//   //   );
//   // }
//
//   Widget newLoan() {
//     return Container(
//       height: 45,
//       width: 140,
//       child: Material(
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         elevation: 1.0,
//         color: isSelectedSecurityViewVisible == true ? appTheme : colorLightGray,
//         child: AbsorbPointer(
//           absorbing: !isSelectedSecurityViewVisible,
//           child: MaterialButton(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//             minWidth: MediaQuery.of(context).size.width,
//             onPressed: () async {
//               Utility.isNetworkConnection().then((isNetwork) {
//                 if (isNetwork) {
//                   if (!userKYC!) {
//                     Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                             builder: (BuildContext context) =>
//                                 CompleteKYCScreen()));
//                   } else {
//                     if(widget.isEmailVerified) {
//                       Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (BuildContext context) =>
//                                   ApprovedSharesScreen()));
//                     } else {
//                       commonDialog(context, Strings.email_verification_popup, 0);
//                     }
//                   }
//                 } else {
//                   Utility.showToastMessage(Strings.no_internet_message);
//                 }
//               });
//             },
//             child: Text(Strings.get_loan, style: TextStyle(color: colorWhite)),
//           ),
//         ),
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
// }
