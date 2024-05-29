import 'package:lms/increase_loan_limit/NewIncreaseLoan.dart';
import 'package:lms/lender/LenderBloc.dart';
import 'package:lms/network/requestbean/SecuritiesRequest.dart';
import 'package:lms/network/responsebean/SecuritiesResponseBean.dart';
import 'package:lms/shares/LoanApplicationBloc.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class IncreaseLoanLimit extends StatefulWidget {
  var overDraftLimit, totalCollateral, loanName, overDraftLimitStr, totalCollateralValueStr, stockAt;

  @override
  _IncreaseLoanLimitState createState() => _IncreaseLoanLimitState();

  IncreaseLoanLimit(this.overDraftLimit, this.totalCollateral, this.loanName, this.overDraftLimitStr, this.totalCollateralValueStr, this.stockAt);
}

class _IncreaseLoanLimitState extends State<IncreaseLoanLimit> {
  var netIncreaseLimit, presentPledgedValue, desiredValue, additionPledgeReq, finalOverDraftLimit;
  TextEditingController netIncreaseController = new TextEditingController();
  final loanApplicationBloc = LoanApplicationBloc();
  List<SecuritiesListData> sharesList = [];
  Preferences preferences = new Preferences();
  List<bool> selectedBoolLenderList = [];
  List<bool> selectedBoolLevelList = [];
  List<String> selectedLenderList = [];
  List<String> selectedLevelList = [];
  List<String> lenderList = [];
  List<String> levelList = [];
  final lenderBloc = LenderBloc();
  List<LenderInfo> lenderInfo = [];

  @override
  void initState() {
    lenderBloc.getLenders().then((value) {
      if (value.isSuccessFull!) {
        setState(() {
          for (int i = 0; i < value.lenderData!.length; i++) {
            lenderList.add(value.lenderData![i].name!);
            selectedLenderList.add(value.lenderData![i].name!);
            selectedBoolLenderList.add(true);
            levelList.addAll(value.lenderData![0].levels!);
            value.lenderData![0].levels!.forEach((element) {
              selectedLevelList.add(element.toString().split(" ")[1]);
              selectedBoolLevelList.add(true);
            });
          }
        });
      } else if (value.errorCode == 403) {
        Navigator.pop(context);
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Navigator.pop(context);
        Utility.showToastMessage(value.errorMessage!);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: colorBg,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: colorBg,
          leading: IconButton(
            icon: ArrowToolbarBackwardNavigation(),
            onPressed: () => Navigator.of(context).pop(),
          ),
          elevation: 0.0,
          centerTitle: true,
          title: Text(
            widget.loanName,
            style: mediumTextStyle_18_gray_dark,
          ),
        ),
        body: getIncreaseLoanDetails() ,
      ),
    );
  }

