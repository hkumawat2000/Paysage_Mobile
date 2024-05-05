import 'dart:convert';

import 'package:choice/account_setting/AccountSettingScreen.dart';
import 'package:choice/all_loans_name/AllLoansNameBloc.dart';
import 'package:choice/approved_securities/ApprovedSecuritiesScreen.dart';
import 'package:choice/approved_shares_and_mf/ApprovedShares.dart';
import 'package:choice/contact_us/ContactUsScreen.dart';
import 'package:choice/feedback/NewFeedbackScreen.dart';
import 'package:choice/increase_loan_limit/IncreaseLoanLimit.dart';
import 'package:choice/lender/LenderScreen.dart';
import 'package:choice/login/LoginBloc.dart';
import 'package:choice/my_loan/MyLoansBloc.dart';
import 'package:choice/network/requestbean/LogoutRequestBean.dart';
import 'package:choice/network/responsebean/AllLoanNamesResponse.dart';
import 'package:choice/network/responsebean/ApprovedSecurityResponseBean.dart';
import 'package:choice/network/responsebean/AuthResponse/AuthLoginResponse.dart';
import 'package:choice/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:choice/network/responsebean/LoanApplicationResponseBean.dart';
import 'package:choice/network/responsebean/MyLoansResponse.dart';
import 'package:choice/payment/PaymentScreen.dart';
import 'package:choice/pin/PinScreen.dart';
import 'package:choice/pledge_eligibility/shares/SecuritySelectionScreen.dart';
import 'package:choice/profile/ProfileBloc.dart';
import 'package:choice/sell_collateral/MFInvokeScreen.dart';
import 'package:choice/sell_collateral/SellCollateralscreen.dart';
import 'package:choice/unpledge/MFRevokeScreen.dart';
import 'package:choice/unpledge/UnpledgeSharescreen.dart';
import 'package:choice/util/AssetsImagePath.dart';
import 'package:choice/util/Colors.dart';
import 'package:choice/util/Preferences.dart';
import 'package:choice/util/Style.dart';
import 'package:choice/util/Utility.dart';
import 'package:choice/util/strings.dart';
import 'package:choice/webview/CommonWebViewScreen.dart';
import 'package:choice/widgets/LoadingDialogWidget.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../account_statement/LoanStatement.dart';
import '../mf_increase_loan/MFIncreaseLoan.dart';

class MoreScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MoreScreenState();
  }
}

class MoreScreenState extends State<MoreScreen> {
  final profileBloc = ProfileBloc();
  final myLoansBloc = MyLoansBloc();
  final allLoansNameBloc = AllLoansNameBloc();
  final loginBloc = LoginBloc();
  String? versionName;
  String profilePhotoUrl = '';
  Preferences preferences = Preferences();
  Utility utility = Utility();
  // RegisterData? registerData;
  LoanApplicationData? list;
  String? loanName, mobileExist, userFullName, lastLogin, userEmail,
      totalCollateralStr, drawingPowerStr , stockAt;
  double? drawingPower,
      totalCollateral,
      sanctionedLimit,
      loanBalance;
  bool isKYCCompleted = false;
  bool isEmailVerified = false;
  bool isAPIRespond = false;
  int? isPayment;
  bool isLoanExist = false;
  bool isIncreaseLoanExist = false;
  bool isTopUpExist = false;
  String topUpApplicationName = '';
  bool isUnpledgeExist = false;
  bool isSellCollateralExist = false;
  bool isSellTriggered = false;
  bool isMarginShortFall = false;
  int canPledge = 0;
  MarginShortfall? marginShortfall;
  var unPledgeMarginShortFallMsg;
  Interest? interest;
  String? loanType;
  String? schemeType;
  String? kycType;

  @override
  void initState() {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        getLastLogInDetails();
        getLoanDetails();
        autoFetchData();
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
    super.initState();
  }

