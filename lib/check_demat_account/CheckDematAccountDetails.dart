// import 'package:lms/util/Colors.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class CheckDematAccountDetailsScreen extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return CheckDematAccountDetailsScreenState();
//   }
// }
//
// class CheckDematAccountDetailsScreenState extends State<CheckDematAccountDetailsScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           icon: Icon(
//             Icons.chevron_left,
//             size: 30,
//             color: appTheme,
//           ),
//           onPressed: () async{
//             Navigator.pop(context);
//           },
//         ),
//         actions: <Widget>[
//           Padding(
//             padding: EdgeInsets.only(right: 8.0),
//             child: Icon(
//               Icons.search,
//               color: appTheme,
//             ),
//           ),
//         ],
//       ),
//       body: Column(
//         children: <Widget>[
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 8.0, right: 10.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: <Widget>[
//                 Column(
//                   children: <Widget>[
//                     Text('Demat acount no.'),
//                     Text('12xxxxxxxxx45'),
//                   ],
//                 ),
//                 Container(
//                   height: 20,
//                   width: 70,
//                   child: Material(
//                     elevation: 1.0,
//                     color: appTheme,
//                     child: MaterialButton(
// //                    minWidth: MediaQuery.of(context).size.width,
//                       onPressed: () async {},
//                       child: Text(
//                         "Export pdf",
//                         style: TextStyle(color: Colors.white, fontSize: 8),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Row(
//             children: <Widget>[
//               Container(
//                 width: MediaQuery.of(context).size.width,
//                 color: Colors.grey,
//                 height: 25,
//                 child: Center(
//                   child:
//                       Text('This facility is only for customers having demat account with Choice',
//                           style: TextStyle(
//                             fontSize: 11,
//                           )),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(
//             height: 10,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(15.0),
//             child: Container(
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.all(Radius.circular(30.0)),
//                   border: Border.all(
//                     color: Colors.white,
//                   )),
//               child: Card(
// //                elevation: 5,
//                 child: Container(
//                   width: double.infinity,
//                   height: 200,
//                   child: Column(
//                     children: <Widget>[
//                       Container(
//                         height: 140,
//                         color: appTheme,
//                         child: Column(
//                           children: <Widget>[
//                             Padding(
//                               padding: const EdgeInsets.only(top: 15.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 children: <Widget>[
//                                   Text(
//                                     "50",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   Text(
//                                     "30,000,000",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: <Widget>[
//                                 Text(
//                                   "Total Campany",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 Text(
//                                   "Total Value",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ],
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Divider(
//                               height: 2,
//                               color: Colors.black,
//                               indent: 30,
//                               endIndent: 30,
//                               thickness: 2,
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(top: 10.0),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                                 children: <Widget>[
//                                   Text(
//                                     "20",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                   Text(
//                                     "16,000,000",
//                                     style: TextStyle(color: Colors.white),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                               children: <Widget>[
//                                 Text(
//                                   "Total Campany",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                                 Text(
//                                   "Total Value",
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.only(top: 20.0),
//                         child: Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             Text('Total Eligible'),
//                             SizedBox(
//                               width: 20,
//                             ),
//                             Text('8000.00'),
//                           ],
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(
//             height: 20,
//           ),
//           Expanded(
//             child: dematAccountDetailsList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget dematAccountDetailsList() {
//     return Container(
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemCount: 4,
//         itemBuilder: (context, index) {
//           return dematAccountsDetails();
//         },
//       ),
//     );
//   }
//
//   Widget dematAccountsDetails() {
//     return Padding(
//       padding: const EdgeInsets.all(15.0),
//       child: Row(
//         children: <Widget>[
//           Flexible(
//             child: Card(
//               elevation: 5,
//               child: Container(
//                 width: double.infinity,
//                 height: 80,
//                 child: Column(
//                   children: <Widget>[
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Row(
//                         children: <Widget>[
//                           CircleAvatar(
//                             child: ClipOval(),
//                             minRadius: 25,
//                             maxRadius: 25,
//                             backgroundColor: Colors.grey,
//                           ),
//                           SizedBox(
//                             width: 20,
//                           ),
//                           Column(
//                             children: <Widget>[
//                               Text(
//                                 "Mahindra Industries Ltd.",
//                                 style: TextStyle(
//                                     fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold),
//                               ),
//                               Text(
//                                 "Approved category Sup A",
//                                 style: TextStyle(fontSize: 12, color: Colors.black),
//                               ),
//                               SizedBox(
//                                 height: 10,
//                               ),
//                               Row(
//                                 children: <Widget>[
//                                   Row(
//                                     children: <Widget>[
//                                       Text('Qty'),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Text('4'),
//                                     ],
//                                   ),
//                                   SizedBox(
//                                     width: 40,
//                                   ),
//                                   Row(
//                                     children: <Widget>[
//                                       Text('LTP'),
//                                       SizedBox(
//                                         width: 10,
//                                       ),
//                                       Text('Rs.10,000'),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
