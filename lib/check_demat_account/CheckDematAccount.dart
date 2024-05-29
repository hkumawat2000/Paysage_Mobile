// import 'package:lms/checkdemataccount/CheckDematAccountDetails.dart';
// import 'package:lms/common_widgets/constants.dart';
// import 'package:lms/util/Colors.dart';
// import 'package:lms/util/Style.dart';
// import 'package:lms/util/strings.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
// import 'package:flutter/material.dart';
//
// import 'MyDematHoldings.dart';
//
// class CheckDematAccountScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return CheckDematAccountState();
//   }
// }
//
// class CheckDematAccountState extends State<CheckDematAccountScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         backgroundColor: colorBg,
//         appBar: AppBar(
//           backgroundColor: colorBg,
//           elevation: 0,
//           leading: IconButton(
//             icon: Icon(
//               Icons.chevron_left,
//               size: 30,
//               color: appTheme,
//             ),
//             onPressed: () async {
//               Navigator.pop(context);
//             },
//           ),
//           actions: <Widget>[
//             Padding(
//               padding: EdgeInsets.only(right: 8.0),
//               child: Icon(
//                 Icons.search,
//                 color: colorLightGray,
//               ),
//             ),
//           ],
//         ),
//         body: SingleChildScrollView(
//           physics: ScrollPhysics(),
//           child: Container(
//               padding: EdgeInsets.only(left: 20,right: 20),
//               child: Column(children: [
//                 Row(children: [
//                   headingText(Strings.demat_account)
//                 ]),
//                 SizedBox(height: 24),
//                 Row(children: [
//                   Expanded(
//                       child: Container(
//                           padding: EdgeInsets.all(10),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(15),
//                            color: colorLightBlue,
//                           ),
//                           child: Column(children: [
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text('\u{20B9} 60,00,000',
//                                 style: subHeadingValue),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text(Strings.total_value,
//                                 style: subHeading),
//                             SizedBox(height: 25),
//                             Text("2",
//                                 style: subHeadingValue),
//                             SizedBox(
//                               height: 5,
//                             ),
//                             Text("DEMAT ACCOUNT",
//                                 style: subHeading),
//                             SizedBox(
//                               height: 5,
//                             ),
//                           ])))
//                 ]),
//                 SizedBox(height: 10),
//                 ListView.builder(
//                   physics: ScrollPhysics(),
//                   shrinkWrap: true,
//                   itemCount: 2,
//                   itemBuilder: (context, index) {
//                     return Padding(
//                         padding: EdgeInsets.only(top: 10),
//                         child: Row(children: [
//                           Expanded(
//                               child: GestureDetector(
//                                 child: Container(
//                                     padding: EdgeInsets.only(
//                                         left: 20, top: 10, bottom: 10),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Colors.white,
//                                     ),
//                                     child: Column(children: [
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Row(children: [
//                                         Container(
//                                             padding: EdgeInsets.all(10),
//                                             decoration: BoxDecoration(
//                                               borderRadius:
//                                               BorderRadius.circular(15),
//                                               color: Color(0xFFF8F9FE),
//                                             ),
//                                             child: Text(
//                                                 "Demat AC no - 23874628734278345",
//                                                 style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: colorDarkGray)))
//                                       ]),
//                                       SizedBox(height: 10),
//                                       Table(children: [
//                                         TableRow(children: [
//                                           Text("50",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   color: colorDarkGray,
//                                                   fontSize: 18)),
//                                           Text("\u{20B9} 30,00,000",
//                                               style: TextStyle(
//                                                   fontWeight: FontWeight.bold,
//                                                   fontSize: 18,
//                                                   color: colorDarkGray))
//                                         ])
//                                       ]),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                       Table(children: [
//                                         TableRow(children: [
//                                           Text("Total Scrips",
//                                               style: subHeading),
//                                           Text("Loan Value",
//                                               style: subHeading)
//                                         ])
//                                       ]),
//                                       SizedBox(
//                                         height: 10,
//                                       ),
//                                     ])),
//                                 onTap: (){
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (BuildContext context) =>
//                                               MyDematHoldingsScreen()));
//                                 },
//                               ))
//                         ]));
//                   },
//                 ),
//                 SizedBox(height: 10),
//               ])),
//         ));
//   }
//
//   Widget dematAccountList() {
//     return Container(
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemCount: 4,
//         itemBuilder: (context, index) {
//           return dematAccounts();
//         },
//       ),
//     );
//   }
//
//   Widget dematAccounts() {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Card(
//         elevation: 5,
//         child: Container(
//           width: double.infinity,
//           height: 120,
//           color: appTheme,
//           child: Column(
//             children: <Widget>[
//               Container(
//                 height: 50,
//                 color: Colors.white,
//                 child: Column(
//                   children: <Widget>[
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: <Widget>[
//                         Text("Demat Account No. 12xxxxxxxxxx45"),
//                         IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (BuildContext context) =>
//                                         CheckDematAccountDetailsScreen()));
//                           },
//                           icon: Icon(Icons.chevron_right),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           "50",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Text(
//                           "Total Company",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ],
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 20.0),
//                     child: Column(
//                       children: <Widget>[
//                         Text(
//                           "Rs." + "2,00,00",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                         Text(
//                           "Overdraft Limit",
//                           style: TextStyle(color: Colors.white),
//                         ),
//                       ],
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
// }
