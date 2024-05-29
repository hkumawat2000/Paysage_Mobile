import 'package:lms/common_widgets/constants.dart';
import 'package:lms/loan_withdraw/LoanWithdrawOTP.dart';
import 'package:lms/loan_withdraw/WithdrawBloc.dart';
import 'package:lms/network/responsebean/WithdrawDetailsResponse.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/ErrorMessageWidget.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/LoadingWidget.dart';
import 'package:lms/widgets/NoDataWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:lms/util/Preferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'LoanWithdrawOTP.dart';

class LoanWithdrawScreen extends StatefulWidget {
  String loanName;

  @override
  State<StatefulWidget> createState() {
    return LoanWithdrawScreenState();
  }

  LoanWithdrawScreen(this.loanName);
}

class LoanWithdrawScreenState extends State<LoanWithdrawScreen> {
  final withdrawBloc = WithdrawBloc();
  var availableAmount, loanBalance, drawingPower, bankName, accountNumber, bankAccountName;
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey<ScaffoldState>();
  TextEditingController amountController = new TextEditingController();
  TextEditingController? bankAccController;
  bool isSubmitBtnClickable = true;
  WithdrawDetailsData? withdrawData;
  WithdrawDetailsResponse? withdrawDetailsResponse;

  @override
  void initState() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        getWithdrawDetails();
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
    bankAccController = new TextEditingController(text: accountNumber);
    super.initState();
  }

  void getWithdrawDetails() async {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    withdrawDetailsResponse = await withdrawBloc.getWithdrawDetails(widget.loanName);
    if(withdrawDetailsResponse!.isSuccessFull!){
      Navigator.pop(context);
      setState(() {
        withdrawData = withdrawDetailsResponse!.withdrawDetailsData;
      });
    } else if (withdrawDetailsResponse!.errorCode == 403) {
      commonDialog(context, Strings.session_timeout, 4);
    }
  }

  @override
  Widget build(BuildContext context) {
   return GestureDetector(
     onTap: (){
       FocusScope.of(context).unfocus();
     },
      child: Scaffold(
       key: _scaffoldkey,
       appBar: AppBar(
         elevation: 0,
         leading: IconButton(
           icon: ArrowToolbarBackwardNavigation(),
           onPressed: () => Navigator.of(context).pop(),
         ),
         centerTitle: true,
         title: Text(
           widget.loanName,
           style: kDefaultTextStyle,
         ),
         backgroundColor: colorBg,
       ),
       body:  withdrawDetailsResponse != null ? withdrawLoanDetails(): Container()),
    );
  }

  Widget withdrawLoanDetails() {
    return  Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            loanAccountDetails(),
            SizedBox(height: 10),
            loanWithdrawDetails(),
            SizedBox(height: 10),
            bankWidget(),
            SizedBox(height: 10),
            enterAmountTextFormField(),
            SizedBox(height: 24),
            amountTransferText(),
            SizedBox(height: 80),
            nextPreWidget()
          ],
        ),
      ),
    );
  }

  Widget loanAccountDetails() {
    return Row(
      children: <Widget>[
        headingText('Withdraw Loan'),
      ],
    );
  }

  Widget loanWithdrawDetails() {
    availableAmount = roundDouble(withdrawData!.loan!.amountAvailableForWithdrawal!.toDouble(), 2);
    loanBalance = withdrawData!.loan!.balance;
    drawingPower = withdrawData!.loan!.drawingPowerStr;

    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        decoration: BoxDecoration(
          color: colorLightBlue,
          border: Border.all(color: colorLightBlue, width: 3.0),
          borderRadius:
              BorderRadius.all(Radius.circular(15.0)), // set rounded corner radius
        ),
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                subHeadingText('₹${availableAmount != null ? numberToString(availableAmount.toStringAsFixed(2)) : "0"}'),
                SizedBox(height: 4),
                Text(
                  'AVAILABLE AMOUNT',
                  style: subHeading,
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 5.0, right: 5.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      children: [
                        subHeadingText(loanBalance != null
                            ? loanBalance < 0
                            ? negativeValue(double.parse(loanBalance.toString().replaceAll(",", "")))
                            : "₹$loanBalance"
                            : "0",
                            isNeg: withdrawData!.loan!.balance != null ? withdrawData!.loan!.balance! < 0 ? true : false : false),
                        SizedBox(height: 4),
                        Text(
                          'LOAN BALANCE',
                          style: subHeading,
                        ),
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
                        subHeadingText('₹${drawingPower != null ? drawingPower : "0"}'),
                        SizedBox(height: 4),
                        Text(
                          'DRAWING POWER',
                          style: subHeading,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget amountTransferText() {
    return Text(
      'Enter the amount you wish to transfer to your bank account.',
      style: TextStyle(color: colorLightGray, fontSize: 12),
    );
  }

  Widget enterAmountTextFormField() {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(primaryColor: appTheme),
      child: TextField(
        obscureText: false,
        autofocus: true,
        cursorColor: appTheme,
        maxLength: 10,
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
        ],
        style: textFiledInputStyle,
        controller: amountController,
        decoration: new InputDecoration(
          counterText: "",
          hintText: "0,000",
          labelText: "Amount",
          prefixText: "₹",
          labelStyle: TextStyle(color: colorLightGray, fontSize: 15),
          // hintStyle: textFiledHintStyle,
          focusColor: Colors.grey,
          enabledBorder: new UnderlineInputBorder(
            borderSide: BorderSide(
              color: appTheme,
              width: 0.5,
            ),
          ),
        ),
        onChanged: (value) {
          setState(() {
            amountController.selection =
            new TextSelection(baseOffset: value.length, extentOffset: value.length);
            if (amountController.text.isEmpty) {
              isSubmitBtnClickable = true;
            } else if (double.parse(amountController.text) > availableAmount) {
              Utility.showToastMessage("Amount should be less than ${availableAmount}");
              isSubmitBtnClickable = true;
            } else if (double.parse(amountController.text) == 0) {
              isSubmitBtnClickable = true;
            } else {
              printLog("success");
              isSubmitBtnClickable = false;
            }
          });
        },
      ),
    );
  }

  Widget bankWidget() {
    if (withdrawData!.banks != null && withdrawData!.banks!.length != 0) {
      bankName = withdrawData!.banks![0].bank;
      accountNumber = withdrawData!.banks![0].accountNumber;
      bankAccountName = withdrawData!.banks![0].name;
    }

    return bankName != null ? Column(
      children: <Widget>[
        SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              bankName != null ? bankName.toString() : "",
              style: textFiledInputStyle,
            ),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              accountNumber != null ? accountNumber : "",
              style: textFiledInputStyle,
            ),
          ],
        ),
      ],
    ) : SizedBox();
  }

  Widget nextPreWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
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
            color: isSubmitBtnClickable ? colorLightGray : appTheme,
            child: AbsorbPointer(
              absorbing: isSubmitBtnClickable,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () async {
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          if(amountController.text.isEmpty || double.parse(amountController.text) == 0){
                            Utility.showToastMessage(Strings.invalid_amount);
                          } else{
                            requestWithdrawOTP();
                          }
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
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

  void requestWithdrawOTP() async {
    Preferences preferences = Preferences();
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    if (amountController.text.isEmpty) {
      Utility.showToastMessage(Strings.enter_amount);
    } else if(double.parse(amountController.value.text) > availableAmount){
      Utility.showToastMessage("Amount should be less than ${availableAmount}");
    } else {
      LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
      withdrawBloc.requestWithdrawOTP().then((value) {
        Navigator.pop(context);
        if (value.isSuccessFull!) {
          Utility.showToastMessage(value.message!);
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = widget.loanName;
          parameter[Strings.withdraw_amount] = amountController.text.toString();
          parameter[Strings.date_time] = getCurrentDateAndTime();
          firebaseEvent(Strings.withdraw_otp_sent, parameter);

          _otpgModalBottomSheet(context);
        } else if(value.errorCode == 403) {
          commonDialog(context, Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(value.errorMessage!);
        }
      });
    }
  }

  void _otpgModalBottomSheet(context) {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        isScrollControlled: true,
        builder: (BuildContext bc) {
          return WithdrawOTPVerification(
              widget.loanName, amountController.text, bankAccountName ?? "", accountNumber ?? "");
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
