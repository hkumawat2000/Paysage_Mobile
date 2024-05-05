import 'package:choice/forgot_pin/ForgotPinBloc.dart';
import 'package:choice/network/requestbean/ForgotPinRequestBean.dart';
import 'package:choice/util/AssetsImagePath.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Preferences.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/Utility.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/LoadingDialogWidget.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sms_autofill/sms_autofill.dart';

class ForgotPinScreen extends StatefulWidget {
  @override
  _ForgotPinScreenState createState() => _ForgotPinScreenState();
}

class _ForgotPinScreenState extends State<ForgotPinScreen> with CodeAutoFill{

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController newPinController = TextEditingController();
  TextEditingController receivePinController = TextEditingController();
  Preferences? preferences = new Preferences();
  bool receivePinVisible = true;
  bool newPinVisible = true;
  FocusNode newPinFocus = FocusNode();
  final forgotPinBloc = ForgotPinBloc();
  String? email, mobile;
  String signature = "";


  @override
  void dispose() {
    SmsAutoFill().unregisterListener();
    super.dispose();
    cancel();
  }

  @override
  void initState() {
    listenForCode();
    autoFetch();
    super.initState();
  }

  @override
  void codeUpdated() {
    if(RegExp(r'^[0-9]+$').hasMatch(code!)){
      receivePinController.text = code ?? "";
    }
  }

  void autoFetch() async {
    email = await preferences!.getEmail();
    mobile = await preferences!.getMobile();
    printLog('=====EMAIL===== > $email');
    if(email!.isNotEmpty) {
      requestForOTP();
    } else {
      printLog('EMAIL not found');
      commonDialog(context, Strings.something_went_wrong_try, 3);
    }
  }

  requestForOTP() {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    forgotPinBloc.forgotOtpRequest(email!).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        showSnackBarWithMessage(_scaffoldKey, Strings.forgot_pin_toast);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorBg,
        resizeToAvoidBottomInset: true,
        appBar: buildAppBar(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 30,
                ),
                AppIcon(),
                SizedBox(
                  height: 30,
                ),
                headingText(Strings.forgot_pin),
                SizedBox(
                  height: 65,
                ),
                receivePinField(), //OTP field
                SizedBox(
                  height: 20,
                ),
                newPinField(), //New pin field
                SizedBox(
                  height: 30,
                ),
                doNotReceive(),
                SizedBox(
                  height: 40,
                ),
                submit(),
                SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget buildAppBar(BuildContext context) {
    return new AppBar(
      elevation: 0.0,
      centerTitle: true,
      backgroundColor: colorBg,
      leading: IconButton(
        icon: ArrowToolbarBackwardNavigation(),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget header(){
    return Container(
        height: 150,
        width: double.infinity,
        decoration: BoxDecoration(
          color: appTheme2,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20.0), bottomRight: Radius.circular(20.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 140,
              height: 140,
              child: Image.asset(
                AssetsImagePath.spark_loan_logo,
              ),
            ),
          ],
        )
    );
  }

  Widget receivePinField() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextFormField(
          obscureText: receivePinVisible,
          enabled: true,
          autofocus: true,
          maxLength: 4,
          keyboardType:
          TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
          ],
          controller: receivePinController,
          style: textFiledInputStyle,
          cursorColor: appTheme,
          onChanged: (text) {
            if (text.length == 4) {
              FocusScope.of(context).requestFocus(newPinFocus);
            }
          },
          decoration: InputDecoration(
            counterText: "",
            hintText: Strings.received_otp,
            hintStyle: textFiledHintStyle,
            suffixIcon: IconButton(
              icon: Icon(
                receivePinVisible ? Icons.visibility_off : Icons.visibility,
                color: appTheme,
              ),
              onPressed: () {
                setState(() {
                  receivePinVisible = !receivePinVisible;
                });
              },
            ),
            enabledBorder: new UnderlineInputBorder(
              borderSide: BorderSide(
                color: appTheme,
                width: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget newPinField() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextFormField(
          obscureText: newPinVisible,
          enabled: true,
          autofocus: true,
          maxLength: 4,
          keyboardType:
          TextInputType.numberWithOptions(
              decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(
                RegExp('[0-9]')),
          ],
          onChanged: (text) {
            if (text.length == 4) {
              FocusScope.of(context).requestFocus(FocusNode());
            }
          },
          controller: newPinController,
          focusNode: newPinFocus,
          cursorColor: appTheme,
          style: textFiledInputStyle,
          decoration: new InputDecoration(
            counterText: "",
            hintText: Strings.create_new_pin,
            hintStyle: textFiledHintStyle,
            suffixIcon: IconButton(
              icon: Icon(
                newPinVisible ? Icons.visibility_off : Icons.visibility,
                color: appTheme,
              ),
              onPressed: () {
                setState(() {
                  newPinVisible = !newPinVisible;
                });
              },
            ),
            enabledBorder: new UnderlineInputBorder(
              borderSide: BorderSide(
                color: appTheme,
                width: 0.5,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget doNotReceive(){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(Strings.not_receive_pin),
        GestureDetector(
          child: Text(Strings.click_here,
              style: TextStyle(color: Colors.blue, fontWeight: FontWeight.w600)),
          onTap: (){
            Utility.isNetworkConnection().then((isNetwork) {
              if (isNetwork) {
                autoFetch();
                listenForCode();
                // requestForOTP();
              } else {
                Utility.showToastMessage(Strings.no_internet_message);
              }
            });
          },
        ),
      ],
    );
  }

  Widget submit(){
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          height: 45,
          width: 100,
          child: Material(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            elevation: 1.0,
            color: appTheme,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () async {
                Utility.isNetworkConnection().then((isNetwork) {
                  if (isNetwork) {
                    setPin();
                  } else {
                    Utility.showToastMessage(Strings.no_internet_message);
                  }
                });
              },
              child: ArrowForwardNavigation(),
            ),
          ),
        ),
      ],
    );
  }

  void setPin() {
    if (receivePinController.text.trim().length <= 3) {
      Utility.showToastMessage(Strings.invalid_received_pin);
    } else if (newPinController.text.trim().length <= 3) {
      Utility.showToastMessage(Strings.invalid_new_pin);
    } else {
      LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
      ForgotPinRequestBean forgotPinRequestBean = new ForgotPinRequestBean(
        email: email!,
        otp: receivePinController.text.toString(),
        newPin: newPinController.text.toString(),
        retypePin: newPinController.text.toString()
      );
      forgotPinBloc.forgotPin(forgotPinRequestBean).then((value) {
        Navigator.pop(context);
        if (value.isSuccessFull!) {
          preferences!.setPin(newPinController.text);
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.forgot_pin_success, parameter);

          Utility.showToastMessage(value.message!);
          Navigator.pop(context);
        } else {
          receivePinController.clear();
          Utility.showToastMessage(value.errorMessage!);
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.error_message] = value.errorMessage;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.forgot_pin_failed, parameter);
        }
      });
    }
  }
}
