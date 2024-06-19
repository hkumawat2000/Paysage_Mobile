import 'package:lms/network/requestbean/TermsConditionRequestBean.dart';
import 'package:lms/network/responsebean/TermsConditionResponse.dart';
import 'package:lms/shares/EligibleDialog.dart';
import 'package:lms/shares/LoanApplicationBloc.dart';
import 'package:lms/shares/LoanOTPVerification.dart';
import 'package:lms/terms_conditions/TnCBloc.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/ErrorMessageWidget.dart';
import 'package:lms/widgets/LoadingWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lms/terms_conditions/TermsConditionWebView.dart';

class TermsConditionsScreen extends StatefulWidget {
  String eligibleLoan, cartName, stockAt, isComingFor;
  String? loanRenewalName;
  String? loanType;

  @override
  _TermsConditionsScreenState createState() => _TermsConditionsScreenState();

  TermsConditionsScreen(this.eligibleLoan, this.cartName, this.stockAt, this.isComingFor, this.loanRenewalName, this.loanType);
}

class _TermsConditionsScreenState extends State<TermsConditionsScreen> {
  final _tncBloc = TnCBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAcceptTnC = false;
  List<bool> checkBoxValue = [];
  TermsConditionResponse? termsConditionResponse;
  final loanApplicationBloc = LoanApplicationBloc();
  @override
  void dispose() {
    _tncBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    if(widget.isComingFor == Strings.loanRenewal){
      _tncBloc.saveTnCList(TermsConditionRequestBean(cartName: "", loanName: "", loanRenewalName: widget.loanRenewalName, topupAmount: 0.0)).then((value) {
        if (!value.isSuccessFull!) {
          if (value.errorCode == 403) {
            commonDialog(context, Strings.session_timeout, 4);
          }
        }
      });
    }else {
      _tncBloc.saveTnCList(TermsConditionRequestBean(cartName: widget.cartName,loanName: "", loanRenewalName: "", topupAmount: 0.0)).then((value) {
        if (!value.isSuccessFull!) {
          if (value.errorCode == 403) {
            commonDialog(context, Strings.session_timeout, 4);
          }
        }
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorBg,
        body: SafeArea(child: getTnCList()));
  }

  Widget appBar(AsyncSnapshot<TermsConditionResponse> snapshot){
    return AppBar(
      backgroundColor: colorBg,
      elevation: 0,
      leading: IconButton(
        icon: ArrowToolbarBackwardNavigation(),
        onPressed: () {
          Utility.isNetworkConnection().then((isNetwork) {
            if (isNetwork) {
              Navigator.pop(context);
            } else {
              Utility.showToastMessage(Strings.no_internet_message);
            }
          });
        },
      ),
      title: Text("Terms and Conditions", style: boldTextStyle_18),
      actions: [
        IconButton(
          icon: Image.asset(AssetsImagePath.pdf, height: 30, width: 30),
          onPressed: () {
            Utility.isNetworkConnection().then((isNetwork) {
              if (isNetwork) {
                _launchURL(snapshot.data!.termsConditionData!.tncFile!);
              } else {
                Utility.showToastMessage(Strings.no_internet_message);
              }
            });
          },
        ),
      ],
      centerTitle: true,
    );
  }

  void _launchURL(_url) async =>
      await canLaunch(_url) ? await launch(_url) : throw 'Could not launch $_url';

  Widget getTnCList() {
    return StreamBuilder(
      stream: _tncBloc.tncData,
      builder: (context, AsyncSnapshot<TermsConditionResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return _buildNoDataWidget();
          } else {
            return termsConditionWidget(snapshot);
          }
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error.toString());
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget termsConditionWidget(AsyncSnapshot<TermsConditionResponse> snapshot) {
    for(int i=0; i<snapshot.data!.termsConditionData!.tncCheckboxes!.length; i++){
      if(checkBoxValue.length != snapshot.data!.termsConditionData!.tncCheckboxes!.length){
        checkBoxValue.add(false);
      }
    }
    return ListView(
      shrinkWrap: true,
      children: <Widget>[
        appBar(snapshot),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
          child: Column(
            children: [
              Html(
                data: snapshot.data!.termsConditionData!.tncHtml,
              ),
              SizedBox(height: 10),
              Html(
                  data: snapshot.data!.termsConditionData!.tncHeader,
                  onLinkTap: (url, attributes, element) =>
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => TermsConditionWebView(
                                      url!,
                                      false,
                                      Strings.terms_and_condition)));
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      })),
              SizedBox(height: 10),
              ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data!.termsConditionData!.tncCheckboxes!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Row(
                      children: [
                        Checkbox(
                            value: checkBoxValue[index],
                            activeColor: appTheme,
                            onChanged: (bool? newValue) {
                              setState(() {
                                checkBoxValue[index] = newValue!;
                              });
                            },
                        ),
                        Expanded(
                          child: Html(
                            data: snapshot.data!.termsConditionData!.tncCheckboxes![index],
                          ),
                        ),
                      ],
                    );
                  },
              ),
              SizedBox(height: 10),
              Html(
                data: snapshot.data!.termsConditionData!.tncFooter,
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 45,
                    width: 100,
                    child: Material(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      elevation: 1.0,
                      color: checkBoxValue.contains(false) ? colorGrey : appTheme,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          Preferences preferences = Preferences();
                          String? mobile = await preferences.getMobile();
                          String? email = await preferences.getEmail();
                          if (checkBoxValue.contains(false)) {
                            Utility.showToastMessage(Strings.valid_terms);
                          } else {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                Navigator.pop(context);
                                // Firebase Event
                                Map<String, dynamic> parameter = new Map<String, dynamic>();
                                parameter[Strings.mobile_no] = mobile;
                                parameter[Strings.email] = email;
                                parameter[Strings.cart_name] = widget.cartName;
                                parameter[Strings.demat_ac_no] = widget.stockAt;
                                parameter[Strings.eligible_loan_prm] = widget.eligibleLoan;
                                parameter[Strings.date_time] = getCurrentDateAndTime();
                                if(widget.isComingFor == Strings.loan) {
                                  firebaseEvent(Strings.accept_tnc, parameter);
                                } else if(widget.isComingFor == Strings.increase_loan || widget.isComingFor == Strings.mf_increase_loan) {
                                  firebaseEvent(Strings.increase_loan_accept_tnc, parameter);
                                }else if(widget.isComingFor == Strings.loanRenewal) {
                                  firebaseEvent(Strings.loan_renewal_accept_tnc, parameter);
                                }
                                if(widget.isComingFor == Strings.loanRenewal){
                                  loanRenewalOTP();
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext bc) {
                                        return LoanOTPVerification(widget.cartName,"file id", widget.stockAt, widget.isComingFor, widget.loanRenewalName, widget.isComingFor);
                                      });
                                }else{
                                  showModalBottomSheet(
                                      backgroundColor: Colors.transparent,
                                      context: context,
                                      isScrollControlled: true,
                                      builder: (BuildContext context) {
                                        return EligibleCDialog(widget.eligibleLoan.toString(),
                                            widget.cartName, "fileId", widget.stockAt, widget.isComingFor);
                                      });
                                }
                              } else {
                                Utility.showToastMessage(Strings.no_internet_message);
                                // Navigator.pop(context);
                              }
                            });
                          }
                        },
                        child: Text(
                          Strings.accept,
                          style: TextStyle(color: colorWhite, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 14),
            ],
          ),
        )
      ],
    );
  }

  Widget tncConditionList(List<String> _conditions) {
    return ListView.builder(
        itemCount: _conditions.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return CheckboxListTile(
            controlAffinity: ListTileControlAffinity.leading,
            checkColor: Colors.white,
            activeColor: appTheme,
            title: Text(_conditions[index]),
            value: true,
            onChanged: (val) {
              setState(() {});
            },
          );
        });
  }

  void showErrorMessage(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  Widget _buildLoadingWidget() {
    return LoadingWidget();
  }

  Widget _buildErrorWidget(String error) {
    return ErrorMessageWidget(error: error);
  }

  Widget _buildNoDataWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("No data found"),
        ],
      ),
    );
  }

  void loanRenewalOTP() async {
    Preferences preferences = Preferences();
    String? mobile = await preferences.getMobile();
    String? email = await preferences.getEmail();

    loanApplicationBloc.loanRenewalOTP(widget.loanRenewalName).then((value){
      if(value.isSuccessFull!){
        Utility.showToastMessage(Strings.success_otp_sent);
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.cart_name] = widget.cartName;
        parameter[Strings.demat_ac_no] = widget.stockAt;
        parameter[Strings.eligible_loan_prm] = widget.eligibleLoan;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        if(widget.isComingFor == Strings.loan) {
          firebaseEvent(Strings.pledge_otp_sent, parameter);
        } else if(widget.isComingFor == Strings.increase_loan) {
          firebaseEvent(Strings.increase_loan_otp_sent, parameter);
        }else if(widget.isComingFor == Strings.loanRenewal) {
          firebaseEvent(Strings.loan_renewal_otp_sent, parameter);
        }

      } else if (value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else{
        showErrorMessage(value.errorMessage!);
      }
    });
  }

}
