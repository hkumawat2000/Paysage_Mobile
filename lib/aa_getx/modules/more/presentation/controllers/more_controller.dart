import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/get_profile_set_alert_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/my_loans_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/get_profile_set_alert_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_my_active_loans_usecase.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_profile_set_alert_usecase.dart';
import 'package:lms/aa_getx/modules/more/presentation/views/more_view.dart';
import 'package:lms/login/LoginBloc.dart';
import 'package:lms/network/responsebean/LoanApplicationResponseBean.dart';
import 'package:lms/util/Preferences.dart';

class MoreController extends GetxController{
  final loginBloc = LoginBloc();
  RxString versionName = ''.obs;
  RxString profilePhotoUrl = ''.obs;
  Preferences preferences = Preferences();
  Utility utility = Utility();
  // RegisterData? registerData;
  LoanApplicationData? list;
  RxString loanName = "".obs;
  RxString mobileExist = "".obs;
  RxString userEmail = "".obs;
  RxString totalCollateralStr = "".obs;
  RxString drawingPowerStr = "".obs;
  RxString stockAt = "".obs;
  RxString userFullName="".obs;
  RxString lastLogin= "".obs;
  double? drawingPower,
      totalCollateral,
      sanctionedLimit;
  RxDouble? loanBalance;
  RxBool isKYCCompleted = false.obs;
  RxBool isEmailVerified = false.obs;
  RxBool isAPIRespond = false.obs;
  RxInt? isPayment;
  RxBool isLoanExist = false.obs;
  RxBool isIncreaseLoanExist = false.obs;
  RxBool isTopUpExist = false.obs;
  RxString topUpApplicationName = ''.obs;
  RxBool isUnpledgeExist = false.obs;
  RxBool isSellCollateralExist = false.obs;
  RxBool isSellTriggered = false.obs;
  RxBool isMarginShortFall = false.obs;
  RxInt canPledge = 0.obs;
  MarginShortfallEntity? marginShortfall;
  RxString? unPledgeMarginShortFallMsg;
  Rx<InterestEntity>? interest;
  RxString? loanType;
  String? schemeType;
  String? kycType;
  final GetMyActiveLoansUseCase _getMyActiveLoansUseCase;
  final ConnectionInfo _connectionInfo;
  final GetLoanDetailsUseCase _getLoanDetailsUseCase;
  final GetProfileSetAlertUseCase _getProfileSetAlertUseCase;

  MoreController(this._getMyActiveLoansUseCase, this._connectionInfo, this._getLoanDetailsUseCase, this._getProfileSetAlertUseCase);

  @override
  void onInit() {
    getLastLogInDetails();
    getLoanDetails();
    autoFetchData();
    super.onInit();
  }

