// import 'package:choice/util/Colors.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_switch/flutter_switch.dart';
//
// class ReminderAndNotificationMenu extends StatefulWidget {
//   @override
//   _ReminderAndNotificationMenuState createState() => _ReminderAndNotificationMenuState();
// }
//
// class _ReminderAndNotificationMenuState extends State<ReminderAndNotificationMenu> {
//
//   bool isRepaymentPush = true;
//   bool isRepaymentEmail = true;
//   bool isUpdatePush = true;
//   bool isUpdateEmail = true;
//   bool isOfferPush = true;
//   bool isOfferEmail = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Divider(color: colorGrey),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 8, 0, 10),
//               child: Text('Repayment Reminders',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
//             ),
//             Row(
//               children: [
//                 // SizedBox(
//                 //   height: 30,
//                 //   child: FlutterSwitch(
//                 //     value: isRepaymentPush,
//                 //     activeColor: colorGreen,
//                 //     onToggle: (value){
//                 //       setState(() {
//                 //         isRepaymentPush = value;
//                 //       });
//                 //     },
//                 //   ),
//                 // ),
//
//                 SizedBox(width: 2),
//                 Text('Push Message',
//                 style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
//                 Spacer(),
//                 // SizedBox(
//                 //   height: 30,
//                 //   child: FlutterSwitch(
//                 //     value: isRepaymentEmail,
//                 //     activeColor: colorGreen,
//                 //     onToggle: (value){
//                 //       setState(() {
//                 //         isRepaymentEmail = value;
//                 //       });
//                 //     },
//                 //   ),
//                 // ),
//                 SizedBox(width: 2),
//                 Text('Email',style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
//                 SizedBox(width: 10),
//               ],
//             ),
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Divider(color: colorGrey),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 8, 0, 10),
//               child: Text('Important Updates',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
//             ),
//             Row(
//               children: [
//                 // SizedBox(
//                 //   height: 30,
//                 //   child: FlutterSwitch(
//                 //     value: isUpdatePush,
//                 //     activeColor: colorGreen,
//                 //     onToggle: (value){
//                 //       setState(() {
//                 //         isUpdatePush = value;
//                 //       });
//                 //     },
//                 //   ),
//                 // ),
//                 SizedBox(width: 2),
//                 Text('Push Message',
//                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
//                 Spacer(),
//                 // SizedBox(
//                 //   height: 30,
//                 //   child: FlutterSwitch(
//                 //     value: isUpdateEmail,
//                 //     activeColor: colorGreen,
//                 //     onToggle: (value){
//                 //       setState(() {
//                 //         isUpdateEmail = value;
//                 //       });
//                 //     },
//                 //   ),
//                 // ),
//                 SizedBox(width: 2),
//                 Text('Email',style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
//                 SizedBox(width: 10),
//               ],
//             ),
//           ],
//         ),
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Divider(color: colorGrey),
//             Padding(
//               padding: const EdgeInsets.fromLTRB(0, 8, 0, 10),
//               child: Text('New Product Offers',
//                 style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
//             ),
//             Row(
//               children: [
//                 // SizedBox(
//                 //   height: 30,
//                 //   child: FlutterSwitch(
//                 //     value: isOfferPush,
//                 //     activeColor: colorGreen,
//                 //     onToggle: (value){
//                 //       setState(() {
//                 //         isOfferPush = value;
//                 //       });
//                 //     },
//                 //   ),
//                 // ),
//                 SizedBox(width: 2),
//                 Text('Push Message',
//                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
//                 Spacer(),
//                 // SizedBox(
//                 //   height: 30,
//                 //   child: FlutterSwitch(
//                 //     value: isOfferEmail,
//                 //     activeColor: colorGreen,
//                 //     onToggle: (value){
//                 //       setState(() {
//                 //         isOfferEmail = value;
//                 //       });
//                 //     },
//                 //   ),
//                 // ),
//                 SizedBox(width: 2),
//                 Text('Email',style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),),
//                 SizedBox(width: 10),
//               ],
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }
