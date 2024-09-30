
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/payment/domain/entities/request/loan_details_request_entity.dart';
import 'package:lms/aa_getx/modules/payment/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/arguments/mf_invoke_arguments.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/request/unpledge_request_req_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/unpledge_details_response_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/usecases/get_unpledge_details_usecase.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/usecases/request_unpledge_otp_usecase.dart';
import 'package:lms/unpledge/UnpledgeBloc.dart';

class MfRevokeController extends GetxController{
  final ConnectionInfo _connectionInfo;
  final GetUnpledgeDetailsUseCase _getUnpledgeDetailsUseCase;
  final RequestUnpledgeOtpUseCase _requestUnpledgeOtpUseCase;

  MfRevokeController(this._connectionInfo, this._getUnpledgeDetailsUseCase,this._requestUnpledgeOtpUseCase);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Preferences preferences = new Preferences();
  final unpledgeBloc = UnpledgeBloc();
  double? revisedDrawingPower, existingDrawingPower;
  var loanName, loanBalance, revisedCollateral,
      maxAllowableValue, selectedScips, unpledgeScripsValue, totalcollateralValue;
  RxDouble selectedSecurityValue = 0.0.obs, existingCollateral = 0.0.obs;
  List<UnpledgeItemsEntity> unpledgeItemsList = [];
  List<CollateralLedgerEntity> collateralList = [];
  List<UnpledgeItemsEntity> searchMyCartList = [];
  List<bool> unPledgeControllerEnable = [];
  UnpledgeDataEntity unpledgeData = new UnpledgeDataEntity();
  int tempLength = 0;
  List<String>? scripNameList;
  List<String> unitStringList = [];
  List<double>? actualQtyList;
  bool? resetValue;
  List<TextEditingController> controllers = [];
  Rx<UnpledgeDetailsResponseEntity> unpledgeDetailsResponse = UnpledgeDetailsResponseEntity().obs;// response of unpledge details
  Rx<UnpledgeEntity> unpledge = UnpledgeEntity().obs;
  List<bool> checkBoxValues = [];
  bool checkBoxValue = false;
  bool isScripsSelect = true;
  bool canUnpledge = true;
  bool isUnpledgeAlert = false;
  List<bool> isAddBtnShow = [];
  double totalValue = 0;
  double eligibleLoan = 0;
  Widget appBarTitle = new Text(
    "",
    style: new TextStyle(color: Colors.white),
  );
  Icon actionIcon = new Icon(
    Icons.search,
    color: appTheme,
    size: 25,
  );
  TextEditingController textController = TextEditingController();
  double actualDrawingPower = 0;
  String? revocationChargeType;
  double revocationCharge = 0;
  double revocationMinCharge = 0;
  double revocationMaxCharge = 0;
  double revocationPercentage = 0;
  FocusNode focusNode = FocusNode();
  MfInvokeArguments pageArguments = Get.arguments;

  @override
  void onInit() {
    resetValue = true;
    appBarTitle = Text(
      pageArguments.loanNo,
      style: TextStyle(color: appTheme),
    );
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        getUnpledgeDetails(pageArguments.loanNo);
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
    super.onInit();
  }

