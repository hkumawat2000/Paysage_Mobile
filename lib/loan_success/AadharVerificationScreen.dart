import 'dart:async';

import 'package:choice/shares/EligibleDialog.dart';
import 'package:choice/util/AssetsImagePath.dart';
import 'package:choice/util/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_entry_text_field/pin_entry_text_field.dart';

class AadharVerificationScreen extends StatefulWidget {
  String eligibleLoan,cartName;

  @override
  AadharVerificationScreenState createState() => AadharVerificationScreenState();
  AadharVerificationScreen(this.eligibleLoan,this.cartName);
}

class AadharVerificationScreenState extends State<AadharVerificationScreen>
    with TickerProviderStateMixin {
  Timer? _timer;
  int _start = 30;
  bool retryAvailable = false;
  AnimationController? controller;
  String? otpValue;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          if (_start < 1) {
            timer.cancel();
            setState(() {
              retryAvailable = true;
            });
          } else {
            _start = _start - 1;
          }
        },
      ),
    );
  }

  String get timerString {
    Duration duration = Duration(seconds: _start);
    return '${duration.inMinutes}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
  }

  @override
  void dispose() {
    _timer!.cancel();
    controller!.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 30),
    );
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [const Color(0xFFFEFEFE), const Color(0xFFFEFEFE)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
            child: ListView(children: <Widget>[
              SizedBox(height: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.black,
                        size: 15,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      }),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "My Cart E-sign Aadhar verificaon",
                      style: TextStyle(color: appTheme, fontSize: 20,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        AssetsImagePath.aadhar_card,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("OTP has been send on your mobile number",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            )),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      alignment: Alignment.center,
                      child:Column(
                        children: <Widget>[
                          PinEntryTextField(
                            fields: 4,
                            showFieldAsBox: false,
                            onSubmit: (String otp) {}, // end onSubmit
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              _timerAndRetrySection(),
                              Text("Retry", style: TextStyle(color: appTheme),)
                            ],
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            height: 45,
                            width: 200,
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              elevation: 1.0,
                              color: appTheme,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  if(widget.eligibleLoan.length != 0) {
                                    Navigator.pop(context);
                                    Navigator.pop(context);
//                                    if(widget.eligibleLoan =="1"){
//                                      increaseLoamDialogBox(context);
//                                    }else{
                                      eligibleDialogBox(context);
//                                    }
//
//                                  }else{
//                                    Navigator.push(context, MaterialPageRoute(
//                                      builder: (BuildContext context)=> LoanSuccessScreen("123456")
//                                    ));
                                  }

                                },
                                child: Text(
                                  'Submit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ),
                  ],
                ),
              )
            ])));
  }

  Widget _timerAndRetrySection() {
    return AnimatedBuilder(
      animation: controller!,
      builder: (context, child) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // retryAvailable
            //     ?
            Text(timerString,
                style: TextStyle(color: red, fontSize: 16.0)),
            SizedBox(
              width: 20,
            ),
          ],
        );
      },
    );
  }

  eligibleDialogBox(BuildContext context) {
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return EligibleCDialog(widget.eligibleLoan,widget.cartName,"","","");
        });
  }
//  increaseLoamDialogBox(BuildContext context) {
//    return showModalBottomSheet(
//        backgroundColor: Colors.transparent,
//        context: context,
//        isScrollControlled: true,
//        builder: (BuildContext bc) {
//          return IncreaseLimitCDialog();
//        });
//  }
}
