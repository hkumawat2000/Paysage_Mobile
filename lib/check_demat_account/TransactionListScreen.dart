// import 'package:choice/util/Colors.dart';
// import 'package:choice/util/Style.dart';
// import 'package:choice/widgets/WidgetCommon.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class TransactionListScreen extends StatefulWidget{
//   @override
//   TransactionListScreenState createState() => TransactionListScreenState();
//
// }
//
// class TransactionListScreenState extends State<TransactionListScreen>{
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//             appBar: AppBar(
//               backgroundColor: colorBg,
//               elevation: 0,
//               leading: IconButton(
//                 icon: Icon(
//                   Icons.chevron_left,
//                   size: 30,
//                   color: appTheme,
//                 ),
//                 onPressed: () async {
//                   Navigator.pop(context);
//                 },
//               ),
//             ),
//             body: Container(
//                 color: colorBg,
//                 padding: EdgeInsets.only(left: 20,right: 20),
//                 child: Column(children: [
//                   Row(children: [
//                     headingText("Transactions")
//                   ]),
//                   SizedBox(height: 10),
//                   ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: 6,
//                     itemBuilder: (context, index) {
//                       return Padding(
//                           padding: EdgeInsets.only(top: 10),
//                           child: Row(children: [
//                             Expanded(
//                                 child: Container(
//                                     padding: EdgeInsets.all(10),
//                                     decoration: BoxDecoration(
//                                       borderRadius: BorderRadius.circular(10),
//                                       color: Colors.white,
//                                     ),
//                                     child: Row(
//                                         mainAxisAlignment:
//                                         MainAxisAlignment.spaceBetween,
//                                         children: [
//                                           Column(
//                                               crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                               children: [
//                                                 Row(children: [
//                                                   Text("29 June 2020",
//                                                       style: TextStyle(
//                                                           fontSize: 18,
//                                                           fontWeight:
//                                                           FontWeight.w500,
//                                                           color: appTheme))
//                                                 ]),
//                                                 SizedBox(height: 5,),
//                                                 Text(
//                                                     "UPI / 02568/ keshav@okicici",
//                                                     style: TextStyle(
//                                                       fontSize: 12,color: colorLightGray,
//                                                     )),
//                                               ]),
//                                           Row(children: [
//                                             Container(
//                                                 padding: EdgeInsets.all(4),
//                                                 decoration: BoxDecoration(
//                                                   border: Border.all(
//                                                       color: index % 2 == 0
//                                                           ? Colors.red
//                                                           : Colors.green),
//                                                   borderRadius:
//                                                   BorderRadius.circular(6),
//                                                   color: index % 2 == 0
//                                                       ? Colors.red.shade200
//                                                       : Colors.green.shade200,
//                                                 ),
//                                                 child: Text(
//                                                     index % 2 == 0
//                                                         ? "Dr"
//                                                         : "Cr",
//                                                     style: TextStyle(
//                                                         fontSize: 11,
//                                                         color: index % 2 == 0
//                                                             ? red
//                                                             : colorGreen))),
//                                             SizedBox(width: 5),
//                                             Text('\u{20B9} 10,00,000',
//                                                 style: TextStyle(
//                                                     fontSize: 18,
//                                                     fontWeight:
//                                                     FontWeight.bold,color: colorDarkGray)),
//                                           ])
//                                         ])))
//                           ]));
//                     },
//                   )
//                 ])))
//     );
//   }
// }