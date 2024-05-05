import 'package:choice/authentication/Fingureprint.dart';
import 'package:choice/login/LoginValidationBloc.dart';
import 'package:choice/registration/OfflineCustomerScreen.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Preferences.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/Utility.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/welcome/NewWelcomeScreen.dart';
import 'package:choice/widgets/LoadingDialogWidget.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'RegistrationBloc.dart';

class SetPinScreen extends StatefulWidget {
  bool isForOfflineCustomer;
  int isLoanOpen;

  @override
  SetPinScreenState createState() => SetPinScreenState();

  SetPinScreen(this.isForOfflineCustomer, this.isLoanOpen);
}

class SetPinScreenState extends State<SetPinScreen> {
  final registerBloc = RegistrationBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _loginValidatorBloc = LoginValidatorBloc();
  Utility _utility = Utility();
  Preferences? preferences;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();

  TextEditingController? _confirmPinController;
  TextEditingController? pinController;

  String errorMessage = "";
  bool? isArrowVisisble;
  FocusNode confirmPinFocus = FocusNode();
  bool pinVisible = true;
  bool cnfPinVisible = true;
  final LocalAuthentication _localAuthentication = LocalAuthentication();
  bool hasFingerPrintSupport = false;

  @override
  void dispose() {
    _loginValidatorBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _getBiometricsSupport();
    super.initState();
    preferences = new Preferences();
    pinController = TextEditingController();
    _confirmPinController = TextEditingController();
  }

  Future<bool> _onBackPressed() async{
    return await showDialog(
        context: context,
        builder: (BuildContext context) {
          return onBackPressDialog(1,Strings.exit_app);
        }) ?? false;
  }


  Future<void> _getBiometricsSupport() async {
    try {
      hasFingerPrintSupport = await _localAuthentication.canCheckBiometrics;
      printLog("hasFingerPrintSupport ==> $hasFingerPrintSupport");
    } catch (e) {
      printLog(e.toString());
    }
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
      child: GestureDetector(
        child: Scaffold(
          key: _scaffoldKey,
          backgroundColor: colorBg,
          body: Container(
            child: SingleChildScrollView(
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                // autovalidate: true,
                key: _form,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 80,
                    ),
                    AppIcon(),
                    SizedBox(
                      height: 34,
                    ),
                    headingText(Strings.set_pin),
                    SizedBox(
                      height: 60,
                    ),
                    pinFeild(),
                    SizedBox(
                      height: 20,
                    ),
                    reEnterPinFeild(),
                    SizedBox(
                      height: 120,
                    ),
                    Container(
                      height: 45,
                      width: 100,
                      child: Material(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        elevation: 1.0,
                        color: appTheme,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
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
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        onTap: (){
          FocusScope.of(context).unfocus();
        },
      ),
    );
  }

  Widget pinFeild() {
    final theme = Theme.of(context);
    return StreamBuilder(
      stream: _loginValidatorBloc.pinStream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right:20),
          child: Theme(
            data: theme.copyWith(primaryColor: appTheme),
            child: TextFormField(
              obscureText: pinVisible,
              enabled: true,
              autofocus: true,
              maxLength: 4,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              controller: pinController,
              style: textFiledInputStyle,
              cursorColor: appTheme,
              onChanged: (text) {
                if (text.length == 4) {
                  FocusScope.of(context).requestFocus(confirmPinFocus);
                }
              },
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme),
                ),
                errorBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 0.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.red),
                ),
                counterText: "",
                hintText: Strings.pin,
                labelText: Strings.pin,
                hintStyle: TextStyle(color: colorGrey),
                labelStyle: TextStyle(color: appTheme),
                suffixIcon: IconButton(
                  icon: Icon(pinVisible ? Icons.visibility_off : Icons.visibility, color: appTheme),
                  onPressed: () {
                    setState(() {
                      pinVisible = !pinVisible;
                    });
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget reEnterPinFeild() {
    final theme = Theme.of(context);
    return StreamBuilder(
      stream: _loginValidatorBloc.pinStream,
      builder: (context, AsyncSnapshot<String> snapshot) {
        return Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Theme(
            data: theme.copyWith(primaryColor: appTheme),
            child: TextFormField(
              obscureText: cnfPinVisible,
              enabled: true,
              autofocus: true,
              maxLength: 4,
              keyboardType:
              TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[0-9]')),
              ],
              controller: _confirmPinController,
              focusNode: confirmPinFocus,
              validator: (val) {
                if (val!.isEmpty) {
                } else if (val != pinController!.text) return 'Pin Not Match';
                return null;
              },
              onChanged: (text) {
                if (text.length == 4) {
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              },
              cursorColor: appTheme,
              style: textFiledInputStyle,
              decoration: new InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: appTheme),
                ),
                errorBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(color: Colors.red, width: 0.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                  borderSide: BorderSide(width: 1, color: Colors.red),
                ),
                counterText: "",
                hintText: Strings.confirm_pin,
                labelText: Strings.confirm_pin,
                hintStyle: TextStyle(color: colorGrey),
                labelStyle: TextStyle(color: appTheme),
                suffixIcon: IconButton(
                  icon: Icon(cnfPinVisible ? Icons.visibility_off : Icons.visibility, color: appTheme),
                  onPressed: () {
                    setState(() {
                      cnfPinVisible = !cnfPinVisible;
                    });
                  },
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void setPin() async {
    String email = await preferences!.getEmail();
    String? mobile = await preferences!.getMobile();
    if (pinController!.text.length == 0) {
      Utility.showToastMessage(Strings.enter_pin);
    } else if (_confirmPinController!.text.length == 0) {
      Utility.showToastMessage(Strings.re_enter_pin);
    } else if (pinController!.text != _confirmPinController!.text) {
      Utility.showToastMessage(Strings.confirm_enter_pin);
    } else if (pinController!.text.length != 4 || _confirmPinController!.text.length != 4) {
      Utility.showToastMessage(Strings.pin_length);
    } else {
      LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
      registerBloc.setPin(_confirmPinController!.text).then((value) {
        Navigator.pop(context); //pop dialog
        if (value != null && value.isSuccessFull!) {
          preferences!.setPin(_confirmPinController!.text);
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.email] = email;
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.pin_set, parameter);
          if (hasFingerPrintSupport) {
            Navigator.push(context,
                MaterialPageRoute(builder: (BuildContext context) => FingureprintScreen(widget.isForOfflineCustomer, widget.isLoanOpen)));
          } else {
            if (widget.isForOfflineCustomer && widget.isLoanOpen == 0) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                  builder: (BuildContext context) => OfflineCustomerScreen()), (route) => false);
            } else {
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (BuildContext context) => RegistrationSuccessfulScreen()));
            }
          }
        } else {
          Utility.showToastMessage(value.errorMessage!);
        }
      });
    }
  }
}