  Widget getIncreaseLoanDetails(){
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                headingText("Increase Loan Limit"),
                SizedBox(
                  height: 30,
                ),
                Text("Existing overdraft limit", style: mediumTextStyle_14_gray),
                SizedBox(
                  height: 5,
                ),
                Text("₹${numberToString(widget.overDraftLimit.toStringAsFixed(2))}",
                    style: regularTextStyle_18_gray_dark),
                SizedBox(
                  height: 25,
                ),
                Text("Required overdraft limit", style: mediumTextStyle_14_gray),
                Container(
                  height: 36,
                  child: TextField(
                    obscureText: false,
                    cursorColor: appTheme,
                    maxLength: 10,
                    keyboardType: TextInputType.numberWithOptions(decimal: true),
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}')),
                    ],
                    style: textFiledInputStyle,
                    controller: netIncreaseController,
                    decoration: InputDecoration(counterText: "", prefixText: '₹'),
                    onChanged: (val) {
                      setState(() {
                        var val1;
                        if(netIncreaseController.text.trim() == ''
                            || netIncreaseController.text.trim() == '.'
                            || netIncreaseController.text.trim() == '0'){
                          val1 = '0';
                          netIncreaseController.clear();
                          netIncreaseLimit = 0.0;
                          additionPledgeReq = 0.0;
                          desiredValue = 0.0;
                        } else {
                          val1 = netIncreaseController.text ;
                          var val2 = widget.overDraftLimit;
                          var val3 = double.parse(val1) - val2;
                          var val4 = double.parse(val1) * 2;
                          var val5 = widget.totalCollateral;
                          var val6 = val4 - val5;
                          var val7 = val2 + double.parse(val1);
                          netIncreaseLimit = val3;
                          desiredValue = val4;
                          additionPledgeReq = val6;
                          finalOverDraftLimit = val7.toStringAsFixed(2);
                        }
                      });
                    },
                  ),
                ),
                SizedBox(height: 25),
                Text("Net increase in limit", style: mediumTextStyle_14_gray),
                SizedBox(
                  height: 5,
                ),
                Text(netIncreaseLimit != null
                    ? "₹${numberToString(netIncreaseLimit.toStringAsFixed(2))}"
                    : "₹0.00",
                    style: regularTextStyle_18_gray_dark),
                SizedBox(
                  height: 25,
                ),
                Text("Current value of pledged securities", style: mediumTextStyle_14_gray),
                SizedBox(
                  height: 5,
                ),
                Text("₹${numberToString(widget.totalCollateral.toStringAsFixed(2))}",
                    style: regularTextStyle_18_gray_dark),
                SizedBox(
                  height: 25,
                ),
                Text("Desired value of securities", style: mediumTextStyle_14_gray,),
                SizedBox(
                  height: 5,
                ),
                Text(desiredValue != null
                    ? "₹${numberToString(desiredValue.toStringAsFixed(2))}"
                    : "₹0.00",
                    style: regularTextStyle_18_gray_dark),
                SizedBox(
                  height: 25,
                ),
                Text("Additional Pledge required", style: mediumTextStyle_14_gray),
                SizedBox(
                  height: 5,
                ),
                Text(additionPledgeReq != null
                    ? "₹${numberToString(additionPledgeReq.toStringAsFixed(2))}"
                    : "₹0.00",
                    style: regularTextStyle_18_gray_dark),
                SizedBox(
                  height: 25,
                ),
                Text("Note: Final overdraft limit will be based on the value of securities you ultimately pledge in the following screens.", style: boldTextStyle_16),
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
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
                  color: appTheme,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () async {
                      getDetails();
                    },
                    child: ArrowForwardNavigation(),
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30,
          ),
        ],
      ),
    );
  }


  void getDetails() async {
    if (netIncreaseController.value.text.trim().isEmpty) {
      Utility.showToastMessage(Strings.valid_od_limit);
    } else if(netIncreaseController.text.startsWith('0')){
      Utility.showToastMessage(Strings.valid_od_limit);
    } else if (double.parse(netIncreaseController.value.text.trim()) <= widget.overDraftLimit) {
      Utility.showToastMessage(Strings.validation_msg_increase_loan);
    } else {
      LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
      loanApplicationBloc.getSecurities(SecuritiesRequest(
          lender: selectedLenderList.join(","),
          level: selectedLevelList.join(","),
          demat: widget.stockAt)).then((value) {
        Navigator.pop(context);
        if (value.isSuccessFull!) {
          sharesList = value.securityData!.securities!;
          List<SecuritiesListData> securities = [];
          for (var i = 0; i < sharesList.length; i++) {
            //Quantity != 0  (this filter is temporary for solved UAT issue.)
            if (sharesList[i].isEligible == true && sharesList[i].quantity != 0
                && sharesList[i].price != 0 && sharesList[i].stockAt == widget.stockAt) {
              var temp = sharesList[i];
              // temp.quantity = temp.quantity;
              securities.add(sharesList[i]);
            }
          }
          lenderInfo.addAll(value.securityData!.lenderInfo!);
          // stockAt = List.generate(securities.length, (index) => securities[index].stockAt!).toSet().toList();
          if (securities.length != 0) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => NewIncreaseLoanScreen(null, Strings.increase_loan, securities, widget.stockAt,
                        widget.loanName, lenderInfo, lenderList, levelList)));
          } else {
            commonDialog(context, Strings.not_fetch, 0);
          }
        } else if (value.errorCode == 403) {
          commonDialog(context, Strings.session_timeout, 4);
        } else if (value.errorCode == 404) {
          commonDialog(context, Strings.not_fetch, 0);
        } else {
          Utility.showToastMessage(value.errorMessage!);
        }
      });
    }
  }
}
