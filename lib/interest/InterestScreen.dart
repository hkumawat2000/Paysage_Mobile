import 'dart:convert';
import 'dart:io';
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/network/requestbean/PaymentRequest.dart';
import 'package:lms/network/requestbean/RazorPayRequest.dart';
import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/payment/PaymentBloc.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class InterestScreen extends StatefulWidget {
  double loanBalance;
  String loanName;
  double totalInterestAmount;
  String dueDate;

  InterestScreen(this.totalInterestAmount, this.loanName, this.loanBalance, this.dueDate);

  @override
  State<StatefulWidget> createState() => InterestScreenState();
}

class InterestScreenState extends State<InterestScreen> {
  Razorpay? _razorpay;
  final paymentBloc = PaymentBloc();
  var orderId, paymentAmount, drawingPower, sanctionedLimit, loanBalance, emailId, mobileNumber;
  TextEditingController _amountController = TextEditingController();
  bool isSubmitBtnClickable = true;
  int id = 1;
  String radioButtonItem = 'Full Amount';
  bool isAmountFieldVisible = false;
  Preferences preferences = Preferences();
  String transaction_logID = "";

  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getPreferenceData();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }

  getPreferenceData() async {
    var email = await preferences.getEmail();
    var mobile = await preferences.getMobile();
    setState(() {
      emailId = email;
      mobileNumber = mobile;
    });
  }


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: colorBg,
          appBar: AppBar(
            backgroundColor: colorBg,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: NavigationBackImage(),
              onPressed: () => Navigator.of(context).pop(),
            ),
            title: Text(
                widget.loanName != null ? widget.loanName : "",
                style: mediumTextStyle_18_gray_dark),
          ),
          body: paymentLoanDetails()),
    );
  }

  Widget paymentLoanDetails() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: headingText(Strings.interest_payment),
          ),
          loanPaymentDetails(),
          SizedBox(
            height: 10,
          ),
          requestRadioSection(),
          Visibility(visible: isAmountFieldVisible, child: amountFeild()),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            child: Text(Strings.interest_payment_screen_msg),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              proceedBtn(),
            ],
          )
        ],
      ),
    );
  }

  Widget loanPaymentDetails() {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Column(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: colorLightBlue,
                  border: Border.all(color: colorLightBlue, width: 3.0),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0, left: 15.0, right: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '₹${widget.totalInterestAmount != null ? widget.totalInterestAmount.toStringAsFixed(2) : "0"}',
                            style: boldTextStyle_24,
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 3.0, left: 10.0),
                            child: Container(
                              height: 40.0,
                              width: 1.0,
                              color: Colors.grey,
                            ),
                          ),
                          Text('${widget.dueDate}', style: boldTextStyle_24),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0, bottom: 8.0, right: 20.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text("INTEREST DUE", style: subHeading),
                          Text("DUE DATE", style: subHeading),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget requestRadioSection() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Radio(
                value: 1,
                groupValue: id,
                activeColor: appTheme,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem = 'Full Amount';
                    id = 1;
                    isAmountFieldVisible = false;
                  });
                },
              ),
              Text('${widget.totalInterestAmount}',
                  style: TextStyle(color: appTheme, fontSize: 18, fontWeight: FontWeight.bold)),
            ],
          ),
          Row(
            children: [
              Radio(
                value: 2,
                groupValue: id,
                activeColor: appTheme,
                onChanged: (val) {
                  setState(() {
                    radioButtonItem = 'Please enter amount';
                    id = 2;
                    isAmountFieldVisible = true;
                  });
                },
              ),
              Text(
                'Please enter amount',
                style: TextStyle(color: appTheme, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget amountFeild() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextField(
          textCapitalization: TextCapitalization.sentences,
          style: textFiledInputStyle,
          cursorColor: appTheme,
          maxLength: 10,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
          ],
          controller: _amountController,
          decoration: InputDecoration(
            counterText: "",
            hintText: Strings.enter_payment_amount,
            hintStyle: textFiledHintStyle,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: appTheme,
                width: 0.5,
              ),
            ),
          ),
          onChanged: (value) {
            setState(() {
              _amountController.selection = new TextSelection(baseOffset: value.length, extentOffset: value.length);
              if (_amountController.text.isEmpty) {
                isSubmitBtnClickable = true;
              } else if (double.parse(_amountController.text.toString().trim()) <= 0.0) {
                isSubmitBtnClickable = true;
              } else if (double.parse(_amountController.text.toString().trim()) > widget.totalInterestAmount) {
                isSubmitBtnClickable = true;
                Utility.showToastMessage(Strings.amount_not_greater);
              } else {
                isSubmitBtnClickable = false;
              }
            });
          },
        ),
      ),
    );
  }

  Widget proceedBtn() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          icon: ArrowBackwardNavigation(),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Container(
          height: 45,
          width: 100,
          child: Material(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            elevation: 1.0,
            color: id == 1
                ? appTheme
                : isSubmitBtnClickable
                    ? colorLightGray
                    : appTheme,
            child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () async {
                Utility.isNetworkConnection().then((isNetwork) {
                  if (isNetwork) {
                    if (id == 1) {
                      createOrderId(widget.totalInterestAmount);
                    } else {
                      if (_amountController.value.text.toString().length == 0) {
                        Utility.showToastMessage(Strings.enter_payment_amount);
                      } else if (double.parse(_amountController.value.text.toString().trim()) <= 0.0) {
                        Utility.showToastMessage(Strings.atleast_one);
                      } else if (double.parse(_amountController.value.text) > widget.totalInterestAmount) {
                        Utility.showToastMessage(Strings.amount_not_greater);
                      } else {
                        double amount = double.parse(_amountController.text.toString().trim());
                        createOrderId(amount);
                      }
                    }
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

  void createOrderId(amount) async {
    var newAmount = amount * 100;
    if (amount > widget.loanBalance) {
      Utility.showToastMessage("Payment amount should not greater than ${widget.loanBalance}");
    } else {
      LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
      double amount;
      if (id == 1) {
        amount = double.parse(widget.totalInterestAmount.toString());
      } else {
        amount = double.parse(_amountController.text.toString().trim());
      }
      Notes notes = Notes(widget.loanName, amount.toString(), "1", "");
      PaymentRequest requestBean = PaymentRequest(newAmount, "INR", notes);
      paymentBloc.createOrderID(requestBean).then((value) {
        Navigator.pop(context);
        if (value.isSuccessFull!) {
          orderId = value.id;
          paymentAmount = value.amount;
          if (orderId != null) {
            createPaymentRequest(IsFailed(), Strings.create_loan_transaction);
            // openCheckout(value.amount, value.id);
          } else {
            Utility.showToastMessage(Strings.something_went_wrong);
          }
        } else {
          Utility.showToastMessage(value.errorMessage!);
        }
      });
    }
  }


  void openCheckout(amount, orderID) async {
    String? baseURL = await preferences.getBaseURL();
    var options = {
      // 'key': baseURL == Constants.baseUrlProd ? 'rzp_live_55JW5NYsUIguyM' : 'rzp_test_edJR1nkRmL3cfc',
      'key': 'rzp_live_55JW5NYsUIguyM',
      'amount': amount, //in the smallest currency sub-unit.
      'name': 'LMS',
      'order_id': orderID, // Generate order_id using Orders API
      'description': 'Payment',
      'prefill': {'contact': '+91$mobileNumber', 'email': emailId},
      //ToDo need to activated wallet from Razorpay dashboard
//      'external': {
//        'wallets': ['paytm']
//      }
    };
    try {
      _razorpay!.open(options);
    } catch (e) {
      printLog(e.toString());
    }
  }


  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (BuildContext contex) => DashBoard()));
        Utility.showToastMessage(Strings.payment_successful);
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    printLog("========> PaymentFailureResponse <==========");
    printLog(response.message!);
    IsFailed isFailed = IsFailed();
    if(Platform.isAndroid){
      Map<String, dynamic> map = json.decode(response.message!);
      Map<String, dynamic> data = map["error"];
      printLog("handlePaymentError ==> $data");
      isFailed = IsFailed(code:data["code"], description: data["description"], source: data["source"], step: data["step"], reason: data["reason"] );
    } else {
      isFailed = IsFailed(description: response.message!);
    }
    printLog("isFailed ==> ${jsonEncode(isFailed)}");

    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        createPaymentRequest(isFailed, "");
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Utility.showToastMessage("EXTERNAL_WALLET: " + response.walletName!);
  }


  void createPaymentRequest(IsFailed isFailed, String isComingFor) async {
    var amount;
    if (id == 1) {
      amount = double.parse(widget.totalInterestAmount.toString());
    }else{
      amount = double.parse(_amountController.text.toString().trim());
    }
    RazorPayRequest request = RazorPayRequest(
        loanName: widget.loanName,
        amount: amount,
        orderId: orderId,
        loanMarginShortfallName: "",
        isForInterest: 1,
        loanTransactionName: isComingFor == Strings.create_loan_transaction ? "" : transaction_logID,
        isFailed: isFailed.description != null? isFailed: null);

    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait); //is_for_interest=1
    paymentBloc.createInterestPaymentRequest(request).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        FocusScope.of(context).requestFocus(new FocusNode());
        if(isComingFor == Strings.create_loan_transaction){
          setState(() {
            transaction_logID = value.data!.loanTransactionName!;
          });
          printLog("Transaction Log ID ==> $transaction_logID");
          openCheckout(paymentAmount, orderId);
        } else {
          Utility.showToastMessage(Strings.razorpay_canceled);
        }
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }
}