import 'package:lms/account_setting//AccountSettingBloc.dart';
import 'package:lms/network/requestbean/UpdateProfileAndPinRequestBean.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _accountSettingBloc = AccountSettingBloc();
  TextEditingController currentPin = TextEditingController();
  TextEditingController newPin = TextEditingController();
  TextEditingController reTypePin = TextEditingController();
  bool _currentPasswordVisible = true;
  bool _newPasswordVisible = true;
  bool _reTypePasswordVisible = true;
  FocusNode currentPinFocus = FocusNode();
  FocusNode newPinFocus = FocusNode();
  FocusNode confirmPinFocus = FocusNode();
  Preferences preferences = Preferences();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: new Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: AnimatedPadding(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding:
          EdgeInsets.only(
              bottom: (
                  MediaQuery.of(context).viewInsets.bottom -
                      (MediaQuery.of(context).viewInsets.bottom * 0.3)
              )
          ),
          child: Container(
            height: (MediaQuery.of(context).size.height) - (300),
            width: double.infinity,
            decoration: new BoxDecoration(
              color: colorWhite,
              borderRadius: new BorderRadius.only(
                topLeft: const Radius.circular(20.0),
                topRight: const Radius.circular(20.0),
              ),
            ),
            child: ChangePasswordDialog(),
          ),
        ),
      ),
    );
  }

  Widget ChangePasswordDialog() {
    final theme = Theme.of(context);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            GestureDetector(
              child: Container(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.cancel_outlined,
                  color: colorGrey,
                  size: 26,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Text(
              Strings.change_password,
              style: TextStyle(
                fontSize: 20,
                color: red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 24),
            Theme(
              data: theme.copyWith(primaryColor: appTheme),
              child: TextFormField(
                decoration: InputDecoration(
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appTheme,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorBlack,
                    ),
                  ),
                  labelText: Strings.current_password,
                  labelStyle: TextStyle(
                      color: currentPinFocus.hasFocus ? appTheme : colorLightGray,
                  ),
                  hintText: Strings.current_password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _currentPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: appTheme,
                    ),
                    onPressed: () {
                      setState(() {
                        _currentPasswordVisible = !_currentPasswordVisible;
                      });
                    },
                  ),
                ),
                enabled: true,
                maxLength: 4,
                keyboardType:
                TextInputType.numberWithOptions(
                    decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp('[0-9]')),
                ],
                focusNode: currentPinFocus,
                controller: currentPin,
                obscureText: _currentPasswordVisible,
                obscuringCharacter: '*',
                style: TextStyle(fontWeight: FontWeight.w600),
                onChanged: (text) {
                  if (text.length == 4) {
                    FocusScope.of(context).requestFocus(newPinFocus);
                  }
                },
              ),
            ),
            SizedBox(height: 10),
            Theme(
              data: theme.copyWith(primaryColor: appTheme),
              child: TextFormField(
                decoration: InputDecoration(
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appTheme,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorBlack,
                    ),
                  ),
                  labelText: Strings.new_password,
                  labelStyle: TextStyle(
                    color: newPinFocus.hasFocus ? appTheme : colorLightGray,
                  ),
                  hintText: Strings.new_password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _newPasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: appTheme,
                    ),
                    onPressed: () {
                      setState(() {
                        _newPasswordVisible = !_newPasswordVisible;
                      });
                    },
                  ),
                ),
                enabled: true,
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
                    FocusScope.of(context).requestFocus(confirmPinFocus);
                  }
                },
                focusNode: newPinFocus,
                controller: newPin,
                obscureText: _newPasswordVisible,
                obscuringCharacter: '*',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 10),
            Theme(
              data: theme.copyWith(primaryColor: appTheme),
              child: TextFormField(
                decoration: InputDecoration(
                  counterText: "",
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: appTheme,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: colorBlack,
                    ),
                  ),
                  labelText: Strings.retype_password,
                  labelStyle: TextStyle(
                    color: confirmPinFocus.hasFocus ? appTheme : colorLightGray,
                  ),
                  hintText: Strings.retype_password,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _reTypePasswordVisible
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: appTheme,
                    ),
                    onPressed: () {
                      setState(() {
                        _reTypePasswordVisible = !_reTypePasswordVisible;
                      });
                    },
                  ),
                ),
                focusNode: confirmPinFocus,
                enabled: true,
                maxLength: 4,
                keyboardType:
                TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                ],
                validator: (val) {
                  if (val!.isEmpty) {
                  } else if (val != newPin.text) return 'Pin Not Match';
                  return null;
                },
                onChanged: (text) {
                  if (text.length == 4) {
                    FocusScope.of(context).unfocus();
                  }
                },
                controller: reTypePin,
                obscureText: _reTypePasswordVisible,
                obscuringCharacter: '*',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            SizedBox(height: 40),
            Center(
              child: GestureDetector(
                child: Image(image: AssetImage(AssetsImagePath.change_pin_submit_icon)),
                // Card(
                //   elevation: 6.0,
                //   color: colorGreen,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.all(Radius.circular(50)),
                //   ),
                //   child: Padding(
                //     padding: const EdgeInsets.all(12.0),
                //     child: Image(image: AssetImage(AssetsImagePath.change_pin_submit_icon)),
                //   ),
                // ),
                onTap: () async {
                  String email = await preferences.getEmail();
                  String? mobile = await preferences.getMobile();
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      if(currentPin.text.length < 4){
                        commonDialog(context, 'Please enter valid current pin', 0);
                      } else if(newPin.text.length < 4){
                        commonDialog(context, 'Please enter valid new pin', 0);
                      } else if(reTypePin.text.length < 4) {
                        commonDialog(context, 'Please enter valid retype pin', 0);
                      }
                      else {
                        LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
                        UpdateProfileAndPinRequestBean updateProfileAndPinRequestBean = new UpdateProfileAndPinRequestBean(
                            isForUpdatePin: 1,
                            oldPin: currentPin.text.trim().toString(),
                            newPin: newPin.text.trim().toString(),
                            retypePin: reTypePin.text.trim().toString(),
                            isForProfilePic: 0,
                            image: ""
                        );
                        // Call API on submit to store the pin in the backend
                        _accountSettingBloc.setProfileAndPin(updateProfileAndPinRequestBean).then((value) {
                          Navigator.pop(context);
                          if(value.isSuccessFull!){
                            preferences.setPin(newPin.text.trim().toString());
                            // Firebase Event
                            Map<String, dynamic> parameters = new Map<String, dynamic>();
                            parameters[Strings.mobile_no] = mobile;
                            parameters[Strings.email] = email;
                            parameters[Strings.date_time] = getCurrentDateAndTime();
                            firebaseEvent(Strings.change_pin, parameters);
                            commonDialog(context, value.message, 3);
                          } else if(value.errorCode == 403){
                            commonDialog(context, Strings.session_timeout, 4);
                          } else {
                            // Firebase Event
                            Map<String, dynamic> parameters = new Map<String, dynamic>();
                            parameters[Strings.mobile_no] = mobile;
                            parameters[Strings.email] = email;
                            parameters[Strings.error_message] = value.errorMessage;
                            parameters[Strings.date_time] = getCurrentDateAndTime();
                            firebaseEvent(Strings.change_pin_failed, parameters);
                            commonDialog(context, value.errorMessage , 0);
                          }
                        });
                      }
                    } else {
                      Utility.showToastMessage(Strings.no_internet_message);
                    }
                  });
                },
              ),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