  Future<void> getLastLogInDetails() async{
    if (await _connectionInfo.isConnected){
      GetProfileSetAlertRequestEntity getProfileSetAlertRequestEntity= GetProfileSetAlertRequestEntity(amount: 0, isForAlert: 0 , percentage:0 );
      DataState<GetProfileSetAlertResponseEntity> response = await _getProfileSetAlertUseCase.call(GetProfileSetAlertParams(getProfileSetAlertRequestEntity: getProfileSetAlertRequestEntity));

      if(response is DataSuccess){
        if (response.data != null) {
          isKYCCompleted.value = response.data!.alertData!.customerDetails!.kycUpdate! == 1 ? true : false;
          isEmailVerified.value = response.data!.alertData!.customerDetails!.isEmailVerified! == 1 ? true : false;

          if(response.data!.alertData!.userKyc != null) {
            userFullName.value = response.data!.alertData!.userKyc!.fullname!;
          } else {
            userFullName.value = response.data!.alertData!.customerDetails!.fullName!;
            debugPrint(" userFullName  ${userFullName.value}");
          }

          if (response.data!.alertData!.lastLogin != null) {
            var displayDate = response.data!.alertData!.lastLogin;
            var displayDateFormatter = new DateFormat('MMM dd, yyyy hh:mm a');
            var date = DateTime.parse(displayDate!);
            String formattedDate = displayDateFormatter.format(date);
            lastLogin.value = formattedDate;
            debugPrint(" lastLogin  ${lastLogin.value}");
          }
          if (response.data!.alertData!.profilePhotoUrl != null) {
            profilePhotoUrl.value = response.data!.alertData!.profilePhotoUrl!;
          }
        } else {
          Utility.showToastMessage(response.error!.message);
        }

      }else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future<void> autoFetchData() async {
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    String version = await Utility.getVersionInfo();
      mobileExist.value = mobile!;
      userEmail.value = email;
      versionName.value = version;
  }

  Future<void> getLoanDetails() async {
    if (await _connectionInfo.isConnected){
      DataState<MyLoansResponseEntity> response = await _getMyActiveLoansUseCase.call();

      if(response is DataSuccess){

        if (response.data!.message!.data!.loans!.length  != 0) {
          canPledge.value = response.data!.message!.data!.canPledge!;
          loanName.value = response.data!.message!.data!.loans![response.data!.message!.data!.loans!.length - 1].name!;
          drawingPower = response.data!.message!.data!.loans![response.data!.message!.data!.loans!.length - 1].drawingPower;
          totalCollateral = response.data!.message!.data!.loans![response.data!.message!.data!.loans!.length - 1].totalCollateralValue;
          sanctionedLimit = response.data!.message!.data!.loans![response.data!.message!.data!.loans!.length - 1].totalCollateralValue;
          // preferences.setLoanApplicationNo(loanName!);
          // preferences.setDrawingPower(drawingPower.toString());
          // preferences.setSanctionedLimit(sanctionedLimit.toString());
          GetLoanDetailsRequestEntity loanDetailsRequestEntity = GetLoanDetailsRequestEntity(loanName:loanName.value, transactionsPerPage: 15, transactionsStart: 0,);
          DataState<LoanDetailsResponseEntity> loanDetailsResponse = await _getLoanDetailsUseCase.call(GetLoanDetailsParams(loanDetailsRequestEntity: loanDetailsRequestEntity));

         if(loanDetailsResponse is DataSuccess){
           if(loanDetailsResponse.data != null) {
               drawingPowerStr.value = loanDetailsResponse.data!.data!.loan!.drawingPowerStr!;
               totalCollateralStr.value = loanDetailsResponse.data!.data!.loan!.totalCollateralValueStr!;
               stockAt.value = loanDetailsResponse.data!.data!.pledgorBoid!;
               loanType!.value = loanDetailsResponse.data!.data!.loan!.instrumentType!;
               loanType!.value = loanDetailsResponse.data!.data!.loan!.schemeType!;
               if (loanDetailsResponse.data!.data!.loan != null) {
                 loanBalance!.value = loanDetailsResponse.data!.data!.loan!.balance!;
               }

               if (loanDetailsResponse.data!.data!.increaseLoan != null) {
                 isIncreaseLoanExist.value = true;
               } else {
                 isIncreaseLoanExist.value = false;
               }
               if (loanDetailsResponse.data!.data!.topUpApplication == null) {
                 isTopUpExist.value = true;
                 topUpApplicationName.value = loanDetailsResponse.data!.data!.topUpApplicationName!;
               } else {
                 isTopUpExist.value = false;
               }
               if (loanDetailsResponse.data!.data!.unpledge != null) {
                 isUnpledgeExist.value = true;
                 if (loanDetailsResponse.data!.data!.unpledge!.unpledgeMsgWhileMarginShortfall != null) {
                   unPledgeMarginShortFallMsg!.value = loanDetailsResponse.data!.data!.unpledge!.unpledgeMsgWhileMarginShortfall!;
                 }
               } else {
                 isUnpledgeExist.value = false;
               }
               if (loanDetailsResponse.data!.data!.sellCollateral != null) {
                 isSellCollateralExist.value = true;
               } else {
                 isSellCollateralExist.value = false;
               }
               if (loanDetailsResponse.data!.data!.isSellTriggered == 1) {
                 isSellTriggered.value = true;
               } else {
                 isSellTriggered.value = false;
               }
               if (loanDetailsResponse.data!.data!.marginShortfall != null) {
                 isMarginShortFall.value = true;
                 marginShortfall = loanDetailsResponse.data!.data!.marginShortfall!;
               } else {
                 isMarginShortFall.value = false;
               }

               if (loanDetailsResponse.data!.data!.interest != null) {
                 interest!.value = loanDetailsResponse.data!.data!.interest!;
               }

               isPayment!.value = loanDetailsResponse.data!.data!.paymentAlreadyInProcess!;

               isAPIRespond.value = true;
               isLoanExist.value = true;

           } else {
             commonDialog(loanDetailsResponse.error!.message, 3);
                        isAPIRespond.value = true;
           }
         }
        } else {
          isAPIRespond.value = true;
          canPledge.value = response.data!.message!.data!.canPledge!;
        }
      }else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  void manageSettingsClicked()  {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        ///todo: change following code after AccountSettingScreen screen completed
        // final result = await Navigator.push(context, MaterialPageRoute(builder: (context) => AccountSettingScreen()));
        // if(result != null) {
        //   if (profilePhotoUrl.isEmpty) {
        //     getLastLogInDetails();
        //   }
        // }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void increaseLimitClicked() {
    Utility.isNetworkConnection()
        .then((isNetwork) {
      if (isNetwork) {
        if(loanType == Strings.mutual_fund){
          if (isIncreaseLoanExist.value) {
            ///todo: change following code after MFIncreaseLoan screen completed
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => MFIncreaseLoan(loanName!, Strings.increase_loan, null, loanType!, schemeType!)));
          } else {
            commonDialog(Strings.increase_loan_request_pending, 0);
          }
        } else {
          if (isIncreaseLoanExist.value) {
            if(!isTopUpExist.value){
              ///todo: change following code after IncreaseLoanLimit screen completed
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext
              //         context) =>
              //             IncreaseLoanLimit(
              //                 drawingPower,
              //                 totalCollateral,
              //                 loanName,
              //                 drawingPowerStr,
              //                 totalCollateralStr,
              //                 stockAt)));
            }else{
              commonDialog( "Your top-up application: ${topUpApplicationName.toString()} is pending", 0);
            }
          } else {
            commonDialog(
                Strings.pending_increase_loan, 0);
          }
        }
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  void logOutClicked() {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        MoreController controller = MoreController(_getMyActiveLoansUseCase,_connectionInfo, _getLoanDetailsUseCase,_getProfileSetAlertUseCase);
        logoutConfirmDialog(controller);
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void yesClicked() {
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
        Get.offNamedUntil(
          pinView,
          (route) => false,
        );
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
    //userLogout(context);
  }

  void sellCollateralOrInvokeClicked()  {
    Utility.isNetworkConnection()
        .then((isNetwork) {
      if (isNetwork) {
        if (isSellCollateralExist.value) {
          if(!isSellTriggered.value){
            if(loanType == Strings.shares){
              ///todo: change following code after SellCollateralScreen screen completed
              // Navigator.push(context, MaterialPageRoute(
              //     builder: (BuildContext context) => SellCollateralScreen(
              //         loanName!,
              //         Strings.all,
              //         "", loanType!)));
            }else{
              ///todo: change following code after MFInvokeScreen screen completed
              // Navigator.push(context, MaterialPageRoute(
              //     builder: (BuildContext context) => MFInvokeScreen(
              //         loanName!,
              //         Strings.all,
              //         "", "")));
            }

          } else {
            commonDialog( Strings.sale_triggered_small, 0);
          }
        } else {
          commonDialog(loanType == Strings.shares ? Strings.sell_collateral_request_pending : Strings.invoke_request_pending, 0);
        }
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  void loanAccStatementClicked() {
    Utility.isNetworkConnection()
        .then((isNetwork) {
      if (isNetwork) {
        ///todo: change following code after LoanStatementScreen screen completed
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) =>
        //             LoanStatementScreen(
        //                 loanName,
        //                 loanBalance,
        //                 drawingPower, loanType)));
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  void paymentClicked() {
    Utility.isNetworkConnection()
        .then((isNetwork) {
      if (isNetwork) {
        if (isPayment == 0) {
          ///todo: change following code after PaymentScreen screen completed
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) => PaymentScreen(
          //             loanName,
          //             // isMarginShortFall,
          //             marginShortfall != null ? marginShortfall!.status == "Pending" ? true : false : false,
          //             marginShortfall != null ? marginShortfall!.shortfallC : "",
          //             marginShortfall != null ? marginShortfall!.minimumCollateralValue : "",
          //             marginShortfall != null ? marginShortfall!.totalCollateralValue : "",
          //             marginShortfall != null
          //                 && marginShortfall!.status != "Sell Triggered"
          //                 && marginShortfall!.status != "Request Pending" ? marginShortfall!.name : "",
          //             marginShortfall != null ? marginShortfall!.minimumCashAmount! : 0.0,
          //             interest != null ? 1 : 0)));
        } else {
          commonDialog(
              Strings.pending_payment, 0);
        }
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  void pledgeClicked() {
    Utility.isNetworkConnection()
        .then((isNetwork) {
      if (isNetwork) {
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobileExist;
        parameter[Strings.email] = userEmail;
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.new_loan_click, parameter);
        ///todo: change following code after ApprovedSharesScreen screen completed
        // Navigator.push(context, MaterialPageRoute(
        //     builder: (BuildContext context) => ApprovedSharesScreen()));
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  unPledgeClicked() {
    Utility.isNetworkConnection()
        .then((isNetwork) {
      if (isNetwork) {
        if (unPledgeMarginShortFallMsg == null) {
          if (isUnpledgeExist.value) {
            if(loanType == Strings.shares) {
              ///todo: change following code after UnpledgeSharesScreen screen completed
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (BuildContext context) =>
              //         UnpledgeSharesScreen(loanName!, Strings.all, "", loanType!)));
            } else {
              ///todo: change following code after MFRevokeScreen screen completed
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (BuildContext context) =>
              //         MFRevokeScreen(loanName!, Strings.all, "", "")));
            }
          } else {
            commonDialog(loanType == Strings.shares ? Strings.unpledge_request_pending : Strings.revoke_request_pending, 0);
          }
        } else {
          commonDialog(
              unPledgeMarginShortFallMsg
                  .toString(),
              0);
        }
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  void approvedSchemeOrSecurityClicked() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        ///todo: change following code after ApprovedSecuritiesScreen screen completed
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder:
        //             (BuildContext context) =>
        //             ApprovedSecuritiesScreen()));
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  feedbackClicked() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        ///todo: change following code after NewFeedbackScreen screen completed
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) =>
        //             NewFeedbackScreen(
        //                 Strings.more_menu, 0)));
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  void contactUsClicked() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        ///todo: change following code after ContactUsScreen screen completed
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (BuildContext context) =>
        //             ContactUsScreen()));
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  void fAQClicked() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        ///todo: change following code after CommonWebViewScreen screen completed
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //         builder: (context) =>
        //             CommonWebViewScreen(
        //                 1, "Help / FAQs")));
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }
}