  getLastLogInDetails() {
    loginBloc.getProfileSetAlert(0, 0, 0).then((value) {
      if (value.isSuccessFull!) {
        setState(() {
          isKYCCompleted = value.alertData!.customerDetails!.kycUpdate! == 1 ? true : false;
          isEmailVerified = value.alertData!.customerDetails!.isEmailVerified! == 1 ? true : false;

          if(value.alertData!.userKyc != null) {
            userFullName = value.alertData!.userKyc!.fullname;
          } else {
            userFullName = value.alertData!.customerDetails!.fullName;
          }

          if (value.alertData!.lastLogin != null) {
            var displayDate = value.alertData!.lastLogin;
            var displayDateFormatter = new DateFormat('MMM dd, yyyy hh:mm a');
            var date = DateTime.parse(displayDate!);
            String formattedDate = displayDateFormatter.format(date);
            lastLogin = formattedDate;
          }
          if (value.alertData!.profilePhotoUrl != null) {
            profilePhotoUrl = value.alertData!.profilePhotoUrl!;
          }
        });
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }


  Future<void> autoFetchData() async {
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    String version = await Utility.getVersionInfo();
    setState(() {
      mobileExist = mobile;
      userEmail = email;
      versionName = version;
    });
  }

  getLoanDetails() async {
    MyLoansResponse myLoans = await myLoansBloc.myActiveLoans();
    if (myLoans.errorCode == 403) {
      commonDialog(context, Strings.session_timeout, 4);
    }
    if (myLoans.message!.data!.loans!.length != 0) {
      canPledge = myLoans.message!.data!.canPledge!;
      loanName = myLoans.message!.data!.loans![myLoans.message!.data!.loans!.length - 1].name;
      drawingPower = myLoans.message!.data!.loans![myLoans.message!.data!.loans!.length - 1].drawingPower;
      totalCollateral = myLoans.message!.data!.loans![myLoans.message!.data!.loans!.length - 1].totalCollateralValue;
      sanctionedLimit = myLoans.message!.data!.loans![myLoans.message!.data!.loans!.length - 1].totalCollateralValue;
      // preferences.setLoanApplicationNo(loanName!);
      // preferences.setDrawingPower(drawingPower.toString());
      // preferences.setSanctionedLimit(sanctionedLimit.toString());
      myLoansBloc.getLoanDetails(loanName).then((value) {
        if (value.isSuccessFull!) {
          setState(() {
            drawingPowerStr = value.data!.loan!.drawingPowerStr;
            totalCollateralStr = value.data!.loan!.totalCollateralValueStr;
            stockAt = value.data!.pledgorBoid;
            loanType = value.data!.loan!.instrumentType;
            loanType = value.data!.loan!.schemeType;
            if (value.data!.loan != null) {
              loanBalance = value.data!.loan!.balance;
            }

            if (value.data!.increaseLoan != null) {
              isIncreaseLoanExist = true;
            } else {
              isIncreaseLoanExist = false;
            }
            if (value.data!.topUpApplication == null) {
              isTopUpExist = true;
              topUpApplicationName = value.data!.topUpApplicationName!;
            } else {
              isTopUpExist = false;
            }
            if (value.data!.unpledge != null) {
              isUnpledgeExist = true;
              if (value.data!.unpledge!.unpledgeMsgWhileMarginShortfall != null) {
                unPledgeMarginShortFallMsg = value.data!.unpledge!.unpledgeMsgWhileMarginShortfall;
              }
            } else {
              isUnpledgeExist = false;
            }
            if (value.data!.sellCollateral != null) {
              isSellCollateralExist = true;
            } else {
              isSellCollateralExist = false;
            }
            if (value.data!.isSellTriggered == 1) {
              isSellTriggered = true;
            } else {
              isSellTriggered = false;
            }
            if (value.data!.marginShortfall != null) {
              isMarginShortFall = true;
              marginShortfall = value.data!.marginShortfall;
            } else {
              isMarginShortFall = false;
            }

            if (value.data!.interest != null) {
              interest = value.data!.interest;
            }

            isPayment = value.data!.paymentAlreadyInProcess;

            isAPIRespond = true;
            isLoanExist = true;
          });
        } else {
          if (value.errorMessage != null) {
            commonDialog(context, value.errorMessage, 3);
          }
          setState(() {
            isAPIRespond = true;
          });
        }
      });
    } else {
      setState(() {
        isAPIRespond = true;
        canPledge = myLoans.message!.data!.canPledge!;
      });
    }
  }

  // void userLogout(BuildContext context) async {
  //   String firebaseToken = await preferences.getFirebaseToken();
  //   LogoutRequestBean logoutRequestBean = LogoutRequestBean(firebaseToken: firebaseToken);
  //   Utility.isNetworkConnection().then((isNetwork) {
  //     if (isNetwork) {
  //       LoadingDialogWidget.showDialogLoading(context, "Logging out...");
  //       profileBloc.userLogout(logoutRequestBean).then((value) {
  //         Navigator.pop(context); //pop dialog
  //         Navigator.pop(context); //pop dialog
  //         if (value.isSuccessFull!) {
  //           preferences.clearPreferences();
  //           Utility.showToastMessage(value.message!.message!);
  //           preferences.setFingerprintEnable(true);
  //           preferences.setPanName(userFullName!);
  //           preferences.setLoanList(list);
  //
  //           if (registerData!.pendingEsigns!.length != 0) {
  //             preferences.setEsign(true);
  //           } else {
  //             preferences.setEsign(false);
  //           }
  //           Navigator.pushAndRemoveUntil(
  //             context,
  //             MaterialPageRoute(
  //               builder: (BuildContext context) => PinScreen(),
  //             ),
  //             (route) => false,
  //           );
  //         } else {
  //           Utility.showToastMessage(value.message!.message!);
  //         }
  //       });
  //     } else {
  //       showSnackBar(_scaffoldKey);
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: colorBg,
        elevation: 0.0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Utility.isNetworkConnection().then((isNetwork) async {
                  if (isNetwork) {
                    logoutConfirmDialog(context);
                  } else {
                    Utility.showToastMessage(Strings.no_internet_message);
                  }
                });
              },
              child: Text(
                Strings.logout,
                style:
                    TextStyle(color: red, fontSize: 14.0, fontWeight: semiBold),
              ),
            ),
            SizedBox(width: 10)
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          color: colorBg,
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3.0),
                    child: headingText("More"),
                  ),
                  IconButton(
                    icon: Image.asset(AssetsImagePath.manage_settings_icon,
                        width: 23.0, height: 25.0, color: appTheme),
                    onPressed: () {
                      Utility.isNetworkConnection().then((isNetwork) async {
                        if (isNetwork) {
                          final result = await Navigator.push(context,
                              MaterialPageRoute(builder: (context) => AccountSettingScreen()));
                          if(result != null) {
                            if (profilePhotoUrl.isEmpty) {
                              getLastLogInDetails();
                            }
                          }
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                  )
                ],
              ),
              Card(
                elevation: 0.5,
                color: colorWhite,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(top: 20, bottom: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: CircleAvatar(
                          backgroundColor: colorLightBlue,
                          backgroundImage: profilePhotoUrl.isNotEmpty
                              ? NetworkImage(profilePhotoUrl)
                              : AssetImage(AssetsImagePath.profile)as ImageProvider,
                          radius: 40.0,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
                        child: Column(
                          children: [
                            Text(
                              userFullName ?? "",
                              style: boldTextStyle_24,
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            lastLogin != null
                                ? Text(lastLogin != null
                                ? 'Last Login : $lastLogin' : "",
                                style: boldTextStyle_14, textAlign: TextAlign.center)
                                : SizedBox(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              isAPIRespond
                  ? Column(
                      children: <Widget>[
                        isLoanExist
                            ? GestureDetector(
                                child: ReusableMoreIconTileCard(
                                  assetsImagePath:
                                      AssetsImagePath.increase_limit,
                                  tileText: Strings.increase_loan,
                                ),
                                onTap: () {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) {
                                    if (isNetwork) {
                                      if(loanType == Strings.mutual_fund){
                                        if (isIncreaseLoanExist) {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (BuildContext context) => MFIncreaseLoan(loanName!, Strings.increase_loan, null, loanType!, schemeType!)));
                                        } else {
                                          commonDialog(context, Strings.increase_loan_request_pending, 0);
                                        }
                                      } else {
                                        if (isIncreaseLoanExist) {
                                          if(!isTopUpExist){
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (BuildContext
                                                    context) =>
                                                        IncreaseLoanLimit(
                                                            drawingPower,
                                                            totalCollateral,
                                                            loanName,
                                                            drawingPowerStr,
                                                            totalCollateralStr,
                                                            stockAt)));
                                          }else{
                                            commonDialog(context, "Your top-up application: ${topUpApplicationName.toString()} is pending", 0);
                                          }
                                        } else {
                                          commonDialog(context,
                                              Strings.pending_increase_loan, 0);
                                        }
                                      }
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
                                    }
                                  });
                                },
                              )
                            : SizedBox(),
//                  isLoanExist ? GestureDetector(
//                    onTap: () {
//                      if (loanBalance <= drawingPower) {
//                        Utility.isNetworkConnection().then((isNetwork) {
//                          if (isNetwork) {
//                            Navigator.push(
//                                context,
//                                MaterialPageRoute(
//                                    builder: (BuildContext contex) => LoanWithdrawScreen(loanName)));
//                          } else {
//                            Utility.showToastMessage(Strings.no_internet_message);
//                          }
//                        });
//                      } else {
//                        Utility.showToastMessage(Strings.withdraw_amount_message);
//                      }
//                    },
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.atm,
//                      tileText: toTitleCase(Strings.withdraw),
//                    ),
//                  )
//                      : SizedBox(),
                        isLoanExist
                            ? GestureDetector(
                                onTap: () {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) {
                                    if (isNetwork) {
                                      if (isSellCollateralExist) {
                                        if(!isSellTriggered){
                                          if(loanType == Strings.shares){
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (BuildContext context) => SellCollateralScreen(
                                                    loanName!,
                                                    Strings.all,
                                                    "", loanType!)));
                                          }else{
                                            Navigator.push(context, MaterialPageRoute(
                                                builder: (BuildContext context) => MFInvokeScreen(
                                                    loanName!,
                                                    Strings.all,
                                                    "", "")));
                                          }

                                        } else {
                                          commonDialog(context, Strings.sale_triggered_small, 0);
                                        }
                                      } else {
                                        commonDialog(context, loanType == Strings.shares ? Strings.sell_collateral_request_pending : Strings.invoke_request_pending, 0);
                                      }
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
                                    }
                                  });
                                },
                                child: ReusableMoreIconTileCard(
                                  assetsImagePath:
                                      AssetsImagePath.sell_collateral,
                                  tileText: loanType == Strings.shares ? Strings.sell_collateral : Strings.invoke,
                                ),
                              )
                            : SizedBox(),
                        isLoanExist
                            ? GestureDetector(
                                onTap: () {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) {
                                    if (isNetwork) {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (BuildContext context) =>
                                                  LoanStatementScreen(
                                                      loanName,
                                                      loanBalance,
                                                      drawingPower, loanType)));
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
                                    }
                                  });
                                },
                                child: ReusableMoreIconTileCard(
                                  assetsImagePath: AssetsImagePath.document,
                                  tileText: Strings.statement,
                                ),
                              )
                            : SizedBox(),
                        isLoanExist
                            ? GestureDetector(
                                onTap: () {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) {
                                    if (isNetwork) {
                                      if (isPayment == 0) {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (BuildContextcontext) => PaymentScreen(
                                                    loanName,
                                                    // isMarginShortFall,
                                                    marginShortfall != null ? marginShortfall!.status == "Pending" ? true : false : false,
                                                    marginShortfall != null ? marginShortfall!.shortfallC : "",
                                                    marginShortfall != null ? marginShortfall!.minimumCollateralValue : "",
                                                    marginShortfall != null ? marginShortfall!.totalCollateralValue : "",
                                                    marginShortfall != null
                                                        && marginShortfall!.status != "Sell Triggered"
                                                        && marginShortfall!.status != "Request Pending" ? marginShortfall!.name : "",
                                                    marginShortfall != null ? marginShortfall!.minimumCashAmount! : 0.0,
                                                    interest != null ? 1 : 0)));
                                      } else {
                                        commonDialog(context,
                                            Strings.pending_payment, 0);
                                      }
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
                                    }
                                  });
                                },
                                child: ReusableMoreIconTileCard(
                                  assetsImagePath: AssetsImagePath.credit_card,
                                  tileText: "Payment",
                                ),
                              )
                            : SizedBox(),
                        isKYCCompleted
                            ? isEmailVerified
                                ? canPledge == 1
                                    ? GestureDetector(
                                    onTap: () {
                                      Utility.isNetworkConnection()
                                          .then((isNetwork) {
                                        if (isNetwork) {
                                          // Firebase Event
                                          Map<String, dynamic> parameter = new Map<String, dynamic>();
                                          parameter[Strings.mobile_no] = mobileExist;
                                          parameter[Strings.email] = userEmail;
                                          parameter[Strings.date_time] = getCurrentDateAndTime();
                                          firebaseEvent(Strings.new_loan_click, parameter);

                                          Navigator.push(context, MaterialPageRoute(
                                                  builder: (BuildContext context) => ApprovedSharesScreen()));
                                        } else {
                                          Utility.showToastMessage(
                                              Strings.no_internet_message);
                                        }
                                      });
                                    },
                                    child: ReusableMoreIconTileCard(
                                      assetsImagePath: AssetsImagePath.pledge,
                                      tileText: Strings.pledge,
                                    ),
                                  )
                                    : SizedBox()
                                : SizedBox()
                            : SizedBox(),
                        // SizedBox(height: 15),
                        isLoanExist
                            ? GestureDetector(
                                onTap: () {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) {
                                    if (isNetwork) {
                                      if (unPledgeMarginShortFallMsg == null) {
                                        if (isUnpledgeExist) {
                                          if(loanType == Strings.shares) {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (BuildContext context) =>
                                                        UnpledgeSharesScreen(loanName!, Strings.all, "", loanType!)));
                                          } else {
                                            Navigator.push(context,
                                                MaterialPageRoute(builder: (BuildContext context) =>
                                                    MFRevokeScreen(loanName!, Strings.all, "", "")));
                                          }
                                        } else {
                                          commonDialog(context,loanType == Strings.shares ? Strings.unpledge_request_pending : Strings.revoke_request_pending, 0);
                                        }
                                      } else {
                                        commonDialog(
                                            context,
                                            unPledgeMarginShortFallMsg
                                                .toString(),
                                            0);
                                      }
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
                                    }
                                  });
                                },
                                child: ReusableMoreIconTileCard(
                                  assetsImagePath: AssetsImagePath.unpledge,
                                  tileText: loanType == Strings.shares ? Strings.unpledge : Strings.revoke,
                                ),
                              )
                            : SizedBox(),
