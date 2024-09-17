import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/more/domain/usecases/get_loan_details_usecase.dart';
import 'package:lms/aa_getx/modules/my_loan/domain/entities/common_response_entities.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/entities/request/sell_collateral_request_entity.dart';
import 'package:lms/aa_getx/modules/sell_collateral/domain/usecases/request_sell_collateral_otp_usecase.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/arguments/mf_invoke_arguments.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/arguments/sell_collateral_otp_arguments.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/views/mf_invoke_view.dart';
import 'package:lms/aa_getx/modules/sell_collateral/presentation/views/sell_collateral_otp_view.dart';
import 'package:lms/my_loan/MyLoansBloc.dart';
import 'package:lms/sell_collateral/SellCollateralBloc.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/loan_details_response_entity.dart';
import 'package:lms/aa_getx/modules/more/domain/entities/request/loan_details_request_entity.dart';

class MfInvokeController extends GetxController{
  final ConnectionInfo _connectionInfo;
  final GetLoanDetailsUseCase _getLoanDetailsUseCase;
  final RequestSellCollateralOtpUseCase _requestSellCollateralOtpUseCase;

  MfInvokeController(this._connectionInfo, this._getLoanDetailsUseCase, this._requestSellCollateralOtpUseCase);

  Preferences preferences = Preferences();
  final myLoansBloc = MyLoansBloc();
  final sellCollateralBloc = SellCollateralBloc();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  List<TextEditingController> controllers2 = [];
  bool checkBoxValue = false;
  bool resetValue  = true;
  RxBool isMarginShortFall = false.obs;
  RxBool isScripsSelect = true.obs;
  RxBool isAPIRespond = false.obs;
  List<bool> checkBoxValues = [];
  int tempLength = 0;
  List<SellListEntity> sellList = [];
  List<bool> pledgeControllerEnable = [];
  RxList<ItemsEntity> myPledgedSecurityList = <ItemsEntity>[].obs;
  List<CollateralLedgerEntity> collateralList = [];
  List<ItemsEntity> searchMyCartList = [];
  List<double> actualQtyList = [];
  List<String> unitStringList = [];
  Rx<LoanEntity> loanData = new LoanEntity().obs;
  Rx<InvokeChargeDetailsEntity> invokeChargeData = new InvokeChargeDetailsEntity().obs;
  RxDouble vlMarginShortFall = 0.0.obs, vlDesiredValue = 0.0.obs;
  RxDouble totalValue = 0.0.obs;
  var totalSelectedScrips, selectedSecuritiesValue;
  RxDouble eligibleLoan = 0.0.obs;
  RxDouble totalCollateral = 0.0.obs;
  String marginShortfallName = "";
  RxDouble invokeCharge= 0.0.obs;
  double invokePercentage = 0.0;
  RxDouble actualDrawingPower = 0.0.obs;
  RxDouble selectedSchemeEligibility = 0.0.obs;
  List<bool> isAddBtnShow = [];
  bool hideSecurityValue = false;
  bool showSecurityValue = true;
  Widget appBarTitle = new Text(
    "",
    style: new TextStyle(color: Colors.white),
  );
  Rx<Icon> actionIcon = new Icon(
    Icons.search,
    color: appTheme,
    size: 25,
  ).obs;
  TextEditingController textController = TextEditingController();
  FocusNode focusNode = FocusNode();
  MfInvokeArguments mfInvokeArguments = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    //resetValue = true;
    appBarTitle = Text(mfInvokeArguments.loanNo, style: TextStyle(color: appTheme));
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        getLoanData();
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  getLoanData() async {
    if (await _connectionInfo.isConnected) {
      GetLoanDetailsRequestEntity loanDetailsRequestEntity =
      GetLoanDetailsRequestEntity(
        loanName: mfInvokeArguments.loanNo,
        transactionsPerPage: 15,
        transactionsStart: 0,
      );
      DataState<LoanDetailsResponseEntity> loanDetailsResponse =
      await _getLoanDetailsUseCase.call(GetLoanDetailsParams(
          loanDetailsRequestEntity: loanDetailsRequestEntity));

      if (loanDetailsResponse is DataSuccess) {
        if (loanDetailsResponse.data!.data!.loan != null) {
          //setState(() {
            isAPIRespond.value = true;
            loanData.value = loanDetailsResponse.data!.data!.loan!;
            totalCollateral.value = loanDetailsResponse.data!.data!.loan!.totalCollateralValue ?? 0.0;
            totalValue.value = 0.0;
            eligibleLoan.value = 0.0;
            totalSelectedScrips = 0;
            if(loanDetailsResponse.data!.data!.collateralLedger != null){
              collateralList.addAll(loanDetailsResponse.data!.data!.collateralLedger!);
            }
            if (loanDetailsResponse.data!.data!.marginShortfall != null) {
              marginShortfallName = loanDetailsResponse.data!.data!.marginShortfall!.name!;
              isMarginShortFall.value = true;
              vlMarginShortFall.value = loanDetailsResponse.data!.data!.marginShortfall!.minimumCashAmount!;
              vlDesiredValue.value = loanDetailsResponse.data!.data!.marginShortfall!.advisableCashAmount!;
            } else {
              isMarginShortFall.value = false;
            }
            unitStringList.clear();
            for (int i = 0; i < loanDetailsResponse.data!.data!.loan!.items!.length; i++) {
              if(loanDetailsResponse.data!.data!.loan!.items![i].amount != 0.0) {
                myPledgedSecurityList.add(loanDetailsResponse.data!.data!.loan!.items![i]);
                controllers2.add(TextEditingController());
                actualDrawingPower.value = actualDrawingPower.value + ((loanData.value.items![i].price! * loanData.value.items![i].pledgedQuantity!) * (loanData.value.items![i].eligiblePercentage! / 100));
                unitStringList.add("0");
              }
            }
            searchMyCartList.addAll(myPledgedSecurityList);

            if(loanDetailsResponse.data!.data!.invokeChargeDetails != null){
              invokeChargeData.value = loanDetailsResponse.data!.data!.invokeChargeDetails!;
            }

            for (int i = 0; i < myPledgedSecurityList.length; i++) {
              if(mfInvokeArguments.isComingFor == Strings.single){
                if(myPledgedSecurityList[i].isin == mfInvokeArguments.isin && myPledgedSecurityList[i].folio == mfInvokeArguments.folio){
                  totalSelectedScrips = 1;
                  totalValue.value = 0.0 + myPledgedSecurityList[i].amount!;

                  invokeAndEligibility();   //eligibility and invoke percent calculation of single selected schemes value
                  if(myPledgedSecurityList[i].pledgedQuantity.toString().split(".")[1].length != 0){
                    var unitsDecimalCount;
                    String str = myPledgedSecurityList[i].pledgedQuantity.toString();
                    var qtyArray = str.split('.');
                    unitsDecimalCount = qtyArray[1];
                    if(unitsDecimalCount == "0"){
                      unitStringList[i] = str.toString().split(".")[0];
                    }else{
                      unitStringList[i] = myPledgedSecurityList[i].pledgedQuantity.toString();
                    }
                  }
                 // setState(() {
                    eligibleLoan.value = (myPledgedSecurityList[i].price! * double.parse(unitStringList[i])) * (myPledgedSecurityList[i].eligiblePercentage!/100);
                 // });
                }
              }
            }

            if(invokeChargeData.value.invokeInitiateChargeType == 'Fix') {
              invokeCharge.value = invokeChargeData.value.invokeInitiateCharges ?? 0.0;
            } else {
              if(totalValue.value>0){
                invokeCharge.value = invokeChargeData.value.invokeInitiateChargesMinimumAmount ?? 0.0;
              } else {
                invokeCharge.value = 0.00;
              }
            }

            tempLength = myPledgedSecurityList.length;
            for (int i = 0; i < myPledgedSecurityList.length; i++) {
              actualQtyList.add(myPledgedSecurityList[i].pledgedQuantity!);
            }
            isAPIRespond.value = true;
          //});
        }  else {
          commonDialog(Strings.something_went_wrong_try, 0);
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

  void searchResults(String query) {
    List<ItemsEntity> dummySearchList = <ItemsEntity>[];
    dummySearchList.addAll(searchMyCartList);
    if (query.isNotEmpty) {
      List<ItemsEntity> dummyListData = <ItemsEntity>[];
      dummySearchList.forEach((item) {
        if (item.securityName!.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
     // setState(() {
        myPledgedSecurityList.clear();
        myPledgedSecurityList.addAll(dummyListData);
     // });
    } else {
     // setState(() {
        myPledgedSecurityList.clear();
        myPledgedSecurityList.addAll(searchMyCartList);
     // });
    }
  }

  void _handleSearchEnd() {
    //setState(() {
      focusNode.unfocus();
      this.actionIcon.value = Icon(Icons.search, color: appTheme, size: 25);
      this.appBarTitle = Text(mfInvokeArguments.loanNo, style: TextStyle(color: appTheme));
      textController.clear();
      myPledgedSecurityList.clear();
      myPledgedSecurityList.addAll(searchMyCartList);
   // });
  }

  invokeAndEligibility() {
    selectedSchemeEligibility.value = 0;
    for(int i =0; i< searchMyCartList.length; i++) {
      selectedSchemeEligibility.value = selectedSchemeEligibility.value + ((searchMyCartList[i].price! * searchMyCartList[i].pledgedQuantity!) * searchMyCartList[i].eligiblePercentage! / 100);
    }
    if(invokeChargeData.value.invokeInitiateChargeType == 'Fix'){
      invokeCharge.value = invokeChargeData.value.invokeInitiateCharges ?? 0.0;
    } else {
      if(totalValue.value > 0){
        invokePercentage = invokeChargeData.value.invokeInitiateCharges ?? 0.0;
        invokeCharge.value = totalValue.value * (invokePercentage / 100);
        if(invokeChargeData.value.invokeInitiateChargesMinimumAmount! > 0 && invokeCharge.value < invokeChargeData.value.invokeInitiateChargesMinimumAmount!) {
          invokeCharge.value = invokeChargeData.value.invokeInitiateChargesMinimumAmount!;
        } else if(invokeChargeData.value.invokeInitiateChargesMaximumAmount! > 0 && invokeCharge.value > invokeChargeData.value.invokeInitiateChargesMaximumAmount!) {
          invokeCharge.value = invokeChargeData.value.invokeInitiateChargesMaximumAmount!;
        }
      } else {
        invokeCharge.value = 0.00;
      }
    }
  }

  void alterCheckBox(value) {
    List<bool> temp = checkBoxValues;
    //setState(() {
      totalSelectedScrips = 0;
      totalValue.value = 0.0;
      eligibleLoan.value = 0.0;
    //});
    for (var index = 0; index < myPledgedSecurityList.length; index++) {
      temp[index] = value;
      //setState(() {
        int actualIndex = searchMyCartList.indexWhere((element) => element.isin == myPledgedSecurityList[index].isin && element.folio == myPledgedSecurityList[index].folio);

        if (value) {
          isAddBtnShow[index] = false;
          myPledgedSecurityList[index].pledgedQuantity = actualQtyList[actualIndex].toDouble();
          searchMyCartList[actualIndex].pledgedQuantity = myPledgedSecurityList[index].pledgedQuantity;

          if(myPledgedSecurityList[index].pledgedQuantity.toString().split(".")[1].length != 0){
            var unitsDecimalCount;
            String str = myPledgedSecurityList[index].pledgedQuantity.toString();
            var qtyArray = str.split('.');
            unitsDecimalCount = qtyArray[1];
            if(unitsDecimalCount == "0"){
              unitStringList[index] = str.toString().split(".")[0];
              controllers2[index].text = str.toString().split(".")[0];
            }else{
              unitStringList[index] = myPledgedSecurityList[index].pledgedQuantity.toString();
              controllers2[index].text = myPledgedSecurityList[index].pledgedQuantity!.toString();
            }
          }
          myPledgedSecurityList[index].pledgedQuantity = double.parse(controllers2[index].text);
          searchMyCartList[actualIndex].pledgedQuantity = myPledgedSecurityList[index].pledgedQuantity;
          myPledgedSecurityList[index].amount = double.parse(controllers2[actualIndex].text) * myPledgedSecurityList[index].price!;
          if (totalSelectedScrips == 0) {
            totalValue.value = 0.0 + myPledgedSecurityList[index].amount!;
          } else {
            totalValue.value = loanData.value.totalCollateralValue! + myPledgedSecurityList[index].amount!;
          }
          eligibleLoan.value += (myPledgedSecurityList[index].price! * double.parse(unitStringList[actualIndex])) * (myPledgedSecurityList[index].eligiblePercentage!/100);
          loanData.value.totalCollateralValue = totalValue.value;
          myPledgedSecurityList[index].check = true;
          totalSelectedScrips = index + 1;
          invokeAndEligibility();
        } else {
          isAddBtnShow[index] = true;
          totalValue.value = loanData.value.totalCollateralValue! - totalValue.value;
          eligibleLoan.value = 0.0;
          loanData.value.totalCollateralValue = totalValue.value;
          myPledgedSecurityList[index].amount = 0.0;
          controllers2[index].text= "0";
          unitStringList[index] = "0";
          myPledgedSecurityList[index].pledgedQuantity = double.parse(controllers2[actualIndex].text);
          searchMyCartList[actualIndex].pledgedQuantity = myPledgedSecurityList[index].pledgedQuantity;
          totalSelectedScrips = 0;
          invokeAndEligibility();
        }
        if (tempLength == myPledgedSecurityList.length) {
          isScripsSelect.value = false;
        } else {
          isScripsSelect.value = true;
        }
        checkBoxValues = temp;
        checkBoxValue = value;
      //});
    }
  }

  void requestSellCollateralOTP() async {
    String? mobile = await preferences.getMobile();
    String email = await preferences.getEmail();
    //showDialogLoading( Strings.please_wait);
    sellList.clear();
    List<double> myDuplicateList = [];
    List<CollateralLedgerEntity> collateralList2 = [];
    collateralList.sort((a, b) => a.requestedQuantity!.compareTo(b.requestedQuantity!));
    collateralList.reversed;
    collateralList2.addAll(collateralList.reversed);
    for (int i = 0; i < myPledgedSecurityList.length; i++) {
      myDuplicateList.add(myPledgedSecurityList[i].pledgedQuantity!);
    }
    for (int i = 0; i < myDuplicateList.length; i++) {
      for(int j = 0; j<collateralList2.length; j++){
        if(myPledgedSecurityList[i].isin == collateralList2[j].isin && myPledgedSecurityList[i].folio == collateralList2[j].folio){
          if(myDuplicateList[i] != 0){
            if(myDuplicateList[i] >= collateralList2[j].requestedQuantity!){
              if (myPledgedSecurityList[i].amount != 0.0) {
                sellList.add(new SellListEntity(
                    isin: collateralList2[j].isin,
                    folio: collateralList2[j].folio,
                    psn: collateralList2[j].psn,
                    quantity: collateralList2[j].requestedQuantity!));

                myDuplicateList[i] = double.parse(myDuplicateList[i].toStringAsFixed(3)) - double.parse(collateralList2[j].requestedQuantity!.toStringAsFixed(3));
              }
            }else if(myDuplicateList[i] < collateralList2[j].requestedQuantity!){
              if (myPledgedSecurityList[i].amount != 0.0) {
                sellList.add(new SellListEntity(
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

    if (await _connectionInfo.isConnected) {
      showDialogLoading( Strings.please_wait);
      DataState<CommonResponseEntity> response = await _requestSellCollateralOtpUseCase.call();
      Get.back();
      if (response is DataSuccess) {
        if(response.data != null){
        Utility.showToastMessage(Strings.enter_otp);
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.loan_number] = mfInvokeArguments.loanNo;
        parameter[Strings.is_for_margin_shortfall] = isMarginShortFall.value ? "True" : "False";
        parameter[Strings.date_time] = getCurrentDateAndTime();
        firebaseEvent(Strings.sell_otp_sent, parameter);

        // showModalBottomSheet(
        //   backgroundColor: Colors.transparent,
        //   context: context,
        //   isScrollControlled: true,
        //   builder: (BuildContext bc) {
        //     return SellCollateralOTPScreen(mfInvokeArguments.loanNo, sellList,marginShortfallName, Strings.mutual_fund);
        //   },
        // );
        Get.bottomSheet(
            backgroundColor: Colors.transparent,
            isScrollControlled: true,
            SellCollateralOtpView(),
            settings: RouteSettings(arguments: SellCollateralOtpArguments(loanName: mfInvokeArguments.loanNo, sellList: sellList, marginShortfallName: marginShortfallName, loanType: Strings.mutual_fund))
        );
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

  void actionIconClicked() {
    //setState(() {
      if (this.actionIcon.value.icon == Icons.search) {
        this.actionIcon.value = new Icon(
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
   // });
  }

  Future<void> submitBtnClicked() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        if(isScripsSelect.value == false){
          _handleSearchEnd();
          MfInvokeController controller = MfInvokeController(this._connectionInfo, this._getLoanDetailsUseCase, this._requestSellCollateralOtpUseCase);
          sellCollateralDialogBox(controller);
        }else{
          Utility.showToastMessage(Strings.check_quantity);
        }
      } else {
        showSnackBar(scaffoldKey);
      }
    });
  }

  Future<void> continueClicked() async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        Get.back();
        requestSellCollateralOTP();
      } else {
        showSnackBar(scaffoldKey);
      }
    });
  }

  addBtnClicked(int index, int actualIndex) {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        //setState(() {
          //FocusScope.of(context).unfocus();
          Get.focusScope?.unfocus();
          isAddBtnShow[actualIndex] = false;
          var txt;
          txt = double.parse(controllers2[actualIndex].text) + 1;
          if (actualQtyList[actualIndex] < 1) {
            txt = actualQtyList[actualIndex];
            if(txt>actualQtyList[actualIndex]){
              Utility.showToastMessage(Strings.check_unit);
            } else {
              myPledgedSecurityList[index].pledgedQuantity = txt;
              unitStringList[actualIndex] = txt.toString();
              controllers2[actualIndex].text = unitStringList[actualIndex];
            }
          } else {
            unitStringList[actualIndex] = "1";
            controllers2[actualIndex].text = unitStringList[actualIndex].toString();
            myPledgedSecurityList[index].pledgedQuantity = 1.0;
          }
          totalSelectedScrips = totalSelectedScrips + 1;
          myPledgedSecurityList[index].amount = double.parse(controllers2[actualIndex].text) * myPledgedSecurityList[index].price!;
          //setState(() {
            totalValue.value = 0;
            eligibleLoan.value = 0;
            for(int i= 0; i<searchMyCartList.length ; i++){
              totalValue.value = totalValue.value + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
              eligibleLoan.value += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
            }
            loanData.value.totalCollateralValue = totalValue.value;
            if(searchMyCartList.length == totalSelectedScrips){
              checkBoxValue = true;
            }
            invokeAndEligibility();
          //});
        //});
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  removeClicked(int index, int actualIndex) async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        //FocusScope.of(context).unfocus();
        Get.focusScope?.unfocus();
        Get.focusScope?.requestFocus(new FocusNode());
        //FocusScope.of(context).requestFocus(new FocusNode());
        //setState(() {
          if(controllers2[actualIndex].text.isNotEmpty){
            if(double.parse(controllers2[actualIndex].text.toString()) >= 0.001){
              var txt;
              if(controllers2[actualIndex].text.toString().contains('.') && controllers2[actualIndex].text.toString().split(".")[1].length != 0) {
                var unitsDecimalCount;
                String str = controllers2[actualIndex].text.toString();
                var qtyArray = str.split('.');
                unitsDecimalCount = qtyArray[1];
                if(int.parse(unitsDecimalCount) == 0){
                  txt = double.parse(controllers2[actualIndex].text) - 1;
                  myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toString());
                  unitStringList[actualIndex] = txt.toString();
                  controllers2[actualIndex].text = unitStringList[actualIndex];
                } else {
                  if (unitsDecimalCount.toString().length == 1) {
                    txt = double.parse(controllers2[actualIndex].text) - .1;
                    myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(1));
                    unitStringList[actualIndex] = txt.toStringAsFixed(1);
                    controllers2[actualIndex].text = unitStringList[actualIndex];
                  } else if (unitsDecimalCount.toString().length == 2) {
                    txt = double.parse(controllers2[actualIndex].text) - .01;
                    myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(2));
                    unitStringList[actualIndex] = txt.toStringAsFixed(2);
                    controllers2[actualIndex].text = unitStringList[actualIndex];
                  } else {
                    txt = double.parse(controllers2[actualIndex].text) - .001;
                    myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(3));
                    unitStringList[actualIndex] = txt.toStringAsFixed(3);
                    controllers2[actualIndex].text = unitStringList[actualIndex];
                  }
                }
              }else{
                txt = int.parse(controllers2[actualIndex].text.toString().split(".")[0]) - 1;
                myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toString());
                unitStringList[actualIndex] = txt.toString();
                controllers2[actualIndex].text = unitStringList[actualIndex];
              }
              if (txt >= 0.001) {
                if (double.parse(controllers2[actualIndex].text) <= actualQtyList[actualIndex]) {
                  myPledgedSecurityList[index].amount = txt * myPledgedSecurityList[index].price!;
                  //setState(() {
                    totalValue.value = 0;
                    eligibleLoan.value = 0;
                    for(int i= 0; i<searchMyCartList.length ; i++){
                      totalValue.value = totalValue.value + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                      eligibleLoan.value += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                    }
                  //});
                  loanData.value.totalCollateralValue = totalValue.value;
                } else {
                  Utility.showToastMessage(Strings.check_unit);
                }
              } else {
                //setState(() {
                  checkBoxValues[actualIndex] = false;
                  isAddBtnShow[actualIndex] = true;
                  myPledgedSecurityList[index].amount = 0.0;
                  controllers2[actualIndex].text = "0";
                  unitStringList[actualIndex] = "0";
                  totalValue.value = 0;
                  eligibleLoan.value = 0;
                  for(int i= 0; i<searchMyCartList.length ; i++){
                    totalValue.value = totalValue.value + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                    eligibleLoan.value += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                  }
                  loanData.value.totalCollateralValue = totalValue.value;
                  myPledgedSecurityList[index].pledgedQuantity = double.parse(controllers2[actualIndex].text);
                  totalSelectedScrips = totalSelectedScrips - 1;
                  checkBoxValue = false;
                  if (tempLength == myPledgedSecurityList.length) {
                    isScripsSelect.value = false;
                  } else {
                    isScripsSelect.value = true;
                  }
               // });
              }
            } else {
              //setState(() {
                checkBoxValues[actualIndex] = false;
                isAddBtnShow[actualIndex] = true;
                myPledgedSecurityList[index].amount = 0.0;
                controllers2[actualIndex].text = "0";
                unitStringList[actualIndex] = "0";
                totalValue.value = 0;
                eligibleLoan.value = 0;
                for(int i= 0; i<searchMyCartList.length ; i++){
                  totalValue.value = totalValue.value + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                  eligibleLoan.value += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                }
                loanData.value.totalCollateralValue = totalValue.value;
                myPledgedSecurityList[index].pledgedQuantity = double.parse(controllers2[actualIndex].text);
                totalSelectedScrips = totalSelectedScrips - 1;
                checkBoxValue = false;
                if (tempLength == myPledgedSecurityList.length) {
                  isScripsSelect.value = false;
                } else {
                  isScripsSelect.value = true;
                }
              //});
              Utility.showToastMessage(Strings.check_unit);
            }
          } else {
            //setState(() {
              controllers2[actualIndex].text = "0.001";
              unitStringList[actualIndex] = "0.001";
              myPledgedSecurityList[index].pledgedQuantity = double.parse(controllers2[actualIndex].text);
              myPledgedSecurityList[index].amount = 0.001 * myPledgedSecurityList[index].price!;
              totalValue.value = 0;
              eligibleLoan.value = 0;
              for(int i= 0; i<searchMyCartList.length ; i++){
                totalValue.value = totalValue.value + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                eligibleLoan.value += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
              }
            //});
          }
          //setState(() {
            invokeAndEligibility();
          //});
        //});
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  textFieldOnChanged(int index, int actualIndex) {
    if (controllers2[actualIndex].text.isNotEmpty) {
      if(!controllers2[actualIndex].text.endsWith(".") && !controllers2[actualIndex].text.endsWith(".0") && !controllers2[actualIndex].text.endsWith(".00")){
        if (double.parse(controllers2[actualIndex].text) >= 0.001 && !controllers2[actualIndex].text.startsWith("0.000")) {
          if (double.parse(controllers2[actualIndex].text) < .001) {
            Utility.showToastMessage(Strings.zero_unit_validation);
            Get.focusScope?.requestFocus(new FocusNode());
          } else if (double.parse(controllers2[actualIndex].text) > actualQtyList[actualIndex].toDouble()) {
            Utility.showToastMessage("${Strings.check_unit}, This scheme has only ${actualQtyList[actualIndex]} unit.");
            Get.focusScope?.requestFocus(new FocusNode());
            //setState(() {
              if(myPledgedSecurityList[index].pledgedQuantity.toString().split(".")[1].length != 0){
                var unitsDecimalCount;
                String str = myPledgedSecurityList[index].pledgedQuantity.toString();
                var qtyArray = str.split('.');
                unitsDecimalCount = qtyArray[1];
                if(unitsDecimalCount == "0"){
                  unitStringList[actualIndex] = str.toString().split(".")[0];
                  controllers2[actualIndex].text = str.toString().split(".")[0];
                }else{
                  unitStringList[actualIndex] = myPledgedSecurityList[index].pledgedQuantity.toString();
                  controllers2[actualIndex].text = myPledgedSecurityList[index].pledgedQuantity.toString();
                }
              }else{
                unitStringList[actualIndex] = myPledgedSecurityList[index].pledgedQuantity.toString();
                controllers2[actualIndex].text = myPledgedSecurityList[index].pledgedQuantity.toString();
              }
              myPledgedSecurityList[index].pledgedQuantity = double.parse(controllers2[actualIndex].text);
              totalValue.value = 0;
              eligibleLoan.value = 0;
              for(int i= 0; i<searchMyCartList.length ; i++){
                totalValue.value = totalValue.value + (searchMyCartList[i].price! * double.parse(controllers2[i].text));
                eligibleLoan.value += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
              }
              var updateAmount = double.parse(controllers2[actualIndex].text) * myPledgedSecurityList[index].price!;
              loanData.value.totalCollateralValue = totalValue.value;
              myPledgedSecurityList[index].amount = updateAmount;
            //});
          } else {

            if(controllers2[actualIndex].text.toString().contains(".") && controllers2[actualIndex].text.toString().split(".")[1].length != 0){
              var unitsDecimalCount;
              String str = controllers2[actualIndex].text.toString();
              var qtyArray = str.split('.');
              unitsDecimalCount = qtyArray[1];
              if(unitsDecimalCount == "0"){
                unitStringList[actualIndex] = str.toString().split(".")[0];
              }else{
                unitStringList[actualIndex] = controllers2[actualIndex].text.toString();
              }
            }else{
              unitStringList[actualIndex] = controllers2[actualIndex].text.toString();
            }
            myPledgedSecurityList[index].pledgedQuantity = double.parse(unitStringList[actualIndex]);
            totalValue.value = 0;
            eligibleLoan.value = 0;
            for(int i= 0; i<searchMyCartList.length ; i++){
              totalValue.value = totalValue.value + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
              eligibleLoan.value += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
            }
            var updateAmount = double.parse(controllers2[actualIndex].text) * myPledgedSecurityList[index].price!;
            loanData.value.totalCollateralValue = totalValue.value;
            myPledgedSecurityList[index].amount = updateAmount;
          }
        } else if( controllers2[actualIndex].text != "0") {
          //setState(() {
            if(actualQtyList[actualIndex] < 1){
              controllers2[actualIndex].text = actualQtyList[actualIndex].toString();
              unitStringList[actualIndex] = actualQtyList[actualIndex].toString();
              totalValue.value = 0;
              eligibleLoan.value = 0;
              for(int i= 0; i<searchMyCartList.length ; i++){
                totalValue.value = totalValue.value + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                eligibleLoan.value += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
              }
              myPledgedSecurityList[index].pledgedQuantity = actualQtyList[actualIndex];
            } else {
              controllers2[actualIndex].text = "1";
              unitStringList[actualIndex] = "1";
              totalValue.value = 0;
              eligibleLoan.value = 0;
              for(int i= 0; i<searchMyCartList.length ; i++){
                totalValue.value = totalValue.value + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                eligibleLoan.value += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
              }
              myPledgedSecurityList[index].pledgedQuantity = 1;
            }
            var updateAmount = double.parse(controllers2[actualIndex].text) * myPledgedSecurityList[index].price!;
            myPledgedSecurityList[index].amount = updateAmount;
            //FocusScope.of(context).requestFocus(new FocusNode());
            Get.focusScope?.requestFocus(new FocusNode());
         // });
        }
      }
    }
    invokeAndEligibility();
  }

  addClicked(int index, int actualIndex)  async {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        //FocusScope.of(context).unfocus();
        //FocusScope.of(context).requestFocus(new FocusNode());
        Get.focusScope?.unfocus();
        Get.focusScope?.requestFocus(new FocusNode());
        if(controllers2[actualIndex].text.toString().isNotEmpty){
          if (double.parse(controllers2[actualIndex].text) < actualQtyList[actualIndex]) {
            double incrementWith = 0;
            var txt;
            if(controllers2[actualIndex].text.toString().contains('.') && controllers2[actualIndex].text.toString().split(".")[1].length != 0) {
              var unitsDecimalCount;
              String str = controllers2[actualIndex].text.toString();
              var qtyArray = str.split('.');
              unitsDecimalCount = qtyArray[1];
              if(int.parse(unitsDecimalCount) == 0){
                txt = double.parse(controllers2[actualIndex].text) + 1;
                if(txt>actualQtyList[actualIndex]){
                  Utility.showToastMessage(Strings.check_unit);
                } else {
                  incrementWith = 1;
                  myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toString());
                  unitStringList[actualIndex] = txt.toString();
                  controllers2[actualIndex].text = unitStringList[actualIndex];
                }
              } else {
                if (unitsDecimalCount.toString().length == 1) {
                  txt = double.parse(controllers2[actualIndex].text) + .1;
                  if(txt>actualQtyList[actualIndex]){
                    Utility.showToastMessage(Strings.check_unit);
                  } else {
                    incrementWith = .1;
                    myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(1));
                    unitStringList[actualIndex] = txt.toStringAsFixed(1);
                    controllers2[actualIndex].text = unitStringList[actualIndex];
                  }
                } else if (unitsDecimalCount.toString().length == 2) {
                  txt = double.parse(controllers2[actualIndex].text) + .01;
                  if(txt>actualQtyList[actualIndex]){
                    Utility.showToastMessage(Strings.check_unit);
                  } else {
                    incrementWith = .01;
                    myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(2));
                    unitStringList[actualIndex] = txt.toStringAsFixed(2);
                    controllers2[actualIndex].text = unitStringList[actualIndex];
                  }
                } else {
                  txt = double.parse(controllers2[actualIndex].text) + .001;
                  if(txt>actualQtyList[actualIndex]){
                    Utility.showToastMessage(Strings.check_unit);
                  } else {
                    incrementWith = .001;
                    myPledgedSecurityList[index].pledgedQuantity = double.parse(txt.toStringAsFixed(3));
                    unitStringList[actualIndex] = txt.toStringAsFixed(3);
                    controllers2[actualIndex].text = unitStringList[actualIndex];
                  }
                }
              }
            }else{
              if (actualQtyList[actualIndex] < 1) {
                txt = actualQtyList[actualIndex];
                if(txt>actualQtyList[actualIndex]){
                  Utility.showToastMessage(Strings.check_unit);
                } else {
                  incrementWith = actualQtyList[actualIndex];
                  myPledgedSecurityList[index].pledgedQuantity = txt;
                  unitStringList[actualIndex] = txt.toString();
                  controllers2[actualIndex].text = unitStringList[actualIndex];
                }
              } else{
                txt = double.parse(controllers2[actualIndex].text) + 1;
                if(txt>actualQtyList[actualIndex]){
                  Utility.showToastMessage(Strings.check_unit);
                } else {
                  incrementWith = 1;
                  myPledgedSecurityList[index].pledgedQuantity = txt;
                  if(txt.toString().split(".")[1].length != 0){
                    var unitsDecimalCount;
                    String str = txt.toString();
                    var qtyArray = str.split('.');
                    unitsDecimalCount = qtyArray[1];
                    if(unitsDecimalCount == "0"){
                      unitStringList[actualIndex] = str.toString().split(".")[0];
                      controllers2[actualIndex].text = str.toString().split(".")[0];
                    }else{
                      unitStringList[actualIndex] = txt;
                      controllers2[actualIndex].text = txt;
                    }
                  }
                }
              }
            }
            if(incrementWith != 0){
             // setState(() {
                myPledgedSecurityList[index].pledgedQuantity = txt.toDouble();
                myPledgedSecurityList[index].amount = txt * myPledgedSecurityList[index].price!;
                totalValue.value = 0;
                eligibleLoan.value = 0;
                for(int i= 0; i<searchMyCartList.length ; i++){
                  totalValue.value = totalValue.value + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
                  eligibleLoan.value += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
                }
                loanData.value.totalCollateralValue = totalValue.value;
                if(searchMyCartList.length == totalSelectedScrips){
                  checkBoxValue = true;
                }
             // });
            }
          } else {
            Utility.showToastMessage(Strings.check_unit);
          }}
        else{
         // setState(() {
            controllers2[actualIndex].text = "0.001";
            unitStringList[actualIndex] = "0.001";
            myPledgedSecurityList[index].pledgedQuantity = double.parse(controllers2[actualIndex].text);
            myPledgedSecurityList[index].amount = 0.001 * myPledgedSecurityList[index].price!;
            totalValue.value = 0;
            eligibleLoan.value = 0;
            for(int i= 0; i<searchMyCartList.length ; i++){
              totalValue.value = totalValue.value + (searchMyCartList[i].price! * double.parse(unitStringList[i]));
              eligibleLoan.value += (searchMyCartList[i].price! * double.parse(unitStringList[i])) * (searchMyCartList[i].eligiblePercentage!/100);
            }
          //});
        }
        invokeAndEligibility();
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }
}