import 'package:lms/complete_kyc/CKYCAddressScreen.dart';
import 'package:lms/complete_kyc/CompleteKYCBloc.dart';
import 'package:lms/network/requestbean/ConsentDetailRequestBean.dart';
import 'package:lms/network/responsebean/ConsentDetailResponseBean.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';


class CkycConsentScreen1 extends StatefulWidget {
  String? ckycName;
  bool? forLoanRenewal;
  bool? isShowEdit; //used for loan renewal handling
  String? loanName;
  String? loanRenewalName;
  CkycConsentScreen1(this.ckycName, this.forLoanRenewal, this.isShowEdit, this.loanName, this.loanRenewalName);

  @override
  _CkycConsentScreen1State createState() => _CkycConsentScreen1State();
}

class _CkycConsentScreen1State extends State<CkycConsentScreen1> {
  bool checkBoxValue = true;
  String? userEmail = "-";
  Preferences preferences = new Preferences();
  CompleteKYCBloc completeKYCBloc = CompleteKYCBloc();
  int acceptTerms = 1;
  AddressDetails addressList = AddressDetails();
  UserKycDoc userKyc = UserKycDoc();
  bool isAPICalling = true;
  int loanRenewal = 0;
  String isAPICallingText = Strings.please_wait;
  String? ckycDocName;

  @override
  void initState() {
    if(widget.forLoanRenewal!){
      if(widget.isShowEdit!){
        loanRenewal = 1;
      }else{
        loanRenewal = 0;
      }
    }else{
      if(widget.isShowEdit!){
        loanRenewal = 0;
      }
    }
    getConsentInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => backPressYesNoDialog(context),
      child: Scaffold(
        backgroundColor: colorBg,
        appBar: AppBar(
          backgroundColor: colorBg,
          elevation: 0,
          leading: IconButton(
            icon: NavigationBackImage(),
            onPressed: () => backPressYesNoDialog(context),
          ),
        ),
        body: isAPICalling ? Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isAPICallingText),
          ],
        )): SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Center(child: headingText("Confirm Your Details (1/2)")),
                SizedBox(height: 40),
                subHeadingText(Strings.personal_info),
                SizedBox(height: 20),
                Text(Strings.name, style: mediumTextStyle_14_gray),
                SizedBox(height: 5),
                Text(userKyc.fullname!, style: regularTextStyle_18_gray_dark),
                SizedBox(height: 20),
                Text("Pan Number", style: mediumTextStyle_14_gray),
                SizedBox(height: 5),
                Text(userKyc.panNo!, style: regularTextStyle_18_gray_dark),
                SizedBox(height: 20),
                Text("CKYC Number", style: mediumTextStyle_14_gray),
                SizedBox(height: 5),
                Text(userKyc.ckycNo!, style: regularTextStyle_18_gray_dark),
                SizedBox(height: 20),
                Text(Strings.email, style: mediumTextStyle_14_gray),
                SizedBox(height: 5),
                Text(userKyc.email != null && userKyc.email!.isNotEmpty
                    ? userKyc.email!.replaceRange(userEmail!.indexOf('@') > 4 ? 4 : 2, userKyc.email!.indexOf('@'), "XXXXX") : "-",
                  style: regularTextStyle_18_gray_dark,
                ),
                SizedBox(height: 20),
                Text("Mobile Number", style: mediumTextStyle_14_gray),
                SizedBox(height: 5),
                Text(userKyc.mobNum != null && userKyc.mobNum!.isNotEmpty ? encryptAcNo(userKyc.mobNum!) : "-",
                  style: regularTextStyle_18_gray_dark,
                ),
                SizedBox(height: 20),
                Text("Gender", style: mediumTextStyle_14_gray),
                SizedBox(height: 5),
                Text(userKyc.genderFull!, style: regularTextStyle_18_gray_dark,),
                SizedBox(height: 10),
                SizedBox(
                  height: 70,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    forwardNavigation()
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget forwardNavigation() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: ArrowBackwardNavigation(),
          onPressed: () => backPressYesNoDialog(context),
        ),
        Container(
          height: 45,
          width: 100,
          child: Material(
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            elevation: 1.0,
            color: appTheme,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () async {
                Utility.isNetworkConnection().then((isNetwork) {
                  if (isNetwork) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => CKYCAddressScreen(widget.forLoanRenewal! ? ckycDocName! : widget.ckycName!, widget.isShowEdit, widget.loanName, widget.loanRenewalName, widget.forLoanRenewal!)));
                  } else {
                    Utility.showToastMessage(Strings.no_internet_message);
                  }
                });
              },
              child: ArrowForwardNavigation(),
            ),
          ),
        )
      ],
    );
  }

  getConsentInfo() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        completeKYCBloc.consentDetails(ConsentDetailRequestBean(userKycName: widget.ckycName,acceptTerms: 1, isLoanRenewal: loanRenewal)).then((value) {
          if (value.isSuccessFull!) {
            setState(() {
              userKyc = value.data!.userKycDoc!;
              ckycDocName = value.data!.userKycDoc!.name;
              isAPICalling = false;
            });
          } else if (value.errorCode == 403) {
            setState(() {
              isAPICalling = true;
              isAPICallingText = Strings.session_timeout;
            });
            commonDialog(context, Strings.session_timeout, 4);
          } else {
            setState(() {
              isAPICalling = true;
              isAPICallingText = value.errorMessage!;
            });
          }
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }
}
