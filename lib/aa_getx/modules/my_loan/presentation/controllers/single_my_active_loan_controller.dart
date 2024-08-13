import 'dart:convert';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/all_loan_names_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/usecases/get_all_loans_name_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/arguments/margin_shortfall_arguments.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Utility.dart';
import 'package:cron/cron.dart';
import 'package:flutter/material.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';

class SingleMyActiveLoanController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  var fileId;
  TargetPlatform? platform;
  var drawingPower, sanctionedValue, loanBalance;
  RxString baseURL = "".obs;
  Rx<LoanEntity?> loans = LoanEntity().obs;
  Rx<MarginShortfallEntity?> marginShortfall = MarginShortfallEntity().obs;
  Rx<InterestEntity?> interest = InterestEntity().obs;
  Rx<LoanDetailDataEntity?> loanDetailData = LoanDetailDataEntity().obs;
  Preferences preferences = new Preferences();
  var now = new DateTime.now();
  RxBool loanDialogVisibility = true.obs;
  RxString loanNumber = "".obs;
  RxString interestDueDate = "".obs;
  RxInt dpdText = 0.obs;
  bool isLoading = true;
  RxBool isSellCollateral = false.obs;
  RxBool isIncreaseLoan = false.obs;
  RxBool isPayment = false.obs;
  RxBool isMarginShortFall = false.obs;
  RxBool isTimerDone = false.obs;
  RxBool isActionTaken = false.obs;

  // int hours = 0, min = 0, sec = 0;
  RxInt hours = 0.obs;
  RxInt min = 0.obs;
  RxInt sec = 0.obs;
  TextEditingController topUpAmountController = TextEditingController();
  RxString responseText = Strings.please_wait.obs;
  LoanDetailsResponseEntity? loanDetailsResponse;
  int isTodayHoliday = 0;
  var cron = new Cron();
  RxString loanType = "".obs;
  RxString schemeType = "".obs;
  final ConnectionInfo _connectionInfo;
  final GetAllLoansNamesUseCase _getAllLoansNamesUseCase;
  final GetLoanDetailsUseCase _getLoanDetailsUseCase;

  SingleMyActiveLoanController(this._connectionInfo,
      this._getAllLoansNamesUseCase, this._getLoanDetailsUseCase);

  @override
  void onInit() {
    getData();
    runClone();
    getLoanDetails();

    /// will check the network connection before API call inside this function that's why below code is commented.
    // Utility.isNetworkConnection().then((isNetwork) {
    //   if (isNetwork) {
    //     getLoanDetails();
    //   } else {
    //     Utility.showToastMessage(Strings.no_internet_message);
    //   }
    // });
    super.onInit();
  }

  runClone() {
    cron.schedule(new Schedule.parse('0 0 * * *'), () async {
      getLoanDetails();
    });
  }

  void getLoanDetails() async {
    if (await _connectionInfo.isConnected) {
      DataState<AllLoanNamesResponseEntity> response =
          await _getAllLoansNamesUseCase.call();
      if (response is DataSuccess) {
        if (response.data != null) {
          if (response.data!.allLoansNameData != null) {
            loanNumber.value = response.data!.allLoansNameData![0].name!;
            getSingleLoanData(loanNumber);
          } else {
            responseText.value = Strings.no_loan;
          }
        } else {
          responseText.value = Strings.no_loan;
        }
      } else if (response is DataFailed) {
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

  void getData() async {
    String? base_url = await preferences.getBaseURL();
    baseURL.value = base_url!;
  }

  void getSingleLoanData(loanName) async {
     //loanDetailsResponse = await myLoansBloc.getLoanDetails(loanName);
    if (await _connectionInfo.isConnected) {
      GetLoanDetailsRequestEntity loanDetailsRequestEntity =
          GetLoanDetailsRequestEntity(
        loanName: loanName,
        transactionsPerPage: 15,
        transactionsStart: 0,
      );
      DataState<LoanDetailsResponseEntity> loanDetailsResponse =
          await _getLoanDetailsUseCase.call(GetLoanDetailsParams(
              loanDetailsRequestEntity: loanDetailsRequestEntity));

      if (loanDetailsResponse is DataSuccess) {
        if (loanDetailsResponse.data!.data!.loan != null) {
          loanDetailData.value = loanDetailsResponse.data!.data;
          drawingPower = loanDetailData.value!.loan!.drawingPower;
          sanctionedValue = loanDetailData.value!.loan!.sanctionedLimit;
          loanBalance = loanDetailData.value!.loan!.balance;
          loans.value = loanDetailsResponse.data!.data!.loan;
          loanNumber.value = loanDetailsResponse.data!.data!.loan!.name!;
          loanType.value =
              loanDetailsResponse.data!.data!.loan!.instrumentType ?? "";
          schemeType.value =
              loanDetailsResponse.data!.data!.loan!.schemeType ?? "";
          if (loanDetailsResponse.data!.data!.marginShortfall != null) {
            isMarginShortFall.value = true;
            marginShortfall.value =
                loanDetailsResponse.data!.data!.marginShortfall;
            if (loanDetailsResponse
                    .data!.data!.marginShortfall!.deadlineInHrs !=
                null) {
              if (loanDetailsResponse
                      .data!.data!.marginShortfall!.deadlineInHrs ==
                  "00:00:00") {
                isTimerDone.value = true;
              }
              if (loanDetailsResponse.data!.data!.marginShortfall!.status ==
                  "Request Pending") {
                isActionTaken.value = true;
              }

              hours.value = int.parse(loanDetailsResponse
                  .data!.data!.marginShortfall!.deadlineInHrs!
                  .split(":")[0]);
              min.value = int.parse(loanDetailsResponse
                  .data!.data!.marginShortfall!.deadlineInHrs!
                  .split(":")[1]);
              sec.value = int.parse(loanDetailsResponse
                  .data!.data!.marginShortfall!.deadlineInHrs!
                  .split(":")[2]);
              isTodayHoliday = loanDetailsResponse
                  .data!.data!.marginShortfall!.isTodayHoliday!;
            } else {
              isActionTaken.value = true;
              isTimerDone.value = true;
            }
          }
          if (loanDetailsResponse.data!.data!.interest != null) {
            interest.value = loanDetailsResponse.data!.data!.interest;
            //interestDueDate.value = interest!.dueDate;
            interestDueDate.value = interest.value!.dueDate!;
            dpdText.value = interest.value!.dpdText!;
          }
          if (loanDetailsResponse.data!.data!.sellCollateral == null) {
            isSellCollateral.value = true;
          } else {
            isSellCollateral.value = false;
          }
          if (loanDetailsResponse.data!.data!.increaseLoan != null) {
            isIncreaseLoan.value = true;
          } else {
            isIncreaseLoan.value = false;
          }

          if (loanDetailsResponse.data!.data!.paymentAlreadyInProcess !=
              null) {
            isPayment.value = true;
          } else {
            isPayment.value = false;
          }
          // preferences. setDrawingPower(loanDetailsResponse!.data!.loan!.drawingPowerStr!);
          // preferences.setSanctionedLimit(loanDetailsResponse!.data!.loan!.sanctionedLimitStr!);
        }
      } else if (loanDetailsResponse is DataFailed) {
        if (loanDetailsResponse.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(loanDetailsResponse.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  withdrawClicked() {
    if (loanDetailData.value!.loan!.balance! <=
        loanDetailData.value!.loan!.drawingPower!) {
      Utility.isNetworkConnection().then((isNetwork) {
        if (isNetwork) {
          if (loanDetailData.value!.loanRenewalIsExpired == 1 &&
              loanDetailData.value!.loan!.balance! > 0) {
            commonDialog("Account debit freeze\nWithdrawal disabled", 0);
          } else {
            /// todo: uncomment and change following code after LoanWithdrawScreen page is completed
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext contex) => LoanWithdrawScreen(loanNumber)));
          }
        } else {
          Utility.showToastMessage(Strings.no_internet_message);
        }
      });
    } else {
      Utility.showToastMessage(Strings.withdraw_amount_message);
    }
  }

  increaseLoanClicked() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if (loanType == Strings.mutual_fund) {
          if (isIncreaseLoan.value) {
            /// todo: uncomment and change following code after MFIncreaseLoan page is completed
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => MFIncreaseLoan(loanNumber.value, Strings.increase_loan, null, loanType!.value, schemeType!.value)));
          } else {
            commonDialog(Strings.increase_loan_request_pending, 0);
          }
        } else {
          if (isIncreaseLoan.value) {
            if (loanDetailsResponse!.data!.topUpApplication == 1) {
              /// todo: uncomment and change following code after IncreaseLoanLimit page is completed
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) =>
              //             IncreaseLoanLimit(
              //                 loanDetailData!.value!.loan!.drawingPower,
              //                 loanDetailData!.value!.loan!.totalCollateralValue,
              //                 loanDetailData!.value!.loan!.name,
              //                 loanDetailData!.value!.loan!.drawingPowerStr,
              //                 loanDetailData!.value!.loan!.totalCollateralValueStr,
              //                 loanDetailData!.value!.pledgorBoid)));
              debugPrint(
                  "loanDetailData!.pledgorBoid${loanDetailData.value!.pledgorBoid}");
            } else {
              commonDialog(
                  "Your top-up application: ${loanDetailsResponse!.data!.topUpApplicationName} is pending",
                  0);
            }
          } else {
            commonDialog(Strings.pending_increase_loan, 0);
          }
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  payNowClicked() {
    // if (loanDetailData!.loan!.balance == 0.0) {
    //   paaymentDialog();
    // } else {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        debugPrint("interest${jsonEncode(interest)}");

        if (loanDetailData.value!.paymentAlreadyInProcess == 0) {
          /// todo: uncomment and change following code after PaymentScreen page is completed
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext contex) =>
          //             PaymentScreen(loanNumber,
          //                 // isMarginShortFall,
          //                 marginShortfall != null ? marginShortfall!.value!.status == "Pending" ? true : false : false,
          //                 marginShortfall != null ? marginShortfall!.value!.shortfallC : "",
          //                 marginShortfall != null ? marginShortfall!.value!.minimumCollateralValue : "",
          //                 marginShortfall != null ? marginShortfall!.value!.totalCollateralValue : "",
          //                 marginShortfall != null
          //                     && marginShortfall!.value!.status != "Sell Triggered"
          //                     && marginShortfall!.value!.status != "Request Pending" ? marginShortfall!.value!.name : "",
          //                 marginShortfall != null ? marginShortfall!.value!.minimumCashAmount! : 0.0, interest != null ? 1: 0)));
        } else {
          commonDialog(Strings.pending_payment, 0);
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
    // }
  }

  addTopUpClicked() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if (loanDetailsResponse!.data!.increaseLoan == 1) {
          /// todo: uncomment and change following code after SubmitTopUP page is completed
          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (BuildContext context) =>
          //             SubmitTopUP(
          //                 loanDetailData!.value!.topUp,
          //                 loanNumber)));
        } else {
          commonDialog(
              "Your increase loan application: ${loanDetailsResponse!.data!.increaseLoanName.toString()} is pending",
              0);
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  payNowInterestScreenClicked() {
    /// todo: uncomment and change following code after InterestScreen page is completed
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext
    //         context) =>
    //             InterestScreen(
    //                 interest!.value!.totalInterestAmt!,
    //                 loanDetailData!
    //                     .value!.loan!.name!,
    //                 loanDetailData!
    //                     .value!.loan!.balance!,
    //                 interestDueDate!.value)));
  }

  openBottomSheet() {
    debugPrint("shortfall__${jsonEncode(marginShortfall)}");
    // showModalBottomSheet(
    //     backgroundColor: Colors.transparent,
    //     context: context,
    //     isScrollControlled: true,
    //     builder: (BuildContext bc) {
    //       return marginShortfallInfo(
    //           context,
    //           marginShortfall.loanBalance,
    //           marginShortfall
    //               .minimumCashAmount,
    //           drawingPower,
    //           marginShortfall.shortfallC,
    //           loanType);
    //     });

    Get.bottomSheet(
      marginShortfallInfo(
          marginShortfall.value!.loanBalance,
          marginShortfall.value!.minimumCashAmount,
          drawingPower,
          marginShortfall.value!.shortfallC,
          loanType),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  actionTakenOrRequestPendingClicked() async {
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();

    // Firebase Event
    Map<String, dynamic> parameter = new Map<String, dynamic>();
    parameter[Strings.mobile_no] = mobile;
    parameter[Strings.email] = email;
    parameter[Strings.margin_shortfall_name] = marginShortfall.value!.name;
    parameter[Strings.loan_number] = loanDetailData.value!.loan!.name;
    parameter[Strings.margin_shortfall_status] = marginShortfall.value!.status;
    parameter[Strings.date_time] = getCurrentDateAndTime();
    firebaseEvent(Strings.margin_shortFall_click, parameter);

    Get.toNamed(marginShortfallView, arguments: MarginShortfallArguments(
        loanData: loanDetailData.value,
        pledgorBoid:  loanDetailData.value!.pledgorBoid!,
        isSellCollateral: isSellCollateral.value,
        isSaleTriggered: isTimerDone.value,
        isRequestPending:  marginShortfall.value!.status ==
            "Request Pending"
            ? true
            : false,
        msg: marginShortfall.value!.actionTakenMsg ?? "",
        loanType: loanType.value,
        schemeType: schemeType.value));
  }

  viewLoanStatement() {
    /// todo: uncomment and change following code after LoanStatementScreen page is completed
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //         builder: (BuildContext context) => LoanStatementScreen(loanNumber,
    //             loanDetailData!.value!.loan!.balance, loanDetailData!.value!.loan!.drawingPower, loanType)));
  }
}
