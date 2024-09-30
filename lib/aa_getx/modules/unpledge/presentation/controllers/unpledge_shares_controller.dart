
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
import 'package:lms/aa_getx/modules/sell_collateral/presentation/arguments/sell_collateral_arguments.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/request/unpledge_request_req_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/entities/unpledge_details_response_entity.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/usecases/get_unpledge_details_usecase.dart';
import 'package:lms/aa_getx/modules/unpledge/domain/usecases/request_unpledge_otp_usecase.dart';
import 'package:lms/aa_getx/modules/unpledge/presentation/views/unpledge_otp_verification_view.dart';
import 'package:lms/unpledge/UnpledgeBloc.dart';

class UnpledgeSharesController extends GetxController{
  final ConnectionInfo _connectionInfo;
  final GetUnpledgeDetailsUseCase _getUnpledgeDetailsUseCase;
  final RequestUnpledgeOtpUseCase _requestUnpledgeOtpUseCase;
  UnpledgeSharesController( this._connectionInfo, this._getUnpledgeDetailsUseCase, this._requestUnpledgeOtpUseCase);

  final scaffoldKey = GlobalKey<ScaffoldState>();
  Preferences preferences = new Preferences();
  final unpledgeBloc = UnpledgeBloc();
  double? loanBalance, existingDrawingPower, existingCollateral, maxAllowableValue;
  int selectedScrips = 0;
  var selectedSecurityValue;
  double actualDrawingPower = 0;
  double? revisedDrawingPower;
  bool canUnpledge = true;
  double totalValue = 0;
  RxList<UnpledgeItemsEntity> unpledgeItemsList = <UnpledgeItemsEntity>[].obs;
  RxList<UnpledgeItemsEntity> actualMyCartList = <UnpledgeItemsEntity>[].obs;
  Rx<UnpledgeDataEntity> unpledgeData = new UnpledgeDataEntity().obs;
  List<double>? unpledgeQtyList;
  UnpledgeDetailsResponseEntity? unpledgeDetailsResponse;
  RxBool checkBoxValue = false.obs;
  Widget appBarTitle = new Text("", style: new TextStyle(color: Colors.white));
  Icon actionIcon = new Icon(Icons.search, color: appTheme, size: 25);
  TextEditingController textController = TextEditingController();
  List<TextEditingController> qtyControllers = [];
  List<bool> isAddBtnShow = [];
  List<FocusNode> focusNode = [];
  SellCollateralArguments pageArguments = Get.arguments;
  FocusNode focusNodes = FocusNode();

