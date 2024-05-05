// import 'package:choice/checkdemataccount/TransactionListScreen.dart';
// import 'package:choice/util/Colors.dart';
// import 'package:choice/util/Style.dart';
// import 'package:choice/widgets/WidgetCommon.dart';
// import 'package:flutter/material.dart';
//
// class MyDematHoldingsScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return MyDematHoldingsState();
//   }
// }
//
// class MyDematHoldingsState extends State<MyDematHoldingsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
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
//         body: NestedScrollView(
//           headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
//             return <Widget>[
//               SliverList(
//                 delegate: SliverChildListDelegate([
//                   Padding(
//                     padding: EdgeInsets.only(left: 20, right: 20),
//                     child:
//                     Column(
//                       children: <Widget>[
//                         Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: <Widget>[
//                               headingText("My Demat Holdings"),
//                               SizedBox(height: 10),
//                               Text(
//                                 '12xxxxxxxxx45',
//                                 style: TextStyle(color: colorDarkGray, fontSize: 18),
//                               )
//                             ],
//                           ),
//                           Icon(
//                             Icons.picture_as_pdf,
//                             color: Colors.red,
//                           )
//                         ]),
//                         SizedBox(height: 10,),
//                         Stack(
//                           children: <Widget>[
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: colorWhite,
//                                 borderRadius: BorderRadius.only(
//                                     topLeft: Radius.circular(15.0),
//                                     topRight: Radius.circular(15.0),
//                                     bottomLeft: Radius.circular(15.0),
//                                     bottomRight: Radius.circular(
//                                         15.0)), // set rounded corner radius
//                               ),
//                               child: Column(
//                                 children: <Widget>[
//                                   Container(
//                                     padding: const EdgeInsets.only(
//                                         top: 10, right: 15, left: 15),
//                                     child: Table(children: [
//                                       TableRow(
//                                         children: <Widget>[
//                                           Text('Total Eligible',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: appTheme)),
//                                           Text('\u{20B9} 50,000',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: Colors.green))
//                                         ],
//                                       ),
//
//                                     ]),
//                                   ),
//                                   Divider(
//                                     thickness: 0.5,
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.only(
//                                         top: 10, right: 15, left: 15),
//                                     child: Table(children: [
//                                       TableRow(
//                                         children: <Widget>[
//                                           Text('50',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: colorDarkGray)),
//                                           Padding(
//                                             padding: const EdgeInsets.only(bottom: 6),
//                                             child: Text('\u{20B9} 60,00,000',
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: colorDarkGray)),
//                                           ),
//                                         ],
//                                       ),
//                                       TableRow(children: <Widget>[
//                                         Text("Total Company",
//                                             style: TextStyle(
//                                                 fontSize: 12, color: colorLightGray)),
//                                         Padding(
//                                           padding: const EdgeInsets.only(bottom: 10),
//                                           child: Text("Total Securities value",
//                                               style: TextStyle(
//                                                   fontSize: 12, color: colorLightGray)),
//                                         )
//                                       ])
//                                     ]),
//                                   ),
//                                   Divider(
//                                     thickness: 0.5,
//                                   ),
//                                   Container(
//                                     padding: const EdgeInsets.only(right: 15, left: 15),
//                                     child: Table(children: [
//                                       TableRow(
//                                         children: <Widget>[
//                                           Text('30',
//                                               style: TextStyle(
//                                                   fontSize: 18,
//                                                   fontWeight: FontWeight.bold,
//                                                   color: colorDarkGray)),
//                                           Padding(
//                                             padding: const EdgeInsets.only(bottom: 6),
//                                             child: Text('\u{20B9} 40,00,000',
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight: FontWeight.bold,
//                                                     color: colorDarkGray)),
//                                           ),
//                                         ],
//                                       ),
//                                       TableRow(children: <Widget>[
//                                         Text("Approved Companies",
//                                             style: TextStyle(
//                                                 fontSize: 12, color: colorLightGray)),
//                                         Padding(
//                                           padding: const EdgeInsets.only(bottom: 10),
//                                           child: Text("Approved Securities value",
//                                               style: TextStyle(
//                                                   fontSize: 12, color: colorLightGray)),
//                                         )
//                                       ])
//                                     ]),
//                                   ),
//                                   Divider(
//                                     thickness: 0.5,
//                                   ),
//                                   Column(
//                                     children: <Widget>[
//                                       Container(
//                                         padding:
//                                         const EdgeInsets.only(right: 15, left: 15),
//                                         child: Table(children: [
//                                           TableRow(
//                                             children: <Widget>[
//                                               Text('15',
//                                                   style: TextStyle(
//                                                       fontSize: 18,
//                                                       fontWeight: FontWeight.bold,
//                                                       color: colorDarkGray)),
//                                               Padding(
//                                                 padding:
//                                                 const EdgeInsets.only(bottom: 6),
//                                                 child: Text('\u{20B9} 20,00,000',
//                                                     style: TextStyle(
//                                                         fontSize: 18,
//                                                         fontWeight: FontWeight.bold,
//                                                         color: colorDarkGray)),
//                                               ),
//                                             ],
//                                           ),
//                                           TableRow(children: <Widget>[
//                                             Text("Pledged Companies",
//                                                 style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: colorLightGray)),
//                                             Padding(
//                                               padding:
//                                               const EdgeInsets.only(bottom: 10),
//                                               child: Text("Pledged Securities value",
//                                                   style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: colorLightGray)),
//                                             )
//                                           ])
//                                         ]),
//                                       ),
//                                   GestureDetector(
//
//                                     child: Container(
//                                       decoration: BoxDecoration(
//                                         borderRadius: BorderRadius.only(
//                                             bottomLeft: Radius.circular(15),
//                                             bottomRight: Radius.circular(15)),
//                                         color: appTheme,
//                                       ),
//                                       child: Row(
//                                         mainAxisAlignment: MainAxisAlignment.center,
//                                         children: <Widget>[
//                                           Padding(
//                                             padding: const EdgeInsets.all(12),
//                                             child: Text(
//                                               "VIEW TRANSACTIONS",
//                                               style: TextStyle(
//                                                   color: Colors.white,
//                                                   fontSize: 12,
//                                                   fontWeight: FontWeight.bold),
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                     onTap: (){
//                                       Navigator.push(context, MaterialPageRoute(
//                                         builder: (BuildContext context) => TransactionListScreen()
//                                       ));
//                                     },
//                                   )
//                                     ],
//                                   ),
//
//
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//                       ],
//                     ),
//                   ),
//
//                 ]),
//               )
//             ];
//           },
//           body: Container(
//               padding: EdgeInsets.only(left: 20, right: 20),
//               child: Column(children: [
//                 Expanded(
//                   child: ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: 4,
//                     itemBuilder: (context, index) {
//                       return dematListItem();
//                     },
//                   ),
//                 ),
//               ])),
//         ));
//   }
//
//   Widget dematListItem() {
//     return Row(
//       children: <Widget>[
//         Flexible(
//           child: Container(
//             margin: EdgeInsets.only(top: 10),
//             padding: EdgeInsets.only(left: 20, right: 20,top: 10,bottom: 10),
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(15),
//               color: Colors.white,
//             ),
//             width: double.infinity,
//             //height: 80,
//             child: Column(
//               children: <Widget>[
//                 Row(
//                   children: <Widget>[
//                     Text(
//                       "Reliance Industries Ltd.",
//                       style: TextStyle(
//                           fontSize: 18,
//                           color: appTheme,
//                           fontWeight: FontWeight.bold),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Row(
//                   children: <Widget>[
//                     Icon(
//                       Icons.security,
//                       size: 15,
//                       color: Colors.green,
//                     ),
//                     SizedBox(
//                       width: 5,
//                     ),
//                     Text(
//                       "Sup A",
//                       style: TextStyle(
//                         color: Colors.green,
//                         fontSize: 12
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Table(
//                   children: [
//                     TableRow(
//                       children: <Widget>[
//                         Text('50',
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold,color: colorDarkGray)),
//                         Text('\u{20B9} 20,000',
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold,color: colorDarkGray)),
//                         Text('\u{20B9} 20,000',
//                             style: TextStyle(
//                                 fontSize: 18, fontWeight: FontWeight.bold,color: colorDarkGray)),
//                       ],
//                     )
//                   ],
//                 ),
//                 SizedBox(
//                   height: 5,
//                 ),
//                 Table(
//                   children: [
//                     TableRow(
//                       children: <Widget>[
//                         Text('QTY', style: TextStyle(
//                             fontSize: 12, fontWeight: FontWeight.bold,color: colorLightGray)),
//                         Text('Price', style:TextStyle(
//                             fontSize: 12, fontWeight: FontWeight.bold,color: colorLightGray)),
//                         Text('Value', style:TextStyle(
//                             fontSize: 12, fontWeight: FontWeight.bold,color: colorLightGray)),
//                       ],
//                     )
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget bottomSection() {
//     return Container(
//       alignment: Alignment.topCenter,
//       height: 70,
//       width: 375,
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.white, width: 3.0), // set border width
//         borderRadius: BorderRadius.only(
//             topRight: Radius.circular(40.0),
//             topLeft: Radius.circular(40.0)), // set rounded corner radius
//         boxShadow: [
//           BoxShadow(blurRadius: 10, color: Colors.grey, offset: Offset(1, 5))
//         ], // make rounded corner of border
//       ),
//       child: Padding(
//         padding: const EdgeInsets.only(left: 40, right: 20,top: 20),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Text('Total Eligible',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: appTheme)),
//             Text('\u{20B9} 50,000',
//                 style: TextStyle(
//                     fontSize: 18,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.green))
//           ],
//         )
//
//       ),
//     );
//   }
// }
