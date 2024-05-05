import 'dart:convert';

import 'package:choice/loan_renewal/LoanRenewalEsignBloc.dart';
import 'package:choice/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:choice/new_dashboard/NewDashboardScreen.dart';
import 'package:choice/shares/LoanApplicationBloc.dart';
import 'package:choice/shares/webviewScreen.dart';
import 'package:choice/topup/top_up_esign/TopUpEsignBloc.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Preferences.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/Utility.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/LoadingDialogWidget.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class EsignConsentScreen extends StatefulWidget {
  String loanApplicationNo;
  int fromWhichESign;
  String isComingFor;
  String totalCollateral;
  String sanctionLimit;

  @override
  State<StatefulWidget> createState() => EsignConsentScreenState();

  EsignConsentScreen(this.loanApplicationNo, this.fromWhichESign, this.isComingFor, this.totalCollateral, this.sanctionLimit);
}

class EsignConsentScreenState extends State<EsignConsentScreen> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  Preferences preferences = Preferences();
  final loanApplicationBloc = LoanApplicationBloc();
  final topUpEsignBloc = TopUpEsignBloc();
  final loanRenewalEsignBloc = LoanRenewalEsignBloc();
  String? fileId, mobile, email;

  @override
  void initState() {
    getData();
    super.initState();
  }

  getData() async {
    mobile = await preferences.getMobile();
    email = await preferences.getEmail();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorBg,
        appBar: AppBar(
          backgroundColor: colorBg,
          elevation: 0,
          leading: IconButton(
            icon: ArrowToolbarBackwardNavigation(),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text("Do you want to add E-sign?", style: boldTextStyle_18),
          centerTitle: true,
        ),
        body: ListView(
          shrinkWrap: true,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                      "By Clicking on Yes, I authorize Spark Financial Technologies Private Limited to -"),
                  SizedBox(height: 20),
                  Text(
                      "1. Use my Aadhaar / Virtual ID details (as applicable) for the purpose of digitally signing of loan documents for/with lending partner(s) of Spark Financial Technologies Private Limited and authenticate my identity through the Aadhaar Authentication system (Aadhaar based e-KYC services of UIDAI) in accordance with the provisions of the Aadhaar (Targeted Delivery of Financial and other Subsidies, Benefits and Services) Act, 2016 and the allied rules and regulations notified thereunder and for no other purpose."),
                  SizedBox(height: 10),
                  Text(
                      "2. Authenticate my Aadhaar/Virtual ID through OTP or Biometric for authenticating my identity through the Aadhaar Authentication system for obtaining my e-KYC through Aadhaar based e-KYC services of UIDAI and use my Photo and Demographic details (Name, Gender, Date of Birth and Address) for the purpose of digitally signing of loan documents for/with lending partner(s) of Spark Financial Technologies Private Limited."),
                  SizedBox(height: 10),
                  Text(
                      "3. I understand that Security and confidentiality of personal identity data provided, for the purpose of Aadhaar based authentication is ensured by NSDL e-Gov and the data will be stored by NSDL e-Gov till such time as mentioned in guidelines from UIDAI from time to time."),
                  SizedBox(height: 10),
                  Text(
                      "4. OTP will be sent to your aadhaar linked mobile number and email address."),
                  SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Container(
                          height: 50,
                          // width: 140,
                          child: Material(
                            color: appTheme,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                            elevation: 1.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              child: Text(
                                Strings.no,
                                style: buttonTextWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Container(
                          height: 50,
                          // width: 140,
                          child: Material(
                            color: appTheme,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                            ),
                            elevation: 1.0,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                              minWidth: MediaQuery.of(context).size.width,
                              onPressed: () {
                                eSignVerification();
                              },
                              child: Text(
                                Strings.yes,
                                style: buttonTextWhite,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                ],
              ),
            )
          ],
        ));
  }

  void eSignVerification() async {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    // Firebase Event
    Map<String, dynamic> parameter = new Map<String, dynamic>();
    parameter[Strings.mobile_no] = mobile;
    parameter[Strings.email] = email;
    parameter[Strings.date_time] = getCurrentDateAndTime();
    if(widget.isComingFor == Strings.pledge){
      parameter[Strings.loan_application_no_prm] = widget.loanApplicationNo;
      parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
      parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
      firebaseEvent(Strings.loan_e_sign_in_process, parameter);
    } else if(widget.isComingFor == Strings.increase_loan){
      parameter[Strings.increase_loan_application_no] = widget.loanApplicationNo;
      parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
      parameter[Strings.new_total_collateral_value] = widget.sanctionLimit;
      firebaseEvent(Strings.increase_loan_e_sign_In_Process, parameter);
    } else if(widget.isComingFor == Strings.top_up){
      parameter[Strings.top_up_application_no] = widget.loanApplicationNo;
      parameter[Strings.loan_number] = widget.totalCollateral;
      parameter[Strings.top_up_amount_prm] = widget.sanctionLimit;
      firebaseEvent(Strings.top_up_e_sign_In_Process, parameter);
    } else if(widget.isComingFor == Strings.loanRenewal){
      parameter[Strings.loan_renewal_application_no] = widget.loanApplicationNo;
      parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
      parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
      firebaseEvent(Strings.loan_renewal_e_sign_In_Process, parameter);
    }

    if (widget.fromWhichESign == 0) {
      loanApplicationBloc.esignVerification(widget.loanApplicationNo).then((value) async {
        Navigator.pop(context);
        if (value.isSuccessFull!) {
          if(value.data!.fileId != null) {
            fileId = value.data!.fileId;
            eSignProcess(value, value.data!.fileId);
          } else {
            commonDialog(context, Strings.e_sign_file_if_null, 0);
          }
        } else {
          Utility.showToastMessage(Strings.something_went_wrong);
        }
      });
    } else if(widget.fromWhichESign == 1){
      topUpEsignBloc.topUpEsignVerification(widget.loanApplicationNo).then((value) async {
        Navigator.pop(context);
        if (value.isSuccessFull!) {
          if(value.data!.fileId != null){
            eSignProcessTopUP(widget.loanApplicationNo, value.data!.esignUrl!, value.data!.fileId!);
          } else {
            commonDialog(context, Strings.e_sign_file_if_null, 0);
          }
        } else {
          // Utility.showToastMessage(value.message);
        }
      });
    } else if(widget.fromWhichESign == 2){
      loanRenewalEsignBloc.loanRenewalEsignVerification(widget.loanApplicationNo).then((value) async {
        Navigator.pop(context);
        if (value.isSuccessFull!) {
          // Utility.showToastMessage(value.message);
          eSignLoanRenewalProcess(value.data!.esignUrl!, value.data!.fileId!);
        } else {
          // Utility.showToastMessage(value.message);
        }
      });
    }
  }

  eSignProcess(value, fileId) async {
    String result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewScreenWidget(value.data.esignUrl, fileId, widget.isComingFor)));
    if (result == Strings.success) {
      esignSuccessAPI(fileId);
//      setState(() {
//        pendingEsignList.clear();
//      });
    } else if (result == Strings.fail) {
      // Firebase Event
      Map<String, dynamic> parameter = new Map<String, dynamic>();
      parameter[Strings.mobile_no] = mobile;
      parameter[Strings.email] = email;
      // parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
      // parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
      parameter[Strings.error_message] = Strings.fail;
      parameter[Strings.date_time] = getCurrentDateAndTime();
      if(widget.isComingFor == Strings.pledge){
        parameter[Strings.loan_application_no_prm] = widget.loanApplicationNo;
        parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
        parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
        firebaseEvent(Strings.loan_e_sign_failed, parameter);
      } else if(widget.isComingFor == Strings.increase_loan){
        parameter[Strings.increase_loan_application_no] = widget.loanApplicationNo;
        parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
        parameter[Strings.new_total_collateral_value] = widget.sanctionLimit;
        firebaseEvent(Strings.increase_loan_e_sign_failed, parameter);
      } else if(widget.isComingFor == Strings.top_up){
        parameter[Strings.top_up_application_no] = widget.loanApplicationNo;
        parameter[Strings.loan_number] = widget.totalCollateral;
        parameter[Strings.top_up_amount_prm] = widget.sanctionLimit;
        firebaseEvent(Strings.top_up_e_sign_failed, parameter);
      } else if(widget.isComingFor == Strings.loanRenewal){
        parameter[Strings.loan_renewal_application_no] = widget.loanApplicationNo;
        parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
        parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
        firebaseEvent(Strings.loan_renewal_e_sign_failed, parameter);
      }
      _showFailDialog(value);
    } else if (result == Strings.cancel) {
      // Firebase Event
      Map<String, dynamic> parameter = new Map<String, dynamic>();
      parameter[Strings.mobile_no] = mobile;
      parameter[Strings.email] = email;
      // parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
      // parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
      parameter[Strings.error_message] = Strings.cancel;
      parameter[Strings.date_time] = getCurrentDateAndTime();
      if(widget.isComingFor == Strings.pledge){
        parameter[Strings.loan_application_no_prm] = widget.loanApplicationNo;
        parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
        parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
        firebaseEvent(Strings.loan_e_sign_failed, parameter);
      } else if(widget.isComingFor == Strings.increase_loan){
        parameter[Strings.increase_loan_application_no] = widget.loanApplicationNo;
        parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
        parameter[Strings.new_total_collateral_value] = widget.sanctionLimit;
        firebaseEvent(Strings.increase_loan_e_sign_failed, parameter);
      } else if(widget.isComingFor == Strings.top_up){
        parameter[Strings.top_up_application_no] = widget.loanApplicationNo;
        parameter[Strings.loan_number] = widget.totalCollateral;
        parameter[Strings.top_up_amount_prm] = widget.sanctionLimit;
        firebaseEvent(Strings.top_up_e_sign_failed, parameter);
      } else if(widget.isComingFor == Strings.loanRenewal){
        parameter[Strings.loan_renewal_application_no] = widget.loanApplicationNo;
        parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
        parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
        firebaseEvent(Strings.loan_renewal_e_sign_failed, parameter);
      }
      _showCancelDialog(value);
    } else {
      // Utility.showToastMessage(value.message);
    }
  }

  eSignLoanRenewalProcess(value, fileId) async {
    String result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewScreenWidget(value, fileId, widget.isComingFor)));
    if (result == Strings.success) {
      esignLoanRenewalSuccessAPI(fileId);
//      setState(() {
//        pendingEsignList.clear();
//      });
    } else if (result == Strings.fail) {
      // Firebase Event
      Map<String, dynamic> parameter = new Map<String, dynamic>();
      parameter[Strings.mobile_no] = mobile;
      parameter[Strings.email] = email;
      // parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
      // parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
      parameter[Strings.error_message] = Strings.fail;
      parameter[Strings.date_time] = getCurrentDateAndTime();
      if(widget.isComingFor == Strings.pledge){
        parameter[Strings.loan_application_no_prm] = widget.loanApplicationNo;
        parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
        parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
        firebaseEvent(Strings.loan_e_sign_failed, parameter);
      } else if(widget.isComingFor == Strings.increase_loan){
        parameter[Strings.increase_loan_application_no] = widget.loanApplicationNo;
        parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
        parameter[Strings.new_total_collateral_value] = widget.sanctionLimit;
        firebaseEvent(Strings.increase_loan_e_sign_failed, parameter);
      } else if(widget.isComingFor == Strings.top_up){
        parameter[Strings.top_up_application_no] = widget.loanApplicationNo;
        parameter[Strings.loan_number] = widget.totalCollateral;
        parameter[Strings.top_up_amount_prm] = widget.sanctionLimit;
        firebaseEvent(Strings.top_up_e_sign_failed, parameter);
      } else if(widget.isComingFor == Strings.loanRenewal){
        parameter[Strings.loan_renewal_application_no] = widget.loanApplicationNo;
        parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
        parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
        firebaseEvent(Strings.loan_renewal_e_sign_failed, parameter);
      }
      _showFailDialog(value);
    } else if (result == Strings.cancel) {
      // Firebase Event
      Map<String, dynamic> parameter = new Map<String, dynamic>();
      parameter[Strings.mobile_no] = mobile;
      parameter[Strings.email] = email;
      // parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
      // parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
      parameter[Strings.error_message] = Strings.cancel;
      parameter[Strings.date_time] = getCurrentDateAndTime();
      if(widget.isComingFor == Strings.pledge){
        parameter[Strings.loan_application_no_prm] = widget.loanApplicationNo;
        parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
        parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
        firebaseEvent(Strings.loan_e_sign_failed, parameter);
      } else if(widget.isComingFor == Strings.increase_loan){
        parameter[Strings.increase_loan_application_no] = widget.loanApplicationNo;
        parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
        parameter[Strings.new_total_collateral_value] = widget.sanctionLimit;
        firebaseEvent(Strings.increase_loan_e_sign_failed, parameter);
      } else if(widget.isComingFor == Strings.top_up){
        parameter[Strings.top_up_application_no] = widget.loanApplicationNo;
        parameter[Strings.loan_number] = widget.totalCollateral;
        parameter[Strings.top_up_amount_prm] = widget.sanctionLimit;
        firebaseEvent(Strings.top_up_e_sign_failed, parameter);
      } else if(widget.isComingFor == Strings.loanRenewal){
        parameter[Strings.loan_renewal_application_no] = widget.loanApplicationNo;
        parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
        parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
        firebaseEvent(Strings.loan_renewal_e_sign_failed, parameter);
      }
      _showCancelDialog(value);
    } else {
      // Utility.showToastMessage(value.message);
    }
  }

  esignSuccessAPI(fileId) async {
    LoadingDialogWidget.showDialogLoading(context, "Updating...");
    loanApplicationBloc.esignSuccess(widget.loanApplicationNo, fileId).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        // parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
        // parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        if(widget.isComingFor == Strings.pledge){
          parameter[Strings.loan_application_no_prm] = widget.loanApplicationNo;
          parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
          parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
          firebaseEvent(Strings.loan_e_sign_done, parameter);
        } else if(widget.isComingFor == Strings.increase_loan){
          parameter[Strings.increase_loan_application_no] = widget.loanApplicationNo;
          parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
          parameter[Strings.new_collateral_value] = widget.sanctionLimit;
          firebaseEvent(Strings.increase_loan_e_sign_done, parameter);
        } else if(widget.isComingFor == Strings.top_up){
          parameter[Strings.top_up_application_no] = widget.loanApplicationNo;
          parameter[Strings.loan_number] = widget.totalCollateral;
          parameter[Strings.top_up_amount_prm] = widget.sanctionLimit;
          firebaseEvent(Strings.top_up_e_sign_done, parameter);
        } else if(widget.isComingFor == Strings.loanRenewal){
          parameter[Strings.loan_renewal_application_no] = widget.loanApplicationNo;
          parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
          parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
          firebaseEvent(Strings.loan_renewal_e_sign_done, parameter);
        }

