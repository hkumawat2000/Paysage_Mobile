import 'package:choice/network/requestbean/TopUpRequest.dart';
import 'package:choice/network/responsebean/TermsConditionResponse.dart';
import 'package:choice/new_dashboard/NewDashboardScreen.dart';
import 'package:choice/shares/webviewScreen.dart';
import 'package:choice/topup/top_up_esign/TopUpEsignBloc.dart';
import 'package:choice/topup/top_up_loan//TopUpBloc.dart';
import 'package:choice/topup/top_up_terms_conditions/TopUpTermsConditionsBloc.dart';
import 'package:choice/util/AssetsImagePath.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Preferences.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/Utility.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/widgets/ErrorMessageWidget.dart';
import 'package:choice/widgets/LoadingDialogWidget.dart';
import 'package:choice/widgets/LoadingWidget.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:choice/terms_conditions/TermsConditionWebView.dart';

class TopUpTermsConditionsScreen extends StatefulWidget {
  final loanName, topAmount;

  TopUpTermsConditionsScreen(this.loanName, this.topAmount);

  @override
  TopUpTermsConditionsScreenState createState() => TopUpTermsConditionsScreenState();
}

class TopUpTermsConditionsScreenState extends State<TopUpTermsConditionsScreen> {
  final topUpBloc = TopUpBloc();
  final topUpTermsConditionsBloc = TopUpTermsConditionsBloc();
  final topUpEsignBloc = TopUpEsignBloc();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isAcceptTnC = false;
  List<bool> checkBoxValue = [];
  TermsConditionResponse? termsConditionResponse;
  var fileId;

  @override
  void dispose() {
    topUpTermsConditionsBloc.dispose();
    super.dispose();
  }

  @override
  void initState() {
    topUpTermsConditionsBloc.getTopUpTermsCondition(widget.loanName, widget.topAmount);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: colorBg,
        body: getTnCList());
  }

  Widget appBar(AsyncSnapshot<TermsConditionResponse> snapshot) {
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
                _launchURL(snapshot.data!.termsConditionData!.tncFile);
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

  _launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Widget getTnCList() {
    return StreamBuilder(
      stream: topUpTermsConditionsBloc.tncData,
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
    return SingleChildScrollView(
      child: Column(
        // shrinkWrap: true,
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
                    onLinkTap: (url, _, __, ___) {
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          printLog("URL ==> $url");
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => TermsConditionWebView(url!, false, Strings.terms_and_condition)));
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    }),
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
                            if (checkBoxValue.contains(false)) {
                              Utility.showToastMessage(Strings.valid_terms);
                            } else {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  submitTopUp();
                                } else {
                                  Utility.showToastMessage(Strings.no_internet_message);
                                  Navigator.pop(context);
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
                SizedBox(height: 20),
              ],
            ),
          )
        ],
      ),
    );
  }

  void submitTopUp() async {
    Preferences preferences = Preferences();
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();

    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    TopUpRequest topUpRequest = TopUpRequest(loanName: widget.loanName, topupAmount: widget.topAmount);
    topUpBloc.submitTopUp(topUpRequest).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {

        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.loan_number] = widget.loanName;
        parameter[Strings.top_up_application] = value.topUpData!.topupApplicationName;
        parameter[Strings.top_up_amount_prm] = widget.topAmount;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.top_up_application_created, parameter);

        eSignVerification(value.topUpData!.topupApplicationName!);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
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

  void eSignVerification(String topUpApplicationName) {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    topUpEsignBloc.topUpEsignVerification(topUpApplicationName).then((value) async {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        if(value.data!.fileId != null) {
          eSignProcess(topUpApplicationName, value.data!.esignUrl!, value.data!.fileId!);
        } else {
          Utility.showToastMessage(Strings.top_up_e_sign_file_if_null);
          Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => DashBoard()));
        }
      } else {
        Utility.showToastMessage(value.message!);
      }
    });
  }

  eSignProcess(String topUpApplicationName, String value, String fileId) async {
    Preferences preferences = Preferences();
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();

    String result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => WebViewScreenWidget(value, fileId, Strings.top_up)));

    // Firebase Event
    Map<String, dynamic> parameter = new Map<String, dynamic>();
    parameter[Strings.mobile_no] = mobile;
    parameter[Strings.email] = email;
    parameter[Strings.date_time] = getCurrentDateAndTime();

    if (result == Strings.success) {
      topUpEsignBloc.esignSuccess(topUpApplicationName, fileId).then((value) {
        if (value.isSuccessFull!) {
        } else {
          Utility.showToastMessage(value.message!);
        }
      });
      Navigator.pop(context);
      parameter[Strings.top_up_application_no] = topUpApplicationName;
      parameter[Strings.loan_number] = widget.loanName;
      parameter[Strings.top_up_amount_prm] = widget.topAmount;
      firebaseEvent(Strings.top_up_e_sign_done, parameter);
      _showSuccessDialog(value, fileId);
    } else if (result == Strings.fail) {
      Navigator.pop(context);
      parameter[Strings.error_message] = Strings.fail;
      parameter[Strings.top_up_application_no] = topUpApplicationName;
      parameter[Strings.loan_number] = widget.loanName;
      parameter[Strings.top_up_amount_prm] = widget.topAmount;
      firebaseEvent(Strings.top_up_e_sign_failed, parameter);
      _showFailDialog(topUpApplicationName, value, fileId);
    } else if (result == Strings.cancel) {
      Navigator.pop(context);
      parameter[Strings.error_message] = Strings.cancel;
      parameter[Strings.top_up_application_no] = topUpApplicationName;
      parameter[Strings.loan_number] = widget.loanName;
      parameter[Strings.top_up_amount_prm] = widget.topAmount;
      firebaseEvent(Strings.top_up_e_sign_failed, parameter);
      _showCancelDialog(topUpApplicationName, value, fileId);
    }
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
                    child: new Text(Strings.e_sign_successful_toast,
                        style: TextStyle(fontSize: 16.0, color: colorDarkGray)),
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

  Future<void> _showCancelDialog(topUpApplicationName, value, fileId) async {
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
                    child: new Text(Strings.e_sign_cancelled,
                        style: TextStyle(fontSize: 16.0, color: colorDarkGray)),
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

  Future<void> _showFailDialog(topUpApplicationName, value, fileId) async {
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
                    child: new Text(Strings.e_sign_failed,
                        style: TextStyle(fontSize: 16.0, color: colorDarkGray)),
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
}
