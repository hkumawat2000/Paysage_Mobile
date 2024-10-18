import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/my_cart_request_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/mf_scheme_response_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/presentation/controllers/pledge_mf_scheme_selection_controller.dart';

class PledgeMfSchemeSelectionView
    extends GetView<PledgeMfSchemeSelectionController> {
  PledgeMfSchemeSelectionView();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Obx(
        ()=> Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: colorBg,
          appBar: buildBar(context),
          body: schemeSelectionBody(),
        ),
      ),
    );
  }

  PreferredSizeWidget buildBar(BuildContext context) {
    final theme = Theme.of(context);
    return new AppBar(
      elevation: 0.0,
      centerTitle: true,
      title: controller.appBarTitle,
      backgroundColor: colorBg,
      leading: IconButton(
        icon: ArrowToolbarBackwardNavigation(),
        onPressed: () => Navigator.pop(context),
      ),
      actions: <Widget>[
        Theme(
          data: theme.copyWith(primaryColor: Colors.white),
          child: IconButton(
            icon: controller.actionIcon,
            onPressed: () {
              if (controller.actionIcon.icon == Icons.search) {
                controller.actionIcon = Icon(
                  Icons.close,
                  color: appTheme,
                  size: 25,
                );
                controller.appBarTitle = TextField(
                  controller: controller.textController,
                  focusNode: controller.searchFocusNode,
                  style: TextStyle(
                    color: appTheme,
                  ),
                  cursorColor: appTheme,
                  decoration: InputDecoration(
                      prefixIcon: new Icon(
                        Icons.search,
                        color: appTheme,
                        size: 25,
                      ),
                      hintText: "Search...",
                      focusColor: appTheme,
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: appTheme)),
                  onChanged: (value) => controller.schemeSearch(
                      controller.schemesListAfterFilter, value),
                );
                controller.searchFocusNode.requestFocus();
              } else {
                controller.handleOnSearchEnd();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget schemeSelectionBody() {
    return NestedScrollView(
      physics: NeverScrollableScrollPhysics(),
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(height: 0.5),
            ]),
          )
        ];
      },
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                mutualFundDropdown(),
                SizedBox(width: 20),
                Expanded(
                  child: GestureDetector(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Strings.filter, style: regularTextStyle_14),
                        SizedBox(width: 4),
                        Icon(Icons.filter_alt_rounded,
                            size: 24, color: appTheme)
                      ],
                    ),
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        context: Get.context!,
                        isScrollControlled: true,
                        builder: (BuildContext context) {
                          return filerDialog();
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              controller: controller.scrollController,
              child: schemesListBuilder(),
            ),
          ),
          controller.isDefaultBottomDialog.isTrue
              ? bottomSheetDialog()
              : eligibleLimitViewVaultDialog()
        ],
      ),
    );
  }

  Widget schemesListBuilder() {
    return StreamBuilder<MfSchemeResponseEntity>(
      stream: controller.getSchemes,
      builder: (context, AsyncSnapshot<MfSchemeResponseEntity> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data!.mfSchemeDataResponseModel == null ||
              snapshot.data!.mfSchemeDataResponseModel!.schemesListEntity!
                      .length ==
                  0) {
            return NoDataWidget();
          } else {
            controller.schemesList.value =
                snapshot.data!.mfSchemeDataResponseModel!.schemesListEntity!;
            return schemesListWidget();
          }
        } else if (snapshot.hasError) {
          if (snapshot.error == "403") {
            SchedulerBinding.instance.addPostFrameCallback((_) {
              commonDialog(Strings.session_timeout, 4);
            });
            return ErrorMessageWidget("");
          }
          return ErrorMessageWidget(snapshot.error.toString());
        } else {
          return Column(
            children: [
              SizedBox(height: 60),
              LoadingWidget(),
            ],
          );
        }
      },
    );
  }

  Widget filerDialog() {
    controller.lenderCheckBox.addAll(controller.selectedBoolLenderList);
    controller.levelCheckBox.addAll(controller.selectedBoolLevelList);

    return Container(
      height: Get.mediaQuery.size.height - 200,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.white, width: 3.0),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(16.0), topLeft: Radius.circular(16.0)),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
        ],
      ),
      child: NestedScrollView(
        physics: NeverScrollableScrollPhysics(),
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            SliverList(
              delegate: SliverChildListDelegate([SizedBox(height: 1)]),
            )
          ];
        },
        body: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(Strings.lender,
                          style: boldTextStyle_18.copyWith(fontSize: 20)),
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter s) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.lenderList.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                onChanged: (val) {
                                  s(() {
                                    controller.lenderCheckBox[index] = val!;
                                    if (!controller.lenderCheckBox
                                        .contains(true)) {
                                      Utility.showToastMessage(
                                          "Atleast one lender is mandatory");
                                      controller.lenderCheckBox[index] = !val;
                                    }
                                  });
                                },
                                value: controller.lenderCheckBox[index],
                                title: Text(controller.lenderList[index]),
                              );
                            },
                          );
                        },
                      ),
                      SizedBox(height: 20),
                      Text(Strings.level,
                          style: boldTextStyle_18.copyWith(fontSize: 20)),
                      StatefulBuilder(
                        builder: (BuildContext context, StateSetter s) {
                          return ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: controller.levelList.length,
                            itemBuilder: (context, index) {
                              return CheckboxListTile(
                                contentPadding: EdgeInsets.zero,
                                onChanged: (val) {
                                  s(() {
                                    controller.levelCheckBox[index] = val!;
                                    if (!controller.levelCheckBox
                                        .contains(true)) {
                                      Utility.showToastMessage(
                                          "Atleast one level is mandatory");
                                      controller.levelCheckBox[index] = !val;
                                    }
                                  });
                                },
                                value: controller.levelCheckBox[index],
                                title: Text(controller.levelList[index]),
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: 40,
                      width: 100,
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35),
                            side: BorderSide(color: red)),
                        elevation: 1.0,
                        color: colorWhite,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          minWidth: Get.mediaQuery.size.width,
                          onPressed: () async {
                            Get.back();
                          },
                          child: Text(
                            Strings.cancel,
                            style: buttonTextRed,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 40,
                      width: 100,
                      child: Material(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)),
                        elevation: 1.0,
                        color: appTheme,
                        child: MaterialButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          minWidth: Get.mediaQuery.size.width,
                          onPressed: () async {
                            Utility.isNetworkConnection().then((isNetwork) {
                              if (isNetwork) {
                                controller.previousLevelList
                                    .addAll(controller.selectedLevelList);
                                if (!controller.levelCheckBox.contains(true)) {
                                  Utility.showToastMessage(
                                      "Atleast one level is mandatory");
                                } else {
                                  controller.selectedLenderList.clear();
                                  controller.selectedLevelList.clear();
                                  for (int i = 0;
                                      i < controller.lenderList.length;
                                      i++) {
                                    if (controller.lenderCheckBox[i]) {
                                      controller.selectedLenderList
                                          .add(controller.lenderList[i]);
                                      controller.selectedBoolLenderList[i] =
                                          true;
                                    } else {
                                      controller.selectedBoolLenderList[i] =
                                          false;
                                    }
                                  }

                                  for (int i = 0;
                                      i < controller.levelList.length;
                                      i++) {
                                    if (controller.levelCheckBox[i]) {
                                      controller.selectedLevelList.add(
                                          controller.levelList[i]
                                              .toString()
                                              .split(" ")[1]);
                                      controller.selectedBoolLevelList[i] =
                                          true;
                                    } else {
                                      controller.selectedBoolLevelList[i] =
                                          false;
                                    }
                                  }
                                  bool condition1 = controller.previousLevelList
                                      .toSet()
                                      .difference(
                                          controller.selectedLevelList.toSet())
                                      .isEmpty;
                                  bool condition2 =
                                      controller.previousLevelList.length ==
                                          controller.selectedLevelList.length;
                                  bool isEqual = condition1 && condition2;
                                  Get.back();
                                  if (!isEqual) {
                                    showDialogLoading(Strings.please_wait);
                                    controller.scrollUp();
                                    controller.handleOnSearchEnd();
                                    controller.getSchemesAndSetLoanAmount();
                                  }
                                }
                              } else {
                                Utility.showToastMessage(
                                    Strings.no_internet_message);
                              }
                            });
                          },
                          child: Text(
                            Strings.apply,
                            style: buttonTextWhite,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget mutualFundDropdown() {
    return Expanded(
      child: Container(
        child: DropdownButton<String>(
          isExpanded: true,
          value: controller.currentMutualFundOption,
          icon: Image.asset(AssetsImagePath.down_arrow, height: 15, width: 15),
          elevation: 16,
          onChanged: controller.changedDropDownMutualFund,
          items: controller.dropDownMutualFund,
        ),
      ),
    );
  }

  Widget schemesListWidget() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 10.0, top: 0, right: 10, bottom: 120),
      child: ListView.builder(
        key: Key(controller.schemesList.length.toString()),
        // controller: _scrollController,
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        itemCount: controller.schemesList.length,
        itemBuilder: (context, index) {
          // if (index == schemesList.length) {
          //   return Container(height: MediaQuery.of(context).size.height / 2);
          // }
          int actualIndex = controller.schemesListAfterFilter.indexWhere(
              (element) =>
                  element.schemeName ==
                  controller.schemesList[index].schemeName);

          return Container(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 3.0),
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              child: Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Text("${controller.schemesList[index].schemeName!}",
                          style: boldTextStyle_18),
                      SizedBox(
                        height: 4,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width:
                                  (MediaQuery.of(context).size.width - 150) / 3,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        scripsValueText(
                                            "₹${controller.schemesList[index].price!.toString()}"),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                "${controller.isAddBtnSelected[actualIndex] ? "0" : controller.unitControllersList[actualIndex].text.toString().trim()} Units",
                                                style: mediumTextStyle_12_gray,
                                              ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            controller.isAddBtnSelected[actualIndex]
                                ? addSchemesBtn(index, actualIndex)
                                : increaseDecreaseSchemes(index, actualIndex),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: <Widget>[
                                Stack(
                                  children: <Widget>[
                                    Container(
                                      width: 72,
                                      height: 73,
                                      child: Container(
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          color: colorRed,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(100.0)),
                                        ),
                                        child: controller.schemesList[index]
                                                        .amcImage !=
                                                    null &&
                                                controller.schemesList[index]
                                                    .amcImage!.isNotEmpty
                                            ? CircleAvatar(
                                                backgroundImage: NetworkImage(
                                                    controller
                                                        .schemesList[index]
                                                        .amcImage!),
                                                backgroundColor: colorRed,
                                                radius: 50.0)
                                            : Text(
                                                getInitials(
                                                    controller
                                                        .schemesList[index]
                                                        .schemeName,
                                                    1),
                                                style: extraBoldTextStyle_30),
                                        // : Text(schemesList[index].amcCode!, style: extraBoldTextStyle_30),
                                      ), //Container ,
                                    ), //Container
                                    Positioned(
                                      top: 51,
                                      left: 4,
                                      height: 22,
                                      width: 68,
                                      child: Container(
                                        width: 68,
                                        child: Material(
                                          color: colorBg,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(35),
                                              side: BorderSide(color: red)),
                                          elevation: 1.0,
                                          child: MaterialButton(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(35)),
                                            minWidth: MediaQuery.of(context)
                                                .size
                                                .width,
                                            onPressed: () {
                                              controller.getIsinDetailsData(
                                                  controller
                                                      .schemesList[index].isin
                                                      .toString(),
                                                  index,
                                                  actualIndex);
                                            },
                                            child: Text(
                                              "Details",
                                              style: TextStyle(
                                                  color: red,
                                                  fontSize: 10,
                                                  fontWeight: bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ) //Container
                                  ], //<Widget>[]
                                ), //Stack
                              ],
                            ),
                          ]),
                      SizedBox(
                        height: 10,
                      ),
                      // Text(
                      //   "Scheme Type: ${schemesList[index].schemeType}",
                      //   style: mediumTextStyle_12_gray,
                      // ),
                      // lenderListUI(schemesList[index].lenders!)
                    ],
                  )));
        },
      ),
    );
  }

  Widget increaseDecreaseSchemes(int index, int actualIndex) {
    if (controller.eligibleLoanAmount.value != 0.0) {
      controller.isSchemeSelect.value = false;
    } else {
      controller.isSchemeSelect.value = true;
    }
    return Visibility(
      visible: controller.isAddQtyEnable[actualIndex],
      child: Column(
        children: [
          Row(
            children: <Widget>[
              IconButton(
                iconSize: 20.0,
                icon: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 1, color: colorBlack),
                  ),
                  child: Icon(Icons.remove, color: colorBlack, size: 18),
                ),
                onPressed: () async {
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      controller.DecreaseOrRemoveScheme(index,actualIndex);
                    } else {
                      Utility.showToastMessage(Strings.no_internet_message);
                    }
                  });
                },
              ),
              Container(
                width: 60,
                height: 65,
                child: TextField(
                  controller: controller.unitControllersList[actualIndex],
                  textAlign: TextAlign.center,
                  decoration: InputDecoration(counterText: ""),
                  focusNode: controller.focusNode[actualIndex],
                  showCursor: true,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    DecimalTextInputFormatter(decimalRange: 3),
                    FilteringTextInputFormatter.allow(
                        RegExp(r'^(\d+)?\.?\d{0,3}')),
                  ],
                  style: boldTextStyle_18,
                  onChanged: (value) {
                   controller.increaseSchemeThroughTextfield(value,index,actualIndex);
                  },
                ),
              ),
              IconButton(
                iconSize: 20,
                icon: Container(
                  padding: EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(width: 1, color: colorBlack),
                  ),
                  child: Icon(Icons.add, color: colorBlack, size: 18),
                ),
                onPressed: () async {
                 controller.increaseorAddScheme(index,actualIndex);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget addSchemesBtn(int index, int actualIndex) {
    return Visibility(
      visible: controller.isAddBtnSelected[actualIndex],
      child: Container(
        height: 30,
        width: 70,
        child: Material(
          color: appTheme,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          elevation: 1.0,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            minWidth: Get.mediaQuery.size.width,
            onPressed: () {
            controller.onAddSchemeButtonClick(index,actualIndex);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Add +",
                    style: TextStyle(
                        color: colorWhite, fontSize: 10, fontWeight: bold))
              ],
            ),
          ),
        ),
      ),
    );
  }



  Widget lenderListUI(String lenders) {
    List<String> lenderIconList = lenders.split(",");
    return Center(
      child: Container(
        height: 40,
        child: ListView.builder(
          itemCount: lenderIconList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: Image.asset(
                getInitials(lenderIconList[index], 1).toLowerCase() == "c"
                    ? AssetsImagePath.lender_finserv
                    : getInitials(lenderIconList[index], 1).toLowerCase() == "b"
                        ? AssetsImagePath.lender_bajaj_finance
                        : getInitials(lenderIconList[index], 1).toLowerCase() ==
                                "t"
                            ? AssetsImagePath.lender_tata_capital
                            : AssetsImagePath.lender_finserv,
                height: 24,
                width: 24,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget bottomSheetDialog() {
    if (controller.eligibleLoanAmount.value != 0.0) {
      controller.isSchemeSelect.value = false;
    } else {
      controller.isSchemeSelect.value = true;
    }

    return Visibility(
      visible: controller.isDefaultBottomDialog.value,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
          ],
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset(AssetsImagePath.down_arrow_image,
                        height: 15, width: 15),
                    onPressed: () {
                      controller.isDefaultBottomDialog.value = false;
                      controller.isEligibleBottomDialog.value = true;
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(Strings.scheme_value,
                              style: mediumTextStyle_18_gray),
                        ),
                        Text(
                          "₹${numberToString(controller.schemeValue.toStringAsFixed(2))}",
                          style: boldTextStyle_18_gray_dark,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Expanded(
                          child: Text(Strings.eligible_loan_amount_small,
                              style: mediumTextStyle_18_gray),
                        ),
                        Text(
                            "₹${numberToString(controller.eligibleLoanAmount.toStringAsFixed(2))}",
                            style: textStyleGreenStyle_18)
                      ],
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Container(
                  height: 50,
                  width: 140,
                  child: Material(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(35)),
                    elevation: 1.0,
                    color: controller.isSchemeSelect.value == false
                        ? controller.schemeValue <= 999999999999
                            ? appTheme
                            : colorLightGray
                        : colorLightGray,
                    child: AbsorbPointer(
                      absorbing: controller.isSchemeSelect.value,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)),
                        minWidth: Get.mediaQuery.size.width,
                        onPressed: () async {
                          controller.onViewVaultClicked();
                        },
                        child: Text(Strings.view_vault, style: buttonTextWhite),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget eligibleLimitViewVaultDialog() {
    if (controller.eligibleLoanAmount.value == 0.0) {
      controller.isSchemeSelect.value = true;
    } else {
      controller.isSchemeSelect.value = false;
    }

    return Visibility(
      visible: controller.isEligibleBottomDialog.value,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.white, width: 3.0),
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
          boxShadow: [
            BoxShadow(
                blurRadius: 10, color: colorLightGray, offset: Offset(1, 5))
          ],
        ),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Image.asset(AssetsImagePath.up_arrow,
                        height: 15, width: 15),
                    onPressed: () {
                      controller.isDefaultBottomDialog.value = true;
                      controller.isEligibleBottomDialog.value = false;
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                                "₹${numberToString(controller.eligibleLoanAmount.value.toStringAsFixed(2))}",
                                style: textStyleGreenStyle_18),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(Strings.eligible_loan_amount_small,
                                    style: mediumTextStyle_12_gray)
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        height: 50,
                        width: 140,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          elevation: 1.0,
                          color: controller.isSchemeSelect.isFalse
                              ? controller.schemeValue.value <= 999999999999
                                  ? appTheme
                                  : colorLightGray
                              : colorLightGray,
                          child: AbsorbPointer(
                            absorbing: controller.isSchemeSelect.value,
                            child: MaterialButton(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              minWidth: Get.mediaQuery.size.width,
                              onPressed: () async {
                                Utility.isNetworkConnection()
                                    .then((isNetwork) async {
                                  if (isNetwork) {
                                    SecuritiesRequestEntity securities =
                                        SecuritiesRequestEntity();
                                    RxList<SecuritiesListRequestEntity>
                                        schemeQtyList =
                                        <SecuritiesListRequestEntity>[].obs;
                                    RxList<SchemesListEntity> schemesList =
                                        <SchemesListEntity>[].obs;
                                    schemeQtyList.clear();
                                    for (int i = 0;
                                        i <
                                            controller
                                                .schemesListAfterFilter.length;
                                        i++) {
                                      if (!controller.isAddBtnSelected[i]) {
                                        schemeQtyList.add(
                                            new SecuritiesListRequestEntity(
                                                isin: controller
                                                    .schemesListAfterFilter[i]
                                                    .isin,
                                                quantity: double.parse(
                                                    controller
                                                        .unitControllersList[i]
                                                        .text)));
                                        schemesList.add(controller
                                            .schemesListAfterFilter[i]);
                                      }
                                    }
                                    securities.list = schemeQtyList;
                                    if (controller.schemeValue.value <=
                                        999999999999) {
                                      controller.handleOnSearchEnd();
                                      MyCartRequestEntity requestBean =
                                          MyCartRequestEntity(
                                        securities: securities,
                                        instrumentType: Strings.mutual_fund,
                                        schemeType:
                                            controller.currentMutualFundOption,
                                        loan_margin_shortfall_name: "",
                                        pledgor_boid: "",
                                        cartName: "",
                                        loamName: "",
                                        lender: controller.lenderList[0],
                                      );

                                      //TODO Navigate to MFViewVaultScreen
                                      // List<SchemesListEntity> securityList =
                                      //     await Navigator.push(
                                      //         context,
                                      //         MaterialPageRoute(
                                      //             builder: (BuildContext
                                      //                     context) =>
                                      //                 MF_ViewVaultDetailsViewScreen(
                                      //                     requestBean,
                                      //                     schemesList)));
                                      // //T
                                      // controller.updateQuantity(securityList);
                                    } else {
                                      commonDialog(
                                          Strings.scheme_validation, 0);
                                    }
                                  } else {
                                    Utility.showToastMessage(
                                        Strings.no_internet_message);
                                  }
                                });
                              },
                              child: Text(Strings.view_vault,
                                  style: buttonTextWhite),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