//        preferences.setEsign(true);
        _showSuccessDialog(value, fileId);
//        Utility.showToastMessage(Strings.esign_successful_toast);
//         setState(() {
          // preferences.setESign(false);
//          isEsignComplete = false;
//          pendingEsignList.clear();
//         });
      } else {
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.loan_application_no_prm] = widget.loanApplicationNo;
        parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
        parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
        parameter[Strings.error_message] = value.errorMessage;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.loan_e_sign_failed, parameter);

        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  esignLoanRenewalSuccessAPI(fileId) async {
    LoadingDialogWidget.showDialogLoading(context, "Updating...");
    loanRenewalEsignBloc.esignSuccess(widget.loanApplicationNo, fileId).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        // parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
        // parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        if(widget.isComingFor == Strings.pledge){
          parameter[Strings.loan_application_no_prm] = widget.loanApplicationNo;
          parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
          parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
          firebaseEvent(Strings.loan_e_sign_done, parameter);
        } else if(widget.isComingFor == Strings.increase_loan){
          parameter[Strings.increase_loan_application_no] = widget.loanApplicationNo;
          parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
          parameter[Strings.new_collateral_value] = widget.sanctionLimit;
          firebaseEvent(Strings.increase_loan_e_sign_done, parameter);
        } else if(widget.isComingFor == Strings.top_up){
          parameter[Strings.top_up_application_no] = widget.loanApplicationNo;
          parameter[Strings.loan_number] = widget.totalCollateral;
          parameter[Strings.top_up_amount_prm] = widget.sanctionLimit;
          firebaseEvent(Strings.top_up_e_sign_done, parameter);
        } else if(widget.isComingFor == Strings.loanRenewal){
          parameter[Strings.loan_renewal_application_no] = widget.loanApplicationNo;
          parameter[Strings.existing_total_collateral_value] = widget.totalCollateral;
          parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
          firebaseEvent(Strings.loan_renewal_e_sign_done, parameter);
        }

