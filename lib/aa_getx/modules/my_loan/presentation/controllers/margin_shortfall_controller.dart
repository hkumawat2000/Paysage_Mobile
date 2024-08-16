import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/lender_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/request/securities_request_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/securities_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/usecases/get_lenders_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/usecases/get_securities_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/arguments/margin_shortfall_arguments.dart';

class MarginShortfallController extends GetxController{
  List<SecuritiesListDataEntity> sharesList = [];
  // List<String>? stockAt;
  Preferences preferences = new Preferences();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  RxList<bool> selectedBoolLenderList = <bool>[].obs;
  RxList<bool> selectedBoolLevelList = <bool>[].obs;
  RxList<String> selectedLenderList = <String>[].obs;
  RxList<String> selectedLevelList = <String>[].obs;
  RxList<String> lenderList = <String>[].obs;
  RxList<String> levelList = <String>[].obs;
  List<LenderInfoEntity> lenderInfo = [];
  MarginShortfallArguments marginShortfallArguments = Get.arguments;
  final GetLendersUseCase _getLendersUseCase;
  final ConnectionInfo _connectionInfo;
  final GetSecuritiesUseCase _getSecuritiesUseCase;

  MarginShortfallController(this._getLendersUseCase, this._connectionInfo, this._getSecuritiesUseCase);

