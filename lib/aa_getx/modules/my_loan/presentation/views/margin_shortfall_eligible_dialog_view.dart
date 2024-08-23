import 'dart:math';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/controllers/margin_shortfall_eligible_dialog_controller.dart';
import 'package:flutter/material.dart';

///todo: add arguments   MarginShortfallEligibleDialog(this.eligibleLoan, this.cartName, this.fileId,this.pledgorBoid,this.loanName,this.selectedSecuritiesValue, this.loanType); for this page
class MarginShortfallEligibleDialogView extends GetView<MarginShortfallEligibleDialogController>{

  @override
  Widget build(BuildContext context) {
    var eligibleAmount = roundDouble(controller.pageArguments.eligibleLoan!, 2);
    return new Scaffold(
        key: controller.scaffoldkey,
        backgroundColor: Colors.transparent,
        bottomNavigationBar: Obx(()=>AnimatedPadding(
          duration: Duration(milliseconds: 150),
          curve: Curves.easeOut,
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
              height: 272,
              width: 375,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(25.0),
                  topRight: const Radius.circular(25.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 40,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40, right: 30),
                        child: controller.pageArguments.loanType == Strings.shares ? Text(
                          "You are about to pledge ${numberToString(controller.pageArguments.selectedSecuritiesValue!.toStringAsFixed(2))} worth more securities to your loan account ${controller.pageArguments.loanName}.",
                          style: mediumTextStyle_16_gray,
                        ) : Text(
                          "You are about to lien ${numberToString(controller.pageArguments.selectedSecuritiesValue!.toStringAsFixed(2))} worth more schemes to your loan account ${controller.pageArguments.loanName}.",
                          style: mediumTextStyle_16_gray,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0, vertical: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  Strings.eligible_loan_small,
                                  style: textStyleAppThemeStyle,
                                ),
                                Text('₹'+ numberToString(eligibleAmount.toStringAsFixed(2)),
                                  style: textStyleGreenStyle,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              IconButton(
                                icon: ArrowBackwardNavigation(),
                                onPressed: ()=> Get.back(),
                              ),
                              Container(
                                height: 45,
                                width: 100,
                                child: Material(
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(35)),
                                  elevation: 1.0,
                                  color: controller.pageArguments.eligibleLoan == 0.0 ? colorLightGray : appTheme,
                                  child: MaterialButton(
                                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                                    minWidth: MediaQuery.of(context).size.width,
                                    onPressed: () {
                                          if(controller.pageArguments.eligibleLoan != 0.0) {
                                            controller.pledgeOTP();
                                          } else {
                                            Utility.showToastMessage('Eligible loan should not 0');
                                          }
                                    },
                                    child: ArrowForwardNavigation(),
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    ]),
              )),
        )));
  }
  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
}