//        preferences.setEsign(true);
        _showSuccessDialog(value, fileId);
//        Utility.showToastMessage(Strings.esign_successful_toast);
//         setState(() {
          // preferences.setESign(false);
//          isEsignComplete = false;
//          pendingEsignList.clear();
//         });
      } else {
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.loan_application_no_prm] = widget.loanApplicationNo;
        parameter[Strings.total_collateral_value_prm] = widget.totalCollateral;
        parameter[Strings.sanctioned_limit_prm] = widget.sanctionLimit;
        parameter[Strings.error_message] = value.errorMessage;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.loan_e_sign_failed, parameter);

        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  eSignProcessTopUP(String topUpApplicationName, String value, String fileId) async {
    String result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => WebViewScreenWidget(value, fileId, widget.isComingFor)));

    // Firebase Event
    Map<String, dynamic> parameter = new Map<String, dynamic>();
    parameter[Strings.mobile_no] = mobile;
    parameter[Strings.email] = email;
    parameter[Strings.date_time] = getCurrentDateAndTime();

    if (result == Strings.success) {
      topUpEsignBloc.esignSuccess(topUpApplicationName, fileId).then((value) {
        if (value.isSuccessFull!) {
          // Utility.showToastMessage(value.message);
          _showSuccessDialog(value, fileId);
        } else {
          // Utility.showToastMessage(value.message);
        }
      });
      parameter[Strings.top_up_application_no] = widget.loanApplicationNo;
      parameter[Strings.loan_number] = widget.totalCollateral;
      parameter[Strings.top_up_amount_prm] = widget.sanctionLimit;
      firebaseEvent(Strings.top_up_e_sign_done, parameter);
    } else if (result == Strings.fail) {
      parameter[Strings.error_message] = Strings.fail;
      parameter[Strings.top_up_application_no] = widget.loanApplicationNo;
      parameter[Strings.loan_number] = widget.totalCollateral;
      parameter[Strings.top_up_amount_prm] = widget.sanctionLimit;
      firebaseEvent(Strings.top_up_e_sign_failed, parameter);
      Navigator.pop(context);
      _showFailDialog(value);
    } else if (result == Strings.cancel) {
      parameter[Strings.error_message] = Strings.cancel;
      parameter[Strings.top_up_application_no] = widget.loanApplicationNo;
      parameter[Strings.loan_number] = widget.totalCollateral;
      parameter[Strings.top_up_amount_prm] = widget.sanctionLimit;
      firebaseEvent(Strings.top_up_e_sign_failed, parameter);
      Navigator.pop(context);
      _showCancelDialog(value);
    } else {
      // Utility.showToastMessage("");
    }
  }

  Future<void> _showFailDialog(value) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(
                        Icons.cancel,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(Strings.e_sign_failed, style: mediumTextStyle_16_dark),
                  ), //
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 100,
                  child: Material(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 1.0,
                    color: appTheme,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text(
                        Strings.ok,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showCancelDialog(value) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    GestureDetector(
                      child: Icon(
                        Icons.cancel,
                        color: Colors.grey,
                        size: 20,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
                  ],
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(Strings.e_sign_cancelled, style: mediumTextStyle_16_dark),
                  ), //
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 100,
                  child: Material(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 1.0,
                    color: appTheme,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      child: Text(
                        Strings.ok,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _showSuccessDialog(value, fileId) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15.0))),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: new Text(widget.fromWhichESign == 0? Strings.e_sign_successful_toast_increase_loan:Strings.e_sign_successful_toast, style: mediumTextStyle_16_dark),
                  ), //
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 40,
                  width: 100,
                  child: Material(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 1.0,
                    color: appTheme,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () async {
                        // Map<String, dynamic> cust = await preferences.getCustomer();
                        // RegisterData registerData = RegisterData.fromJson(cust);
                        // setState(() {
                          // preferences.setESign(false);
//                          registerData.pendingEsigns.clear();
//                         });
                        // printLog("esign${jsonEncode(registerData.pendingEsigns)}");
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
                      },
                      child: Text(
                        Strings.ok,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('fileId', fileId));
  }
}
