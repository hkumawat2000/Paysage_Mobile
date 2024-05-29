// import 'dart:async';
//
// import 'package:lms/completekyc/CompleteKYCScreen.dart';
// import 'package:lms/completekyc/EditChoiceInformationScreen.dart';
// import 'package:lms/login/LoginBloc.dart';
// import 'package:lms/login/LoginDao.dart';
// import 'package:lms/login/LoginValidationBloc.dart';
// import 'package:lms/registration/RegistrationScreen.dart';
// import 'package:lms/util/Colors.dart';
// import 'package:lms/util/Preferences.dart';
// import 'package:lms/util/Utility.dart';
// import 'package:lms/util/strings.dart';
// import 'package:lms/widgets/LoadingDialogWidget.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// class EditUserDetailsDialog extends StatefulWidget {
//   String userName, address, panNo,bankName,accountNo, ifscCode,userId;
//
//   @override
//   EditUserDetailsDialogState createState() => new EditUserDetailsDialogState();
//   EditUserDetailsDialog(this.panNo, this.address, this.userName, this.bankName, this.accountNo, this.ifscCode,this.userId);
//
// }
//
// class EditUserDetailsDialogState extends State<EditUserDetailsDialog>
//     with TickerProviderStateMixin {
//   Timer _timer;
//   int _start = 30;
//   bool retryAvailable = false;
//   AnimationController controller;
//   final loginBloc = LoginBloc();
//   String otpValue;
//   final _loginValidatorBloc = LoginValidatorBloc();
//   Preferences preferences;
//   var mobileExist;
//
//
//   @override
//   void dispose() {
//     _timer.cancel();
//     controller.dispose();
//     _loginValidatorBloc.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return new Scaffold(
//         backgroundColor: Colors.transparent,
//         bottomNavigationBar: AnimatedPadding(
//           duration: Duration(milliseconds: 150),
//           curve: Curves.easeOut,
//           padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
//           child: Container(
//             height: 300,
//             decoration: new BoxDecoration(
//               color: Colors.white,
//               borderRadius: new BorderRadius.only(
//                 topLeft: const Radius.circular(25.0),
//                 topRight: const Radius.circular(25.0),
//               ),
//             ),
//             child: Padding(
//               padding: const EdgeInsets.only(left: 20, right: 20),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: <Widget>[
//                   new Text("The information is retrieved from CKYC portal and Bank details are fetched from Choice Broking database. You may enter the desired information which you wish to edit. Any changes you make to your KYC information will have to be validated by documentary evidence. You shall be redirected toour SUPPORT team. However, if you feel that the changes are not material, you can continue yourloan application process. ",
//                       style:TextStyle(fontSize: 14,color: Colors.black)),
//                   SizedBox(height: 20,),
//                   Container(
//                     height: 40,
//                     width: 200,
//                     child: Material(
//                       shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(35)),
//                       elevation: 1.0,
//                       color: appTheme,
//                       child: MaterialButton(
//                           minWidth: MediaQuery.of(context).size.width,
//                           onPressed: () async {
//                           Navigator.pushReplacement(
//                               context,
//                               MaterialPageRoute(builder: (BuildContext context) => EditChoiceInformationScreen(widget.panNo, widget.address,widget.userName, widget.bankName,widget.accountNo,widget.ifscCode,widget.userId)));
//                           },
//                           child: Text("Next", style: TextStyle(color: Colors.white),)
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             )
//           ),
//         ));
//   }
//
//
// }
