import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/my_loan/presentation/arguments/mf_increase_loan_arguments.dart';
import 'package:lms/lender/LenderBloc.dart';
import 'package:lms/network/requestbean/MFSchemeRequest.dart';
import 'package:lms/network/responsebean/MFSchemeResponse.dart';
import 'package:lms/network/responsebean/MyCartResponseBean.dart';
import 'package:lms/pledge_eligibility/mutual_fund/MFSchemeBloc.dart';

class MfIncreaseLoanController extends GetxController{
  Widget appBarTitle = new Text("", style: mediumTextStyle_18_gray_dark);
  Icon actionIcon = new Icon(Icons.search, color: appTheme, size: 25);
  TextEditingController _textController = TextEditingController();
  FocusNode searchFocusNode = FocusNode();
  final lenderBloc = LenderBloc();
  final mFSchemeBloc = MFSchemeBloc();
  List<TextEditingController> unitControllersList = [];
  List<SchemesList> schemesListAfterFilter = [];
  List<bool> isAddBtnSelected = [];
  List<bool> isAddQtyEnable = [];
  List<String> selectedLenderList = [];
  List<String> selectedLevelList = [];
  List<bool> selectedBoolLenderList = [];
  List<bool> selectedBoolLevelList = [];
  List<String> lenderList = [];
  List<String> levelList = [];
  List<SchemesList> schemesList = [];
  bool? isDefaultBottomDialog = true;
  bool? isEligibleBottomDialog = false;
  List<FocusNode> focusNode = [];
  double schemeValue = 0.0;
  double eligibleLoanAmount = 0.0;
  bool isSchemeSelect = true;
  String? schemeType = "";
  LoanMarginShortfallObj? marginShortfallObj;
  MFIncreaseLoanArguments pageArguments = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    appBarTitle = Text(
      Strings.pledge_security,
      style: mediumTextStyle_18_gray_dark,
    );
    schemeType = pageArguments.schemeType;
    lenderBloc.getLenders().then((value) {
      ///todo: change the return types of variables used in setState function
     // setState(() {
        if (value.isSuccessFull!) {
          for (int i = 0; i < value.lenderData!.length; i++) {
            lenderList.add(value.lenderData![i].name!);
            selectedLenderList.add(value.lenderData![i].name!);
            selectedBoolLenderList.add(true);
            levelList.addAll(value.lenderData![0].levels!);
            value.lenderData![0].levels!.forEach((element) {
              selectedLevelList.add(element.toString().split(" ")[1]);
              selectedBoolLevelList.add(true);
            });
          }

          mFSchemeBloc.getSchemesList(
              MFSchemeRequest(schemeType, selectedLenderList.join(","),
                  selectedLevelList.join(","))).then((value) {
            if (value.isSuccessFull!) {
              schemesListAfterFilter.clear();
              isAddBtnSelected.clear();
              unitControllersList.clear();
              isAddQtyEnable.clear();
              focusNode.clear();

              schemesListAfterFilter.addAll(value.mFSchemeData!.schemesList!);
              schemesListAfterFilter.forEach((element) {
                isAddBtnSelected.add(true);
                unitControllersList.add(TextEditingController());
                isAddQtyEnable.add(false);
                focusNode.add(FocusNode());
              });
            } else {
              Utility.showToastMessage(value.errorMessage!);
            }
          });
        } else {
          Utility.showToastMessage(value.errorMessage!);
        }
     // });
    });
  }
}
