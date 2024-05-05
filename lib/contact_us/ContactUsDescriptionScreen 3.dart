// import 'package:choice/util/Colors.dart';
// import 'package:choice/widgets/WidgetCommon.dart';
// import 'package:flutter/material.dart';
//
//
// class ContactUsDescription extends StatefulWidget {
//   final title;
//   final description;
//   ContactUsDescription(this.title, this.description);
//
//   @override
//   _ContactUsDescriptionState createState() => _ContactUsDescriptionState();
// }
//
// class _ContactUsDescriptionState extends State<ContactUsDescription> {
//   final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
//
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//           backgroundColor: colorBg,
//           body: SingleChildScrollView(
//              physics: BouncingScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               mainAxisSize: MainAxisSize.max,
//               children: <Widget>[
//                 SizedBox(height: 4),
//                 IconButton(
//                   icon: ArrowToolbarBackwardNavigation(),
//                   onPressed: () => Navigator.pop(context),
//                 ),
//                 Center(
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
//                     child: Text(
//                       widget.title,
//                       textAlign: TextAlign.center,
//                       style: TextStyle(color: appTheme, fontSize: 22, fontWeight: FontWeight.w700),
//                     ),
//                   ),
//                 ),
//                 SizedBox(
//                   height: 16,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
//                   child: Text(
//                     widget.description,
//                     style: TextStyle(color: colorBlack, fontSize: 16, fontWeight: FontWeight.w500),
//                   ),
//                 ),
//
//               ],
//             ),
//           ),
//       ),
//     );
//   }
// }
