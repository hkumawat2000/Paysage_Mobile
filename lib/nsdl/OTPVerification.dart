// import 'dart:async';
//
// import 'package:lms/completekyc/CompleteKYCScreen.dart';
// import 'package:lms/util/Colors.dart';
// import 'package:lms/util/Utility.dart';
// import 'package:lms/util/strings.dart';
// import 'package:flutter/material.dart';
// import 'package:lms/main_getx.dart';
// import 'package:lms/widgets/WidgetCommon.dart';
// import 'package:flutter/services.dart';
// import 'package:path/path.dart';
// import 'package:pin_code_fields/pin_code_fields.dart';
//
// import 'InformationScreen.dart';
//
// class OTPVerification extends StatefulWidget {
//   @override
//   _OTPVerificationState createState() => _OTPVerificationState();
// }
//
// class _OTPVerificationState extends State<OTPVerification> {
//   final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//   Timer? _timer;
//   int _start = 120;
//   AnimationController? controller;
//   TextEditingController otpController = TextEditingController();
//
//   bool retryAvailable = false;
//   bool isSubmitBtnClickable = true;
//   bool isResendOTPClickable = true;
//
//   void startTimer() {
//     const oneSec = const Duration(seconds: 1);
//     _timer = new Timer.periodic(
//       oneSec,
//       (Timer timer) => setState(
//         () {
//           if (_start < 1) {
//             timer.cancel();
//             setState(() {
//               isResendOTPClickable = false;
//               retryAvailable = true;
//             });
//           } else {
//             _start = _start - 1;
//           }
//         },
//       ),
//     );
//   }
//
//   String get timerString {
//     Duration duration = Duration(seconds: _start);
//     return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
//   }
//
//   @override
//   void dispose() {
//     _timer!.cancel();
//     super.dispose();
//   }
//
//   @override
//   void initState() {
//     startTimer();
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: () {
//           FocusScope.of(context).unfocus();
//         },
//         child: Scaffold(
//           //resizeToAvoidBottomInset: false,
//           backgroundColor: Colors.transparent,
//           bottomNavigationBar: AnimatedPadding(
//             duration: Duration(milliseconds: 150),
//             curve: Curves.easeOut,
//             padding: EdgeInsets.only(
//                 bottom: MediaQuery.of(context).viewInsets.bottom),
//             child: Container(
//               height: 420,
//               width: 375,
//               decoration: new BoxDecoration(
//                 color: colorWhite,
//                 borderRadius: new BorderRadius.only(
//                   topLeft: const Radius.circular(30.0),
//                   topRight: const Radius.circular(30.0),
//                 ),
//               ),
//               child: SingleChildScrollView(
//                 child: Padding(
//                   padding: EdgeInsets.only(left: 20, right: 20, bottom: 10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       SizedBox(
//                         height: 20,
//                       ),
//                       HeadingSubHeadingWidget(
//                           Strings.otp_verification, Strings.otp_sent_text),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         encryptAcNo("1234567890"),
//                         style: TextStyle(fontSize: 18),
//                       ),
//                       SizedBox(
//                         height: 40,
//                       ),
//                       Container(
//                         child: PinCodeTextField(
//                           controller: otpController,
//                           appContext: context,
//                           cursorColor: appTheme,
//                           length: 4,
//                           obscureText: false,
//                           autoFocus: true,
//                           animationType: AnimationType.fade,
//                           keyboardType:
//                           TextInputType.numberWithOptions(decimal: true),
//                           inputFormatters: [
//                             WhitelistingTextInputFormatter.digitsOnly
//                           ],
//                           pinTheme: PinTheme(
//                             shape: PinCodeFieldShape.underline,
//                             inactiveColor: colorGrey,
//                             selectedColor: appTheme,
//                             activeColor: appTheme,
//                             disabledColor: colorGrey,
//                             borderWidth: 2,
//                           ),
//                           onCompleted: (otp) {
//                             printLog(otp);
//                             FocusScope.of(context).unfocus();
//                           },
//                           onChanged: (value) {
//                             printLog(value);
//                             setState(() {
//                               if (value.length >= 4) {
//                                 isSubmitBtnClickable = false;
//                               } else {
//                                 isSubmitBtnClickable = true;
//                               }
//                             });
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: 40,
//                       ),
//                       Center(
//                         child: AbsorbPointer(
//                           absorbing: isSubmitBtnClickable,
//                           child: Container(
//                             height: 45,
//                             width: 140,
//                             child: Material(
//                               shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(35)),
//                               elevation: 1.0,
//                               color: isSubmitBtnClickable == true
//                                   ? colorLightGray
//                                   : appTheme,
//                               child: MaterialButton(
//                                 minWidth: MediaQuery.of(context).size.width,
//                                 onPressed: () {
//                                   // Navigator.pushReplacement(
//                                   //     context,
//                                   //     MaterialPageRoute(
//                                   //         builder: (context) =>
//                                   //             InformationScreen()));
//                                 },
//                                 child: Text(
//                                   Strings.submit,
//                                   style: TextStyle(color: Colors.white),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 30,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           Navigator.pop(context);
//                         },
//                         child: Text(
//                           Strings.edit_pan_details,
//                           style: TextStyle(
//                               fontSize: 16, fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           AbsorbPointer(
//                             absorbing: isResendOTPClickable,
//                             child: InkWell(
//                               onTap: () async {
//                                 Utility.isNetworkConnection().then((isNetwork) {
//                                   if (isNetwork) {
//                                     setState(() {
//                                       _start = 120;
//                                       retryAvailable = false;
//                                       isResendOTPClickable = true;
//                                       startTimer();
//                                     });
//                                   } else {
//                                     Utility.showToastMessage(Strings.no_internet_message);
//                                   }
//                                 });
//                               },
//                               child: Text(
//                                 Strings.resend_otp,
//                                 style: TextStyle(
//                                     color: isResendOTPClickable == true
//                                         ? colorGrey
//                                         : appTheme,
//                                     fontSize: 16,
//                                     fontWeight: FontWeight.w500),
//                               ),
//                             ),
//                           ),
//                           Text(timerString,
//                               style: TextStyle(
//                                   color: red,
//                                   fontSize: 16.0,
//                                   fontWeight: FontWeight.w500)),
//                         ],
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         )
//     );
//   }
// }
