import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/withdraw/presentation/arguments/loan_withdraw_arguments.dart';
import 'package:lms/aa_getx/modules/withdraw/presentation/controllers/loan_withdraw_controller.dart';

class LoanWithdrawView extends GetView<LoanWithdrawController> {
  LoanWithdrawView();

  LoanWithdrawArguments loanWithdrawArguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          key: controller.scaffoldkey,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: ArrowToolbarBackwardNavigation(),
              onPressed: () => Navigator.of(context).pop(),
            ),
            centerTitle: true,
            title: Text(
              loanWithdrawArguments.loanName,
              style: kDefaultTextStyle,
            ),
            backgroundColor: colorBg,
          ),
          body: controller.isLoanDataAvailable.isTrue
              ? withdrawLoanDetails()
              : Container()),
    );
  }

  Widget withdrawLoanDetails() {
    return Padding(
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
    return Center(
      child: Container(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
        decoration: BoxDecoration(
          color: colorLightBlue,
          border: Border.all(color: colorLightBlue, width: 3.0),
          borderRadius: BorderRadius.all(
              Radius.circular(15.0)), // set rounded corner radius
        ),
        child: Column(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                subHeadingText(
                    '₹${controller.availableAmount != 0.0 ? numberToString(controller.availableAmount.toStringAsFixed(2)) : "0"}'),
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
                        subHeadingText(
                            controller.loanBalance != 0.0
                                ? controller.loanBalance < 0
                                    ? negativeValue(double.parse(controller
                                        .loanBalance
                                        .toString()
                                        .replaceAll(",", "")))
                                    : "₹${controller.loanBalance}"
                                : "0",
                            isNeg: controller.loanBalance != 0.0
                                ? controller.loanBalance < 0
                                    ? true
                                    : false
                                : false),
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
                        subHeadingText(
                            '₹${controller.drawingPower.isNotEmpty ? controller.drawingPower : "0"}'),
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
    final theme = Theme.of(Get.context!);
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
        controller: controller.amountController,
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
          controller.amountController.selection = new TextSelection(
              baseOffset: value.length, extentOffset: value.length);
          if (controller.amountController.text.isEmpty) {
            controller.isSubmitBtnClickable.value = true;
          } else if (double.parse(controller.amountController.text) >
              controller.availableAmount.toDouble()) {
            Utility.showToastMessage(
                "Amount should be less than ${controller.availableAmount}");
            controller.isSubmitBtnClickable.value = true;
          } else if (double.parse(controller.amountController.text) == 0) {
            controller.isSubmitBtnClickable.value = true;
          } else {
            // printLog("success");
            controller.isSubmitBtnClickable.value = false;
          }
        },
      ),
    );
  }

  Widget bankWidget() {
    

    return controller.bankName.isNotEmpty
        ? Column(
            children: <Widget>[
              SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                   controller.bankName.isNotEmpty ? controller.bankName.toString() : "",
                    style: textFiledInputStyle,
                  ),
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                  controller.accountNumber.isNotEmpty ? controller.accountNumber.toString() : "",
                    style: textFiledInputStyle,
                  ),
                ],
              ),
            ],
          )
        : SizedBox();
  }

  Widget nextPreWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: ArrowBackwardNavigation(),
          onPressed: () {
            Get.back();
            //Navigator.pop(context);
          },
        ),
        Container(
          height: 45,
          width: 100,
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            elevation: 1.0,
            color: controller.isSubmitBtnClickable.isTrue ? colorLightGray : appTheme,
            child: AbsorbPointer(
              absorbing: controller.isSubmitBtnClickable.value,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                minWidth: MediaQuery.of(Get.context!).size.width,
                onPressed: () async {
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          if (controller.amountController.text.isEmpty ||
                              double.parse(controller.amountController.text) == 0) {
                            Utility.showToastMessage(Strings.invalid_amount);
                          } else {
                          controller.requestLoanwithdrawOtp();
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

  // Widget _buildNoDataWidget() {
  //   return NoDataWidget();
  // }

  // Widget _buildLoadingWidget() {
  //   return LoadingWidget();
  // }

  // Widget _buildErrorWidget(String error) {
  //   return ErrorMessageWidget(error: error);
  // }
}
