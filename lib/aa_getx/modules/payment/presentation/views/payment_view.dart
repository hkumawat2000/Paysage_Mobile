import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/modules/more/data/models/loan_details_response_model.dart';
import 'package:lms/aa_getx/modules/payment/presentation/controllers/payment_controller.dart';

class PaymentView extends GetView<PaymentController> {

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
            title: Text(controller.paymentArguments.loanName != null ? controller.paymentArguments.loanName : "",
                style: mediumTextStyle_18_gray_dark),
          ),
          body: getWithdrawDetails()),
    );
  }

  Widget getWithdrawDetails() {
    return StreamBuilder(
      stream: controller.paymentBloc.paymentLoan,
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
              commonDialog(Strings.session_timeout, 4);
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
                controller.paymentArguments.isMarginShortfall!
                    ? marginShortFall(
                    controller.loanBalance,
                    controller.paymentArguments.marginShortfallAmount,
                    controller.paymentArguments.minimumCashAmount,
                    controller.drawingPower,
                    AssetsImagePath.business_finance,
                    colorLightRed,
                    true, snapshot.data!.loan!.instrumentType!)
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                controller.paymentArguments.isMarginShortfall! ? Container() : amountField(),
                controller.paymentArguments.isMarginShortfall! ? requestRadioSection() : Container(),
                Visibility(visible: controller.isAmountFieldVisible.value, child: amountField()),
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
    controller.drawingPower = snapshot.data!.loan!.drawingPower!;
    controller.drawingPowerStr = snapshot.data!.loan!.drawingPowerStr!;
    controller.sanctionedLimit = numberToString(snapshot.data!.loan!.sanctionedLimit!.toStringAsFixed(2));
    controller.loanBalance = snapshot.data!.loan!.balance;
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
                        subHeadingText('₹${controller.sanctionedLimit != null ? controller.sanctionedLimit : "0"}'),
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
                        subHeadingText('₹${controller.drawingPower != null ? controller.drawingPowerStr : "0"}'),
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
                subHeadingText(controller.loanBalance != null
                    ? controller.loanBalance! < 0
                    ? negativeValue(controller.loanBalance!)
                    : "₹${numberToString(controller.loanBalance!.toStringAsFixed(2))}"
                    : "0",
                    isNeg: controller.loanBalance! < 0 ? true : false),
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
    final theme = Get.theme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
      child: Theme(
        data: theme.copyWith(primaryColor: appTheme),
        child: TextField(
          // textCapitalization: TextCapitalization.sentences,
          controller: controller.amountController,
          style: textFiledInputStyle,
          focusNode: controller.focusNode,
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
          onChanged: (value)=> controller.amountValueChanged() ,
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
              groupValue: controller.id,
              activeColor: appTheme,
              onChanged: (val)=>controller.radioId1Selected(),
            ),
            Text('Pay Shortfall Amount ${controller.paymentArguments.minimumCashAmount!.toStringAsFixed(2)}',
                style: TextStyle(color: appTheme, fontSize: 18, fontWeight: FontWeight.bold)),
          ],
        ),
        Row(
          children: [
            Radio(
              value: 2,
              groupValue: controller.id,
              activeColor: appTheme,
              onChanged: (val)=>controller.radioId2Selected() ,
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
          onPressed: ()=>Get.back(),
        ),
        Container(
          height: 45,
          width: 100,
          child: Material(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            elevation: 1.0,
            color: controller.isSubmitBtnClickable == true ? colorLightGray : appTheme,
            child: AbsorbPointer(
              absorbing: controller.isSubmitBtnClickable.value,
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                minWidth: Get.size.width,
                onPressed: ()=>controller.proceedButtonClicked(),
                child: ArrowForwardNavigation(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNoDataWidget() {
    return NoDataWidget();
  }

  Widget _buildLoadingWidget() {
    return LoadingWidget();
  }

  Widget _buildErrorWidget(String error) {
    return ErrorMessageWidget(error);
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
