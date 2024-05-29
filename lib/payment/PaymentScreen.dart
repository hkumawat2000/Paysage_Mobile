import 'dart:convert';
import 'dart:io';
import 'package:lms/common_widgets/constants.dart';
import 'package:lms/network/requestbean/PaymentRequest.dart';
import 'package:lms/network/requestbean/RazorPayRequest.dart';
import 'package:lms/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/ErrorMessageWidget.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/LoadingWidget.dart';
import 'package:lms/widgets/NoDataWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'dart:math' as math;

import 'PaymentBloc.dart';

class PaymentScreen extends StatefulWidget {
  var loanName, marginShortfallAmount, minimumCollateralValue, totalCollateralValue, marginShortfallLoanName;
  double minimumCashAmount;
  bool isMarginShortfall;
  int isForInterest;

  PaymentScreen(
      this.loanName,
      this.isMarginShortfall,
      this.marginShortfallAmount,
      this.minimumCollateralValue,
      this.totalCollateralValue,
      this.marginShortfallLoanName,
      this.minimumCashAmount,
      this.isForInterest);

  @override
  State<StatefulWidget> createState() => PaymentScreenState();
}


class PaymentScreenState extends State<PaymentScreen> {
  Razorpay? _razorpay;
  final paymentBloc = PaymentBloc();
  var orderId, paymentAmount, drawingPower, drawingPowerStr, sanctionedLimit,
      minimumPayAmount, emailId, mobileNumber, loanBalanceAmt;
  double? loanBalance;
  TextEditingController _amountController = TextEditingController();
  bool isSubmitBtnClickable = true;
  FocusNode focusNode = FocusNode();
  int id = 1;
  String radioButtonItem = 'Full Amount';
  bool isAmountFieldVisible = false;
  Preferences preferences = Preferences();
  String transaction_logID = "";


  @override
  void dispose() {
    super.dispose();
    _razorpay!.clear();
  }


  @override
  void initState() {
    _razorpay = Razorpay();
    _razorpay!.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay!.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay!.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    getPreferenceData();
    if(widget.isMarginShortfall){
      radioButtonItem = 'Full Amount';
      id = 1;
      isAmountFieldVisible = false;
      isSubmitBtnClickable = false;
      _amountController.text = "";
    }
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        paymentBloc.getLoanDetails(widget.loanName);
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
    super.initState();
  }

  getPreferenceData() async {
    var email = await preferences.getEmail();
    var mobile = await preferences.getMobile();
    setState(() {
      emailId = email;
      mobileNumber = mobile;
    });
  }