//                  userEsign != null ? GestureDetector(
//                    onTap: () {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (BuildContext context) => UnpledgeQuantity()));
//                    },
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.unpledge,
//                      tileText: toTitleCase("UnPledge"),
//                    ),
//                  ):Container(),
//                   !isKYCCompleted
//                         GestureDetector(
//                           onTap: () {
//                             Utility.isNetworkConnection().then((isNetwork) {
//                               if (isNetwork) {
//                                 // Firebase Event
//                                 Map<String, dynamic> parameter = new Map<String, dynamic>();
//                                 parameter[Strings.mobile_no] = mobileExist;
//                                 parameter[Strings.date_time] = getCurrentDateAndTime();
//                                 firebaseEvent(Strings.check_eligible_lender, parameter);
//
//                                 // Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => SecuritySelectionScreen()));
//
//                                 // showModalBottomSheet(
//                                 //     backgroundColor: Colors.transparent,
//                                 //     context: context,
//                                 //     isScrollControlled: true,
//                                 //     builder: (BuildContext bc) {
//                                 //       return LenderScreen(isEmailVerified, canPledge);
//                                 //     });
//                               } else {
//                                 Utility.showToastMessage(Strings.no_internet_message);
//                               }
//                             });
//                           },
//                           child: ReusableMoreIconTileCard(
//                             assetsImagePath: AssetsImagePath.history_grey,
//                             tileText: toTitleCase(Strings.check_eligible_limit),
//                           ),
//                         ),
                        GestureDetector(
                          onTap: () {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder:
                                            (BuildContext context) =>
                                            ApprovedSecuritiesScreen()));
                              } else {
                                Utility.showToastMessage(
                                    Strings.no_internet_message);
                              }
                            });
                          },
                          child: ReusableMoreIconTileCard(
                            assetsImagePath: AssetsImagePath.approved_security_list_icon,
                            tileText: loanType == Strings.mutual_fund ? Strings.approved_scheme: Strings.approved_security,
                          ),
                        ),
                        // : SizedBox(),
                        /* SizedBox(
                    height: 15,
                  ),*/
