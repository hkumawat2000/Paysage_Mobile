import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/account_statement/presentation/arguments/loan_statement_arguments.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/all_loan_names_response_entity.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/usecases/get_all_loans_name_usecase.dart';
import 'package:lms/aa_getx/modules/pledged_securities/data/models/request/my_pledged_securities_request_model.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/entities/my_pledged_securities_details_response_entity.dart';
import 'package:lms/aa_getx/modules/pledged_securities/domain/usecases/get_my_pledged_securities_usecase.dart';
import 'package:lms/network/requestbean/SellCollateralRequestBean.dart';
import 'package:lms/network/requestbean/UnpledgeRequestBean.dart';
import 'package:lms/pledged_securities/MyPledgedSecuritiesBloc.dart';

class MyPledgeSecurityController extends GetxController{
  final ConnectionInfo _connectionInfo;
  final GetAllLoansNamesUseCase _getAllLoansNamesUseCase;
  final GetLoanDetailsUseCase _getLoanDetailsUseCase;
  final GetMyPledgedSecuritiesUseCase _getMyPledgedSecuritiesUseCase;

  MyPledgeSecurityController(this._connectionInfo,
      this._getAllLoansNamesUseCase, this._getLoanDetailsUseCase, this._getMyPledgedSecuritiesUseCase);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final myPledgedSecuritiesBloc = MyPledgedSecuritiesBloc();
  RxString loanName = "".obs;
  RxString selectedScrips = "".obs;
  RxDouble totalValue = 0.0.obs;
  RxDouble drawingPower = 0.0.obs;
  RxDouble loanBalance = 0.0.obs;
  RxString responseText = Strings.please_wait.obs;
  Rx<MyPledgedSecuritiesDetailsResponseEntity?> pledgedResponse = Rxn<MyPledgedSecuritiesDetailsResponseEntity>();
  RxList<AllPledgedSecuritiesEntity> allPledgedSecurities = <AllPledgedSecuritiesEntity>[].obs;
  RxList<bool> pressDownList = <bool>[].obs;
  List<SellList> sellList = [];
  List<UnPledgeList> unPledgeList = [];
  RxBool isIncreaseLoan = false.obs;
  RxBool isUnpledge = false.obs;
  RxBool isSellCollateral = false.obs;
  RxBool isSellTriggered = false.obs;
  RxString unPledgeMarginShortFallMsg="".obs;
  RxString loanType="".obs;
  RxString schemeType = "".obs;

  @override
  void onInit() {
    super.onInit();
    getAllLoansName();
  }