  Widget getWithdrawDetails() {
    return StreamBuilder(
      stream: paymentBloc.paymentLoan,
      builder: (context, AsyncSnapshot<LoanDetailData> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data == null) {
            return _buildNoDataWidget();
          } else {
            return paymentLoanDetails(snapshot);
          }
        } else if (snapshot.hasError) {
          if(snapshot.error == "403") {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              commonDialog(context, Strings.session_timeout, 4);
            });
            return _buildErrorWidget("");
          }
          return _buildErrorWidget(snapshot.error.toString());
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }


  Widget paymentLoanDetails(AsyncSnapshot<LoanDetailData> snapshot) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
            child: Column(
              children: [
                Row(
                  children: [
                    headingText("Pay Loan"),
                  ],
                ),
                SizedBox(height: 10),
                loanPaymentDetails(snapshot),
                SizedBox(height: 10),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              children: [
                widget.isMarginShortfall
                    ? marginShortFall(
                    context,
                    loanBalance,
                    widget.marginShortfallAmount,
                    widget.minimumCashAmount,
                    drawingPower,
                    AssetsImagePath.business_finance,
                    colorLightRed,
                    true, snapshot.data!.loan!.instrumentType!)
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                widget.isMarginShortfall ? Container() : amountField(),
                widget.isMarginShortfall ? requestRadioSection() : Container(),
                Visibility(visible: isAmountFieldVisible, child: amountField()),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              proceedBtn(),
            ],
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  Widget loanPaymentDetails(AsyncSnapshot<LoanDetailData> snapshot) {
    // drawingPower = numberToString(snapshot.data!.loan!.drawingPower!.toStringAsFixed(2));
    drawingPower = snapshot.data!.loan!.drawingPower!;
    drawingPowerStr = snapshot.data!.loan!.drawingPowerStr!;
    sanctionedLimit = numberToString(snapshot.data!.loan!.sanctionedLimit!.toStringAsFixed(2));
    loanBalance = snapshot.data!.loan!.balance;
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        decoration: BoxDecoration(
          color: colorLightBlue,
          border: Border.all(color: colorLightBlue, width: 3.0),
          borderRadius:
          BorderRadius.all(Radius.circular(15.0)),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0, left: 5.0, right: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: [
                        subHeadingText('₹${sanctionedLimit != null ? sanctionedLimit : "0"}'),
                        SizedBox(height: 4),
                        Text(Strings.sanctioned_limit, style: subHeading),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 5.0, right: 5.0),
                    child: Container(
                      height: 40.0,
                      width: 1.0,
                      color: Colors.grey,
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        subHeadingText('₹${drawingPower != null ? drawingPowerStr : "0"}'),
                        SizedBox(height: 4),
                        Text(Strings.drawing_power, style: subHeading),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                subHeadingText(loanBalance != null
                    ? loanBalance! < 0
                    ? negativeValue(loanBalance!)
                    : "₹${numberToString(loanBalance!.toStringAsFixed(2))}"
                    : "0",
                    isNeg: loanBalance! < 0 ? true : false),
                SizedBox(height: 4),
                Text(Strings.loan_balance, style: subHeading),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget amountField() {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextField(
          // textCapitalization: TextCapitalization.sentences,
          controller: _amountController,
          style: textFiledInputStyle,
          focusNode: focusNode,
          cursorColor: appTheme,
          showCursor: true,
          maxLength: 10,
          keyboardType: TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            DecimalTextInputFormatter(decimalRange: 2),
            FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
          ],
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
              // _amountController.selection = new TextSelection(baseOffset: value.length, extentOffset: value.length);
              if (widget.isMarginShortfall) {
                if (_amountController.text.isEmpty) {
                  isSubmitBtnClickable = true;
                } else if (double.parse(_amountController.text.toString().trim()) == 0.0) {
                  isSubmitBtnClickable = true;
                } else if (double.parse(_amountController.text.toString().trim()) > loanBalance!) {
                  isSubmitBtnClickable = true;
                  Utility.showToastMessage(Strings.payment_greater_than + " " "$loanBalance");
                } else {
                  isSubmitBtnClickable = false;
                }
              } else {
                if (_amountController.text.isEmpty) {
                  isSubmitBtnClickable = true;
                  // } else if (double.parse(_amountController.text.toString().trim()) > loanBalance && widget.isForInterest == 1) {
                  //   isSubmitBtnClickable = true;
                  //   Utility.showToastMessage(Strings.payment_greater_than + " " "${loanBalance}");
                } else if (double.parse(_amountController.text.toString().trim()) == 0.0) {
                  isSubmitBtnClickable = true;
                } else {
                  isSubmitBtnClickable = false;
                }
              }
            });
          },
        ),
      ),
    );
  }


  Widget requestRadioSection() {
    return Column(
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
                  isSubmitBtnClickable = false;
                  _amountController.text = "";
                });
              },
            ),
            Text('Pay Shortfall Amount ${widget.minimumCashAmount.toStringAsFixed(2)}',
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
                  isSubmitBtnClickable = true;
                });
              },
            ),
            Text(
              Strings.enter_amount,
              style: TextStyle(color: appTheme, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
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
            color: isSubmitBtnClickable == true ? colorLightGray : appTheme,
            child: AbsorbPointer(
              absorbing: isSubmitBtnClickable,
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () async {
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      if (widget.isMarginShortfall) {
                        if (id == 1) {
                          createOrderId(widget.minimumCashAmount, loanBalance);
                        } else {
                          if (_amountController.text.toString().trim().length == 0) {
                            Utility.showToastMessage(Strings.enter_payment_amount);
                          } else {
                            double amount = double.parse(_amountController.text.toString().trim());
                            createOrderId(amount, loanBalance);
                          }
                        }
                      } else {
                        double amount = double.parse(_amountController.text.toString().trim());
                        createOrderId(amount, loanBalance);
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
        ),
      ],
    );
  }


  void createOrderId(amount, loanBalance) {
    if(widget.isMarginShortfall){
      if (amount > loanBalance) {
        Utility.showToastMessage(Strings.payment_greater_than + " " "$loanBalance");
      } else {
        createOrder(amount);
      }
    } else{
      createOrder(amount);
    }
  }

  createOrder(amount) async {
    var newAmount = amount * 100;
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    double requestAmountValue;
    if (widget.isMarginShortfall) {
      if (id == 1) {
        requestAmountValue = double.parse(widget.minimumCashAmount.toString().trim());
      } else {
        requestAmountValue = double.parse(_amountController.text.toString().trim());
      }
    } else {
      requestAmountValue = double.parse(_amountController.text.toString().trim());
    }
    Notes notes = Notes(widget.loanName,
        requestAmountValue.toString(),
        widget.isMarginShortfall ? "0" : widget.isForInterest.toString() ,
        widget.marginShortfallLoanName);
    PaymentRequest requestBean = PaymentRequest(newAmount, "INR", notes);
    paymentBloc.createOrderID(requestBean).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        printLog("Order ID response : ${value.toJson()}");
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.loan_number] = widget.loanName;
        parameter[Strings.payment_amount] = amount.toStringAsFixed(2);
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.payment_in_process, parameter);

        orderId = value.id;
        paymentAmount = value.amount;
        if (orderId != null) {
          createPaymentRequest(IsFailed(), Strings.create_loan_transaction);
        } else {
          Utility.showToastMessage(Strings.something_went_wrong);
        }
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }


  void openCheckout(amount, orderID) async {
    String? baseURL = await preferences.getBaseURL();
    var options = {
      'key': baseURL == Constants.baseUrlProd ? 'rzp_live_55JW5NYsUIguyM' : 'rzp_test_PWqvSLj4rnBOaG',
      // 'key': 'rzp_live_55JW5NYsUIguyM',
      'amount': amount, //in the smallest currency sub-unit.
      'name': 'Spark.Loans',
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
      printLog("_razorpayE$e");
      printLog(e.toString());
    }
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
            title: Text(widget.loanName != null ? widget.loanName : "",
                style: mediumTextStyle_18_gray_dark),
          ),
          body: getWithdrawDetails()),
    );
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
    printLog("========> Payment Failure Response <==========");
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
    var requestAmountValue;
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    if (widget.isMarginShortfall) {
      if (id == 1) {
        requestAmountValue = double.parse(widget.minimumCashAmount.toString().trim());
      } else {
        requestAmountValue = double.parse(_amountController.text.toString().trim());
      }
    } else {
      requestAmountValue = double.parse(_amountController.text.toString().trim());
    }
    RazorPayRequest request = RazorPayRequest(
        loanName: widget.loanName,
        amount: requestAmountValue,
        orderId: orderId,
        loanMarginShortfallName: widget.marginShortfallLoanName,
        isForInterest: widget.isMarginShortfall? 0: widget.isForInterest,
        loanTransactionName: isComingFor == Strings.create_loan_transaction ? "" : transaction_logID,
        isFailed: isFailed.description != null ? isFailed : null);
    printLog("request${jsonEncode(request)}");
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    paymentBloc.createPaymentRequest(request).then((value) {
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
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = widget.loanName;
          parameter[Strings.payment_amount] = requestAmountValue.toStringAsFixed(2);
          parameter[Strings.error_message] = Strings.razorpay_canceled;
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.payment_cancel, parameter);
        }
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  Widget _buildNoDataWidget() {
    return NoDataWidget();
  }

  Widget _buildLoadingWidget() {
    return LoadingWidget();
  }

  Widget _buildErrorWidget(String error) {
    return ErrorMessageWidget(error: error);
  }
}

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, // unused.
      TextEditingValue newValue,
      ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    if (decimalRange != null) {
      String value = newValue.text;

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == ".") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
        composing: TextRange.empty,
      );
    }
    return newValue;
  }
}
