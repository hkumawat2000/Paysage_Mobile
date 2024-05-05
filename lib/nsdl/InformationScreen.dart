// import 'package:choice/AdditionalAccountDetail/AdditionalAccountDetailScreen.dart';
// import 'package:choice/newdashboard/NewDashboardScreen.dart';
// import 'package:choice/util/Colors.dart';
// import 'package:choice/util/Preferences.dart';
// import 'package:choice/util/Style.dart';
// import 'package:choice/util/Utility.dart';
// import 'package:choice/util/strings.dart';
// import 'package:choice/widgets/WidgetCommon.dart';
// import 'package:flutter/material.dart';
// import 'BankDetailScreen.dart';
// import 'OTPVerification.dart';
//
// class InformationScreen extends StatefulWidget {
//   String ckycName;
//   InformationScreen(this.ckycName);
//
//   @override
//   _InformationScreenState createState() => _InformationScreenState();
// }
//
// class _InformationScreenState extends State<InformationScreen> {
//   bool checkBoxValue = true;
//   // String? userEmail = "aaaa@gmail.com";
//   String? userEmail = "-";
//   Preferences preferences = new Preferences();
//
//   @override
//   void initState() {
//     preferences.setOkClicked(false);
//     // TODO: implement initState
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => backPressYesNoDialog(context),
//       child: Scaffold(
//         backgroundColor: colorbg,
//         appBar: AppBar(
//           backgroundColor: colorbg,
//           elevation: 0,
//           leading: IconButton(
//             icon: NavigationBackImage(),
//             onPressed: () => backPressYesNoDialog(context),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.only(left: 35, right: 35),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Center(child: Text(Strings.detail_information,
//                   style: TextStyle(color: appTheme, fontSize: 28,
//                       fontWeight: FontWeight.bold))),
//                 SizedBox(
//                   height: 40,
//                 ),
//                 Text(Strings.personal_info, style: semiBoldTextStyle_18),
//                 SizedBox(height: 20),
//                 Table(
//                     defaultColumnWidth: FixedColumnWidth(150.0),
//                     children: [
//                   TableRow(children: [
//                     Text("Name :", style: regularTextStyle_18_gray),
//                     Text('ABCD', style: TextStyle(color: appTheme, fontSize: 18)),
//                   ]),
//                   TableRow(children: [
//                     SizedBox(height: 10),
//                     SizedBox(height: 10),
//                   ]),
//                       TableRow(children: [
//                         Text("Pan Number :", style: regularTextStyle_18_gray),
//                         Text('AAKHR7426K', style: TextStyle(color: appTheme, fontSize: 18)),
//                       ]),
//                       TableRow(children: [
//                         SizedBox(height: 10),
//                         SizedBox(height: 10),
//                       ]),
//                       TableRow(children: [
//                         Text("CKYC Number :", style: regularTextStyle_18_gray),
//                         Text('AAKHR1237426K', style: TextStyle(color: appTheme, fontSize: 18)),
//                       ]),
//                       TableRow(children: [
//                         SizedBox(height: 10),
//                         SizedBox(height: 10),
//                       ]),
//                   TableRow(children: [
//                     Text("Email  :", style: regularTextStyle_18_gray),
//                     userEmail!.contains('@') ?  Text(
//                       userEmail!.replaceRange(userEmail!.indexOf('@') > 4 ? 4 : 2,
//                           userEmail!.indexOf('@'), "XXXXX"),
//                       style: TextStyle(fontSize: 18, color: appTheme),
//                     ) : Text(userEmail!),
//                   ]),
//                   TableRow(children: [
//                     SizedBox(height: 10),
//                     SizedBox(height: 10),
//                   ]),
//                   TableRow(children: [
//                     Text("Mobile No. :", style: regularTextStyle_18_gray),
//                     Text(
//                       encryptAcNo("1234567890"),
//                       style: TextStyle(color: appTheme, fontSize: 18),
//                     ),
//                   ]), TableRow(children: [
//                         SizedBox(height: 10),
//                         SizedBox(height: 10),
//                       ]),
//                       TableRow(
//                           children: [
//                             Text("Gender :", style: regularTextStyle_18_gray),
//                             Text('Female',
//                                 style: TextStyle(color: appTheme, fontSize: 18)),
//                           ]),
//                 ]),
//                 SizedBox(height: 70),
//                 Text(
//                   Strings.information_declaration,
//                   style: TextStyle(color: appTheme, fontSize: 17),
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: [
//                     Container(
//                       height: 40,
//                       width: 120,
//                       child: Material(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(45)),
//                         elevation: 1.0,
//                         color: appTheme,
//                         child: MaterialButton(
//                           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () {
//                             setState(() {
//                               preferences.setOkClicked(true);
//                             });
//                             showDialogOnCkycSuccess("hello");
//
//                             // Navigator.push(
//                             //     context,
//                             //     MaterialPageRoute(
//                             //         builder: (context) => AdditionalAccountDetailScreen(true)));
//                           },
//                           child: Text(
//                             Strings.ok,
//                             style: TextStyle(color: Colors.white),
//                           ),
//                         ),
//                       ),
//                     ),
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
//   showDialogOnCkycSuccess(String msg) {
//     return showDialog<void>(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return WillPopScope(
//           onWillPop: () async => false,
//           child: AlertDialog(
//             backgroundColor: Colors.white,
//             // title: Text(
//             //   "KYC Success Dialog",
//             //   style: TextStyle(color: Colors.green, fontSize: 28),
//             // ),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10.0))),
//             content: Text(msg),
//             actions: <Widget>[
//               Center(
//                 child: Container(
//                   width: 100,
//                   child: Material(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(35)),
//                     elevation: 1.0,
//                     color: appTheme,
//                     child: MaterialButton(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                       minWidth: MediaQuery.of(context).size.width,
//                       onPressed: () {
//                         setState(() {
//                           preferences.setOkClicked(false);
//                         });
//                         Navigator.pop(context);
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => AdditionalAccountDetailScreen(0, "", "", "")));
//                       },
//                       child: Text(
//                         Strings.ok,
//                         style: TextStyle(color: Colors.white),
//                       ),
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
//   showDialogForCKYC(String msg) {
//     return showDialog<void>(
//       barrierDismissible: false,
//       context: context,
//       builder: (BuildContext context) {
//         return WillPopScope(
//           onWillPop: () async => true,
//           child: AlertDialog(
//             backgroundColor: Colors.white,
//             // title: Text(
//             //   "Additional Skip",
//             //   style: TextStyle(color: Colors.green, fontSize: 28),
//             // ),
//             shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10.0))),
//             content: Text(msg),
//             actions: <Widget>[
//               Center(
//                 child: Container(
//                   width: 100,
//                   child: Material(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(35)),
//                     elevation: 1.0,
//                     color: appTheme,
//                     child: MaterialButton(
//                       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                       minWidth: MediaQuery.of(context).size.width,
//                       onPressed: () {
//                         Navigator.pop(context);
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (context) => DashBoard()));
//                       },
//                       child: Text(
//                         Strings.ok,
//                         style: TextStyle(color: Colors.white),
//                       ),
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
// }
