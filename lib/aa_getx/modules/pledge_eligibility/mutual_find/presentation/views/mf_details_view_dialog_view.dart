import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/request/my_cart_request_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/domain/entities/response/mf_scheme_response_entity.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/presentation/arguments/mf_details_dialog_arguments.dart';
import 'package:lms/aa_getx/modules/pledge_eligibility/mutual_find/presentation/controllers/mf_details_view_dialog_controller.dart';

class MfDetailsViewDialogView extends GetView<MfDetailsViewDialogController> {
  MfDetailsDialogArguments mfDetailsDialogArguments;
  MfDetailsViewDialogView({required this.mfDetailsDialogArguments});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => WillPopScope(
        onWillPop: controller.onBackPressed,
        child: Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                    controller.focusNode.unfocus();
                    Navigator.pop(
                        context, controller.arguments.selectedSchemeList);
                  },
                  child: Container(
                    color: Colors.transparent,
                    height: 100,
                    alignment: Alignment.topCenter,
                    child: Center(
                      child: IconButton(
                        iconSize: 40,
                        icon: Image.asset(
                          AssetsImagePath.cross_icon,
                        ),
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          controller.focusNode.unfocus();
                          Navigator.pop(
                              context, controller.arguments.selectedSchemeList);
                        },
                      ),
                    ),
                  ),
                ),
                Expanded(child: getBottomSheet()),
              ],
            )),
      ),
    );
  }

  Widget getBottomSheet() {
    if (controller.arguments.scheme.units == 0) {
      controller.isAddBtnSelected.value = true;
      controller.isAddQtyEnable.value = false;
    } else {
      controller.isAddBtnSelected.value = false;
      controller.isAddQtyEnable.value = true;
    }

    return GestureDetector(
      onTap: () => FocusScope.of(Get.context!).unfocus(),
      child: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Container(
          height: Get.mediaQuery.size.height - 100,
          decoration: new BoxDecoration(color: Colors.white),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: Column(
                    children: [
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Container(
                                width: 70,
                                height: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: colorRed,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100.0)),
                                ),
                                child: controller.arguments.scheme.amcImage !=
                                            null &&
                                        controller.arguments.scheme.amcImage!
                                            .isNotEmpty
                                    ? CircleAvatar(
                                        backgroundImage: NetworkImage(controller
                                            .arguments.scheme.amcImage!),
                                        backgroundColor: colorRed,
                                        radius: 50.0)
                                    : Text(
                                        getInitials(
                                            controller
                                                .arguments.scheme.schemeName,
                                            1),
                                        style: extraBoldTextStyle_30),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: Center(
                                  child: mediumHeadingText(Strings.nav))),
                          Expanded(
                              child: Center(child: mediumHeadingText("UNIT"))),
                          Expanded(
                              child: Center(child: mediumHeadingText("VALUE"))),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                              child: Center(
                                  child: scripsValueText(
                                      "₹${controller.arguments.scheme.price!.toString()}"))),
                          Expanded(
                              child: Center(
                                  child: controller.isAddBtnSelected.isTrue
                                      ? addSecuritiesBtn()
                                      : increaseDecreaseSecurities())),
                          Expanded(
                              child: Center(
                                  child: scripsValueText(
                                      "₹${(controller.arguments.scheme.price! * controller.arguments.scheme.units!).toStringAsFixed(3)}"))),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        child: Text(Strings.approving_lender,
                            style: boldTextStyle_18),
                      ),
                      SizedBox(height: 10),
                      approvingLenderList(),
                    ],
                  ),
                ),
              ),
              controller.isDefalutbottomDialog.isTrue
                  ? bottomsheetdialog()
                  : eligibleLimitViewVaultdialog()
            ],
          ),
        ),
      ),
    );
  }

  Widget approvingLenderList() {
    return Container(
      height: 360.0,
      //width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 10, top: 10),
      child: new ListView.builder(
        itemCount: controller.arguments.isinDetails!.length,
        itemBuilder: (context, index) {
          return new Container(
            margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 5),
            width: (MediaQuery.of(context).size.width - 40) / 2,
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black12, width: 1.0),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 10, top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(left: 2, right: 2),
                    alignment: Alignment.center,
                    child: Text(
                      controller.arguments.isinDetails![index].name!,
                      style: boldTextStyle_18,
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  mediumHeadingText("CAT"),
                  SizedBox(
                    height: 5,
                  ),
                  scripsValueText(
                      controller.arguments.isinDetails![index].category),
                  SizedBox(
                    height: 18,
                  ),
                  mediumHeadingText("LTV"),
                  SizedBox(
                    height: 5,
                  ),
                  scripsValueText(
                      "${controller.arguments.isinDetails![index].ltv!.toStringAsFixed(2)}%"),
                  SizedBox(
                    height: 18,
                  ),
                  mediumHeadingText("ROI (Per Month)"),
                  SizedBox(
                    height: 5,
                  ),
                  scripsValueText(
                      "${controller.arguments.isinDetails![index].rateOfInterest!.toStringAsFixed(2)}%"),
                  SizedBox(
                    height: 18,
                  ),
                  mediumHeadingText("MIN Limit"),
                  SizedBox(
                    height: 5,
                  ),
                  scripsValueText(
                      "₹${numberToString(controller.arguments.isinDetails![index].minimumSanctionedLimit!.toStringAsFixed(2))}"),
                  SizedBox(
                    height: 18,
                  ),
                  mediumHeadingText("MAX Limit"),
                  SizedBox(
                    height: 5,
                  ),
                  scripsValueText(
                      "₹${numberToString(controller.arguments.isinDetails![index].maximumSanctionedLimit!.toStringAsFixed(2))}"),
                ],
              ),
            ),
          );
        },
        scrollDirection: Axis.horizontal,
      ),
    );
  }

  Widget bottomsheetdialog() {
    if (controller.arguments.selectedSchemeList.length != 0) {
      controller.isSchemeSelect.value = false;
    } else {
      controller.isSchemeSelect.value = true;
    }

    return Visibility(
      visible: controller.isDefalutbottomDialog.value,
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
                      controller.isDefalutbottomDialog.value = false;
                      controller.isEligiblebottomDialog.value = true;
                    },
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(Strings.selected_value,
                              style: mediumTextStyle_18_gray),
                        ),
                        Text(
                          "₹${numberToString(controller.schemeValue!.toStringAsFixed(2))}",
                          style: boldTextStyle_18_gray_dark,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Text(Strings.eligible_loan_amount_small,
                              style: mediumTextStyle_18_gray),
                        ),
                        Text(
                            "₹${numberToString(controller.eligibleLoanAmount!.toStringAsFixed(2))}",
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
                    color: controller.isSchemeSelect.isFalse
                        ? controller.schemeValue.value! <= 999999999999
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
                          Utility.isNetworkConnection().then((isNetwork) async {
                            if (isNetwork) {
                              FocusScope.of(Get.context!).unfocus();
                              if (controller.controllers.text.isEmpty) {
                                controller.arguments.selectedSchemeList
                                    .removeWhere((element) =>
                                        element.isin ==
                                        controller.arguments.scheme.isin);
                              }
                              SecuritiesRequestEntity securities =
                                  SecuritiesRequestEntity();
                              controller.securitiesListItems.clear();
                              for (int i = 0;
                                  i <
                                      controller
                                          .arguments.selectedSchemeList.length;
                                  i++) {
                                if (controller.arguments.selectedSchemeList[i]
                                            .units !=
                                        null &&
                                    controller.arguments.selectedSchemeList[i]
                                            .units !=
                                        0) {
                                  controller.securitiesListItems.add(
                                    new SecuritiesListRequestEntity(
                                        isin: controller.arguments
                                            .selectedSchemeList[i].isin,
                                        quantity: controller.arguments
                                            .selectedSchemeList[i].units),
                                  );
                                }
                              }
                              securities.list = controller.securitiesListItems;
                              if (controller.schemeValue.value! <=
                                  999999999999) {
                                MyCartRequestEntity requestBean =
                                    MyCartRequestEntity(
                                        securities: securities,
                                        instrumentType: Strings.mutual_fund,
                                        schemeType:
                                            controller.arguments.schemeType,
                                        loan_margin_shortfall_name: "",
                                        pledgor_boid: "",
                                        cartName: "",
                                        loamName: "",
                                        lender: controller.arguments.lender);
                                if (controller.arguments.selectedSchemeList
                                            .length ==
                                        1 &&
                                    (controller.arguments.scheme.isin ==
                                        controller.arguments
                                            .selectedSchemeList[0].isin)) {
                                  if (controller.controllers.text.isNotEmpty &&
                                      controller.controllers.text != " ") {
                                    List<SchemesListEntity> securityList =
                                        await Get.toNamed(mfViewVaultDetailsScreen);
                                        // Navigator.push(
                                        //     context,
                                        //     MaterialPageRoute(
                                        //         builder: (BuildContext
                                        //                 context) =>
                                        //             MF_ViewVaultDetailsViewScreen(
                                        //               requestBean,
                                        //               widget.selectedSchemeList,
                                        //             )));

                                    bool isExist = false;
                                    securityList.forEach((element) {
                                      if (element.isin ==
                                          controller.arguments.scheme.isin) {
                                        isExist = true;
                                      }
                                    });
                                    if (isExist) {
                                      securityList.forEach((element) {
                                        if (element.isin ==
                                            controller.arguments.scheme.isin) {
                                          isExist = true;
                                          // } else {
                                          controller.controllers.text =
                                              element.units!.toString();
                                          controller.arguments.scheme.units =
                                              element.units!;
                                          if (element.units! == 0) {
                                            controller.isAddBtnSelected.value =
                                                true;
                                            controller.isAddQtyEnable.value =
                                                false;
                                          } else {
                                            controller.isAddBtnSelected.value =
                                                false;
                                            controller.isAddQtyEnable.value =
                                                true;
                                          }
                                        }
                                      });
                                    } else {
                                      controller.controllers.text = "0";
                                      controller.arguments.scheme.units = 0;
                                      controller.isAddBtnSelected.value = true;
                                      controller.isAddQtyEnable.value = false;
                                    }
                                    controller.arguments.selectedSchemeList
                                        .clear();
                                    controller.arguments.selectedSchemeList
                                        .addAll(securityList);
                                  controller.updateSchemeAndELValue();
                                  }
                                } else {
                                  List<SchemesListEntity> securityList =
                                      await Get.toNamed(mfViewVaultDetailsScreen);
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (BuildContext context) =>
                                      //             MF_ViewVaultDetailsViewScreen(
                                      //                 requestBean,
                                      //                 widget
                                      //                     .selectedSchemeList)));

                                  bool isExist = false;
                                  securityList.forEach((element) {
                                    if (element.isin ==
                                        controller.arguments.scheme.isin) {
                                      isExist = true;
                                    }
                                  });
                                  if (isExist) {
                                    securityList.forEach((element) {
                                      if (element.isin ==
                                          controller.arguments.scheme.isin) {
                                        isExist = true;
                                        var unitsDecimalCount;
                                        String str = element.units.toString();
                                        var qtyArray = str.split('.');
                                        unitsDecimalCount = qtyArray[1];
                                        if (unitsDecimalCount == "0") {
                                          controller.controllers.text =
                                              element.units!.toInt().toString();
                                          controller.arguments.scheme.units =
                                              element.units!;
                                        } else {
                                          controller.controllers.text =
                                              element.units!.toString();
                                          controller.arguments.scheme.units =
                                              element.units!;
                                        }

                                        if (element.units! == 0) {
                                          controller.isAddBtnSelected.value =
                                              true;
                                          controller.isAddQtyEnable.value =
                                              false;
                                        } else {
                                          controller.isAddBtnSelected.value =
                                              false;
                                          controller.isAddQtyEnable.value =
                                              true;
                                        }
                                      }
                                    });
                                  } else {
                                    controller.controllers.text = "0";
                                    controller.arguments.scheme.units = 0;
                                    controller.isAddBtnSelected.value = true;
                                    controller.isAddQtyEnable.value = false;
                                  }
                                  controller.arguments.selectedSchemeList
                                      .clear();
                                  controller.arguments.selectedSchemeList
                                      .addAll(securityList);
                                controller.updateSchemeAndELValue();
                                }
                              } else {
                                commonDialog(Strings.scheme_validation, 0);
                              }
                            } else {
                              Utility.showToastMessage(
                                  Strings.no_internet_message);
                            }
                          });
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

  Widget eligibleLimitViewVaultdialog() {
    if (controller.arguments.selectedSchemeList.length == 0) {
      controller.isSchemeSelect.value = true;
    } else {
      controller.isSchemeSelect.value = false;
    }

    return Visibility(
      visible: controller.isEligiblebottomDialog.value,
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
                    icon: Image.asset(
                      AssetsImagePath.up_arrow,
                      height: 15,
                      width: 15,
                    ),
                    onPressed: () {
                      controller.isDefalutbottomDialog.value = true;
                      controller.isEligiblebottomDialog.value = false;
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
                              "₹${numberToString(controller.eligibleLoanAmount.value!.toStringAsFixed(2))}",
                              style: textStyleGreenStyle_18),
                        ),
                        SizedBox(
                          width: 2,
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                Strings.eligible_loan_amount_small,
                                style: mediumTextStyle_12_gray,
                              )
                            ],
                          ),
                        ),
                      ],
                    )),
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
                              ? controller.schemeValue.value! <= 999999999999
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
                                    controller.securitiesListItems.clear();
                                    for (int i = 0;
                                        i <
                                            controller.arguments.schemeListItems
                                                .length;
                                        i++) {
                                      if (controller.arguments
                                                  .schemeListItems[i].units !=
                                              null &&
                                          controller.arguments
                                                  .schemeListItems[i].units !=
                                              0) {
                                        controller.securitiesListItems.add(
                                          new SecuritiesListRequestEntity(
                                              isin: controller.arguments
                                                  .schemeListItems[i].isin,
                                              quantity: controller.arguments
                                                  .schemeListItems[i].units),
                                        );
                                      }
                                    }
                                    final Map<String,
                                            SecuritiesListRequestEntity>
                                        schemeMap = new Map();
                                    controller.securitiesListItems
                                        .forEach((item) {
                                      schemeMap[item.isin!] = item;
                                    });
                                    securities.list =
                                        controller.securitiesListItems;
                                    if (controller.schemeValue.value! <=
                                        999999999999) {
                                      MyCartRequestEntity requestBean =
                                          MyCartRequestEntity(
                                              securities: securities,
                                              instrumentType:
                                                  Strings.mutual_fund,
                                              schemeType: controller
                                                  .arguments.schemeType,
                                              loan_margin_shortfall_name: "",
                                              pledgor_boid: "",
                                              cartName: "",
                                              loamName: "",
                                              lender:
                                                  controller.arguments.lender);
                                      if (controller.arguments
                                                  .selectedSchemeList.length ==
                                              1 &&
                                          (controller.arguments.scheme.isin ==
                                              controller
                                                  .arguments
                                                  .selectedSchemeList[0]
                                                  .isin)) {
                                        if (controller
                                                .controllers.text.isNotEmpty &&
                                            controller.controllers.text !=
                                                " ") {
                                          List<SchemesListEntity> securityList =
                                              await Get.toNamed(mfViewVaultDetailsScreen);
                                              // Navigator.push(
                                              //     context,
                                              //     MaterialPageRoute(
                                              //         builder: (BuildContext
                                              //                 context) =>
                                              //             MF_ViewVaultDetailsViewScreen(
                                              //               requestBean,
                                              //               widget
                                              //                   .selectedSchemeList,
                                              //             )));

                                          bool isExist = false;
                                          securityList.forEach((element) {
                                            if (element.isin ==
                                                controller
                                                    .arguments.scheme.isin) {
                                              isExist = true;
                                              print(
                                                  "helloo --> ${element.units.toString()}");
                                            }
                                          });

                                          if (isExist) {
                                            securityList.forEach((element) {
                                              if (element.isin ==
                                                  controller
                                                      .arguments.scheme.isin) {
                                                isExist = true;
                                                // } else {
                                                controller.controllers.text =
                                                    element.units!.toString();
                                                controller.arguments.scheme
                                                    .units = element.units!;
                                                if (element.units! == 0) {
                                                  controller.isAddBtnSelected
                                                      .value = true;
                                                  controller.isAddQtyEnable
                                                      .value = false;
                                                } else {
                                                  controller.isAddBtnSelected
                                                      .value = false;
                                                  controller.isAddQtyEnable
                                                      .value = true;
                                                }
                                              }
                                            });
                                          } else {
                                            controller.controllers.text = "0";
                                            controller.arguments.scheme.units =
                                                0;
                                            controller.isAddBtnSelected.value =
                                                true;
                                            controller.isAddQtyEnable.value =
                                                false;
                                          }
                                          controller
                                              .arguments.selectedSchemeList
                                              .clear();
                                          controller
                                              .arguments.selectedSchemeList
                                              .addAll(securityList);
                                         controller.updateSchemeAndELValue();
                                        }
                                      } else {
                                        List<SchemesListEntity> securityList =
                                            await Get.toNamed(mfViewVaultDetailsScreen);
                                            // Navigator.push(
                                            //     context,
                                            //     MaterialPageRoute(
                                            //         builder: (BuildContext
                                            //                 context) =>
                                            //             MF_ViewVaultDetailsViewScreen(
                                            //                 requestBean,
                                            //                 widget
                                            //                     .selectedSchemeList)));

                                        bool isExist = false;
                                        securityList.forEach((element) {
                                          if (element.isin ==
                                              controller
                                                  .arguments.scheme.isin) {
                                            isExist = true;
                                          }
                                        });
                                        if (isExist) {
                                          securityList.forEach((element) {
                                            if (element.isin ==
                                                controller
                                                    .arguments.scheme.isin) {
                                              isExist = true;
                                              controller.controllers.text =
                                                  element.units!.toString();
                                              controller.arguments.scheme
                                                  .units = element.units!;
                                              if (element.units! == 0) {
                                                controller.isAddBtnSelected
                                                    .value = true;
                                                controller.isAddQtyEnable
                                                    .value = false;
                                              } else {
                                                controller.isAddBtnSelected
                                                    .value = false;
                                                controller.isAddQtyEnable
                                                    .value = true;
                                              }
                                            }
                                          });
                                        } else {
                                          controller.controllers.text = "0";
                                          controller.arguments.scheme.units = 0;
                                          controller.isAddBtnSelected.value =
                                              true;
                                          controller.isAddQtyEnable.value =
                                              false;
                                        }
                                        controller.arguments.selectedSchemeList
                                            .clear();
                                        controller.arguments.selectedSchemeList
                                            .addAll(securityList);
                                      controller.updateSchemeAndELValue();
                                      }
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
                              child: Text(
                                Strings.view_vault,
                                style: buttonTextWhite,
                              ),
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

  Widget increaseDecreaseSecurities() {
    if (controller.arguments.scheme.eligibleLoanAmount != 0.0) {
      controller.isSchemeSelect.value = false;
    } else {
      controller.isSchemeSelect.value = true;
    }
    return Visibility(
        visible: controller.isAddQtyEnable.value,
        child: Column(
          children: [
            Row(
              children: <Widget>[
                Expanded(
                  child: IconButton(
                    iconSize: 20.0,
                    icon: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(width: 1, color: colorBlack)),
                      child: Icon(
                        Icons.remove,
                        color: colorBlack,
                        size: 18,
                      ),
                    ),
                    onPressed: () async {
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          FocusScope.of(Get.context!).unfocus();
                          var txt;
                          if (controller.controllers.text
                                  .toString()
                                  .contains('.') &&
                              controller.controllers.text
                                      .toString()
                                      .split(".")[1]
                                      .length !=
                                  0) {
                            var unitsDecimalCount;
                            String str = controller.controllers.text.toString();
                            var qtyArray = str.split('.');
                            unitsDecimalCount = qtyArray[1];
                            if (int.parse(unitsDecimalCount) == 0) {
                              txt =
                                  double.parse(controller.controllers.text) - 1;
                              controller.controllers.text = txt.toString();
                            } else {
                              if (unitsDecimalCount.toString().length == 1) {
                                txt =
                                    double.parse(controller.controllers.text) -
                                        .1;
                                controller.controllers.text =
                                    txt.toStringAsFixed(1);
                              } else if (unitsDecimalCount.toString().length ==
                                  2) {
                                txt =
                                    double.parse(controller.controllers.text) -
                                        .01;
                                controller.controllers.text =
                                    txt.toStringAsFixed(2);
                              } else {
                                txt =
                                    double.parse(controller.controllers.text) -
                                        .001;
                                controller.controllers.text =
                                    txt.toStringAsFixed(3);
                              }
                            }
                          } else {
                            controller.focusNode.unfocus();
                            txt = controller.controllers.text.isNotEmpty
                                ? int.parse(controller.controllers.text
                                        .toString()
                                        .split(".")[0]) -
                                    1
                                : 0;
                            controller.controllers.text = txt.toString();
                          }
                          // double txt = int.parse(_controllers.text) - 1;

                          controller.arguments.scheme.units =
                              double.parse(controller.controllers.text);

                          if (txt >= 0.001) {
                            controller.isAddBtnSelected.value = false;
                            controller.isAddQtyEnable.value = true;
                          controller.updateSchemeAndELValue();
                          } else {
                            controller.arguments.selectedSchemeList.removeWhere(
                                (element) =>
                                    element.isin ==
                                    controller.arguments.scheme.isin);
                            controller.isAddBtnSelected.value = true;
                            controller.isAddQtyEnable.value = false;
                            controller.controllers.text = "0";
                          controller.updateSchemeAndELValue();
                          }
                        } else {
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 60,
                    height: 48,
                    child: TextField(
                        controller: controller.controllers,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(counterText: ""),
                        // maxLength: 6,
                        focusNode: controller.focusNode,
                        showCursor: true,
                        keyboardType:
                            TextInputType.numberWithOptions(decimal: true),
                        inputFormatters: [
                          DecimalTextInputFormatter(decimalRange: 3),
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^(\d+)?\.?\d{0,3}')),
                        ],
                        style: boldTextStyle_18,
                        onChanged: (value) {
                          if (!controller.controllers.text
                              .toString()
                              .endsWith(".")) {
                            if (value.isNotEmpty &&
                                double.parse(value.toString()) >= 0.001) {
                              if (double.parse(controller.controllers.text) !=
                                  0) {
                                controller.arguments.scheme.units =
                                    double.parse(controller.controllers.text);
                                controller.isAddBtnSelected.value = false;
                                controller.isAddQtyEnable.value = true;
                               controller.updateSchemeAndELValue();
                              } else {
                                controller.arguments.selectedSchemeList
                                    .removeWhere((element) =>
                                        element.isin ==
                                        controller.arguments.scheme.isin);
                                controller.isAddBtnSelected.value = true;
                                controller.isAddQtyEnable.value = false;
                                controller.controllers.text = "0";
                               controller.updateSchemeAndELValue();
                              }
                            } else {
                              if (controller.controllers.text.isEmpty ||
                                  controller.controllers.text == " " ||
                                  controller.controllers.text == ".0" ||
                                  controller.controllers.text == ".00" ||
                                  controller.controllers.text == "0" ||
                                  controller.controllers.text == "0." ||
                                  controller.controllers.text == "0.0" ||
                                  controller.controllers.text == "0.00") {
                                controller.focusNode.addListener(() {
                                  if (controller.controllers.text.isEmpty ||
                                      controller.controllers.text == " " ||
                                      controller.controllers.text == ".0" ||
                                      controller.controllers.text == ".00" ||
                                      controller.controllers.text == "0" ||
                                      controller.controllers.text == "0." ||
                                      controller.controllers.text == "0.0" ||
                                      controller.controllers.text == "0.00") {
                                    if (controller.focusNode.hasFocus) {
                                      controller.focusNode.requestFocus();
                                    } else {
                                      controller.arguments.selectedSchemeList
                                          .removeWhere((element) =>
                                              element.isin ==
                                              controller.arguments.scheme.isin);
                                      controller.isAddBtnSelected.value = true;
                                      controller.isAddQtyEnable.value = false;
                                      controller.controllers.text = "0";
                                     controller.updateSchemeAndELValue();
                                    }
                                  }
                                });
                              } else {
                                FocusScope.of(Get.context!).unfocus();
                                controller.arguments.selectedSchemeList
                                    .removeWhere((element) =>
                                        element.isin ==
                                        controller.arguments.scheme.isin);
                                controller.isAddBtnSelected.value = true;
                                controller.isAddQtyEnable.value = false;
                                controller.controllers.text = "0";
                               controller.updateSchemeAndELValue();
                              }
                            }
                          } else {
                            var value;
                            value = controller.controllers.text;
                            controller.focusNode.addListener(() {
                              if (controller.controllers.text
                                  .toString()
                                  .endsWith('.')) {
                                if (controller.focusNode.hasFocus) {
                                  controller.focusNode.requestFocus();
                                } else {
                                  if (value.toString().split(".")[0].isEmpty) {
                                    controller.isAddBtnSelected.value = true;
                                    controller.isAddQtyEnable.value = false;
                                    controller.controllers.text = "0";
                                  controller.updateSchemeAndELValue();
                                  } else if (controller.controllers.text
                                      .toString()
                                      .endsWith('.')) {
                                    FocusScope.of(Get.context!).unfocus();
                                    value = int.parse(controller
                                        .controllers.text
                                        .toString()
                                        .split(".")[0]);
                                    controller.controllers.text =
                                        value.toString();
                                  }
                                }
                              }
                            });
                          }
                        }),
                  ),
                ),
                Expanded(
                  child: IconButton(
                    iconSize: 20,
                    icon: Container(
                      padding: EdgeInsets.all(1),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(80),
                          border: Border.all(width: 1, color: colorBlack)),
                      child: Icon(
                        Icons.add,
                        color: colorBlack,
                        size: 18,
                      ),
                    ),
                    onPressed: () async {
                      Utility.isNetworkConnection().then((isNetwork) {
                        if (isNetwork) {
                          FocusScope.of(Get.context!).unfocus();
                          controller.focusNode.unfocus();
                          var txt;
                          if (controller.controllers.text
                                  .toString()
                                  .contains('.') &&
                              controller.controllers.text
                                      .toString()
                                      .split(".")[1]
                                      .length !=
                                  0) {
                            var unitsDecimalCount;
                            String str = controller.controllers.text.toString();
                            var qtyArray = str.split('.');
                            unitsDecimalCount = qtyArray[1];
                            if (int.parse(unitsDecimalCount) == 0) {
                              txt =
                                  double.parse(controller.controllers.text) + 1;
                              controller.controllers.text = txt.toString();
                            } else {
                              if (unitsDecimalCount.toString().length == 1) {
                                txt =
                                    double.parse(controller.controllers.text) +
                                        .1;
                                controller.controllers.text =
                                    txt.toStringAsFixed(1);
                              } else if (unitsDecimalCount.toString().length ==
                                  2) {
                                txt =
                                    double.parse(controller.controllers.text) +
                                        .01;
                                controller.controllers.text =
                                    txt.toStringAsFixed(2);
                              } else {
                                txt =
                                    double.parse(controller.controllers.text) +
                                        .001;
                                controller.controllers.text =
                                    txt.toStringAsFixed(3);
                              }
                            }
                          } else {
                            txt = controller.controllers.text.isNotEmpty
                                ? int.parse(controller.controllers.text
                                        .toString()
                                        .split(".")[0]) +
                                    1
                                : 0;
                            controller.controllers.text = txt.toString();
                          }

                          FocusScope.of(Get.context!).unfocus();
                          controller.arguments.scheme.units =
                              double.parse(controller.controllers.text);
                         controller.updateSchemeAndELValue();
                        } else {
                          FocusScope.of(Get.context!).unfocus();
                          Utility.showToastMessage(Strings.no_internet_message);
                        }
                      });
                    },
                  ),
                ),
              ],
            ),
          ],
        ));
  }

  // updateSchemeAndELValue() {
  //   controller.arguments.scheme.units = controller.controllers.text.isEmpty ||
  //           controller.controllers.text == " "
  //       ? 0
  //       : double.parse(controller.controllers.text);
  //   controller.schemeValue.value = 0;
  //   controller.eligibleLoanAmount.value = 0;
  //   for (int i = 0; i < controller.arguments.selectedSchemeList.length; i++) {
  //     controller.schemeValue.value = controller.schemeValue.value! +
  //         (controller.arguments.selectedSchemeList[i].price! *
  //             controller.arguments.selectedSchemeList[i].units!);
  //     controller.eligibleLoanAmount.value =
  //         controller.eligibleLoanAmount.value! +
  //             (controller.arguments.selectedSchemeList[i].price! *
  //                     controller.arguments.selectedSchemeList[i].units! *
  //                     controller.arguments.selectedSchemeList[i].ltv!) /
  //                 100;
  //     if (controller.arguments.selectedSchemeList[i].isin ==
  //         controller.arguments.scheme.isin) {
  //       controller.arguments.selectedSchemeList[i].units =
  //           controller.arguments.scheme.units;
  //     }
  //   }
  // }

  Widget addSecuritiesBtn() {
    return Visibility(
        visible: controller.isAddBtnSelected.value,
        child: Container(
          height: 30,
          width: 70,
          child: Material(
            color: appTheme,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            elevation: 1.0,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              minWidth: Get.mediaQuery.size.width,
              onPressed: () {
               controller.onaddSecuritiesBtnClick();
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Add +",
                    style: TextStyle(
                        color: colorWhite, fontSize: 10, fontWeight: bold),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
