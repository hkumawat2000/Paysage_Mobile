// import 'package:lms/common_widgets/constants.dart';
// // import 'package:lms/dummy/constants.dart';
// import 'package:lms/refer&earn/ReferEarnBottomView.dart';
// import 'package:lms/util/AssetsImagePath.dart';
// import 'package:lms/util/Colors.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
// // import 'package:dashed_container/dashed_container.dart';
// // import 'package:dotted_border/dotted_border.dart';
// import 'package:dotted_line/dotted_line.dart';
// import 'package:flutter/material.dart';
//
// class ReferAndEarnScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: ArrowToolbarBackwardNavigation(),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         backgroundColor: colorbg,
//         elevation: 0.0,
//         // centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           alignment: Alignment.center,
//           child: Column(
//             children: <Widget>[
//               Image(
//                 image: AssetImage(AssetsImagePath.tutorial_3),
//                 height: 258.55,
//                 width: 171.48,
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Text(
//                 'Refer & Win',
//                 style: kMediumTextStyle,
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//                 child: Text(
//                     'Invite your friends and family members to take advantage of Spark Loans with your referral code and stand a chance to win attractive rewards.',
//                     style: kTextMessageTextStyle),
//               ),
//               SizedBox(
//                 height: 20.0,
//               ),
//               Text('Your refer code', style: kGreyTextTextStyle),
//               SizedBox(
//                 height: 16.0,
//                 // width: 80.0,
//               ),
//               rectBorderWidget,
//               SizedBox(
//                 height: 30.0,
//               ),
//               Container(
//                 height: 45,
//                 width: 145,
//                 child: Material(
//                   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
//                   elevation: 1.0,
//                   color: appTheme,
//                   child: MaterialButton(
//                     minWidth: MediaQuery.of(context).size.width,
//                     onPressed: () async {
//                       referDialogBox(context);
//                     },
//                     child: Text(
//                       'Refer now',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 39.0,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget get rectBorderWidget {
//     return DottedBorder(
//       dashPattern: [6, 3],
//       strokeWidth: 1,
//       borderType: BorderType.RRect,
//       radius: Radius.circular(25),
//       padding: EdgeInsets.all(6),
//       color: red,
//       child: ClipRRect(
//         borderRadius: BorderRadius.all(Radius.circular(12)),
//         child: Container(
//           alignment: Alignment.center,
//           height: 50,
//           width: 140,
//           child: Text(
//             'SPL0369',
//             style: kDefaultTextStyle.copyWith(
//                 fontSize: 16.0, color: Colors.red, fontWeight: FontWeight.bold),
//           ),
//         ),
//       ),
//     );
//   }
//
//   referDialogBox(BuildContext context) {
//     return showModalBottomSheet(
//         backgroundColor: Colors.transparent,
//         context: context,
//         isScrollControlled: true,
//         builder: (BuildContext bc) {
//           return Scaffold(
//             backgroundColor: Colors.transparent,
//             bottomNavigationBar: AnimatedPadding(
//               duration: Duration(milliseconds: 150),
//               curve: Curves.easeOut,
//               padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//               child: Container(
//                 height: 220,
//                 decoration: new BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: new BorderRadius.only(
//                     topLeft: const Radius.circular(25.0),
//                     topRight: const Radius.circular(25.0),
//                   ),
//                 ),
//                 padding: const EdgeInsets.only(left: 10, right: 10),
//                 child: Column(
//                   children: <Widget>[
//                     SizedBox(
//                       height: 30,
//                     ),
//                     referEarnDialog(),
//                     SizedBox(
//                       height: 40,
//                     ),
//                     referEarnDialog(),
//                   ],
//                 ),
//               ),
//             ),
//           );
//         });
//   }
//
//   Widget referEarnDialog() {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       children: <Widget>[
//         Container(
//           height: 40,
//           width: 40,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade800, width: 1.0),
//             // set border width
//             borderRadius: BorderRadius.all(Radius.circular(20.0)),
//           ),
//         ),
//         Container(
//           height: 40,
//           width: 40,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade800, width: 1.0),
//             // set border width
//             borderRadius: BorderRadius.all(Radius.circular(20.0)),
//           ),
//         ),
//         Container(
//           height: 40,
//           width: 40,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade800, width: 1.0),
//             // set border width
//             borderRadius: BorderRadius.all(Radius.circular(20.0)),
//           ),
//         ),
//         Container(
//           height: 40,
//           width: 40,
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade800, width: 1.0),
//             // set border width
//             borderRadius: BorderRadius.all(Radius.circular(20.0)),
//           ),
//         ),
//       ],
//     );
//   }
// }