//                   SizedBox(height: 15),
//                  GestureDetector(
//                    onTap: () {
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (BuildContext context) => EligibilityScreen()));
//                    },
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.history_grey,
//                      tileText: toTitleCase("Eligibility"),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 15,
//                  ),
//                  GestureDetector(
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.share,
//                      tileText: toTitleCase("Track My Application/Requests"),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 15,
//                  ),
//                  GestureDetector(
//                    onTap: () {
//                      Navigator.push(context,
//                          MaterialPageRoute(builder: (BuildContext context) => UploadTDS()));
//                    },
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.share,
//                      tileText: toTitleCase("Upload TDS certificates"),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 15,
//                  ),
//                  GestureDetector(
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.share,
//                      tileText: toTitleCase("FAQs"),
//                    ),
//                  ),
//                  SizedBox(
//                    height: 15,
//                  ),
//                  GestureDetector(
//                    onTap: () {
//                      Navigator.push(
//                          context,
//                          MaterialPageRoute(
//                              builder: (BuildContext context) => ReferAndEarnScreen()));
//                    },
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.share,
//                      tileText: toTitleCase("Refer & Win"),
//                    ),
//                  ),

//                   SizedBox(height: 15),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (BuildContext context) => UnpledgeQuantity()));
                        //   },
                        //   child: ReusableMoreIconTileCard(
                        //     assetsImagePath: AssetsImagePath.unpledge,
                        //     tileText: toTitleCase("Unpledge"),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (BuildContext context) => UnpledgeQuantity()));
                        //   },
                        //   child: ReusableMoreIconTileCard(
                        //     assetsImagePath: AssetsImagePath.unpledge,
                        //     tileText: toTitleCase("My Inactive Loan"),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (BuildContext context) => UploadTDS()));
                        //   },
                        //   child: ReusableMoreIconTileCard(
                        //     assetsImagePath: AssetsImagePath.share,
                        //     tileText: toTitleCase("Upload TDS certificates"),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (BuildContext context) => ReferAndEarnScreen()));
                        //   },
                        //   child: ReusableMoreIconTileCard(
                        //     assetsImagePath: AssetsImagePath.share,
                        //     tileText: toTitleCase("Refer & Win"),
                        //   ),
                        // ),
                        GestureDetector(
                          onTap: () {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            NewFeedbackScreen(
                                                Strings.more_menu, 0)));
                              } else {
                                Utility.showToastMessage(
                                    Strings.no_internet_message);
                              }
                            });
                          },
                          child: ReusableMoreIconTileCard(
                            assetsImagePath: AssetsImagePath.mail,
                            tileText: "Feedback",
                          ),
                        ),
                        // GestureDetector(
                        //   child: ReusableMoreIconTileCard(
                        //     assetsImagePath: AssetsImagePath.phone,
                        //     tileText: toTitleCase("Contact us"),
                        //   ),
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (BuildContext context) =>
                        //                 ContactUsScreen()));
                        //   },
                        // ),

                        // SizedBox(height: 10),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (BuildContext context) => UnpledgeQuantity()));
                        //   },
                        //   child: ReusableMoreIconTileCard(
                        //     assetsImagePath: AssetsImagePath.unpledge,
                        //     tileText: toTitleCase("Unpledge"),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (BuildContext context) => UnpledgeQuantity()));
                        //   },
                        //   child: ReusableMoreIconTileCard(
                        //     assetsImagePath: AssetsImagePath.unpledge,
                        //     tileText: toTitleCase("My Inactive Loan"),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (BuildContext context) => UploadTDS()));
                        //   },
                        //   child: ReusableMoreIconTileCard(
                        //     assetsImagePath: AssetsImagePath.share,
                        //     tileText: toTitleCase("Upload TDS certificates"),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (BuildContext context) => ReferAndEarnScreen()));
                        //   },
                        //   child: ReusableMoreIconTileCard(
                        //     assetsImagePath: AssetsImagePath.share,
                        //     tileText: toTitleCase("Refer & Win"),
                        //   ),
                        // ),
                        // GestureDetector(
                        //   onTap: () {
                        //     Navigator.push(context,
                        //         MaterialPageRoute(builder: (BuildContext context) => FeedbackScreen()));
                        //   },
                        //   child: ReusableMoreIconTileCard(
                        //     assetsImagePath: AssetsImagePath.mail,
                        //     tileText: toTitleCase("Feedback/Rate us"),
                        //   ),
                        // ),
                        GestureDetector(
                          child: ReusableMoreIconTileCard(
                            assetsImagePath: AssetsImagePath.phone,
                            tileText: Strings.contact_us,
                          ),
                          onTap: () {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            ContactUsScreen()));
                              } else {
                                Utility.showToastMessage(
                                    Strings.no_internet_message);
                              }
                            });
                          },
                        ),
