import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/modules/mf_central/presentation/views/mutual_fund_otp_view.dart';

import '../../../../core/constants/strings.dart';
import '../../../../core/utils/common_widgets.dart';
import '../../../../core/utils/style.dart';

class MutualFundConsentView extends GetView<MutualFundConsentView>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorBg,
      appBar: AppBar(
        backgroundColor: colorBg,
        elevation: 0,
        leading: IconButton(
          icon: ArrowToolbarBackwardNavigation(),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Do you want to fetch Mutual Fund?", style: boldTextStyle_18),
        centerTitle: true,
      ),
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                Text(
                    "By continuing, you consent to paysage securely accessing your mutual fund portfolio"),
                SizedBox(height: 20),
                Text(
                    "1. This information will be used to deliver tailored financial services and insights within the app."),
                SizedBox(height: 10),
                Text(
                    "2. Your data will be handled with the highest security standards to ensure confidentiality."),
                SizedBox(height: 10),
                Text(
                    "3. We respect your privacy and will not share your data with third parties without your explicit consent."),
                SizedBox(height: 10),
                Text(
                    "4. Your mutual fund portfolio details will only be used for enhancing your app experience."),
                SizedBox(height: 10),
                Text(
                    "5. You can revoke access and manage your consent preferences anytime in the app settings."),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 50,
                        // width: 140,
                        child: Material(
                          color: appTheme,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                          elevation: 1.0,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () => Get.back(),
                            child: Text(
                              Strings.no,
                              style: buttonTextWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: Container(
                        height: 50,
                        // width: 140,
                        child: Material(
                          color: appTheme,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                          ),
                          elevation: 1.0,
                          child: MaterialButton(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () {
                              Get.bottomSheet(
                                backgroundColor: Colors.transparent,
                                enableDrag: false,
                                isDismissible: false,
                                isScrollControlled: true,
                                MutualFundOtpView(),
                              );
                            },
                            child: Text(
                              Strings.yes,
                              style: buttonTextWhite,
                            ),
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

}