  Future getDetails() async {
    if (await _connectionInfo.isConnected) {
      showDialogLoading(Strings.please_wait);
      DataState<LenderResponseEntity> lenderResponse =
          await _getLendersUseCase.call();
      if (lenderResponse is DataSuccess) {
        if (lenderResponse.data != null) {
          selectedLenderList.clear();
          selectedLevelList.clear();
          for (int i = 0; i < lenderResponse.data!.lenderData!.length; i++) {
            lenderList.add(lenderResponse.data!.lenderData![i].name!);
            selectedLenderList.add(lenderResponse.data!.lenderData![i].name!);
            selectedBoolLenderList.add(true);
            levelList.addAll(lenderResponse.data!.lenderData![0].levels!);
            lenderResponse.data!.lenderData![0].levels!.forEach((element) {
              selectedLevelList.add(element.toString().split(" ")[1]);
              selectedBoolLevelList.add(true);
            });
          }
          getSecurities();
        }
      } else if (lenderResponse is DataFailed) {
        if (lenderResponse.error!.statusCode! == 403) {
          Get.back();
          commonDialog(Strings.session_timeout, 4);
        } else {
          Get.back();
          Utility.showToastMessage(lenderResponse.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  Future payAmountClicked() async {
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if(!marginShortfallArguments.isRequestPending!) {
          if(!marginShortfallArguments.isSaleTriggered!) {

            // Firebase Event
            Map<String, dynamic> parameter = new Map<String, dynamic>();
            parameter[Strings.mobile_no] = mobile;
            parameter[Strings.email] = email;
            parameter[Strings.margin_shortfall_name] = marginShortfallArguments.loanData!.marginShortfall!.name;
            parameter[Strings.loan_number] = marginShortfallArguments.loanData!.loan!.name;
            parameter[Strings.margin_shortfall_status] = marginShortfallArguments.loanData!.marginShortfall!.status;
            parameter[Strings.action_type] = 'Pay Amount';
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.margin_shortFall_action, parameter);
            ///todo: uncomment following code after PaymentScreen is developed
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => PaymentScreen(
            //             marginShortfallArguments.loanData!.loan!.name,
            //             true,
            //             marginShortfallArguments.loanData!.marginShortfall!.shortfallC,
            //             marginShortfallArguments.loanData!.marginShortfall!.minimumCollateralValue,
            //             marginShortfallArguments.loanData!.marginShortfall!.totalCollateralValue,
            //             marginShortfallArguments.loanData!.marginShortfall!.name,
            //             marginShortfallArguments.loanData!.marginShortfall!.minimumCashAmount!,0)));
          } else {
            commonDialog(Strings.sale_triggered_small, 0);
          }
        } else {
          commonDialog( Strings.request_pending, 0);
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Future pledgeMoreClicked()  async {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        if(!marginShortfallArguments.isRequestPending!) {
          if(!marginShortfallArguments.isSaleTriggered!) {
            String? mobile = await preferences.getMobile();
            String email = await preferences.getEmail();
            // Firebase Event
            Map<String, dynamic> parameter = new Map<String, dynamic>();
            parameter[Strings.mobile_no] = mobile;
            parameter[Strings.email] = email;
            parameter[Strings.margin_shortfall_name] = marginShortfallArguments.loanData!.marginShortfall!.name;
            parameter[Strings.loan_number] = marginShortfallArguments.loanData!.loan!.name;
            parameter[Strings.margin_shortfall_status] = marginShortfallArguments.loanData!.marginShortfall!.status;
            parameter[Strings.action_type] = 'Pledge More';
            parameter[Strings.date_time] = getCurrentDateAndTime();
            firebaseEvent(Strings.margin_shortFall_action, parameter);

            if(marginShortfallArguments.loanType == Strings.mutual_fund){
              ///todo: uncomment following code after MFIncreaseLoan is developed
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => MFIncreaseLoan(marginShortfallArguments.loanData!.loan!.name!,Strings.margin_shortfall, marginShortfallArguments.loanData, marginShortfallArguments.loanType, marginShortfallArguments.schemeType)));
            }else{
              getDetails();
            }

          } else {
            commonDialog( Strings.sale_triggered_small, 0);
          }
        } else {
          commonDialog( Strings.request_pending, 0);
        }

      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Future sellOrInvokeClicked() async {
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if(!marginShortfallArguments.isRequestPending!) {
          if(!marginShortfallArguments.isSaleTriggered!) {
            if(!marginShortfallArguments.isSellCollateral!) {
              // Firebase Event
              Map<String, dynamic> parameter = new Map<String, dynamic>();
              parameter[Strings.mobile_no] = mobile;
              parameter[Strings.email] = email;
              parameter[Strings.margin_shortfall_name] = marginShortfallArguments.loanData!.marginShortfall!.name;
              parameter[Strings.loan_number] = marginShortfallArguments.loanData!.loan!.name;
              parameter[Strings.margin_shortfall_status] = marginShortfallArguments.loanData!.marginShortfall!.status;
              parameter[Strings.action_type] = 'Sell';
              parameter[Strings.date_time] = getCurrentDateAndTime();
              firebaseEvent(Strings.margin_shortFall_action, parameter);

              if(marginShortfallArguments.loanType == Strings.shares){
                ///todo: uncomment following code after SellCollateralScreen is developed
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) =>
                //             SellCollateralScreen(marginShortfallArguments.loanData!.loan!.name!, Strings.all, "", marginShortfallArguments.loanType)));
              }else{
                ///todo: uncomment following code after MFInvokeScreen is developed
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (BuildContext context) =>
                //             MFInvokeScreen(marginShortfallArguments.loanData!.loan!.name!, Strings.all, "", "")));
              }
            } else {
              commonDialog( marginShortfallArguments.loanType == Strings.shares ? Strings.sell_collateral_request_pending : Strings.invoke_request_pending, 0);
            }
          } else {
            commonDialog( Strings.sale_triggered_small, 0);
          }
        } else {
          commonDialog( Strings.request_pending, 0);
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  Future<void> getSecurities() async {
    SecuritiesRequestEntity securitiesRequestEntity = SecuritiesRequestEntity(
        lender: selectedLenderList.join(","),
        level: selectedLevelList.join(","),
        demat: marginShortfallArguments.pledgorBoid);
    DataState<SecuritiesResponseEntity> securitiesResponse =
        await _getSecuritiesUseCase.call(SecuritiesRequestParams(
            securitiesRequestEntity: securitiesRequestEntity));
    Get.back();
    if (securitiesResponse is DataSuccess) {
      if (securitiesResponse.data != null) {
        sharesList = securitiesResponse.data!.securityData!.securities!;
        List<SecuritiesListDataEntity> securities = [];
        for (var i = 0; i < sharesList.length; i++) {
          if (sharesList[i].isEligible == true &&
              sharesList[i].quantity != 0 &&
              sharesList[i].price != 0 &&
              sharesList[i].stockAt == marginShortfallArguments.pledgorBoid) {
            var temp = sharesList[i];
            // temp.quantity = temp.quantity;
            securities.add(sharesList[i]);
          }
        }
        lenderInfo.addAll(securitiesResponse.data!.securityData!.lenderInfo!);
        // stockAt = List.generate(securities.length, (index) => securities[index].stockAt!).toSet().toList();

        if (securities.length != 0) {
          ///todo: uncomment following code after NewIncreaseLoanScreen is developed
          //   Navigator.push(context, MaterialPageRoute(
          //       builder: (BuildContext context) => NewIncreaseLoanScreen(marginShortfallArguments.loanData!.marginShortfall, Strings.margin_shortfall, securities, widget.pledgorBoid,
          //           marginShortfallArguments.loanData!.loan!.name!,
          //           lenderInfo,
          //           lenderList,
          //           levelList)));
        } else {
          commonDialog(Strings.not_fetch, 0);
        }
      }
    } else if (securitiesResponse is DataFailed) {
      if (securitiesResponse.error!.statusCode! == 403) {
        commonDialog(Strings.session_timeout, 4);
      } else if (securitiesResponse.error!.statusCode! == 404) {
        commonDialog(Strings.not_fetch, 0);
      } else {
        Utility.showToastMessage(securitiesResponse.error!.message);
      }
    }
  }
}