  @override
  void onInit() {
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
        await _getUnpledgeDetailsUseCase.call(GetLoanDetailsParams(
            loanDetailsRequestEntity: loanDetailsRequestEntity));

        if (response is DataSuccess) {
          if(response.data!.unpledgeData!.unpledge != null)  {
            unpledgeDetailsResponse = response.data!;
            //setState(() {
              unpledgeData.value = response.data!.unpledgeData!;
              for (int i = 0; i < unpledgeData.value.loan!.items!.length; i++) {
                actualDrawingPower = actualDrawingPower + ((unpledgeData.value.loan!.items![i].price! * unpledgeData.value.loan!.items![i].pledgedQuantity!) *
                    (unpledgeData.value.loan!.items![i].eligiblePercentage! / 100));
                qtyControllers.add(TextEditingController());
                focusNode.add(FocusNode());
                if (unpledgeData.value.loan!.items![i].amount != 0.0) {
                  unpledgeItemsList.add(unpledgeData.value.loan!.items![i]);
                  if (pageArguments.isComingFor == Strings.single && unpledgeData.value.loan!.items![i].isin == pageArguments.isin) {
                    selectedScrips = 1;
                    isAddBtnShow.add(false);
                    qtyControllers[i].text = unpledgeItemsList[i].pledgedQuantity!.toInt().toString();
                  } else {
                    isAddBtnShow.add(true);
                  }
                }
              }
              loanBalance =  response.data!.unpledgeData!.loan!.balance;
              maxAllowableValue = 0;
              unpledgeData.value.loan!.existingdrawingPower = unpledgeData.value.loan!.drawingPower;
              unpledgeData.value.loan!.existingtotalCollateralValue = unpledgeData.value.loan!.totalCollateralValue;
              existingDrawingPower = unpledgeData.value.loan!.existingdrawingPower;
              existingCollateral = unpledgeData.value.loan!.existingtotalCollateralValue;
              if(pageArguments.isComingFor == Strings.all) {
                selectedSecurityValue = 0.0;
                selectedScrips = 0;
              }
              actualMyCartList.addAll(unpledgeItemsList);
              unpledgeQtyList = List.generate(unpledgeItemsList.length, (index) => unpledgeItemsList[index].pledgedQuantity!);
              unpledgeCalculationHandling();
            //});
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



   /* unpledgeDetailsResponse = await unpledgeBloc.unpledgeDetails(loan_name);
    if(unpledgeDetailsResponse!.isSuccessFull!){
      if(unpledgeDetailsResponse!.data!.unpledge != null) {
        setState(() {
          unpledgeData = unpledgeDetailsResponse!.data!;
          for (int i = 0; i < unpledgeData.loan!.items!.length; i++) {
            actualDrawingPower = actualDrawingPower + ((unpledgeData.loan!.items![i].price! * unpledgeData.loan!.items![i].pledgedQuantity!) *
                (unpledgeData.loan!.items![i].eligiblePercentage! / 100));
            qtyControllers.add(TextEditingController());
            focusNode.add(FocusNode());
            if (unpledgeData.loan!.items![i].amount != 0.0) {
              unpledgeItemsList.add(unpledgeData.loan!.items![i]);
              if (pageArguments.isComingFor == Strings.single && unpledgeData.loan!.items![i].isin == pageArguments.isin) {
                selectedScrips = 1;
                isAddBtnShow.add(false);
                qtyControllers[i].text = unpledgeItemsList[i].pledgedQuantity!.toInt().toString();
              } else {
                isAddBtnShow.add(true);
              }
            }
          }
          loanBalance = unpledgeDetailsResponse!.data!.loan!.balance;
          maxAllowableValue = 0;
          unpledgeData.loan!.existingdrawingPower = unpledgeData.loan!.drawingPower;
          unpledgeData.loan!.existingtotalCollateralValue = unpledgeData.loan!.totalCollateralValue;
          existingDrawingPower = unpledgeData.loan!.existingdrawingPower;
          existingCollateral = unpledgeData.loan!.existingtotalCollateralValue;
          if(pageArguments.isComingFor == Strings.all) {
            selectedSecurityValue = 0.0;
            selectedScrips = 0;
          }
          actualMyCartList.addAll(unpledgeItemsList);
          unpledgeQtyList = List.generate(unpledgeItemsList.length, (index) => unpledgeItemsList[index].pledgedQuantity!);
          unpledgeCalculationHandling();
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
    dummySearchList.addAll(actualMyCartList);
    if (query.isNotEmpty) {
      List<UnpledgeItemsEntity> dummyListData = <UnpledgeItemsEntity>[];
      dummySearchList.forEach((item) {
        if (item.securityName!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      //setState(() {
        unpledgeItemsList.clear();
        unpledgeItemsList.addAll(dummyListData);
     // });
    } else {
     // setState(() {
        unpledgeItemsList.clear();
        unpledgeItemsList.addAll(actualMyCartList);
     // });
    }
  }

  void _handleSearchEnd() {
    //setState(() {
      focusNodes.unfocus();
      this.actionIcon = Icon(Icons.search, color: appTheme, size: 25);
      this.appBarTitle = Text(
        pageArguments.loanNo,
        style: TextStyle(color: appTheme),
      );
      textController.clear();
      unpledgeItemsList.clear();
      unpledgeItemsList.addAll(actualMyCartList);
    //});
  }

  unpledgeCalculationHandling(){
   // setState(() {
      if(!isAddBtnShow.contains(true)){
        checkBoxValue.value = true;
      } else {
        checkBoxValue.value = false;
      }
      totalValue = 0;
      double actualDP = 0;
      for(int i=0; i< actualMyCartList.length ; i++){
        if(!isAddBtnShow[i] && qtyControllers[i].text.isNotEmpty){
          totalValue += actualMyCartList[i].price! * double.parse(qtyControllers[i].text.toString());
          actualDP = actualDP + ((actualMyCartList[i].price! * double.parse(qtyControllers[i].text.toString())) * (actualMyCartList[i].eligiblePercentage! / 100));
        }
      }
      revisedDrawingPower = actualDrawingPower - actualDP;
      double eligibilityPercentage = (revisedDrawingPower! / loanBalance!) * 100;
      if (eligibilityPercentage >= 100.00 || selectedScrips == 0 || loanBalance! <= 0) {
        canUnpledge = true;
      } else {
        canUnpledge = false;
      }
   // });
  }

  void alterCheckBox(value) {
   // setState(() {
      checkBoxValue.value = value;
    //});
    for (var index = 0; index < unpledgeItemsList.length; index++) {
     // setState(() {
        if (value) {
          isAddBtnShow[index] = false;
          qtyControllers[index].text = unpledgeQtyList![index].toInt().toString();
          unpledgeItemsList[index].pledgedQuantity = unpledgeQtyList![index];
          selectedScrips = index + 1;
        } else {
          isAddBtnShow[index] = true;
          qtyControllers[index].text= "0";
          unpledgeItemsList[index].pledgedQuantity = double.parse(qtyControllers[index].text);
          selectedScrips = 0;
        }
      //});
    }
    unpledgeCalculationHandling();
  }

  void unpledgeRequestOTP() async{
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    showDialogLoading( Strings.please_wait);
    _handleSearchEnd();

    if(await _connectionInfo.isConnected) {
      DataState<
          CommonResponseEntity> response = await _requestUnpledgeOtpUseCase
          .call();
      Get.back();
      if (response is DataSuccess) {
        Utility.showToastMessage(response.data!.message!);
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.loan_number] = pageArguments.loanNo;
        parameter[Strings.max_allowable] =
            numberToString(maxAllowableValue!.toStringAsFixed(2));
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
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }
  }

  void otpModalBottomSheet() {
    List<UnPledgeListEntity> dummyUnpledgeList = [];
    for (int i = 0; i < unpledgeItemsList.length; i++) {
      if(unpledgeItemsList[i].pledgedQuantity != 0) {
        if(unpledgeItemsList[i].amount != 0){
          dummyUnpledgeList.add(new UnPledgeListEntity(
              isin:  unpledgeItemsList[i].isin,
              quantity:  unpledgeItemsList[i].pledgedQuantity,
              psn: unpledgeItemsList[i].psn
          ));
        }
      }
    }
    Get.bottomSheet(
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      UnpledgeOtpVerificationView(dummyUnpledgeList,
            unpledgeData.value.loan!.name!,
            numberToString(maxAllowableValue!.toStringAsFixed(2)),
            Strings.shares),
     // },
    );
  }

  addClicked(int index, int actualIndex)  async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        Get.focusScope?.unfocus();
        if(qtyControllers[actualIndex].text.isNotEmpty){
          if (int.parse(qtyControllers[actualIndex].text) < unpledgeQtyList![actualIndex]) {
            int txt = int.parse(qtyControllers[actualIndex].text) + 1;
            //setState(() {
              qtyControllers[actualIndex].text = txt.toString();
              unpledgeItemsList[index].pledgedQuantity = txt.toDouble();
            //});
          } else {
            Utility.showToastMessage(Strings.check_quantity);
          }
        }
        unpledgeCalculationHandling();
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  onQtyChanged(int index, int actualIndex)  {
    if (qtyControllers[actualIndex].text.isNotEmpty) {
      if (qtyControllers[actualIndex].text != "0") {
        if (int.parse(qtyControllers[actualIndex].text) < 1) {
          Get.focusScope?.requestFocus(new FocusNode());
          Utility.showToastMessage(Strings.zero_qty_validation);
        } else if (double.parse(qtyControllers[actualIndex].text) > unpledgeQtyList![actualIndex]) {
          Get.focusScope?.requestFocus(new FocusNode());
          Utility.showToastMessage("${Strings.check_quantity}, This scrip has only ${unpledgeQtyList![actualIndex]} quantity.");
         // setState(() {
            qtyControllers[actualIndex].text = unpledgeItemsList[index].pledgedQuantity!.toInt().toString();
            unpledgeItemsList[index].pledgedQuantity = double.parse(qtyControllers[actualIndex].text);
         // });
        } else {
         // setState(() {
            unpledgeItemsList[index].pledgedQuantity = double.parse(qtyControllers[actualIndex].text);
         // });
        }
      } else {
        //setState(() {
          Get.focusScope?.requestFocus(new FocusNode());
          qtyControllers[actualIndex].text = "0";
          unpledgeItemsList[index].pledgedQuantity = 0;
          isAddBtnShow[actualIndex] = true;
          selectedScrips = selectedScrips - 1;
          checkBoxValue.value = false;
        //});
      }
    } else {
      focusNode[actualIndex].addListener(() {
        if(!focusNode[actualIndex].hasFocus){
          if(qtyControllers[actualIndex].text.trim() == "" || qtyControllers[actualIndex].text.trim() == "0"){
            isAddBtnShow[actualIndex] = true;
            unpledgeItemsList[index].pledgedQuantity = 0;
            qtyControllers[actualIndex].text = "0";
            selectedScrips = selectedScrips - 1;
            checkBoxValue.value = false;
          }
        }
      });
    }
    unpledgeCalculationHandling();
  }

  removeClicked(int index, int actualIndex)  async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        Get.focusScope?.unfocus();
        //setState(() {
          if(qtyControllers[actualIndex].text.isNotEmpty){
            int txt = int.parse(qtyControllers[actualIndex].text) - 1;
            if (txt != 0) {
              qtyControllers[actualIndex].text = txt.toString();
              unpledgeItemsList[index].pledgedQuantity = txt.toDouble();
            } else {
              isAddBtnShow[actualIndex] = true;
              qtyControllers[actualIndex].text = "0";
              unpledgeItemsList[index].pledgedQuantity = 0;
              selectedScrips = selectedScrips - 1;
            }
          }
          unpledgeCalculationHandling();
        //});
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  addButtonClicked(int index, int actualIndex)  {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        //setState(() {
          Get.focusScope?.unfocus();
          isAddBtnShow[actualIndex] = false;
          qtyControllers[actualIndex].text = "1";
          unpledgeItemsList[index].pledgedQuantity = 1.0;
          selectedScrips = selectedScrips + 1;
          unpledgeCalculationHandling();
        //});
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  actionIconClicked()  {
    //setState(() {
      if (this.actionIcon.icon == Icons.search) {
        this.actionIcon = new Icon(
          Icons.close,
          color: appTheme,
          size: 25,
        );
        this.appBarTitle = new TextField(
          controller: textController,
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
        focusNodes.requestFocus();
      } else {
        _handleSearchEnd();
      }
    //});
  }

}