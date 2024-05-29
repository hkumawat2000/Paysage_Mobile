import 'package:lms/common_widgets/constants.dart';
import 'package:lms/topup/top_up_loan/TopUpBloc.dart';
import 'package:lms/topup/top_up_terms_conditions/TopUpTermsConditionsScreen.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SubmitTopUP extends StatefulWidget {
  final topUpAmount;
  final loanName;

  SubmitTopUP(this.topUpAmount, this.loanName);

  @override
  State<StatefulWidget> createState() {
    return SubmitTopUPState();
  }
}

class SubmitTopUPState extends State<SubmitTopUP> {
  final topUpBloc = TopUpBloc();
  TextEditingController topUpAmountController = TextEditingController();
  int topUpId = 1;
  String? topUpName;
  double? topUpAmount;
  bool isTopUpAmount = false;

  List<TopUpValuesList> fList = [
    TopUpValuesList(topUpId: 1, topUpName: "Top-up the full available amount"),
    TopUpValuesList(topUpId: 2, topUpName: "Enter your own amount \n(restricted to the available amount)"),
  ];

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
          title: Text(widget.loanName != null ? widget.loanName : "", style: kDefaultTextStyle),
          leading: IconButton(
            icon: ArrowToolbarBackwardNavigation(),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    headingText('Top Up'),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text('Loan No',
                              style: kDefaultTextStyle.copyWith(
                                color: appTheme,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,)
                          ),
                        ),
                        Text('${widget.loanName}',
                          style: kDefaultTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: appTheme,
                              fontSize: 18.0),
                        ),
                      ],
                    ),
                    SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text('Top Up Amount',
                              style: kDefaultTextStyle.copyWith(
                                color: appTheme,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold,)),
                        ),
                        Text('${numberToString(widget.topUpAmount.toStringAsFixed(2))}',
                          style: kDefaultTextStyle.copyWith(
                              fontWeight: FontWeight.bold,
                              color: appTheme,
                              fontSize: 18.0),),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: fList
                    .map(
                      (data) => RadioListTile<int?>(
                    activeColor: appTheme,
                    dense: true,
                    title: Text(
                      "${data.topUpName}",
                      style: TextStyle(color: appTheme, fontWeight: FontWeight.w600),
                    ),
                    groupValue: topUpId,
                    value: data.topUpId,
                    onChanged: (val) {
                      setState(() {
                        topUpId = data.topUpId!;
                        topUpName = data.topUpName;
                        topUpAmount = widget.topUpAmount;
                        if (topUpId == 2) {
                          isTopUpAmount = true;
                        } else {
                          isTopUpAmount = false;
                        }
                      });
                    },
                  ),
                )
                    .toList(),
              ),
              Visibility(
                visible: isTopUpAmount,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 20.0),
                  child: TextField(
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                    ],
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(counterText: ""),
                    controller: topUpAmountController,
                    keyboardType: TextInputType.number,
                    cursorColor: appTheme,
                    style: TextStyle(
                      color: colorDarkGray,
                      fontSize: 18,
                    ),
//                    onChanged: (value){
//                      int x = int.parse(topUpAmountController.text);
//                      int divisor = 1000;
//                      int result = (x ~/ divisor) * divisor;
//                      if(int.parse(topUpAmountController.text) == result){
//
//                      }
//                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
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
                          FocusScope.of(context).unfocus();
                          processTop();
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                    child: Text(
                      "Proceed",
                      style:
                      TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold),
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
    );
  }

  void processTop() {
    if (topUpId == 1) {
      submitTopUp(widget.topUpAmount);
    } else if (topUpId == 2) {
      if (topUpAmountController.value.text.trim().isEmpty) {
        Utility.showToastMessage(Strings.valid_enter_amount);
      } else {
        var topAmount = topUpAmountController.text;
        int x = int.parse(topAmount);
        int divisor = 1000;
        int result = (x ~/ divisor) * divisor;
        // if (topUpAmountController.value.text.trim().isEmpty) {
        //   Utility.showToastMessage("Please enter amount");
        // } else
        if (double.parse(topUpAmountController.value.text.trim()) == 0) {
          Utility.showToastMessage(Strings.valid_less_0_amount);
        } else if (double.parse(topUpAmountController.value.text.trim()) > widget.topUpAmount) {
          Utility.showToastMessage(Strings.valid_greater_amount);
        } else if(int.parse(topUpAmountController.text) != result){
          Utility.showToastMessage(Strings.valid_amount_multiple_thousand);
        } else {
          submitTopUp(double.parse(topUpAmountController.value.text.trim()));
        }
      }
    } else {
      Utility.showToastMessage(Strings.valid_select_option);
    }
  }

  void submitTopUp(double topUpAmount) async {
//    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
//    TopUpRequest topUpRequest = TopUpRequest(loanName: widget.loanName, topupAmount: topUpAmount);
//    topUpBloc.submitTopUp(topUpRequest).then((value) {
//      Navigator.pop(context); //pop dialog
//      if (value.isSuccessFull) {
    Preferences preferences = Preferences();
    String? mobile = await preferences.getMobile();
    String? email = await preferences.getEmail();

    // Firebase Event
    Map<String, dynamic> parameter = new Map<String, dynamic>();
    parameter[Strings.mobile_no] = mobile;
    parameter[Strings.email] = email;
    parameter[Strings.loan_number] = widget.loanName;
    parameter[Strings.top_up_amount_prm] = widget.topUpAmount;
    parameter[Strings.date_time] = getCurrentDateAndTime();
    firebaseEvent(Strings.top_up_in_process, parameter);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => TopUpTermsConditionsScreen(widget.loanName,topUpAmount)));
//      } else {
//        Utility.showToastMessage(value.errorMessage);
//      }
//    });
  }
}

class TopUpValuesList {
  int? topUpId;
  String? topUpName;
  double? topUpAmount;

  TopUpValuesList({this.topUpId, this.topUpName, this.topUpAmount});
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const separator = ','; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Short-circuit if the new value is empty
    if (newValue.text.length == 0) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1)
          newString = separator + newString;
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString.toString(),
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}