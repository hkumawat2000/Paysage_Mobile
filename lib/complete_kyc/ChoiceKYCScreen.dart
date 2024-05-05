// import 'package:choice/completekyc/CompleteKYCBloc.dart';
// import 'package:choice/completekyc/EditChoiceInformationScreen.dart';
// import 'package:choice/network/requestbean/UserKYCRequest.dart';
// import 'package:choice/network/responsebean/UserKYCResponse.dart';
// import 'package:choice/newdashboard/NewDashboardScreen.dart';
// import 'package:choice/util/Colors.dart';
// import 'package:choice/util/Preferences.dart';
// import 'package:choice/util/Style.dart';
// import 'package:choice/util/Utility.dart';
// import 'package:choice/util/strings.dart';
// import 'package:choice/widgets/LoadingDialogWidget.dart';
// import 'package:choice/widgets/WidgetCommon.dart';
// import 'package:firebase_analytics/firebase_analytics.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ChoiceKYCSreen extends StatefulWidget {
//   String panNo, name, bankName, accountNo, ifscCode;
//   UserKyc kycUser;
//
//   @override
//   ChoiceKYCSreenState createState() => ChoiceKYCSreenState();
//
//   ChoiceKYCSreen(this.panNo, this.name, this.bankName, this.accountNo, this.ifscCode, this.kycUser);
// }
//
// class ChoiceKYCSreenState extends State<ChoiceKYCSreen> {
//   ScrollController _scrollController = new ScrollController();
//   Preferences? preferences;
//   bool checkBoxValue = true;
//
//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     preferences = Preferences();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(backgroundColor: colorbg, body: userDetails());
//   }
//
//   Widget userDetails() {
//     return SingleChildScrollView(
//       child: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               height: 50,
//             ),
//             headingText(Strings.confirm_your_details),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               padding: const EdgeInsets.only(left: 15,right: 15),
//               decoration: new BoxDecoration(
//                 color: colorWhite,
//                 borderRadius: new BorderRadius.all(Radius.circular(20.0)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 10,
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(Strings.personal_info, style: semiBoldTextStyle_18),
//                       Container(
//                         height: 30,
//                         width: 60,
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.edit,
//                             size: 15,
//                           ),
//                           onPressed: () async {
//                             String? mobile = await preferences!.getMobile();
//                             // Firebase Event
//                             Map<String, dynamic> parameters = new Map<String, dynamic>();
//                             parameters[Strings.pan] = widget.panNo;
//                             parameters[Strings.dob_prm] = widget.kycUser.dateOfBirth;
//                             parameters[Strings.mobile_no] = mobile;
//                             parameters[Strings.name] = widget.name;
//                             parameters[Strings.date_time] = getCurrentDateAndTime();
//                             firebaseEvent(Strings.edit_kyc, parameters);
//                             Navigator.pop(context);
//                             // commonDialog(context, Strings.edit_kyc_message, 3);
//                           },
//                         ),
//                       )
//                     ],
//                   ),
//                   SizedBox(height: 8),
//                   Text(Strings.name, style: mediumTextStyle_14_gray),
//                   SizedBox(height: 2),
//                   Text(widget.name, style: regularTextStyle_18_gray_dark),
//                   SizedBox(height: 10),
//                   Text(Strings.pan_no, style: mediumTextStyle_14_gray),
//                   SizedBox(height: 2),
//                   Text(encryptAcNo(widget.panNo), style: regularTextStyle_18_gray_dark),
//                   SizedBox(height: 10),
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               padding: const EdgeInsets.only(left: 15, right: 15),
//               decoration: new BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: new BorderRadius.all(Radius.circular(15.0)),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: <Widget>[
//                   SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: <Widget>[
//                       Text(
//                         Strings.bank_info,
//                         style: TextStyle(
//                             color: appTheme, fontSize: 18, fontWeight: FontWeight.w800),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: 10),
//                   Text(Strings.account_number, style: mediumTextStyle_14_gray),
//                   SizedBox(height: 2),
//                   Text(encryptAcNo(widget.accountNo), style: regularTextStyle_18_gray_dark),
//                   SizedBox(height: 10),
//                   Text(Strings.bank_name, style: mediumTextStyle_14_gray),
//                   SizedBox(height: 2),
//                   Text(widget.bankName, style: regularTextStyle_18_gray_dark),
//                   SizedBox(height: 10),
//                   Text(Strings.ifsc_code, style: mediumTextStyle_14_gray),
//                   SizedBox(height: 2),
//                   Text(widget.ifscCode, style: regularTextStyle_18_gray_dark),
//                   SizedBox(height: 10),
//                 ],
//               ),
//             ),
//             Container(height: 50),
// //            SizedBox(height: 50),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 IconButton(
//                   icon: ArrowBackwardNavigation(),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//                 Container(
//                   height: 45,
//                   width: 100,
//                   child: Material(
//                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                     elevation: 1.0,
//                     color: appTheme,
//                     child: MaterialButton(
//                       minWidth: MediaQuery.of(context).size.width,
//                       onPressed: () async {
//                         Utility.isNetworkConnection().then((isNetwork) {
//                           if (isNetwork) {
//                             confirmDetailsDialog(context, Strings.kyc_confirm_msg, widget.kycUser);
//                           } else {
//                             Utility.showToastMessage(Strings.no_internet_message);
//                           }
//                         });
//                       },
//                       child: ArrowForwardNavigation(),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//             SizedBox(height: 20),
//           ],
//         ),
//       ),
//     );
//   }
//
//   confirmDetailsDialog(BuildContext context, message, UserKyc kycUser) {
//     return showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return ConfirmationDialog(kycUser);
//         });
//   }
//
//   // sendDetailsDialogBox(BuildContext context) {
//   //   return showDialog(
//   //       context: context,
//   //       builder: (BuildContext context) {
//   //         return AlertDialog(
//   //           backgroundColor: Colors.white,
//   //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
//   //           content: Container(
//   //             child: Column(
//   //               mainAxisAlignment: MainAxisAlignment.center,
//   //               crossAxisAlignment: CrossAxisAlignment.center,
//   //               mainAxisSize: MainAxisSize.min,
//   //               children: <Widget>[
//   //                 Row(
//   //                   crossAxisAlignment: CrossAxisAlignment.end,
//   //                   mainAxisAlignment: MainAxisAlignment.end,
//   //                   children: <Widget>[
//   //                     GestureDetector(
//   //                       child: Icon(
//   //                         Icons.cancel,
//   //                         color: Colors.grey,
//   //                         size: 20,
//   //                       ),
//   //                       onTap: () {
//   //                         Navigator.pop(context);
//   //                       },
//   //                     ),
//   //                   ],
//   //                 ),
//   //                 Center(
//   //                   child: Padding(
//   //                     padding: const EdgeInsets.all(10.0),
//   //                     child: Column(
//   //                       children: <Widget>[
//   //                         Text("Your updated details will be send to our support system",
//   //                             style: TextStyle(fontSize: 16.0, color: Colors.grey)),
//   //                       ],
//   //                     ),
//   //                   ), //
//   //                 ),
//   //                 Container(
//   //                   height: 40,
//   //                   width: 100,
//   //                   child: Material(
//   //                     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//   //                     elevation: 1.0,
//   //                     color: appTheme,
//   //                     child: MaterialButton(
//   //                         minWidth: MediaQuery.of(context).size.width,
//   //                         onPressed: () async {
//   //                           Navigator.pushReplacement(context,
//   //                               MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
//   //                         },
//   //                         child: Text(
//   //                           "Confirm",
//   //                           style: TextStyle(color: Colors.white),
//   //                         )),
//   //                   ),
//   //                 )
//   //               ],
//   //             ),
//   //           ),
//   //         );
//   //       });
//   // }
// }
//
// class ConfirmationDialog extends StatefulWidget {
//   UserKyc kycUser;
//
//   ConfirmationDialog(this.kycUser);
//
//   @override
//   _ConfirmationDialogState createState() => _ConfirmationDialogState();
// }
//
// class _ConfirmationDialogState extends State<ConfirmationDialog> {
//   bool checkBoxValue = true;
//   final completeKYCBloc = CompleteKYCBloc();
//
//   @override
//   Widget build(BuildContext context) {
//     return AlertDialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
//       content: Container(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.end,
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: <Widget>[
//                 GestureDetector(
//                   child: Icon(
//                     Icons.cancel,
//                     color: colorLightGray,
//                     size: 20,
//                   ),
//                   onTap: () {
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//             Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   Text("Great!", style: boldTextStyle_18),
//                   Text(Strings.info_success, style: mediumTextStyle_16_dark, textAlign: TextAlign.center),
//                   Text("verified.", style: mediumTextStyle_16_dark),
//                 ],
//               ),
//             ),
// //                  Row(
// //                    children: <Widget>[
// //                      Expanded(
// //                        child: Center(
// //                          child: new Text(Strings.verified_info, style:mediumTextStyle_16_dark),
// //                        ),
// //                      ),
// //                    ],
// //                  ),
//             SizedBox(
//               height: 10,
//             ),
//             Row(
//               children: <Widget>[
//                 Padding(
//                   padding: const EdgeInsets.only(right: 10),
//                   child: SizedBox(
//                     height: 20,
//                     width: 20,
//                     child: Checkbox(
//                         value: checkBoxValue,
//                         activeColor: appTheme,
//                         onChanged: (bool? newValue) {
//                           setState(() {
//                             checkBoxValue = newValue!;
//                           });
//                         }),
//                   ),
//                 ),
//                 Expanded(
//                   child: Center(
//                       child: new Text(Strings.allow_spark, style: regularTextStyle_12_gray_dark) //
//                       ),
//                 ),
//               ],
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Container(
//               height: 45,
//               width: 100,
//               child: Material(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                 elevation: 1.0,
//                 color: appTheme,
//                 child: MaterialButton(
//                     minWidth: MediaQuery.of(context).size.width,
//                     onPressed: () async {
//                       if (checkBoxValue == true) {
//                         Utility.isNetworkConnection().then((isNetwork) {
//                           if (isNetwork) {
//                             addKYCApiCall();
//                           } else {
//                             Utility.showToastMessage(Strings.no_internet_message);
//                           }
//                         });
//                       } else {
//                         Utility.showToastMessage(Strings.validation_select_checkbox);
//                       }
//                     },
//                     child: ArrowForwardNavigation()),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
//
//   addKYCApiCall() async {
//     Preferences preferences = Preferences();
//     String? mobile = await preferences.getMobile();
//     LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//     UserKYCRequest userKYCRequest = new UserKYCRequest(widget.kycUser, 1);
//     completeKYCBloc.saveUserKYC(userKYCRequest).then((value) {
//       Navigator.pop(context);
//       if (value.isSuccessFull!) {
//         Map<String, dynamic> parameters = new Map<String, dynamic>();
//         parameters[Strings.pan] = widget.kycUser.panNo;
//         parameters[Strings.dob_prm] = widget.kycUser.dateOfBirth;
//         parameters[Strings.mobile_no] = mobile;
//         parameters[Strings.name] = widget.kycUser.investorName;
//         parameters[Strings.date_time] = getCurrentDateAndTime();
//         firebaseEvent(Strings.kyc_done, parameters);
//         Navigator.pop(context);
//         Navigator.pushReplacement(context,
//             MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
//       } else if (value.errorCode == 403) {
//         commonDialog(context, Strings.session_timeout, 4);
//       } else {
//         Utility.showToastMessage(value.errorMessage!);
//       }
//     });
//   }
// }
