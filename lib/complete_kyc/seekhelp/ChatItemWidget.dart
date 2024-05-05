// import 'package:choice/util/Colors.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
//
// class ChatItemWidget extends StatelessWidget{
//   var index;
//
//   ChatItemWidget(this.index);
//
//   @override
//   Widget build(BuildContext context) {
//     if (index % 2 == 0) {
//       //This is the sent message. We'll later use data from firebase instead of index to determine the message is sent or received.
//       return Container(
//         child: Column(
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Container(
//                   child: Image.asset(
//                     'assets/images/survey.png',
//                     width: 15,
//                     height:15,
//                   ),
//                   padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade100,
//                       borderRadius: BorderRadius.circular(8.0)),
//                   margin: EdgeInsets.only(left: 10.0),
//                 ),
//                 Container(
//                   child: Text(
//                     'Hello, Welcome to Spark',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                   width: 200.0,
//                   decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(8.0)),
//                   margin: EdgeInsets.only(left: 10.0),
//                 )
//               ],
//             ),
//             Container(
//               alignment: Alignment.center,
//               child: Text(
//                 DateFormat('dd MMM kk:mm')
//                     .format(DateTime.fromMillisecondsSinceEpoch(1565888474278)),
//                 style: TextStyle(
//                     color: Colors.grey,
//                     fontSize: 12.0,
//                     fontStyle: FontStyle.normal),
//               ),
//               margin: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
//             )
//           ],
//           crossAxisAlignment: CrossAxisAlignment.start,
//         ),
//         margin: EdgeInsets.only(bottom: 10.0),
//       );
//     } else {
//       // This is a received message
//
//       return Container(
//           child: Column(children: <Widget>[
//             Row(
//               children: <Widget>[
//                 Container(
//                   child: Text(
//                     'This error occurring, unable to update KYC',
//                     style: TextStyle(color: Colors.black),
//                   ),
//                   padding: EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 10.0),
//                   width: 200.0,
//                   decoration: BoxDecoration(
//                       color: Colors.grey.shade200,
//                       borderRadius: BorderRadius.circular(8.0)),
//                   margin: EdgeInsets.only(right: 10.0),
//                 )
//               ],
//               mainAxisAlignment:
//               MainAxisAlignment.end, // aligns the chatitem to right end
//             ),
//             Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: <Widget>[
//                   Container(
//                     child: Text(
//                       DateFormat('dd MMM kk:mm')
//                           .format(DateTime.fromMillisecondsSinceEpoch(1565888474278)),
//                       style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 12.0,
//                           fontStyle: FontStyle.normal),
//                     ),
//                     margin: EdgeInsets.only(left: 5.0, top: 5.0, bottom: 5.0),
//                   )])
//           ]));
//     }  }
//
// }