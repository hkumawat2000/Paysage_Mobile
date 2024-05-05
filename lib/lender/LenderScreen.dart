// import 'package:choice/Eligibility/CheckEligibilityBloc.dart';
// import 'package:choice/Eligibility/CheckEligibilityScreen.dart';
// import 'package:choice/lender/LenderBloc.dart';
// import 'package:choice/network/responsebean/ApprovedListResponseBean.dart';
// import 'package:choice/network/responsebean/CheckEligibilityResponseBean.dart';
// import 'package:choice/network/responsebean/LenderResponseBean.dart';
// import 'package:choice/shares/LoanApplicationBloc.dart';
// import 'package:choice/shares/TwoDementaccountDialog.dart';
// import 'package:choice/util/Colors.dart';
// import 'package:choice/util/Preferences.dart';
// import 'package:choice/util/Style.dart';
// import 'package:choice/util/Utility.dart';
// import 'package:choice/util/strings.dart';
// import 'package:choice/widgets/ErrorMessageWidget.dart';
// import 'package:choice/widgets/LoadingDialogWidget.dart';
// import 'package:choice/widgets/LoadingWidget.dart';
// import 'package:choice/widgets/NoDataWidget.dart';
// import 'package:choice/widgets/WidgetCommon.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/scheduler.dart';
//
// class LenderScreen extends StatefulWidget {
//
//   bool isEmailVerified;
//   int canPledge;
//
//   LenderScreen(this.isEmailVerified, this.canPledge);
//
//   @override
//   LenderScreenState createState() => LenderScreenState();
// }
//
// class LenderScreenState extends State<LenderScreen> with TickerProviderStateMixin {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   AnimationController? controller;
//   final lenderBloc = LenderBloc();
//   Preferences preferences = Preferences();
//   final loanApplicationBloc = LoanApplicationBloc();
//   final checkEligibilityBloc = CheckEligibilityBloc();
//   LenderData? lenderData;
//   String? lender;
//
//   @override
//   void initState() {
//     lenderBloc.getLenders();
//     controller = AnimationController(
//       vsync: this,
//       duration: Duration(seconds: 30),
//     );
//     super.initState();
//   }
//
//   @override
//   void dispose() {
//     controller!.dispose();
//     super.dispose();
//   }
//
//   void changedDropDownLender(LenderData? lenderData) {
//     setState(() {
//       this.lenderData = lenderData;
//       lender = lenderData!.name;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.transparent,
//       bottomNavigationBar: AnimatedPadding(
//         duration: Duration(milliseconds: 150),
//         curve: Curves.easeOut,
//         padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//         child: Container(
//           height: 200,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: colorWhite,
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(30.0),
//               topRight: Radius.circular(30.0),
//             ),
//           ),
//           child: Padding(
//             padding: EdgeInsets.only(top: 20.0),
//             child: Column(
//               children: [
//                 Text(Strings.lender_heading,
//                     style: mediumTextStyle_16),
//                 SizedBoxHeightWidget(20.0),
//                 selectLenderDropDown(),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     checkEligibility(),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget selectLenderDropDown() {
//     return StreamBuilder(
//       stream: lenderBloc.dropDownLenderList,
//       builder: (context, AsyncSnapshot<List<LenderData>> snapshot) {
//         if (snapshot.hasData) {
//           if (snapshot.data == null || snapshot.data!.length == 0) {
//             return NoDataWidget();
//           } else {
//             return Padding(
//               padding: EdgeInsets.fromLTRB(20, 5, 20, 10),
//               child: Container(
//                 padding: EdgeInsets.all(15),
//                 height: 60,
//                 width: double.infinity,
//                 decoration: BoxDecoration(
//                   border: Border.all(
//                     color: Colors.grey,
//                   ),
//                   borderRadius: BorderRadius.circular(5.0),
//                 ),
//                 child: DropdownButtonHideUnderline(
//                   child: DropdownButton<LenderData>(
//                     // isExpanded: true,
//                     hint: Text('Lenders'),
//                     style: mediumTextStyle_18,
//                     focusColor: appTheme,
//                     items: snapshot.data
//                         ?.map(
//                           (menu) => DropdownMenuItem<LenderData>(
//                         child: Text(menu.name!),
//                         value: menu,
//                       ),
//                     )
//                         .toList() ??
//                         [],
//                     onChanged: changedDropDownLender,
//                     value: lenderData,
//                   ),
//                 ),
//               ),
//             );
//           }
//         } else if (snapshot.hasError) {
//           if (snapshot.error == "403") {
//             SchedulerBinding.instance.addPostFrameCallback((_) {
//               Navigator.pop(context);
//               commonDialog(context, Strings.session_timeout, 4);
//             });
//             return ErrorMessageWidget(error: Strings.session_timeout);
//           }
//           return ErrorMessageWidget(error: snapshot.error.toString());
//         } else {
//           return SizedBox(
//             height: 50,
//             child: Center(
//               child: Text(Strings.lender_list,
//                   style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w100, color: appTheme)),
//             ),
//           );
//         }
//       },
//     );
//   }
//
//   Widget checkEligibility() {
//     return Padding(
//       padding: EdgeInsets.only(top: 15, right: 10.0),
//       child: Container(
//         height: 45,
//         width: 140,
//         child: Material(
//           color: appTheme,
//           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
//           elevation: 1.0,
//           child: MaterialButton(
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//             minWidth: MediaQuery.of(context).size.width,
//             onPressed: () async {
//               String? mobile = await preferences.getMobile();
//               bool? userKYC = await preferences.getUserKYC();
//               Utility.isNetworkConnection().then((isNetwork) {
//                 if (isNetwork) {
//                   if (lender == null || lender!.isEmpty) {
//                     Utility.showToastMessage(Strings.select_lender);
//                   } else {
//                     // Firebase Event
//                     Map<String, dynamic> parameter = new Map<String, dynamic>();
//                     parameter[Strings.mobile_no] = mobile;
//                     parameter[Strings.lender] = lender;
//                     parameter[Strings.date_time] = getCurrentDateAndTime();
//                     firebaseEvent(Strings.check_eligible_check, parameter);
//                     if(userKYC){
//                       getDetailsWithKYC();
//                     } else {
//                       getDetailsWithoutKYC();
//                     }
//                   }
//                 } else {
//                   Utility.showToastMessage(Strings.no_internet_message);
//                 }
//               });
//             },
//             child: Text(
//               Strings.check_eligibility,
//               style: TextStyle(color: colorWhite),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   getDetailsWithoutKYC() async {
//     LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//     checkEligibilityBloc.getEligibility(lender!, "").then((value) {
//       Navigator.pop(context);
//       Navigator.pop(context);
//       if(value.isSuccessFull!){
//         List<EligibilityData> approvedSecurityList;
//         approvedSecurityList = value.eligibilityData!;
//         approvedSecurityList.removeWhere((element) => element.isEligible == false);
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (BuildContext context) =>
//                     CheckEligibilityScreen(
//                         lender, widget.isEmailVerified,
//                         widget.canPledge, approvedSecurityList)));
//       } else if (value.errorCode == 403) {
//         commonDialog(context, Strings.session_timeout, 4);
//       } else if (value.errorCode == 500) {
//         commonDialog(context, Strings.not_fetch, 0);
//       } else {
//         Utility.showToastMessage(value.errorMessage!);
//       }
//     });
//   }
//
//   void getDetailsWithKYC() async {
//     LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//     checkEligibilityBloc.getEligibilityWithKYC("", "", []).then((value){
//       Navigator.pop(context);
//       if(value.isSuccessFull!){
//         List<EligibilityData> securities = [];
//         for (var i = 0; i < value.eligibilityData!.length; i++) {
//           if (value.eligibilityData![i].isEligible == true && value.eligibilityData![i].quantity != 0.0
//               && value.eligibilityData![i].price != 0.0) {
//             securities.add(value.eligibilityData![i]);
//           }
//         }
//         List<String?> stockAt = List.generate(securities.length, (index) => securities[index].stock_at).toSet().toList();
//         printLog("Demat ac list ==> ${stockAt.length}");
//         if (securities.length != 0) {
//           if(stockAt.length == 1){
//             Navigator.push(context, MaterialPageRoute(
//                 builder: (BuildContext context) => CheckEligibilityScreen(
//                     lender, widget.isEmailVerified,
//                     widget.canPledge, securities)));
//           } else {
//             showModalBottomSheet(
//               backgroundColor: Colors.transparent,
//               context: context,
//               isScrollControlled: true,
//               builder: (BuildContext bc) {
//                 return TwoDematAccountDialog(lender,
//                     widget.isEmailVerified, widget.canPledge,
//                     [], securities, stockAt, Strings.check_eligibility);
//               },
//             );
//           }
//         } else {
//           NonEligibleSecuritiesDialog();
//         }
//       } else if (value.errorCode == 403) {
//         commonDialog(context, Strings.session_timeout, 4);
//       }  else if (value.errorCode == 500) {
//         commonDialog(context, Strings.not_fetch, 0);
//       } else {
//         Utility.showToastMessage(value.errorMessage!);
//       }
//     });
//   }
//
//   Future<void> NonEligibleSecuritiesDialog() {
//     return showDialog<void>(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           backgroundColor: Colors.white,
//           shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.all(Radius.circular(15.0))),
//           content: Container(
//             height: 150,
//             child: Stack(
//               children: [
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: <Widget>[
//                     Text(Strings.nonEligibleSecurities,
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     SizedBoxHeightWidget(8.0),
//                     Text("Do you wish to buy them?",
//                         style: TextStyle(fontWeight: FontWeight.bold)),
//                     SizedBoxHeightWidget(15.0),
//                   ],
//                 ),
//                 Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       Container(
//                         height: 35,
//                         width: 100,
//                         child: Material(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(35)),
//                           elevation: 1.0,
//                           color: appTheme,
//                           child: MaterialButton(
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                             minWidth: MediaQuery.of(context).size.width,
//                             onPressed:  () async {
//                               Utility.isNetworkConnection().then((isNetwork) async {
//                                 if (isNetwork) {
//                                   Utility.launchURL("https://apps.apple.com/in/app/online-trading-app-jiffy/id1327801261");
//                                   // Utility.openJiffy(context);
//                                 } else {
//                                   Utility.showToastMessage(Strings.no_internet_message);
//                                 }
//                               });
//                             },
//                             child: Text(
//                               Strings.yes,
//                               style: buttonTextWhite,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Container(
//                         height: 35,
//                         width: 100,
//                         child: Material(
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(35),
//                               side: BorderSide(color: red)),
//                           elevation: 1.0,
//                           color: colorbg,
//                           child: MaterialButton(
//                             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                             minWidth: MediaQuery.of(context).size.width,
//                             onPressed:  () async {
//                               Navigator.pop(context);
//                             },
//                             child: Text(
//                               Strings.no,
//                               style: buttonTextRed,
//                             ),
//                           ),
//                         ),
//                       ),
//
//                     ],
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