  getUnpledgeDetails(loan_name) async{
    if (await _connectionInfo.isConnected) {
      LoanDetailsRequestEntity loanDetailsRequestEntity =
          LoanDetailsRequestEntity(loanName: loan_name);
      DataState<UnpledgeDetailsResponseEntity> response =
      await _getUnpledgeDetailsUseCase.call(GetLoanDetailsParams(loanDetailsRequestEntity: loanDetailsRequestEntity));

      if (response is DataSuccess) {
        if(response.data!.unpledgeData!.unpledge != null) {
         // setState(() {
          unpledgeDetailsResponse.value = response.data!;
            unpledgeData = response.data!.unpledgeData!;
            unpledge.value = unpledgeDetailsResponse.value.unpledgeData!.unpledge!;
            actualDrawingPower = 0;
            if(response.data!.unpledgeData!.collateralLedger != null){
              collateralList.addAll(response.data!.unpledgeData!.collateralLedger!);
            }
            for (int i = 0; i < unpledgeData.loan!.items!.length; i++) {
              if(unpledgeData.loan!.items![i].amount != 0.0) {
                unpledgeItemsList.add(unpledgeData.loan!.items![i]);
                controllers.add(TextEditingController());
                actualDrawingPower = actualDrawingPower + ((unpledgeData.loan!.items![i].price! * unpledgeData.loan!.items![i].pledgedQuantity!) * (unpledgeData.loan!.items![i].eligiblePercentage! / 100));
                unitStringList.add("0");
              }
              if(pageArguments.isComingFor == Strings.single){
                if(unpledgeData.loan!.items![i].isin == pageArguments.isin && unpledgeData.loan!.items![i].folio == pageArguments.folio) {
                  selectedScips = 1;
                  selectedSecurityValue.value = 0.0 + unpledgeData.loan!.items![i].amount!;
                  if(unpledgeItemsList[i].pledgedQuantity.toString().split(".")[1].length != 0){
                    var unitsDecimalCount;
                    String str = unpledgeItemsList[i].pledgedQuantity.toString();
                    var qtyArray = str.split('.');
                    unitsDecimalCount = qtyArray[1];
                    if(unitsDecimalCount == "0") {
                      unitStringList[i] = str.toString().split(".")[0];
                    } else {
                      unitStringList[i] = unpledgeItemsList[i].pledgedQuantity.toString();
                    }
                  }
                }
              }
            }
            if(response.data!.unpledgeData!.revokeChargeDetails != null) {
              revocationChargeType = response.data!.unpledgeData!.revokeChargeDetails!.revokeInitiateChargeType;
              if(revocationChargeType == "Fix") {
                revocationCharge = response.data!.unpledgeData!.revokeChargeDetails!.revokeInitiateCharges!;
              } else {
                revocationPercentage = response.data!.unpledgeData!.revokeChargeDetails!.revokeInitiateCharges!;
                revocationMinCharge = response.data!.unpledgeData!.revokeChargeDetails!.revokeInitiateChargesMinimumAmount!;
                revocationMaxCharge = response.data!.unpledgeData!.revokeChargeDetails!.revokeInitiateChargesMaximumAmount!;
                if(selectedSecurityValue != 0){
                  revocationCharge = response.data!.unpledgeData!.revokeChargeDetails!.revokeInitiateChargesMinimumAmount!;
                }else{
                  revocationCharge = 0.00;
                }
              }
            }
            tempLength = unpledgeItemsList.length;
            totalcollateralValue = unpledgeData.loan!.totalCollateralValue;
            loanBalance = response.data!.unpledgeData!.loan!.balance;
            maxAllowableValue = 0;
            unpledgeData.loan!.existingdrawingPower = unpledgeData.loan!.drawingPower;
            unpledgeData.loan!.existingtotalCollateralValue = unpledgeData.loan!.totalCollateralValue;
            existingDrawingPower = unpledgeData.loan!.actualDrawingPower;
            existingCollateral.value = unpledgeData.loan!.existingtotalCollateralValue ?? 0.0;
            revisedCollateral = unpledgeData.loan!.totalCollateralValue;
            revisedDrawingPower = unpledgeData.loan!.actualDrawingPower;
            unpledgeData.loan!.totalCollateralValue = 0;
            if(pageArguments.isComingFor == Strings.all) {
              selectedSecurityValue.value = 0.0;
              selectedScips = 0;
            }
            searchMyCartList.addAll(unpledgeItemsList);
            scripNameList = List.generate(unpledgeData.loan!.items!.length, (index) => unpledgeData.loan!.items![index].securityName!);
            actualQtyList = List.generate(unpledgeItemsList.length, (index) => unpledgeItemsList[index].pledgedQuantity!);
            double actualDP = 0;
            for (int i = 0; i < unpledgeItemsList.length; i++) {
              int actualIndex = searchMyCartList.indexWhere((element) => element.isin == unpledgeItemsList[i].isin && element.folio == unpledgeItemsList[i].folio);

              if(double.parse(unitStringList[actualIndex]) >= 0.001) {
                actualDP = actualDP + ((unpledgeItemsList[i].price! * double.parse(unitStringList[actualIndex])) * (unpledgeItemsList[i].eligiblePercentage! / 100));
              }
            }
            revisedDrawingPower = actualDrawingPower - actualDP;
            double eligibilityPercentage = (revisedDrawingPower! / loanBalance) * 100;
            if (eligibilityPercentage >= 100.00 || selectedScips == 0 || loanBalance <= 0) {
              canUnpledge = true;
            } else {
              canUnpledge = false;
            }
            if(revocationChargeType != "Fix"){
              if(selectedSecurityValue > 0){
                if((selectedSecurityValue * revocationPercentage) / 100 >= revocationMaxCharge){
                  revocationCharge = revocationMaxCharge;
                } else if((selectedSecurityValue * revocationPercentage) / 100 <= revocationMinCharge) {
                  revocationCharge = revocationMinCharge;
                } else {
                  revocationCharge = (selectedSecurityValue * revocationPercentage) / 100;
                }
              }else{
                revocationCharge = 0.00;
              }

            }
         // });
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


    /*unpledgeDetailsResponse = await unpledgeBloc.unpledgeDetails(loan_name);
    if(unpledgeDetailsResponse!.isSuccessFull!){
      if(unpledgeDetailsResponse!.data!.unpledge != null) {
        setState(() {
          unpledgeData = unpledgeDetailsResponse!.data!;
          actualDrawingPower = 0;
          if(unpledgeDetailsResponse!.unpledgeData!.collateralLedger != null){
            collateralList.addAll(unpledgeDetailsResponse!.unpledgeData!.collateralLedger!);
          }
          for (int i = 0; i < unpledgeData.loan!.items!.length; i++) {
            if(unpledgeData.loan!.items![i].amount != 0.0) {
              unpledgeItemsList.add(unpledgeData.loan!.items![i]);
              controllers.add(TextEditingController());
              actualDrawingPower = actualDrawingPower + ((unpledgeData.loan!.items![i].price! * unpledgeData.loan!.items![i].pledgedQuantity!) * (unpledgeData.loan!.items![i].eligiblePercentage! / 100));
              unitStringList.add("0");
            }
            if(pageArguments.isComingFor == Strings.single){
              if(unpledgeData.loan!.items![i].isin == pageArguments.isin && unpledgeData.loan!.items![i].folio == pageArguments.folio) {
                selectedScips = 1;
                selectedSecurityValue = 0.0 + unpledgeData.loan!.items![i].amount!;
                if(unpledgeItemsList[i].pledgedQuantity.toString().split(".")[1].length != 0){
                  var unitsDecimalCount;
                  String str = unpledgeItemsList[i].pledgedQuantity.toString();
                  var qtyArray = str.split('.');
                  unitsDecimalCount = qtyArray[1];
                  if(unitsDecimalCount == "0") {
                    unitStringList[i] = str.toString().split(".")[0];
                  } else {
                    unitStringList[i] = unpledgeItemsList[i].pledgedQuantity.toString();
                  }
                }
              }
            }
          }
          if(unpledgeDetailsResponse!.data!.revokeChargeDetails != null) {
            revocationChargeType = unpledgeDetailsResponse!.data!.revokeChargeDetails!.revokeInitiateChargeType;
            if(revocationChargeType == "Fix") {
              revocationCharge = unpledgeDetailsResponse!.data!.revokeChargeDetails!.revokeInitiateCharges!;
            } else {
              revocationPercentage = unpledgeDetailsResponse!.data!.revokeChargeDetails!.revokeInitiateCharges!;
              revocationMinCharge = unpledgeDetailsResponse!.data!.revokeChargeDetails!.revokeInitiateChargesMinimumAmount!;
              revocationMaxCharge = unpledgeDetailsResponse!.data!.revokeChargeDetails!.revokeInitiateChargesMaximumAmount!;
              if(selectedSecurityValue != 0){
                revocationCharge = unpledgeDetailsResponse!.data!.revokeChargeDetails!.revokeInitiateChargesMinimumAmount!;
              }else{
                revocationCharge = 0.00;
              }
            }
          }
          tempLength = unpledgeItemsList.length;
          totalcollateralValue = unpledgeData.loan!.totalCollateralValue;
          loanBalance = unpledgeDetailsResponse!.data!.loan!.balance;
          maxAllowableValue = 0;
          unpledgeData.loan!.existingdrawingPower = unpledgeData.loan!.drawingPower;
          unpledgeData.loan!.existingtotalCollateralValue = unpledgeData.loan!.totalCollateralValue;
          existingDrawingPower = unpledgeData.loan!.actualDrawingPower;
          existingCollateral = unpledgeData.loan!.existingtotalCollateralValue;
          revisedCollateral = unpledgeData.loan!.totalCollateralValue;
          revisedDrawingPower = unpledgeData.loan!.actualDrawingPower;
          unpledgeData.loan!.totalCollateralValue = 0;
          if(pageArguments.isComingFor == Strings.all) {
            selectedSecurityValue = 0.0;
            selectedScips = 0;
          }
          searchMyCartList.addAll(unpledgeItemsList);
          scripNameList = List.generate(unpledgeData.loan!.items!.length, (index) => unpledgeData.loan!.items![index].securityName!);
          actualQtyList = List.generate(unpledgeItemsList.length, (index) => unpledgeItemsList[index].pledgedQuantity!);
          double actualDP = 0;
          for (int i = 0; i < unpledgeItemsList.length; i++) {
            int actualIndex = searchMyCartList.indexWhere((element) => element.isin == unpledgeItemsList[i].isin && element.folio == unpledgeItemsList[i].folio);

            if(double.parse(unitStringList[actualIndex]) >= 0.001) {
              actualDP = actualDP + ((unpledgeItemsList[i].price! * double.parse(unitStringList[actualIndex])) * (unpledgeItemsList[i].eligiblePercentage! / 100));
            }
          }
          revisedDrawingPower = actualDrawingPower - actualDP;
          double eligibilityPercentage = (revisedDrawingPower! / loanBalance) * 100;
          if (eligibilityPercentage >= 100.00 || selectedScips == 0 || loanBalance <= 0) {
            canUnpledge = true;
          } else {
            canUnpledge = false;
          }
          if(revocationChargeType != "Fix"){
            if(selectedSecurityValue > 0){
              if((selectedSecurityValue * revocationPercentage) / 100 >= revocationMaxCharge){
                revocationCharge = revocationMaxCharge;
              } else if((selectedSecurityValue * revocationPercentage) / 100 <= revocationMinCharge) {
                revocationCharge = revocationMinCharge;
              } else {
                revocationCharge = (selectedSecurityValue * revocationPercentage) / 100;
              }
            }else{
              revocationCharge = 0.00;
            }

          }
        });
      }
    } else if (unpledgeDetailsResponse!.errorCode == 403) {
      commonDialog( Strings.session_timeout, 4);
    } else{
      Get.back();
      Utility.showToastMessage(unpledgeDetailsResponse!.errorMessage!);
    }*/
  }

  void searchResults(String query) {
    List<UnpledgeItemsEntity> dummySearchList = <UnpledgeItemsEntity>[];
    dummySearchList.addAll(searchMyCartList);
    if (query.isNotEmpty) {
      List<UnpledgeItemsEntity> dummyListData = <UnpledgeItemsEntity>[];
      dummySearchList.forEach((item) {
        if (item.securityName!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
     // setState(() {
        unpledgeItemsList.clear();
        unpledgeItemsList.addAll(dummyListData);
     // });
    } else {
     // setState(() {
        unpledgeItemsList.clear();
        unpledgeItemsList.addAll(searchMyCartList);
     // });
    }
  }

  void _handleSearchEnd() {
    //setState(() {
      focusNode.unfocus();
      this.actionIcon = Icon(Icons.search, color: appTheme, size: 25);
      this.appBarTitle = Text(
        pageArguments.loanNo.isNotEmpty ? pageArguments.loanNo : "",
        style: TextStyle(color: appTheme),
      );
      textController.clear();
      unpledgeItemsList.clear();
      unpledgeItemsList.addAll(searchMyCartList);
    //});
  }

  updateTotalSchemeValue(){
    //setState(() {
      selectedSecurityValue.value = 0;
      for(int i= 0; i<searchMyCartList.length ; i++){
        selectedSecurityValue.value = selectedSecurityValue.value + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
      }
      unpledgeData.loan!.totalCollateralValue = selectedSecurityValue.value;
    //});
  }

  calculatePercentage(bool isRefresh){
    double actualDP = 0;
    for (int i = 0; i < unpledgeItemsList.length; i++) {
      int actualIndex = searchMyCartList.indexWhere((element) => element.isin == unpledgeItemsList[i].isin && element.folio == unpledgeItemsList[i].folio);

      if(double.parse(unitStringList[actualIndex]) >= 0.001) {
        actualDP = actualDP + ((unpledgeItemsList[i].price! * double.parse(unitStringList[actualIndex])) * (unpledgeItemsList[i].eligiblePercentage! / 100));
      }
    }
    revisedDrawingPower = actualDrawingPower - actualDP;
    double eligibilityPercentage = (revisedDrawingPower! / loanBalance) * 100;
    if (eligibilityPercentage >= 100.00 || selectedScips == 0 || loanBalance <= 0) {
      canUnpledge = true;
    } else {
      canUnpledge = false;
    }

    if(revocationChargeType != "Fix"){
      if(selectedSecurityValue > 0){
        if((selectedSecurityValue * revocationPercentage) / 100 >= revocationMaxCharge){
          revocationCharge = revocationMaxCharge;
        } else if((selectedSecurityValue * revocationPercentage) / 100 <= revocationMinCharge) {
          revocationCharge = revocationMinCharge;
        } else {
          revocationCharge = (selectedSecurityValue * revocationPercentage) / 100;
        }
      }else{
        revocationCharge = 0.00;
      }
    }
    if(isRefresh){
      //setState(() {});
    }

  }

  void altercheckBox(value) {
    List<bool> temp = checkBoxValues;
    //setState(() {
      selectedScips = 0;
      selectedSecurityValue.value = 0.0;
    //});
    for (var index = 0; index < unpledgeItemsList.length; index++) {
      temp[index] = value;
      //setState(() {
        if (value) {
          isAddBtnShow[index] = false;
          unpledgeItemsList[index].pledgedQuantity = actualQtyList![index];
          if(unpledgeItemsList[index].pledgedQuantity.toString().split(".")[1].length != 0){
            var unitsDecimalCount;
            String str = unpledgeItemsList[index].pledgedQuantity.toString();
            var qtyArray = str.split('.');
            unitsDecimalCount = qtyArray[1];
            if(unitsDecimalCount == "0"){
              unitStringList[index] = str.toString().split(".")[0];
              controllers[index].text = str.toString().split(".")[0];
            }else{
              unitStringList[index] = unpledgeItemsList[index].pledgedQuantity.toString();
              controllers[index].text = unpledgeItemsList[index].pledgedQuantity!.toString();
            }
          }
          unpledgeItemsList[index].amount = double.parse(controllers[index].text) * unpledgeItemsList[index].price!;
          if (selectedScips == 0) {
            selectedSecurityValue.value = 0.0 + unpledgeItemsList[index].amount!;
          } else {
            selectedSecurityValue.value = unpledgeData.loan!.totalCollateralValue! + unpledgeItemsList[index].amount!;
          }
          unpledgeData.loan!.totalCollateralValue = selectedSecurityValue.value;
          unpledgeItemsList[index].check = true;
          selectedScips = index + 1;
        } else {
          isAddBtnShow[index] = true;
          selectedSecurityValue.value = roundDouble(unpledgeData.loan!.totalCollateralValue!, 2) - unpledgeItemsList[index].amount!;
          unpledgeData.loan!.totalCollateralValue = selectedSecurityValue.value;
          unpledgeItemsList[index].amount = 0.0;
          controllers[index].text = "0";
          unitStringList[index] = "0";
          unpledgeItemsList[index].pledgedQuantity = double.parse(controllers[index].text);
          selectedScips = 0;
        }
        if (tempLength == unpledgeItemsList.length) {
          isScripsSelect = false;
        } else {
          isScripsSelect = true;
        }
        if(double.parse(revisedDrawingPower.toString()) > maxAllowableValue){
          if (double.parse(revisedDrawingPower.toString()) <= double.parse(existingDrawingPower.toString())) {
            isScripsSelect = false;
          } else {
            isScripsSelect = true;
          }
        }else{
          if(selectedSecurityValue <= maxAllowableValue) {
            isUnpledgeAlert = false;
          }else{
            isUnpledgeAlert = true;
          }
        }
        checkBoxValue = value;
     // });
    }

    calculatePercentage(true);
  }

  void unpledgeRequestOTP() async{
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    showDialogLoading( Strings.please_wait);
    _handleSearchEnd();

    DataState<CommonResponseEntity> response = await _requestUnpledgeOtpUseCase.call();
    Get.back();
    if (response is DataSuccess) {
      Utility.showToastMessage(response.data!.message!);
      // Firebase Event
      Map<String, dynamic> parameter = new Map<String, dynamic>();
      parameter[Strings.mobile_no] = mobile;
      parameter[Strings.email] = email;
      parameter[Strings.loan_number] = pageArguments.loanNo;
      parameter[Strings.max_allowable] = numberToString(maxAllowableValue.toStringAsFixed(2));
      parameter[Strings.date_time] = getCurrentDateAndTime();
      firebaseEvent(Strings.unpledge_otp_sent, parameter);

      otpModalBottomSheet();
    } else if (response is DataFailed) {
      if (response.error!.statusCode == 403) {
        commonDialog(Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(response.error!.message);
      }
    }

    /*unpledgeBloc.requestUnpledgeOTP().then((value) {
      Get.back();
      if (value.isSuccessFull!) {
        Utility.showToastMessage(value.message!);
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.loan_number] = pageArguments.loanNo;
        parameter[Strings.max_allowable] = numberToString(maxAllowableValue.toStringAsFixed(2));
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.unpledge_otp_sent, parameter);

        otpModalBottomSheet(context);
      } else if (value.errorCode == 403) {
        commonDialog( Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });*/
  }

  void otpModalBottomSheet() {
    List<UnPledgeListEntity> dummyUnpledgeList = [];
    List<double> myDuplicateList = [];
    List<CollateralLedgerEntity> collateralList2 = [];
    collateralList.sort((a, b) => a.requestedQuantity!.compareTo(b.requestedQuantity!));
    collateralList.reversed;
    collateralList2.addAll(collateralList.reversed);


    for (int i = 0; i < unpledgeItemsList.length; i++) {
      myDuplicateList.add(unpledgeItemsList[i].pledgedQuantity!);
    }
    for (int i = 0; i < unpledgeItemsList.length; i++) {
      for(int j = 0; j<collateralList2.length; j++){
        if(unpledgeItemsList[i].isin == collateralList2[j].isin && unpledgeItemsList[i].folio == collateralList2[j].folio){
          if(myDuplicateList[i] != 0){
            if(myDuplicateList[i] >= collateralList2[j].requestedQuantity!){
              if (unpledgeItemsList[i].amount != 0.0) {
                dummyUnpledgeList.add(new UnPledgeListEntity(
                    isin: collateralList2[j].isin,
                    folio: collateralList2[j].folio,
                    psn: collateralList2[j].psn,
                    quantity: collateralList2[j].requestedQuantity!));

                myDuplicateList[i] = double.parse(myDuplicateList[i].toStringAsFixed(3)) - double.parse(collateralList2[j].requestedQuantity!.toStringAsFixed(3));
              }
            }else if(myDuplicateList[i] < collateralList2[j].requestedQuantity!){
              if (unpledgeItemsList[i].amount != 0.0) {
                dummyUnpledgeList.add(new UnPledgeListEntity(
                    isin: collateralList2[j].isin,
                    folio: collateralList2[j].folio,
                    psn: collateralList2[j].psn,
                    quantity: double.parse(myDuplicateList[i].toStringAsFixed(3))
                ));
              }
              myDuplicateList[i] = 0;
            }
          }
        }
      }
    }
    // showModalBottomSheet(
    //   backgroundColor: Colors.transparent,
    //   context: context,
    //   isScrollControlled: true,
    //   builder: (BuildContext bc) {
    //     return UnpledgeOTPVerificationScreen(dummyUnpledgeList,
    //         unpledgeData.loan!.name!,
    //         numberToString(maxAllowableValue.toStringAsFixed(2)),
    //         Strings.mutual_fund);
    //   },
    // );

    ///Todo: after UnpledgeOTPVerificationScreen is completed uncomment below code
    // Get.bottomSheet(
    //   backgroundColor: Colors.transparent,
    //   isScrollControlled: true,
    //   UnpledgeOTPVerificationScreen(dummyUnpledgeList,
    //         unpledgeData.loan!.name!,
    //         numberToString(maxAllowableValue.toStringAsFixed(2)),
    //         Strings.mutual_fund),
    // );
  }

  submitClicked() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        unpledgeRequestOTP();
      } else {
        showSnackBar(scaffoldKey);
      }
    });
  }

  actionIconPressed() {
   // setState(() {
      if (this.actionIcon.icon == Icons.search) {
        this.actionIcon = new Icon(
          Icons.close,
          color: appTheme,
          size: 25,
        );
        this.appBarTitle = new TextField(
          controller: textController,
          focusNode: focusNode,
          style: new TextStyle(
            color: appTheme,
          ),
          cursorColor: appTheme,
          decoration: new InputDecoration(
              prefixIcon: new Icon(
                Icons.search,
                color: appTheme,
                size: 25,
              ),
              hintText: Strings.search,
              focusColor: appTheme,
              border: InputBorder.none,
              hintStyle: new TextStyle(color: appTheme)),
          onChanged: (value) => searchResults(value),
        );
        focusNode.requestFocus();
      } else {
        _handleSearchEnd();
      }
    //});
  }

  addBtnClicked(int index, int actualIndex) {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
       // setState(() {
          //FocusScope.of(context).unfocus();
          Get.focusScope?.unfocus();
          isAddBtnShow[actualIndex] = false;
          var txt;
          txt = double.parse(controllers[actualIndex].text) + 1;
          if (actualQtyList![actualIndex] < 1) {
            txt = actualQtyList![actualIndex];
            if(txt>actualQtyList![actualIndex]){
              Utility.showToastMessage(Strings.check_unit);
            } else {
              unpledgeItemsList[index].pledgedQuantity = txt;
              unitStringList[actualIndex] = txt.toString();
              controllers[actualIndex].text = unitStringList[actualIndex];
            }
          }else{
            unitStringList[actualIndex] = "1";
            controllers[actualIndex].text = unitStringList[actualIndex].toString();
            unpledgeItemsList[index].pledgedQuantity = 1.0;
          }
          updateTotalSchemeValue();
          selectedScips = selectedScips + 1;
          unpledgeItemsList[index].amount = double.parse(controllers[actualIndex].text) * unpledgeItemsList[index].price!;
          //setState(() {
            if(searchMyCartList.length == selectedScips){
              checkBoxValue = true;
            }
            if(double.parse(revisedDrawingPower.toString()) > maxAllowableValue){
              if (double.parse(revisedDrawingPower.toString()) <= double.parse(existingDrawingPower.toString())) {
                isScripsSelect = false;
              } else {
                isScripsSelect = true;
              }
            }else{
              if(selectedSecurityValue <= maxAllowableValue) {
                isUnpledgeAlert = false;
              }else{
                isUnpledgeAlert = true;
              }
            }
          //});
          if(controllers[actualIndex].text.isNotEmpty){
            calculatePercentage(true);}
       // });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  removeClicked(int index, int actualIndex) async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
       // setState(() {
          Get.focusScope?.requestFocus(new FocusNode());
          if(controllers[actualIndex].text.isNotEmpty){
            if(double.parse(controllers[actualIndex].text.toString()) >= 0.001) {
              var txt, decrementWith;
              if(unitStringList[actualIndex].toString().contains('.') && unitStringList[actualIndex].toString().split(".")[1].length != 0) {
                var unitsDecimalCount;
                String str = controllers[actualIndex].text.toString();
                var qtyArray = str.split('.');
                unitsDecimalCount = qtyArray[1];
                if(int.parse(unitsDecimalCount) == 0){
                  txt = double.parse(controllers[actualIndex].text) - 1;
                  decrementWith = 1;
                  unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toString());
                  unitStringList[actualIndex] = txt.toString();
                  controllers[actualIndex].text =  unitStringList[actualIndex];
                } else {
                  if (unitsDecimalCount.toString().length == 1) {
                    txt = double.parse(controllers[actualIndex].text) - .1;
                    decrementWith = .1;
                    unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(1));
                    unitStringList[actualIndex] = txt.toStringAsFixed(1);
                    controllers[actualIndex].text =  unitStringList[actualIndex];
                  } else if (unitsDecimalCount.toString().length == 2) {
                    txt = double.parse(controllers[actualIndex].text) - .01;
                    decrementWith = .01;
                    unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(2));
                    unitStringList[actualIndex] = txt.toStringAsFixed(2);
                    controllers[actualIndex].text = unitStringList[actualIndex];
                  } else {
                    txt = double.parse(controllers[actualIndex].text) - .001;
                    decrementWith = .001;
                    unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(3));
                    unitStringList[actualIndex] = txt.toStringAsFixed(3);
                    controllers[actualIndex].text = unitStringList[actualIndex];
                  }
                }
              }else{
                txt = int.parse(controllers[actualIndex].text.toString().split(".")[0]) - 1;
                decrementWith = 1;
                unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toString());
                unitStringList[actualIndex] = txt.toString();
                controllers[actualIndex].text = unitStringList[actualIndex];
              }
              if (txt >= 0.001) {
                if (double.parse(controllers[actualIndex].text) <= actualQtyList![actualIndex]) {
                  unpledgeItemsList[index].amount = txt * unpledgeItemsList[index].price!;
                  print("quantityy --> ${unpledgeItemsList[index].amount.toString()}");
                  updateTotalSchemeValue();
                } else {
                  Utility.showToastMessage(Strings.check_unit);
                }
              } else {
                //setState(() {
                  isAddBtnShow[actualIndex] = true;
                  unpledgeItemsList[index].amount = 0.0;
                  controllers[actualIndex].text = "0";
                  unitStringList[actualIndex] = "0";
                  updateTotalSchemeValue();
                  unpledgeItemsList[index].pledgedQuantity = double.parse(controllers[actualIndex].text);
                  selectedScips = selectedScips - 1;
                  checkBoxValue = false;
                  if(double.parse(revisedDrawingPower.toString()) > maxAllowableValue){
                    if (double.parse(revisedDrawingPower.toString()) <= double.parse(existingDrawingPower.toString())) {
                      isScripsSelect = false;
                    } else {
                      isScripsSelect = true;
                    }
                  }else{
                    if(selectedSecurityValue <= maxAllowableValue) {
                      isUnpledgeAlert = false;
                    }else{
                      isUnpledgeAlert = true;
                    }
                  }
                //});
              }
            } else {
              //setState(() {
                isAddBtnShow[actualIndex] = true;
                unpledgeItemsList[index].amount = 0.0;
                controllers[actualIndex].text = "0";
                unitStringList[actualIndex] = "0";
                updateTotalSchemeValue();
                unpledgeItemsList[index].pledgedQuantity = double.parse(controllers[actualIndex].text);
                selectedScips = selectedScips - 1;
                checkBoxValue = false;
                if(double.parse(revisedDrawingPower.toString()) > maxAllowableValue){
                  if (double.parse(revisedDrawingPower.toString()) <= double.parse(existingDrawingPower.toString())) {
                    isScripsSelect = false;
                  } else {
                    isScripsSelect = true;
                  }
                }else{
                  if(selectedSecurityValue <= maxAllowableValue) {
                    isUnpledgeAlert = false;
                  }else{
                    isUnpledgeAlert = true;
                  }
                }
              //});
              Utility.showToastMessage(Strings.check_unit);
            }
          }else{
            //setState(() {
              controllers[actualIndex].text = "0.001";
              unitStringList[actualIndex] = "0.001";
              unpledgeItemsList[index].pledgedQuantity = double.parse(controllers[actualIndex].text);
              unpledgeItemsList[index].amount = 0.001 * unpledgeItemsList[index].price!;
              updateTotalSchemeValue();
            //});
          }
          if(controllers[actualIndex].text.isNotEmpty){
            calculatePercentage(true);}
        //});
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  addClicked(int index, int actualIndex) async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        Get.focusScope?.unfocus();
        Get.focusScope?.requestFocus(new FocusNode());
        if(controllers[actualIndex].text.isNotEmpty){
          if (double.parse(controllers[actualIndex].text) < actualQtyList![actualIndex]) {
            double incrementWith = 0;
            var txt;
            if(unitStringList[actualIndex].toString().contains('.') && unitStringList[actualIndex].toString().split(".")[1].length != 0) {
              var unitsDecimalCount;
              String str = controllers[actualIndex].text.toString();
              var qtyArray = str.split('.');
              unitsDecimalCount = qtyArray[1];
              if(int.parse(unitsDecimalCount) == 0){
                txt = double.parse(controllers[actualIndex].text) + 1;
                if(txt>actualQtyList![actualIndex]){
                  Utility.showToastMessage(Strings.check_unit);
                } else {
                  incrementWith = 1;
                  unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toString());
                  unitStringList[actualIndex] = txt.toString();
                  controllers[actualIndex].text = unitStringList[actualIndex];
                }
              } else {
                if (unitsDecimalCount.toString().length == 1) {
                  txt = double.parse(controllers[actualIndex].text) + .1;
                  if(txt>actualQtyList![actualIndex]){
                    Utility.showToastMessage(Strings.check_unit);
                  } else{
                    incrementWith = .1;
                    unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(1));
                    unitStringList[actualIndex] = txt.toStringAsFixed(1);
                    controllers[actualIndex].text = unitStringList[actualIndex];
                  }
                } else if (unitsDecimalCount.toString().length == 2) {
                  txt = double.parse(controllers[actualIndex].text) + .01;
                  if(txt>actualQtyList![actualIndex]){
                    Utility.showToastMessage(Strings.check_unit);
                  } else {
                    incrementWith = .01;
                    unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(2));
                    unitStringList[actualIndex] = txt.toStringAsFixed(2);
                    controllers[actualIndex].text = unitStringList[actualIndex];
                  }
                } else {
                  txt = double.parse(controllers[actualIndex].text) + .001;
                  if(txt>actualQtyList![actualIndex]){
                    Utility.showToastMessage(Strings.check_unit);
                  } else {
                    incrementWith = .001;
                    unpledgeItemsList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(3));
                    unitStringList[actualIndex] = txt.toStringAsFixed(3);
                    controllers[actualIndex].text = unitStringList[actualIndex];
                  }
                }
              }
            } else {
              if (actualQtyList![actualIndex] < 1) {
                txt = actualQtyList![actualIndex];
                if(txt>actualQtyList![actualIndex]){
                  Utility.showToastMessage(Strings.check_unit);
                } else {
                  incrementWith = actualQtyList![actualIndex];
                  unpledgeItemsList[index].pledgedQuantity = txt;
                  unitStringList[actualIndex] = txt.toString();
                  controllers[actualIndex].text = unitStringList[actualIndex];
                }
              } else {
                txt = double.parse(controllers[actualIndex].text) + 1;
                if(txt>actualQtyList![actualIndex]){
                  Utility.showToastMessage(Strings.check_unit);
                } else {
                  incrementWith = 1;
                  unpledgeItemsList[index].pledgedQuantity = txt;

                  if(txt.toString().split(".")[1].length != 0){
                    var unitsDecimalCount;
                    String str = txt.toString();
                    var qtyArray = str.split('.');
                    unitsDecimalCount = qtyArray[1];
                    if(unitsDecimalCount == "0"){
                      unitStringList[actualIndex] = str.toString().split(".")[0];
                      controllers[actualIndex].text = str.toString().split(".")[0];
                    }else{
                      unitStringList[actualIndex] = txt;
                      controllers[actualIndex].text = txt;
                    }
                  }
                }
              }
            }
            if(incrementWith !=0){
              //setState(() {
                checkBoxValues[actualIndex] = true;
                unpledgeItemsList[index].check = true;
                unpledgeItemsList[index].pledgedQuantity = txt.toDouble();
                unpledgeItemsList[index].amount = txt * unpledgeItemsList[index].price!;
                updateTotalSchemeValue();
                if(searchMyCartList.length == selectedScips){
                  checkBoxValue = true;
                }
              //});
            }
          } else {
            Utility.showToastMessage(Strings.check_unit);
          }}else{
          controllers[actualIndex].text = "0.001";
          unitStringList[actualIndex] = "0.001";
          updateTotalSchemeValue();
          unpledgeItemsList[index].pledgedQuantity = 0.001;
        }
        if(controllers[actualIndex].text.isNotEmpty){
          calculatePercentage(true);
        }
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  textOnChanged(int index, int actualIndex)  {
    if (controllers[actualIndex].text.isNotEmpty) {
      if(!controllers[actualIndex].text.endsWith(".") && !controllers[actualIndex].text.endsWith(".0") && !controllers[actualIndex].text.endsWith(".00")){
        if (double.parse(controllers[actualIndex].text) >= 0.001 && !controllers[actualIndex].text.startsWith("0.000")) {
          if (double.parse(controllers[actualIndex].text) < .001) {
            Utility.showToastMessage(Strings.zero_unit_validation);
            Get.focusScope?.requestFocus(new FocusNode());
          } else if (double.parse(controllers[actualIndex].text) > actualQtyList![actualIndex].toDouble()) {
            Utility.showToastMessage("${Strings.check_unit}, This scheme has only ${actualQtyList![actualIndex]} unit.");
            Get.focusScope?.requestFocus(new FocusNode());
            //setState(() {
              if(unpledgeItemsList[index].pledgedQuantity.toString().split(".")[1].length != 0){
                var unitsDecimalCount;
                String str = unpledgeItemsList[index].pledgedQuantity.toString();
                var qtyArray = str.split('.');
                unitsDecimalCount = qtyArray[1];
                if(unitsDecimalCount == "0"){
                  unitStringList[actualIndex] = str.toString().split(".")[0];
                  controllers[actualIndex].text = str.toString().split(".")[0];
                }else{
                  unitStringList[actualIndex] = unpledgeItemsList[index].pledgedQuantity.toString();
                  controllers[actualIndex].text = unpledgeItemsList[index].pledgedQuantity.toString();
                }
              }else{
                unitStringList[actualIndex] = unpledgeItemsList[index].pledgedQuantity.toString();
                controllers[actualIndex].text = unpledgeItemsList[index].pledgedQuantity.toString();
              }
              unpledgeItemsList[index].pledgedQuantity = double.parse(controllers[actualIndex].text);
              updateTotalSchemeValue();
              var updateAmount = double.parse(controllers[actualIndex].text) * unpledgeItemsList[index].price!;
              unpledgeData.loan!.totalCollateralValue = selectedSecurityValue.value;
              unpledgeItemsList[index].amount = updateAmount;
            //});
          } else {
            if(controllers[actualIndex].text.toString().contains(".") && controllers[actualIndex].text.toString().split(".")[1].length != 0){
              var unitsDecimalCount;
              String str = controllers[actualIndex].text.toString();
              var qtyArray = str.split('.');
              unitsDecimalCount = qtyArray[1];
              if(unitsDecimalCount == "0"){
                unitStringList[actualIndex] = str.toString().split(".")[0];
              }else{
                unitStringList[actualIndex] = controllers[actualIndex].text.toString();
              }
            }else{
              unitStringList[actualIndex] = controllers[actualIndex].text.toString();
            }
            unpledgeItemsList[index].pledgedQuantity = double.parse(unitStringList[actualIndex]);
            updateTotalSchemeValue();
            var updateAmount = double.parse(controllers[actualIndex].text) * unpledgeItemsList[index].price!;
            unpledgeData.loan!.totalCollateralValue = selectedSecurityValue.value;
            unpledgeItemsList[index].amount = updateAmount;
          }
        } else if( controllers[actualIndex].text != "0") {
          //setState(() {
            if(actualQtyList![actualIndex] < 1){
              controllers[actualIndex].text = actualQtyList![actualIndex].toString();
              unitStringList[actualIndex] = actualQtyList![actualIndex].toString();
              updateTotalSchemeValue();
              unpledgeItemsList[index].pledgedQuantity = actualQtyList![actualIndex];
            } else {
              controllers[actualIndex].text = "1";
              unitStringList[actualIndex] = "1";
              updateTotalSchemeValue();
              unpledgeItemsList[index].pledgedQuantity = 1;
            }
            var updateAmount = double.parse(controllers[actualIndex].text) * unpledgeItemsList[index].price!;
            unpledgeData.loan!.totalCollateralValue = selectedSecurityValue.value;
            unpledgeItemsList[index].amount = updateAmount;
            Get.focusScope?.requestFocus(new FocusNode());
         // });
        }
      }
    }
    if(controllers[actualIndex].text.isNotEmpty && double.parse(controllers[actualIndex].text) >= 0.001){
      if(controllers[actualIndex].text.contains(".") && controllers[actualIndex].text.split(".")[1].isNotEmpty){
        if(controllers[actualIndex].text.toString().contains(".") && controllers[actualIndex].text.toString().split(".")[1].length != 0){
          var unitsDecimalCount;
          String str = controllers[actualIndex].text.toString();
          var qtyArray = str.split('.');
          unitsDecimalCount = qtyArray[1];
          if(unitsDecimalCount.toString().isNotEmpty && unitsDecimalCount != 0){
            unitStringList[actualIndex] = controllers[actualIndex].text.toString();
          }else{
            unitStringList[actualIndex] = str.toString().split(".")[0];
          }
        }else{
          unitStringList[actualIndex] = controllers[actualIndex].text.toString();
        }
        calculatePercentage(true);
      }
    }
  }
}