//                  GestureDetector(
//                    child: ReusableMoreIconTileCard(
//                      assetsImagePath: AssetsImagePath.settings,
//                      tileText: toTitleCase("Settings"),
//                    ),
//                    onTap: (){
//                      Utility.isNetworkConnection().then((isNetwork) {
//                        if (isNetwork) {
//                          Navigator.push(
//                              context,
//                              MaterialPageRoute(
//                                  builder: (BuildContext context) =>
//                                      AccountSettingScreen(userFullName,mobileExist,userEmail,true)));
//                        } else {
//                          Utility.showToastMessage(
//                              Strings.no_internet_message);
//                        }
//                      });
//                    },
//                  ),
                        // GestureDetector(
                        //   child: ReusableMoreIconTileCard(
                        //     assetsImagePath: AssetsImagePath.settings,
                        //     tileText: toTitleCase("Settings"),
                        //   ),
                        //   onTap: (){
                        //     Navigator.push(
                        //         context,
                        //         MaterialPageRoute(
                        //             builder: (BuildContext context) =>
                        //                 AccountSettingScreen(userFullName,mobileExist,userEmail,true)));
                        //   },
                        // ),
                        GestureDetector(
                          child: ReusableMoreIconTileCard(
                            assetsImagePath: AssetsImagePath.faq,
                            tileText: "FAQ",
                          ),
                          onTap: () {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            CommonWebViewScreen(
                                                1, "Help / FAQs")));
                              } else {
                                Utility.showToastMessage(
                                    Strings.no_internet_message);
                              }
                            });
                          },
                        ),
                        // GestureDetector(
                        //   child: ReusableMoreIconTileCard(
                        //     assetsImagePath: AssetsImagePath.privacy_policy,
                        //     tileText: toTitleCase(Strings.privacy_policy),
                        //   ),
                        //   onTap: () {
                        //     Utility.isNetworkConnection().then((isNetwork) {
                        //       if (isNetwork) {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) =>
                        //                     CommonWebViewScreen(
                        //                         2, Strings.privacy_policy)));
                        //       } else {
                        //         Utility.showToastMessage(
                        //             Strings.no_internet_message);
                        //       }
                        //     });
                        //   },
                        // ),
                        // GestureDetector(
                        //   child: ReusableMoreIconTileCard(
                        //     assetsImagePath: AssetsImagePath.terms_of_use,
                        //     tileText: toTitleCase(Strings.terms_of_use),
                        //   ),
                        //   onTap: () {
                        //     Utility.isNetworkConnection().then((isNetwork) {
                        //       if (isNetwork) {
                        //         Navigator.push(
                        //             context,
                        //             MaterialPageRoute(
                        //                 builder: (context) =>
                        //                     CommonWebViewScreen(
                        //                         3, Strings.terms_of_use)));
                        //       } else {
                        //         Utility.showToastMessage(
                        //             Strings.no_internet_message);
                        //       }
                        //     });
                        //   },
                        // ),
                        SizedBox(height: 10),
                        version(),
                        SizedBox(height: 70),
                      ],
                    )
                  : shimmerEffect(),
            ],
          ),
        ),
      ),
    );
  }

  Widget shimmerEffect() {
    return Visibility(
      visible: !isAPIRespond,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[400]!,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(6, 14, 6, 14),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey,
              ),
              SizedBox(height: 10),
              Container(
                width: double.infinity,
                height: 60,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget version() {
    return Center(
      child: Text('Version ${versionName != null ? versionName : ""}'),
    );
  }

  Future<void> logoutConfirmDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button for close dialog!
      builder: (BuildContext context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Align(
            alignment: Alignment.center,
            child: Container(
              padding: const EdgeInsets.all(20.0),
              margin: const EdgeInsets.all(20.0),
              alignment: Alignment.center,
              height: 180,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                color: colorWhite,
              ),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    headingText(Strings.SignOut),
                    SizedBox(
                      height: 10,
                    ),
                    Text(Strings.message_sign_out,
                        style: TextStyle(fontSize: 16)),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        FlatButton(
                          child: const Text(Strings.alert_button_no,
                              style: TextStyle(color: colorLightAppTheme)),
                          onPressed: () {
                            Navigator.of(context).pop(Strings.alert_button_no);
                          },
                        ),
                        FlatButton(
                          child: const Text(Strings.alert_button_yes,
                              style: TextStyle(color: colorLightAppTheme)),
                          onPressed: () {
                            Utility.isNetworkConnection().then((isNetwork) async {
                              if (isNetwork) {
                                // preferences.clearPreferences();
                                // preferences.setMobilet(mobileExist);
                                // preferences.setEmail(userEmail);
                                // preferences.setPin(pinExist);
                                // preferences.setLoggedOut("true");
                                // preferences.setPAN(panExist);
                                // preferences.setDOB(userDOB);
                                // preferences.setToken(token);
                                // if (isFingerSupport) {
                                //   if (isUserEnableFingerprint) {
                                //     preferences.setFingerprintEnable(true);
                                //   }
                                // }

                                // Firebase Event
                                Map<String, dynamic> parameter = new Map<String, dynamic>();
                                parameter[Strings.mobile_no] = mobileExist;
                                parameter[Strings.email] = userEmail;
                                parameter[Strings.date_time] = getCurrentDateAndTime();
                                firebaseEvent(Strings.log_out, parameter);

                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) => PinScreen(true),
                                  ),
                                      (route) => false,
                                );
                              } else {
                                Utility.showToastMessage(Strings.no_internet_message);
                              }
                            });
                            //userLogout(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class ReusableMoreIconTileCard extends StatelessWidget {
  final String tileText;
  final String assetsImagePath;

  ReusableMoreIconTileCard({required this.tileText, required this.assetsImagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      child: Card(
        elevation: 2.0,
        color: colorWhite,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: ListTile(
          leading: IconButton(
            icon: Image.asset(assetsImagePath, width: 25, height: 25, color: colorGrey),
            onPressed: null,
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Flexible(child: Text(tileText, style: mediumTextStyle_18_gray_dark)),
              Image.asset(AssetsImagePath.forward, width: 8.54, height: 17.08),
            ],
          ),
        ),
      ),
    );
  }
}