class ManageTouchID extends StatefulWidget {
  @override
  _ManageTouchIDState createState() => _ManageTouchIDState();
}

class _ManageTouchIDState extends State<ManageTouchID> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.transparent,
      bottomNavigationBar: AnimatedPadding(
        duration: Duration(milliseconds: 150),
        curve: Curves.easeOut,
        padding: EdgeInsets.all(0),
        child: Container(
          height: (MediaQuery.of(context).size.height) - (300),
          width: double.infinity,
          decoration: new BoxDecoration(
            color: colorWhite,
            borderRadius: new BorderRadius.only(
              topLeft: const Radius.circular(20.0),
              topRight: const Radius.circular(20.0),
            ),
          ),
          child: ManageTouchIdDialog(),
        ),
      ),
    );
  }

  Widget ManageTouchIdDialog() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            GestureDetector(
              child: Container(
                alignment: Alignment.topRight,
                child: Icon(
                  Icons.cancel_outlined,
                  color: colorGrey,
                  size: 26,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            Text(
              Strings.manage_touch_id,
              style: TextStyle(
                fontSize: 20,
                color: red,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              Strings.manage_touch_id_text,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              Strings.manage_touch_id_text2,
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: Strings.your_password,
                hintText: Strings.your_password,
              ),
            ),
            SizedBox(height: 150),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(60)),
                  border: Border.all(color: colorGreen),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Icon(Icons.done_outline_outlined,
                      color: colorGreen, size: 30),
                ),
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