  Future<void> pullRefresh() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        getAllLoansName();
      } else {
        commonDialog(Strings.no_internet_message, 0);
      }
    });
  }

  Future<void> getAllLoansName() async{
    if (await _connectionInfo.isConnected) {
      DataState<AllLoanNamesResponseEntity> response =
      await _getAllLoansNamesUseCase.call();
      if (response is DataSuccess) {
        if (response.data != null) {
          if (response.data!.allLoansNameData != null) {
            loanName.value = response.data!.allLoansNameData![0].name!;
            getMyPledgedSecuritiesDetails(loanName.value);
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

  Future<void> getMyPledgedSecuritiesDetails(loan_name) async {
    if(await _connectionInfo.isConnected) {
      MyPledgedSecuritiesRequestEntity myPledgedSecuritiesRequestEntity = MyPledgedSecuritiesRequestEntity(loanName: loan_name);
      DataState<MyPledgedSecuritiesDetailsResponseEntity> response = await _getMyPledgedSecuritiesUseCase.call(MyPledgedSecuritiesRequestParams(myPledgedSecuritiesRequestEntity: myPledgedSecuritiesRequestEntity));
      if(response is DataSuccess){
        if(response.data != null){
          pledgedResponse.value = response.data!;
          loanType.value = pledgedResponse.value!.myPledgedSecuritiesData!.instrumentType ?? "";
          schemeType.value = pledgedResponse.value!.myPledgedSecuritiesData!.schemeType ?? "";
          totalValue.value = pledgedResponse.value!.myPledgedSecuritiesData!.totalValue ?? 0.0;
          selectedScrips.value = pledgedResponse.value!.myPledgedSecuritiesData!.numberOfScrips.toString();
          drawingPower.value = pledgedResponse.value!.myPledgedSecuritiesData!.drawingPower ?? 0.0;
          loanBalance.value = pledgedResponse.value!.myPledgedSecuritiesData!.balance ?? 0.0;
          // allPledgedSecurities = pledgedResponse.data.allPledgedSecurities;

          for(int i=0; i< pledgedResponse.value!.myPledgedSecuritiesData!.allPledgedSecurities!.length; i++){
            if(pledgedResponse.value!.myPledgedSecuritiesData!.instrumentType == Strings.shares) {
              if (pledgedResponse.value!.myPledgedSecuritiesData!.allPledgedSecurities![i].pledgedQuantity!.toInt() != 0) {
                allPledgedSecurities.add(pledgedResponse.value!.myPledgedSecuritiesData!.allPledgedSecurities![i]);
              }
            } else {
              if (pledgedResponse.value!.myPledgedSecuritiesData!.allPledgedSecurities![i].pledgedQuantity! >= 0.001) {
                allPledgedSecurities.add(pledgedResponse.value!.myPledgedSecuritiesData!.allPledgedSecurities![i]);
              }
            }
          }

          selectedScrips.value = allPledgedSecurities.length.toString();

          if(pledgedResponse.value!.myPledgedSecuritiesData!.increaseLoan != null){
            isIncreaseLoan.value = true;
          } else {
            isIncreaseLoan.value = false;
          }

          if(pledgedResponse.value!.myPledgedSecuritiesData!.unpledge != null){
            isUnpledge.value = true;
            if(pledgedResponse.value!.myPledgedSecuritiesData!.unpledge!.unpledgeMsgWhileMarginShortfall != null) {
              unPledgeMarginShortFallMsg.value = pledgedResponse.value!.myPledgedSecuritiesData!.unpledge!.unpledgeMsgWhileMarginShortfall!;
            }
          } else {
            isUnpledge.value = false;
          }

          if(pledgedResponse.value!.myPledgedSecuritiesData!.sellCollateral != null){
            isSellCollateral.value = true;
          } else {
            isSellCollateral.value = false;
          }
          if(pledgedResponse.value!.myPledgedSecuritiesData!.isSellTriggered == 1){
            isSellTriggered.value = true;
          } else {
            isSellTriggered.value = false;
          }
        }
      } else if (response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(response.error!.message);
        }
      }
    }else{
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  void pledgedSecuritiesOrSchemesTransactionsClicked() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        Get.toNamed(myPledgedTransactionsView, arguments: LoanStatementArguments(loanName: loanName.value, loanBalance: loanBalance.value, drawingPower: drawingPower.value, loanType: loanType.value));
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void unPledgeOrRevokeClicked() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if(unPledgeMarginShortFallMsg.isEmpty){
          if(isUnpledge.value){
            if(loanType == Strings.shares) {
              ///todo: uncomment following code after UnpledgeSharesScreen in developed
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) => UnpledgeSharesScreen(loanName, Strings.all, "", loanType!)));
            } else {
              ///todo: uncomment following code after MFRevokeScreen in developed
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (BuildContext context) =>
              //         MFRevokeScreen(loanName, Strings.all, "", "")));
            }
          } else {
            commonDialog(loanType == Strings.shares ? Strings.unpledge_request_pending : Strings.revoke_request_pending, 0);
          }
        } else {
          commonDialog(unPledgeMarginShortFallMsg.toString(), 0);
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void pledgeMoreClicked() {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        if(loanType == Strings.mutual_fund){
          if (isIncreaseLoan.value) {
            ///todo: uncomment following code after MFIncreaseLoan in developed
            // Navigator.push(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) => MFIncreaseLoan(loanName, Strings.increase_loan, null, loanType!, schemeType!)));
          } else {
            commonDialog(Strings.increase_loan_request_pending, 0);
          }
        } else {
          if(isIncreaseLoan.value){
            if(pledgedResponse.value!.myPledgedSecuritiesData!.topUpApplication == 1){
              if (await _connectionInfo.isConnected) {
                showDialogLoading(Strings.please_wait);
                GetLoanDetailsRequestEntity loanDetailsRequestEntity =
                    GetLoanDetailsRequestEntity(
                  loanName: loanName.value,
                  transactionsPerPage: 15,
                  transactionsStart: 0,
                );

                DataState<LoanDetailsResponseEntity> loanDetailsResponse =
                    await _getLoanDetailsUseCase.call(GetLoanDetailsParams(
                        loanDetailsRequestEntity: loanDetailsRequestEntity));
                Get.back();
                if (loanDetailsResponse is DataSuccess) {
                  if (loanDetailsResponse.data!.data!.loan != null) {
                    if(loanDetailsResponse.data!.data!.increaseLoan == 1){
                      ///todo: uncomment following code after IncreaseLoanLimit in developed
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (BuildContext context) => IncreaseLoanLimit(
                      //             value.data!.loan!.drawingPower,
                      //             value.data!.loan!.totalCollateralValue,
                      //             value.data!.loan!.name,
                      //             value.data!.loan!.drawingPowerStr,
                      //             value.data!.loan!.totalCollateralValueStr,
                      //             value.data!.pledgorBoid
                      //         )));
                    } else {
                      commonDialog( Strings.increase_loan_request_pending, 0);
                    }
                  } else {
                    commonDialog( Strings.somethingWentWrongTryAgainString, 0);
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
            }else{
              commonDialog( "Your top-up application: ${pledgedResponse.value!.myPledgedSecuritiesData!.topUpApplicationName} is pending", 0);
            }
          } else {
            commonDialog(Strings.increase_loan_request_pending, 0);
          }
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void sellOrInvokeClicked() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if(isSellCollateral.value){
          if(!isSellTriggered.value){
            if(loanType == Strings.shares){
              ///todo: uncomment following code after SellCollateralScreen in developed
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) =>
              //             SellCollateralScreen(loanName,
              //                 Strings.all, "", loanType!)));
            }else{
              ///todo: uncomment following code after MFInvokeScreen in developed
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext context) =>
              //             MFInvokeScreen(loanName,
              //                 Strings.all, "", "")));
            }
          } else {
            commonDialog( Strings.sale_triggered_small, 0);
          }
        } else{
          commonDialog( loanType == Strings.shares ? Strings.sell_collateral_request_pending : Strings.invoke_request_pending, 0);
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

 void pressDownUnpledgeOrRevokeClicked(){
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if (unPledgeMarginShortFallMsg.isEmpty) {
          if (isUnpledge.value) {
            if (loanType == Strings.shares) {
              ///todo: uncomment following code after UnpledgeSharesScreen in developed
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext
              //         context) =>
              //             UnpledgeSharesScreen(
              //                 loanName,
              //                 Strings.single,
              //                 allPledgedSecurities[
              //                 index]
              //                     .isin!,
              //                 loanType!)));
            } else {
              ///todo: uncomment following code after MFRevokeScreen in developed
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext
              //         context) =>
              //             MFRevokeScreen(
              //                 loanName,
              //                 Strings.single,
              //                 allPledgedSecurities[
              //                 index]
              //                     .isin!,
              //                 allPledgedSecurities[
              //                 index]
              //                     .folio!)));
            }
          } else {
            commonDialog(
                loanType == Strings.shares
                    ? Strings.unpledge_request_pending
                    : Strings.revoke_request_pending,
                0);
          }
        } else {
          commonDialog(
              unPledgeMarginShortFallMsg.toString(),
              0);
        }
        ///DC: already commented
        // LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
        // unpledgeBloc.unpledgeDetails(loanName).then((value) {
        //   if(value.isSuccessFull){
        //     if(value.data.unpledge != null){
        //       unPledgeList.clear();
        //       unPledgeList.add(new UnPledgeList(
        //           isin: allPledgedSecurities[index].isin,
        //           quantity: double.parse(allPledgedSecurities[index].pledgedQuantity.toString())
        //       ));
        //       unpledgeBloc.requestUnpledgeOTP().then((value) {
        //         Navigator.pop(context);
        //         if (value.isSuccessFull) {
        //           Utility.showToastMessage(value.message);
        //           showModalBottomSheet(
        //               backgroundColor: Colors.transparent,
        //               context: context,
        //               isScrollControlled: true,
        //               isDismissible: false,
        //               enableDrag: false,
        //               builder: (BuildContext bc) {
        //                 return UnpledgeOTPVerificationScreen(unPledgeList, loanName);
        //               });
        //         } else {
        //           Utility.showToastMessage(value.errorMessage);
        //         }
        //       });
        //     } else {
        //       Navigator.pop(context);
        //       commonDialog(context, 'Previous Unpledge Request is pending. Please Try Again After Sometime.', 0);
        //     }
        //   } else {
        //     Navigator.pop(context);
        //     Utility.showToastMessage(value.errorMessage);
        //   }
        // });
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }

  void pressDownSellOrInvokeClicked()  {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if (isSellCollateral.value) {
          if (!isSellTriggered.value) {
            if (loanType == Strings.shares) {
              ///todo: uncomment following code after SellCollateralScreen in developed
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext
              //         context) =>
              //             SellCollateralScreen(
              //                 loanName,
              //                 Strings.single,
              //                 allPledgedSecurities[
              //                 index]
              //                     .isin!,
              //                 loanType!)));
            } else {
              ///todo: uncomment following code after MFInvokeScreen in developed
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (BuildContext
              //         context) =>
              //             MFInvokeScreen(
              //                 loanName,
              //                 Strings.single,
              //                 allPledgedSecurities[
              //                 index]
              //                     .isin!,
              //                 allPledgedSecurities[
              //                 index]
              //                     .folio!)));
            }
          } else {
            commonDialog(
                Strings.sale_triggered_small, 0);
          }
        } else {
          commonDialog(
              loanType == Strings.shares
                  ? Strings
                  .sell_collateral_request_pending
                  : Strings.invoke_request_pending,
              0);
        }
        ///DC: already commented
        // LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
        // sellList.clear();
        // sellList.add(new SellList(
        //     isin: allPledgedSecurities[index].isin,
        //     quantity: double.parse(allPledgedSecurities[index].pledgedQuantity.toString())
        // ));
        // sellCollateralBloc.requestSellCollateralOTP().then((value) {
        //   Navigator.pop(context);
        //   if (value.isSuccessFull) {
        //     Utility.showToastMessage(Strings.enter_otp);
        //     showModalBottomSheet(
        //       backgroundColor: Colors.transparent,
        //       context: context,
        //       isScrollControlled: true,
        //       isDismissible: false,
        //       enableDrag: false,
        //       builder: (BuildContext bc) {
        //         return SellCollateralOTPScreen(loanName, sellList);
        //       },
        //     );
        //   } else {
        //     Utility.showToastMessage(value.errorMessage);
        //   }
        // });
      } else {
        Utility.showToastMessage(
            Strings.no_internet_message);
      }
    });
  }
}