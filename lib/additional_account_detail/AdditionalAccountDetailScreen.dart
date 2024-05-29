import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/pledge_eligibility/mutual_fund/MFSchemeSelectionScreen.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import 'AdditionalAccountBloc.dart';

class AdditionalAccountDetailScreen extends StatefulWidget {

  int isSkip; //coming from : 1-On boarding, 2-Dashboard, 3-Mutual Fund, 4-Account setting
  String? loanApplicationStatus;
  String? loanName;
  String? instrumentType;

  AdditionalAccountDetailScreen(this.isSkip, this.loanApplicationStatus, this.loanName, this.instrumentType);

  @override
  _AdditionalAccountDetailScreenState createState() =>
      _AdditionalAccountDetailScreenState();
}

class _AdditionalAccountDetailScreenState
    extends State<AdditionalAccountDetailScreen> {
  TextEditingController camsEmailController = TextEditingController();
  AdditionalAccountBloc additionalAccountBloc = AdditionalAccountBloc();
  bool camsEmailValidator = true;
  bool camsEmailSyntaxValidator = true;
  bool isReadOnly = false;
  RegExp emailRegex = RegExp(RegexValidator.emailRegex);
  Preferences preferences = new Preferences();
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    // preferences.setIsVisitedCams(false);
    preferences.setOkClicked(false);
    getData();
    getFocusOfTextField();
    super.initState();
  }

  getFocusOfTextField(){
    focusNode.addListener(() {
      if(focusNode.hasFocus){
        setState(() {
          camsEmailValidator = true;
        });
      }
    });
  }

  getData() async { //fetch value for isReadOnly variable if MF loan is open or is loan application is in pending state
    String camsEmail = await preferences.getCamsEmail();
    camsEmailController.text = camsEmail.toString();

    if(widget.loanApplicationStatus.toString().isNotEmpty){
      if(widget.instrumentType == Strings.mutual_fund
          && (widget.loanApplicationStatus.toString() == "Approved"
              || widget.loanApplicationStatus.toString() == "Pending")){
        setState(() {
          isReadOnly = true;
        });
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async {
          if(widget.isSkip == 2){
            return false;
          }else{
            // commonDialog(context, "If you skip you'll redirected to dashboard", 5);
            return true;
          }
        },
        child: Scaffold(
          backgroundColor: colorBg,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: colorBg,
            leading: widget.isSkip == 4 || widget.isSkip == 3 ? IconButton(
              icon: ArrowToolbarBackwardNavigation(),
              onPressed: () {
                Navigator.pop(context);
              },
            ) : Container(),
            actions: [
              widget.isSkip == 4 || widget.isSkip == 3 ? Container() : Material(
                child: MaterialButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DashBoard()));
                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                  elevation: 1.0,
                  child: Text("Skip", style: TextStyle(color: appTheme, fontSize: 17)),
                ),
              )
            ],
          ),
          body: Theme(
            data: theme.copyWith(primaryColor: appTheme),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Align(
                  alignment: Alignment.center,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 8),
                      subHeadingText(Strings.additional_account_detail_2),
                      SizedBox(height: 30),
                      TextField(
                        controller: camsEmailController,
                        keyboardType: TextInputType.emailAddress,
                        readOnly: isReadOnly,
                        focusNode: focusNode,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9-.@_]')),
                        ],
                        decoration: new InputDecoration(
                          counterText: "",
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: new OutlineInputBorder(
                              borderSide: new BorderSide(color: appTheme)),
                          errorBorder: new OutlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.red, width: 0.0),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            borderSide: BorderSide(
                              width: 1,
                              color: Colors.red,
                            ),
                          ),
                          hintStyle: TextStyle(color: colorGrey),
                          labelStyle: TextStyle(color: appTheme),
                          hintText: Strings.cams_email,
                          labelText: Strings.cams_email,
                          errorText: camsEmailValidator
                              ? null
                              : Strings.enter_email,
                        ),
                        onChanged: (value) {
                          setState(() {
                            if (camsEmailController.text.isNotEmpty) {
                              camsEmailValidator = true;
                            } else {
                              camsEmailValidator = false;
                            }
                          });
                        },
                        onTap: (){
                          if(isReadOnly){
                            if(widget.loanApplicationStatus == "Approved") {
                              Utility.showToastMessage("Your loan account ${widget.loanName} is active");
                            }else if(widget.loanApplicationStatus == "Pending"){
                              Utility.showToastMessage("You have a pending loan application");
                            }
                          }
                        },
                      ),
                      SizedBox(height: 25),
                      RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: Strings.note,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 15)),
                          TextSpan(
                            text: Strings.mandatory_note_for_cams1,
                            style: regularTextStyle_14_gray_dark,
                          ),
                          TextSpan(
                              text: Strings.mandatory_note_for_cams2,
                              style: regularTextStyle_14_blue,
                              recognizer: TapGestureRecognizer()
                                ..onTap = () async {
                                  if (await canLaunch(
                                          "https://mycams.camsonline.com/") ==
                                      true) {
                                    launch("https://mycams.camsonline.com/");
                                  } else {
                                    printLog(Strings.cant_launch_url);
                                  }
                                }),
                          TextSpan(
                            text: Strings.mandatory_note_for_cams3,
                            style: regularTextStyle_14_gray_dark,
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: 60,
                      ),
                      Center(
                        child: AbsorbPointer(
                          absorbing:
                          !isReadOnly ? camsEmailValidator ? false : true : true,
                          child: Container(
                            height: 45,
                            width: 100,
                            child: Material(
                              color: !isReadOnly ? camsEmailValidator ? appTheme : colorLightGray : colorLightGray,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(45)),
                              elevation: 1.0,
                              child: MaterialButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(45)),
                                onPressed: () {
                                  setState(() {
                                    if (emailRegex.hasMatch(camsEmailController.text)) {
                                      additionalAccountAPI(camsEmailController.text);
                                    } else {
                                      //camsEmailSyntaxValidator = false;
                                      Utility.showToastMessage(
                                          Strings.message_valid_mail);
                                    }
                                  });
                                },
                                child: Text(
                                  Strings.submit,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void additionalAccountAPI(String emailID) {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        additionalAccountBloc.camsAccountAPI(emailID).then((value) {
          Navigator.pop(context);
          if (value.isSuccessFull!) {
            preferences.setCamsEmail(emailID);
            Utility.showToastMessage("Verified successfully");
            if(widget.isSkip == 1 || widget.isSkip == 2){
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DashBoard()));
            } else if(widget.isSkip == 3) {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MFSchemeSelectionScreen()));
            }else if(widget.isSkip == 4){
              Navigator.pop(context);
            }
          } else if (value.errorCode == 403) {
            commonDialog(context, Strings.session_timeout, 4);
          } else {
            Utility.showToastMessage(value.errorMessage!);
          }
        });
      }else {
        Navigator.pop(context);
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }
}
