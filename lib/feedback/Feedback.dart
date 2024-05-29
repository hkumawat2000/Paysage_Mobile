// import 'package:lms/dummy/constants.dart';
// import 'package:lms/feedback/FeedbackBloc.dart';
// import 'package:lms/util/Colors.dart';
// import 'package:lms/util/Style.dart';
// import 'package:lms/util/Utility.dart';
// import 'package:lms/util/strings.dart';
// import 'package:lms/widgets/LoadingDialogWidget.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
// import 'package:flutter/material.dart';
//
// class FeedbackScreen extends StatefulWidget {
//   @override
//   FeedBackScreenState createState() => FeedBackScreenState();
// }
//
// class FeedBackScreenState extends State<FeedbackScreen> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//   TextEditingController commentController;
//   final feedbackBloc = FeedbackBloc();
//   int _rating = 0;
//   String _ratingMessage = "";
//
//   @override
//   void dispose() {
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     commentController = TextEditingController();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: colorbg,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: ArrowToolbarBackwardNavigation(),
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//         backgroundColor: colorbg,
//         elevation: 0.0,
//         // centerTitle: true,
//       ),
//       body: Container(
//         padding: EdgeInsets.symmetric(horizontal: 20.0),
//         child: SingleChildScrollView(
//           child: Column(
//             children: <Widget>[
//               Row(
//                 children: <Widget>[
//                   headingText("Feedback"),
//                 ],
//               ),
//               SizedBox(
//                 height: 10.0,
//               ),
//               Row(
//                 children: <Widget>[
//                   Text(
//                     'Please give your valuable feedback',
//                     style: TextStyle(
//                       color: colorLightGray,
//                       fontSize: 18,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 100.0,
//               ),
//               Text(
//                 _ratingMessage,
//                 style: kNormalTextStyle.copyWith(
//                     fontSize: 22.0, fontWeight: FontWeight.bold, color: colorDarkGray),
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Container(
//                 width: 500.0,
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     GestureDetector(
//                       child: Icon(
//                         Icons.star,
//                         size: 40,
//                         color: _rating >= 1 ? appTheme : Colors.grey,
//                       ),
//                       onTap: () => rate(1, 'Poor'),
//                     ),
//                     SizedBox(width: 10),
//                     GestureDetector(
//                       child: Icon(
//                         Icons.star,
//                         size: 40,
//                         color: _rating >= 2 ? appTheme : Colors.grey,
//                       ),
//                       onTap: () => rate(2, 'Need Improvement'),
//                     ),
//                     SizedBox(width: 10),
//                     GestureDetector(
//                       child: Icon(
//                         Icons.star,
//                         size: 40,
//                         color: _rating >= 3 ? appTheme : Colors.grey,
//                       ),
//                       onTap: () => rate(3, 'Satisfactory'),
//                     ),
//                     SizedBox(width: 10),
//                     GestureDetector(
//                       child: Icon(
//                         Icons.star,
//                         size: 40,
//                         color: _rating >= 4 ? appTheme : Colors.grey,
//                       ),
//                       onTap: () => rate(4, 'Good'),
//                     ),
//                     SizedBox(width: 10),
//                     GestureDetector(
//                       child: Icon(
//                         Icons.star,
//                         size: 40,
//                         color: _rating >= 5 ? appTheme : Colors.grey,
//                       ),
//                       onTap: () => rate(5, 'Excellent'),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               commentFeild(),
//               SizedBox(
//                 height: 100.0,
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
//                       Utility.isNetworkConnection().then((isNetwork) {
//                         if (isNetwork) {
//                           saveFeedback();
//                         } else {
//                           showSnackBar(_scaffoldKey);
//                         }
//                       });
//                     },
//                     child: Text(
//                       'Submit',
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
//   Widget commentFeild() {
//     final theme = Theme.of(context);
//     return Padding(
//       padding: const EdgeInsets.only(left: 10, right: 10),
//       child: Theme(
//         data: theme.copyWith(primaryColor: appTheme),
//         child: TextFormField(
//           textCapitalization: TextCapitalization.sentences,
//           controller: commentController,
//           style: TextStyle(color: Colors.grey.shade800, fontSize: 15),
//           decoration: new InputDecoration(
//             counterText: "",
//             hintText: "Comment",
//             hintStyle: TextStyle(color: colorLightGray, fontSize: 14),
//             focusColor: Colors.grey,
//             enabledBorder: new UnderlineInputBorder(
//               borderSide: BorderSide(
//                 color: appTheme,
//                 width: 0.5,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void rate(int rating, String ratingMessage) {
//     //Other actions based on rating such as api calls.
//     setState(() {
//       _rating = rating;
//       _ratingMessage = ratingMessage;
//     });
//   }
//
//   void saveFeedback() {
//     if (_ratingMessage.toString().length == 0) {
//       Utility.showToastMessage("Please select star to give us feedback");
//     } else if (_rating <= 3) {
//       Utility.showToastMessage("Please enter comment");
//     } else {
//       LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//       feedbackBloc.saveFeedback(_ratingMessage.toString(), commentController.text).then((value) {
//         Navigator.pop(context);
//         if (value.isSuccessFull) {
//           Utility.showToastMessage("Feedback save successfully");
//           Navigator.push(
//               context, MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
//         } else {
//           Utility.showToastMessage(value.errorMessage);
//         }
//       });
//     }
//   }
// }
