import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/modules/bank/domain/entities/bank_master_response_entity.dart';
import 'package:lms/aa_getx/modules/bank/presentation/controllers/add_bank_controller.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/arguments/dashboard_arguments.dart';

import '../../../../core/assets/assets_image_path.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../core/utils/utility.dart';
import '../../../../core/utils/common_widgets.dart';

class AddBankView extends GetView<AddBankController>{
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: colorBg,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: colorBg,
          leading: IconButton(
            icon: NavigationBackImage(),
            onPressed: () => Get.back(),
          ),
        ),
        body: Theme(
          data: theme.copyWith(primaryColor: appTheme),
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: headingText(Strings.bank_detail),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  iFSCField(),
                  SizedBox(
                    height: 20,
                  ),
                  bankNameFiled(),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      branchNameFiled(),
                      SizedBox(
                        width: 20,
                      ),
                      cityNameFiled(),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  accountHolderFiled(),
                  SizedBox(
                    height: 30,
                  ),
                  accountNumberFiled(),
                  SizedBox(
                    height: 30,
                  ),
                  accountReNumberFiled(),
                  SizedBox(
                    height: 30,
                  ),
                  accountTypeFiled(),
                  SizedBox(
                    height: 30,
                  ),
                  chequeBrowse(),
                  SizedBox(
                    height: 30,
                  ),
                  submitButton(),
                  SizedBox(
                    height: 15,
                  ),
                  //_buildLoadingWidget(),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget iFSCField() {
    return Row(
      children: [
        Expanded(
          child: Autocomplete<BankDataEntity>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.toString().trim().length >=  9) {
                controller.isAPICalled.value = true;
                controller.bankDetailAPI(textEditingValue.text.toString().trim());
              }
              if (textEditingValue.text.toString().trim().length > 9) {
                List<String> iFSCList;
                iFSCList = List.generate(
                    controller.bankData.length, (index) => controller.bankData[index].ifsc!)
                    .toSet()
                    .toList();
                debugPrint("IFSC CODES ===> ${iFSCList.toSet().toList()}");
                if (textEditingValue.text.length == 10 || textEditingValue.text.length == 11) {
                  if(textEditingValue.text.length == 11){
                    if(textEditingValue.text.toString().toUpperCase() == iFSCList[0].toString().toUpperCase()){
                      controller.bankController.text = controller.bankData[0].bank.toString();
                      controller.branchController.text = controller.bankData[0].branch.toString();
                      controller.cityController.text = controller.bankData[0].city.toString();
                    }
                  }
                  if (!iFSCList
                      .toString()
                      .trim()
                      .contains(textEditingValue.text.toString().trim())) {
                    controller.validatorIFSC.value = false;
                  } else if (iFSCList.length == 0) {
                    controller.validatorIFSC.value = false;
                  } else {
                    controller.validatorIFSC.value = true;
                  }
                }
              }
              if (textEditingValue.text.toString().trim() == '') {
                return const Iterable<BankDataEntity>.empty();
              } else if (textEditingValue.text.toString().trim().length < 10) {
                return const Iterable<BankDataEntity>.empty();
              } else if (controller.bankData.length != 0 &&
                  textEditingValue.text.length == 10 || textEditingValue.text.length == 11) {
                return controller.bankData.where((BankDataEntity option) {
                  return option.ifsc.toString()
                      .contains(textEditingValue.text.toString().trim());
                });
              } else {
                return const Iterable<BankDataEntity>.empty();
              }
            },
            displayStringForOption: (BankDataEntity option) {
              return option.ifsc.toString();
            },
            fieldViewBuilder: (BuildContext context,
                TextEditingController iFSCControllerr,
                fieldFocusNode,
                onFieldSubmitted) {
              controller.iFSCController = iFSCControllerr;
              return TextField(
                maxLength: 11,
                controller: iFSCControllerr,
                autofocus: false,
                focusNode: fieldFocusNode,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z0-9]')),
                ],
                textCapitalization: TextCapitalization.characters,
                decoration: new InputDecoration(
                  counterText: '',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: new OutlineInputBorder(
                      borderSide: new BorderSide(color: appTheme)),
                  errorBorder: new OutlineInputBorder(
                    borderSide: new BorderSide(color: Colors.red, width: 0.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(4)),
                    borderSide: BorderSide(
                      width: 1,
                      color: Colors.red,
                    ),
                  ),
                  errorMaxLines: 2,
                  hintStyle: TextStyle(color: colorGrey),
                  labelStyle: TextStyle(color: appTheme),
                  hintText: Strings.ifsc_code,
                  labelText: Strings.ifsc_code + "*",
                  errorText: controller.iFSCValidator.value ? controller.iFSCTextLen.value ? !controller.isAPICalled.value
                      ? !controller.validatorIFSC.value
                      ? !controller.isAvailable.value ? "*" + Strings.invalid_ifsc_msg : null
                      : null : null : "*" + Strings.invalid_ifsc_msg
                      : "*" + Strings.ifsc_code + Strings.is_mandatory,
                ),
                onChanged: (value)=> controller.ifscOnChanged(value, fieldFocusNode),
              );
            },
            onSelected: (BankDataEntity selection) {
              //setState(() {
                Get.focusScope?.unfocus();
                controller.bankController.text = selection.bank.toString();
                controller.branchController.text = selection.branch.toString();
                controller.cityController.text = selection.city.toString();
              //});
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<BankDataEntity> onSelected,
                Iterable<BankDataEntity> options) {
              controller.isAvailable.value = true;
              return Align(
                  alignment: Alignment.topLeft,
                  child: Material(
                    elevation: 2,
                    child: SingleChildScrollView(
                      child: Container(
                        height: options.length >= 5
                            ? MediaQuery.of(context).size.height * 0.25
                            : options.length == 4
                            ? 170
                            : options.length == 3
                            ? 120
                            : options.length == 2
                            ? 100
                            : options.length == 1
                            ? 60
                            : MediaQuery.of(context).size.height * 0.25,
                        width: 150,
                        //height: 250,
                        decoration: BoxDecoration(
                          color: colorBg,
                          border: Border.all(
                            color: Colors.black12,
                          ),
                        ),
                        child: SingleChildScrollView(
                          child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemExtent: 40,
                              padding: EdgeInsets.all(2.0),
                              itemCount: options.length,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, int index) {
                                final BankDataEntity option =
                                options.elementAt(index);
                                return Container(
                                  child: ListTile(
                                    onTap: () {
                                      onSelected(option);
                                    },
                                    title: Text(option.ifsc.toString(),
                                        style: const TextStyle(
                                            color: Colors.black)),
                                  ),
                                );
                              }),
                        ),
                      ),
                    ),
                  ));
            },
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(
          child: Align(
            alignment: Alignment.topLeft,
            child: GestureDetector(
              onTap: () => commonDialog(Strings.ifsc_info, 0),
              child: Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Image.asset(
                  AssetsImagePath.info,
                  height: 18.0,
                  width: 18.0,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget bankNameFiled() {
    return Row(
      children: [
        Expanded(
          child: TextField(
            enabled: true,
            readOnly: true,
            controller: controller.bankController,
            decoration: new InputDecoration(
              disabledBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              focusedBorder: new OutlineInputBorder(
                  borderSide: new BorderSide(color: appTheme)),
              hintStyle: TextStyle(color: colorGrey),
              labelStyle: TextStyle(color: appTheme),
              hintText: Strings.bank_name,
              labelText: Strings.bank_name+"*",
            ),
          ),
        ),
        SizedBox(
          width: 20,
        ),
        Expanded(child: SizedBox())
      ],
    );
  }

  Widget branchNameFiled() {
    return Expanded(
      child: TextField(
        enabled: true,
        readOnly: true,
        controller: controller.branchController,
        decoration: new InputDecoration(
          disabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: new OutlineInputBorder(
              borderSide: new BorderSide(color: appTheme)),
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
          hintText: Strings.branch_name,
          labelText: Strings.branch_name+"*",
        ),
      ),
    );
  }

  Widget cityNameFiled() {
    return Expanded(
      child: TextField(
        controller: controller.cityController,
        enabled: true,
        readOnly: true,
        decoration: new InputDecoration(
          disabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: new OutlineInputBorder(
              borderSide: new BorderSide(color: appTheme)),
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
          hintText: Strings.city_name,
          labelText: Strings.city_name+"*",
        ),
      ),
    );
  }

  Widget accountHolderFiled() {
    return TextField(
      controller: controller.accHolderNameController,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
      maxLength: 50,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[a-zA-Z- ]')),
      ],
      decoration: new InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder:
        new OutlineInputBorder(borderSide: new BorderSide(color: appTheme)),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
        hintStyle: TextStyle(color: colorGrey),
        labelStyle: TextStyle(color: appTheme),
        hintText: Strings.account_holder_name,
        labelText: Strings.account_holder_name+"*",
        errorText: controller.accHolderNameValidator.value
            ? null
            : "*" + Strings.account_holder_name + Strings.is_mandatory,
      ),
      onChanged: (value)=> controller.accHolderNameOnChanged(),
    );
  }

  Widget accountNumberFiled() {
    return TextFormField(
      obscureText: true,
      controller: controller.accNumberController,
      keyboardType: TextInputType.number,
      obscuringCharacter: '*',
      maxLength: 16,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9]')),
      ],
      decoration: new InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder:
        new OutlineInputBorder(borderSide: new BorderSide(color: appTheme)),
        hintStyle: TextStyle(color: colorGrey),
        labelStyle: TextStyle(color: appTheme),
        hintText: Strings.account_number,
        labelText: Strings.account_number+"*",
        errorText: controller.accNumberValidator.value
            ? null
            : "*" + Strings.account_number + Strings.is_mandatory,
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
      ),
      onChanged: (value)=> controller.accNumberOnChanged(),
    );
  }

  Widget accountReNumberFiled() {
    return TextFormField(
      controller: controller.reEnterAccNumberController,
      keyboardType: TextInputType.number,
      maxLength: 16,
      decoration: new InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder:
        new OutlineInputBorder(borderSide: new BorderSide(color: appTheme)),
        hintStyle: TextStyle(color: colorGrey),
        labelStyle: TextStyle(color: appTheme),
        hintText: Strings.re_enter_account_number,
        labelText: Strings.re_enter_account_number+"*",
        errorText: controller.reEnterAccNumberValidator.value
            ? !controller.reEnterAccNumberIsCorrect.value
            ? null
            : "*" + Strings.account_number_does_not_match_as_above
            : "*" + Strings.re_enter_account_number,
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(
            width: 1,
            color: Colors.red,
          ),
        ),
      ),
      onChanged: (value)=> controller.reEnterAccNumberOnChanged(),
    );
  }

  Widget accountTypeFiled() {
    return TextField(
      controller: controller.accTypeController,
      textCapitalization: TextCapitalization.words,
      keyboardType: TextInputType.name,
      decoration: new InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder:
        new OutlineInputBorder(borderSide: new BorderSide(color: appTheme)),
        hintStyle: TextStyle(color: colorGrey),
        labelStyle: TextStyle(color: appTheme),
        hintText: Strings.account_type,
        labelText: Strings.account_type,
      ),
    );
  }

  Widget chequeBrowse() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Personalized Cheque*", style: TextStyle(
            color: appTheme,
            fontSize: 15,
            fontWeight: FontWeight.normal)),
        SizedBox(height: 2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: (){
                Utility.isNetworkConnection().then((isNetwork) async {
                  if (isNetwork) {
                    bool photoConsent = await controller.preferences.getPhotoConsent();
                    if(!photoConsent) {
                      permissionYesNoDialog();
                    }else{
                      controller.uploadPhoto();
                    }
                  } else {
                    Utility.showToastMessage(Strings.no_internet_message);
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colorBlack),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.all(4),
                child: Text("Browse", style: TextStyle(color: appTheme)),
              ),
            ),
            SizedBox(width: 6),
            Obx(
              () => controller.chequeByteImageString.isNotEmpty
                  ? SizedBox(width: 60, height: 25, child: Image.file(controller.chequeImage!, fit: BoxFit.fill))
                  : SizedBox(),
            ),
          ],
        ),
        SizedBox(height: 5),
        controller.cropMb != null
            ? controller.cropMb! > 10
            ? Text("*Image should be less than 10MB", style: TextStyle(color: red))
            : Text("")
            : Text(""),
      ],
    );
  }

  Widget submitButton() {
    return Center(
      child: AbsorbPointer(
        absorbing: controller.getSubmitValidation()
            ? false
            : true,
        child: Container(
          height: 45,
          width: 120,
          child: Material(
            color: controller.getSubmitValidation()
                ? appTheme
                : colorLightGray,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
            elevation: 1.0,
            child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
              minWidth: Get.mediaQuery.size.width,
              onPressed: () {
                Utility.isNetworkConnection().then((isNetwork) async {
                  if (isNetwork) {
                    Get.focusScope?.unfocus();
                    if (controller.bankController.text.toString().trim().isNotEmpty) {
                      if (controller.accHolderNameValidator == true &&
                          controller.accNumberValidator == true &&
                          controller.reEnterAccNumberValidator == true &&
                          controller.iFSCValidator == true && controller.imageInMb.isTrue) {
                        controller.validateBank();
                      }
                    }
                  } else {
                    Utility.showToastMessage(Strings.no_internet_message);
                  }
                });
              },
              child: Text(
                Strings.submit,
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> permissionYesNoDialog() async {
    return await Get.dialog(
      barrierDismissible: false,
      AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15.0))),
          title: Text("Storage Access", style: boldTextStyle_16),
          content: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                RichText(
                  text: TextSpan(
                    children: <TextSpan>[
                      TextSpan(text: 'Why is LMS asking for my Storage access?\n\n',style: regularTextStyle_12_gray_dark),
                      TextSpan(text: 'LMS asked for ',style: regularTextStyle_12_gray_dark),
                      TextSpan(text: 'Storage Access', style: boldTextStyle_12_gray_dark),
                      TextSpan(text: ' to let you upload the required ',style: regularTextStyle_12_gray_dark),
                      TextSpan(text: 'Documents & Image', style: boldTextStyle_12_gray_dark),
                      TextSpan(text: ' to avail the services.\nWe do ',style: regularTextStyle_12_gray_dark),
                      TextSpan(text: 'collect /share', style: boldTextStyle_12_gray_dark),
                      TextSpan(text: ' the Uploaded Document/Images with us and any other third party based on the services availed.\n\nPermission can be changed at anytime from the device settings.\n\nIn case of any doubts, please visit our ',style: regularTextStyle_12_gray_dark),
                      TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = ()=> controller.privacyPolicyClicked(),
                          text: "Privacy Policy.",
                          style: boldTextStyle_12_gray_dark.copyWith(color: Colors.lightBlue)
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        height: 40,
                        // width: 100,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                              side: BorderSide(color: red)),
                          elevation: 1.0,
                          color: colorWhite,
                          child: MaterialButton(
                            minWidth: Get.mediaQuery.size.width,
                            onPressed: () async {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  Get.back();
                                } else{
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
                            child: Text(
                              "Deny",
                              style: buttonTextRed,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Container(
                        height: 40,
                        // width: 100,
                        child: Material(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(35)),
                          elevation: 1.0,
                          color: appTheme,
                          child: MaterialButton(
                            minWidth: Get.mediaQuery.size.width,
                            onPressed: () async {
                              Utility.isNetworkConnection().then((isNetwork) async {
                                if (isNetwork) {
                                  Get.back();
                                  controller.preferences.setPhotoConsent(true);
                                  controller.uploadPhoto();
                                }else{
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
                            child: Text(
                              "Allow",
                              style: buttonTextWhite,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )
    ) ?? false;
  }

}

showSuccessDialog(String msg, bool isSuccess) {
  return showDialog<void>(
    barrierDismissible: false,
    context: Get.context!,
    builder: (BuildContext context) {
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          contentPadding: EdgeInsets.only(left: 8, right: 8, top: 8),
          titlePadding: EdgeInsets.only(left: 0, right: 0, top: 12),
          backgroundColor: Colors.white,
          title: isSuccess ? Column(
            children: [
              Center(
                child: Text(
                  Strings.success_caps,
                  style: TextStyle(color: Colors.green, fontSize: 28),
                ),
              ),
              Divider(
                color: Colors.grey, thickness: 1,
              )
            ],
          ) : SizedBox(),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(3.0))),
          content: Padding(
            padding: const EdgeInsets.only(left: 18.0, right: 8),
            child: Text(msg),
          ),
          actions: <Widget>[
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 10,bottom: 10),
                child: Container(
                  height: 45,
                  width: 100,
                  child: Material(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    elevation: 1.0,
                    color: appTheme,
                    child: MaterialButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                      minWidth: MediaQuery.of(context).size.width,
                      onPressed: () {
                        Get.back();
                        Get.offAllNamed(dashboardView, arguments: DashboardArguments(
                          isFromPinScreen: false,
                          selectedIndex: 0,
                        ));
                      },
                      child: Text(Strings.ok, style: buttonTextWhite),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}

showFailedDialog(String msg) {
  return showDialog<void>(
    barrierDismissible: false,
    context: Get.context!,
    builder: (BuildContext context) {
      return AlertDialog(
        contentPadding: EdgeInsets.only(left: 8, right: 8, top: 8),
        titlePadding: EdgeInsets.only(left: 0, right: 0, top: 12),
        backgroundColor: Colors.white,
        title: Column(
          children: [
            Center(
              child: Text(
                Strings.failed,
                style: TextStyle(color: Colors.red, fontSize: 28),
              ),
            ),
            Divider(
              color: Colors.grey, thickness: 1,
            ),
          ],
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(3))),
        content: Padding(
          padding: const EdgeInsets.only(left: 18.0, right: 8),
          child: Text(msg),
        ),
        actions: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.only(top: 10,bottom: 10),
              child: Container(
                height: 45,
                width: 100,
                child: Material(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                  elevation: 1.0,
                  color: appTheme,
                  child: MaterialButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                    minWidth: MediaQuery.of(context).size.width,
                    onPressed: () {
                      Navigator.pop(context, Strings.ok);
                    },
                    child: Text(Strings.ok, style: buttonTextWhite),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}

Future<bool> choiceUserConfirmationDialog(AddBankController controller) async {
  return await Get.dialog(
    barrierDismissible: false,
    AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0))),
      content: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Center(
              child: new Text(Strings.choice_user_yes_no,
                  style: regularTextStyle_16_dark), //
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        minWidth: Get.mediaQuery.size.width,
                        onPressed: () async {
                          Utility.isNetworkConnection().then((isNetwork) {
                            if (isNetwork) {
                              Get.back();
                            } else {
                              Utility.showToastMessage(Strings.no_internet_message);
                            }
                          });
                        },
                        child: Text(Strings.no, style: buttonTextRed),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        minWidth: Get.mediaQuery.size.width,
                        onPressed: ()=> controller.yesClicked(),
                        child: Text(Strings.yes, style: buttonTextWhite),
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
  ) ?? false;
}