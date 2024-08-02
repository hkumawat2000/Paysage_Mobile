import 'dart:convert';
import 'dart:io';
import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lms/aa_getx/core/assets/assets_image_path.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/style.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/core/widgets/common_widgets.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/arguments/kyc_address_arguments.dart';
import 'package:lms/aa_getx/modules/kyc/presentation/controllers/kyc_address_controller.dart';

class KycAddressScreen extends GetView<KycAddressController> {
  KycAddressScreen();

  final KycAddressArguments kycAddressArguments = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        onTap: () {
          controller.toChangeBoolValuesForDropdown();
          FocusScope.of(context).unfocus();
        },
        child: WillPopScope(
          onWillPop: () async {
            controller.toChangeBoolValuesForDropdown();
            Navigator.pop(context);
            return true;
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: colorBg,
              leading: IconButton(
                  icon: NavigationBackImage(),
                  onPressed: () {
                    controller.toChangeBoolValuesForDropdown();
                    Get.back();
                    //Navigator.pop(context);
                  }),
            ),
            body: controller.isAPICalling.isTrue
                ? Center(
                    child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(controller.isAPICallingText),
                    ],
                  ))
                : SingleChildScrollView(
                    controller: controller.scrollController,
                    child: Column(
                      children: [
                        Center(
                          child: Padding(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: headingText("Confirm Your Details (2/2)"),
                          ),
                        ),
                        SizedBox(height: 30),
                        permanentAddressFields(),
                        SizedBox(height: 20),
                        correspondingAddressFields(),
                        SizedBox(height: 20),
                        consentOkButton(),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  //Permanent address field
  Widget permanentAddressFields() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration:
          BoxDecoration(color: colorBg, border: Border.all(color: colorBlack)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: subHeadingText("PERMANENT ADDRESS"),
          ),
          Divider(color: colorBlack, thickness: 1),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(height: 10),
                permAddressLineNumber1(),
                SizedBox(height: 20),
                permAddressLineNumber2(),
                SizedBox(height: 20),
                permAddressLineNumber3(),
                SizedBox(height: 20),
                Row(
                  children: [permCity(), SizedBox(width: 10), permPinCode()],
                ),
                SizedBox(height: 20),
                Row(
                  children: [permDistrict(), SizedBox(width: 10), permState()],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    permCountry(),
                    SizedBox(width: 10),
                    Expanded(child: SizedBox(height: 20)),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    permPOAType(),
                    SizedBox(width: 10),
                    permPOABrowse(),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    kycAddressArguments.isShowEdit!
                        ? permEditButton()
                        : Container(),
                    SizedBox(width: 10),
                    kycAddressArguments.isShowEdit!
                        ? permSubmitButton()
                        : Container()
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //Corresponding address field
  Widget correspondingAddressFields() {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration:
          BoxDecoration(color: colorBg, border: Border.all(color: colorBlack)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, top: 10, bottom: 10),
            child: subHeadingText("CORRESPONDING ADDRESS"),
          ),
          Divider(color: colorBlack, thickness: 1),
          corrCheckBox(),
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                SizedBox(height: 6),
                corrAddressLineNumber1(),
                SizedBox(height: 20),
                corrAddressLineNumber2(),
                SizedBox(height: 20),
                corrAddressLineNumber3(),
                SizedBox(height: 20),
                Row(
                  children: [corrCity(), SizedBox(width: 10), corrPinCode()],
                ),
                SizedBox(height: 20),
                Row(
                  children: [corrDistrict(), SizedBox(width: 10), corrState()],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    corrCountry(),
                    SizedBox(width: 10),
                    Expanded(child: SizedBox(height: 20)),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    corrPOAType(),
                    SizedBox(width: 10),
                    corrPOABrowse(),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    kycAddressArguments.isShowEdit!
                        ? corrEditButton()
                        : Container(),
                    SizedBox(width: 10),
                    kycAddressArguments.isShowEdit!
                        ? corrSubmitButton()
                        : Container()
                  ],
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //OK button
  Widget consentOkButton() {
    return Padding(
      padding: EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Checkbox(
                value: controller.consentCheckbox.value,
                onChanged: (value) {
                  controller.onCheckBoxValueChanged();
                  controller.toChangeBoolValuesForDropdown();
                },
              ),
              Expanded(
                  child: Text(controller.consentText!,
                      style: regularTextStyle_14_gray_dark)),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 45,
            width: 100,
            child: Material(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              elevation: 1.0,
              color: kycAddressArguments.isShowEdit!
                  ? !controller.permFieldsEnable.value &&
                         controller.permPOATypeSelected != "POA TYPE" &&
                         controller.permValidatorPOAImageSize.isTrue &&
                          !controller.corrCheckboxEnable.value &&
                          controller.permPOAImage != null &&
                          !controller.corrFieldsEnable.value &&
                         controller.corrPOATypeSelected != "POA TYPE" &&
                         controller.corrValidatorPOAImageSize.isTrue &&
                        controller.consentCheckbox.isTrue &&
                         controller.corrPOAImage != null
                      ? appTheme
                      : colorLightGray
                  : controller.consentCheckbox.isTrue
                      ? appTheme
                      : colorLightGray,
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(35)),
                minWidth: MediaQuery.of(Get.context!).size.width,
                onPressed: () async {
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      controller.toChangeBoolValuesForDropdown();
                      if (kycAddressArguments.isShowEdit!) {
                        if (!controller.permFieldsEnable.value &&
                           controller.permPOATypeSelected != "POA TYPE" &&
                          controller.permValidatorPOAImageSize.isTrue &&
                            !controller.corrCheckboxEnable.value &&
                          controller.permPOAImage != null &&
                            !controller.corrFieldsEnable.value &&
                          controller.corrPOATypeSelected != "POA TYPE" &&
                           controller.corrValidatorPOAImageSize.isTrue &&
                           controller.consentCheckbox.isTrue &&
                           controller.corrPOAImage != null) {
                            //TODO TO call api
                         // saveConsentAPICall();
                        } else {
                          Utility.showToastMessage(
                              "Please submit the data or rectify error(s), if any.");
                        }
                      } else {
                        if (controller.consentCheckbox.isTrue) {
                          //TODO To navigate to Loan Summary screen
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => LoanSummaryScreen(
                          //             false,
                          //             widget.loanRenewalName,
                          //             widget.loanName!)));
                        } else {
                          Utility.showToastMessage(
                              "Please submit the data or rectify error(s), if any.");
                        }
                      }
                    } else {
                      Utility.showToastMessage(Strings.no_internet_message);
                    }
                  });
                },
                child: Text(
                  Strings.ok,
                  style: TextStyle(
                      color: colorWhite,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Widgets for Permanent Address
  Widget permAddressLineNumber1() {
    return TextField(
      controller: controller.permAddressLine1Controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      enabled: true,
      readOnly: !controller.permFieldsEnable.value,
      decoration: new InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: appTheme),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        errorStyle: TextStyle(color: red),
        hintStyle: TextStyle(color: colorGrey),
        labelStyle: TextStyle(color: appTheme),
        hintText: "ADDRESS LINE 1",
        labelText: "ADDRESS LINE 1*",
        errorText:
            controller.permValidatorAddress1.isTrue ? null : '*Mandatory',
      ),
      onChanged: (value) {
        controller.permValidatorAddress1.value = true;
      },
      onTap: () {
        controller.toChangeBoolValuesForDropdown();
      },
    );
  }

  Widget permAddressLineNumber2() {
    return TextField(
      controller: controller.permAddressLine2Controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      enabled: true,
      readOnly: !controller.permFieldsEnable.value,
      decoration: new InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: appTheme),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        hintStyle: TextStyle(color: colorGrey),
        labelStyle: TextStyle(color: appTheme),
        hintText: "ADDRESS LINE 2",
        labelText: "ADDRESS LINE 2",
      ),
      onTap: () {
        controller.toChangeBoolValuesForDropdown();
      },
    );
  }

  Widget permAddressLineNumber3() {
    return TextField(
      controller: controller.permAddressLine3Controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      enabled: true,
      readOnly: !controller.permFieldsEnable.value,
      decoration: new InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: new BorderSide(color: appTheme),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        hintStyle: TextStyle(color: colorGrey),
        labelStyle: TextStyle(color: appTheme),
        hintText: "ADDRESS LINE 3",
        labelText: "ADDRESS LINE 3",
      ),
      onTap: () {
        controller.toChangeBoolValuesForDropdown();
      },
    );
  }

  Widget permCity() {
    return Expanded(
      child: TextField(
        controller: controller.permCityController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.name,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')),
        ],
        enabled: true,
        readOnly: !controller.permFieldsEnable.value,
        decoration: new InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          disabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: new BorderSide(color: appTheme),
          ),
          errorBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.red, width: 0.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          errorStyle: TextStyle(color: red),
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
          hintText: "CITY",
          labelText: "CITY*",
          errorText: controller.permValidatorCity.isTrue ? null : '*Mandatory',
        ),
        onChanged: (value) {
          controller.permValidatorCity.value = true;
        },
        onTap: () {
          controller.toChangeBoolValuesForDropdown();
        },
      ),
    );
  }

  Widget permPinCode() {
    return Expanded(
      child: TextField(
        controller: controller.permPinCodeController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.number,
        enabled: true,
        readOnly: !controller.permFieldsEnable.value,
        maxLength: 6,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
        decoration: new InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          disabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: new BorderSide(color: appTheme),
          ),
          errorBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.red, width: 0.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          errorStyle: TextStyle(color: red),
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
          hintText: "PIN CODE",
          labelText: "PIN CODE*",
          errorText: controller.permValidatorPinCode.isTrue
              ? controller.permValidPinCode.isTrue
                  ? null
                  : "*Invalid Pin Code"
              : '*Mandatory',
        ),
        onChanged: (value) {
          controller.permValidPinCode.value = true;
          controller.permValidatorPinCode.value = true;
          if (value.toString().trim().length == 6) {
            FocusScope.of(Get.context!).unfocus();
            //TODO To cll API
            // callAPIToGetPinCode(Strings.permanent_address,
            //     controller.permPinCodeController.text.toString().trim());
          } else {
            controller.permDistrictController.text = "";
            controller.permStateController.text = "";
          }
        },
        onTap: () {
          controller.toChangeBoolValuesForDropdown();
        },
      ),
    );
  }

  Widget permDistrict() {
    return Expanded(
      child: TextField(
        controller: controller.permDistrictController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.name,
        enabled: true,
        readOnly: true,
        decoration: new InputDecoration(
          counterText: "",
          disabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: new BorderSide(color: appTheme),
          ),
          errorBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.red, width: 0.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          errorStyle: TextStyle(color: red),
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
          hintText: "DISTRICT",
          labelText: "DISTRICT*",
          errorText:
              controller.permValidatorDistrict.isTrue ? null : '*Mandatory',
        ),
        onChanged: (value) {
          controller.permValidatorDistrict.value = true;
        },
        onTap: () {
          controller.toChangeBoolValuesForDropdown();
        },
      ),
    );
  }

  Widget permState() {
    return Expanded(
      child: TextField(
        controller: controller.permStateController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.name,
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
          focusedBorder: OutlineInputBorder(
            borderSide: new BorderSide(color: appTheme),
          ),
          errorBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.red, width: 0.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          errorStyle: TextStyle(color: red),
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
          hintText: "STATE",
          labelText: "STATE*",
          errorText: controller.permValidatorState.isTrue ? null : '*Mandatory',
        ),
        onChanged: (value) {
          controller.permValidatorState.value = true;
        },
        onTap: () {
          controller.toChangeBoolValuesForDropdown();
        },
      ),
    );
  }

  String capitalize(String s) {
    //kajal tiwari ==> Kajal Tiwari
    List<String> splitList = s.split(" ");
    String capString = "";
    for (int i = 0; i < splitList.length; i++) {
      capString = capString +
          splitList[i][0].toUpperCase() +
          splitList[i].substring(1).toLowerCase() +
          " ";
    }
    return capString.trim();
  }

  Widget permCountry() {
    return Expanded(
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return controller.countryList.where((String option) {
            return controller.permFieldsEnable.isTrue
                ? option.toString().toLowerCase().trim().contains(
                    textEditingValue.text.toString().toLowerCase().trim())
                : false;
          });
        },
        displayStringForOption: (String option) {
          return controller.permFieldsEnable.isTrue ? option.toString() : "";
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController countryController,
            fieldFocusNode,
            onFieldSubmitted) {
          controller.permCountryController = countryController;
          if (controller.permOnce == 1) {
            controller.permCountryController.text =
                controller.permCountryValue!;
            controller.permOnce++;
          }
          return TextField(
            controller: countryController,
            focusNode: fieldFocusNode,
            enabled: true,
            readOnly: !controller.permFieldsEnable.value,
            textCapitalization: TextCapitalization.words,
            decoration: new InputDecoration(
              counterText: '',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              disabledBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(4)),
              ),
              focusedBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: appTheme),
              ),
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
              errorStyle: TextStyle(color: red),
              hintStyle: TextStyle(color: colorGrey),
              labelStyle: TextStyle(color: appTheme),
              hintText: "Country",
              labelText: "Country*",
              errorText: controller.permValidatorCountry.isTrue
                  ? controller.permValidatorValidCountry.isTrue
                      ? null
                      : "*Invalid Country"
                  : '*Mandatory',
            ),
            onChanged: (value) {
              controller.permValidatorCountry.value = true;
              for (int i = 0; i < controller.countryList.length; i++) {
                if (controller.permCountryController.text
                            .toString()
                            .trim()
                            .isNotEmpty &&
                        controller.countryList[i].contains(capitalize(controller
                            .permCountryController.text
                            .toString()
                            .trim())) ||
                    controller.permCountryController.text
                        .toString()
                        .trim()
                        .isEmpty) {
                  controller.permValidatorValidCountry.value = true;
                  return;
                } else {
                  controller.permValidatorValidCountry.value = false;
                }
              }
            },
            onTap: () {
              controller.toChangeBoolValuesForDropdown();
            },
          );
        },
        onSelected: (String selection) {
          FocusScope.of(Get.context!).unfocus();
          controller.permValidatorCountry.value = true;
          controller.permValidatorValidCountry.value = true;
          if (controller.countryList.contains(
              controller.permCountryController.text.toString().trim())) {
            controller.permValidatorValidCountry.value = true;
          } else {
            controller.permValidatorValidCountry.value = false;
          }
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 2,
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
                width: (MediaQuery.of(context).size.width / 2) - 30,
                decoration: BoxDecoration(
                  color: colorBg,
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Scrollbar(
                  controller: controller.permScrollController,
                  //isAlwaysShown: true,
                  child: ListView.builder(
                    controller: controller.permScrollController,
                    scrollDirection: Axis.vertical,
                    itemExtent: 40,
                    padding: EdgeInsets.all(2.0),
                    itemCount: options.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return Container(
                        child: ListTile(
                          onTap: () {
                            onSelected(option);
                          },
                          title: Text(option.toString(),
                              style: const TextStyle(color: Colors.black)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget permPOAType() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Proof of Address Type*"),
          SizedBox(height: 2),
          kycAddressArguments.isShowEdit!
              ? Container(
                  height: 32,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AwesomeDropDown(
                      isBackPressedOrTouchedOutSide:
                          controller.permIsBackPressedOrTouchedOutSide.value,
                      dropDownList: controller.poaTypeList,
                      dropDownIcon: Image.asset(AssetsImagePath.down_arrow,
                          height: 20, width: 20),
                      selectedItem: controller.permPOATypeSelected,
                      dropDownListTextStyle:
                          TextStyle(color: colorLightGray, fontSize: 18),
                      onDropDownItemClick: (selectedItem) {
                        controller.permValidatorPOAType.value = true;
                        controller.permPOATypeSelected = selectedItem;
                      },
                      dropDownBottomBorderRadius: 2,
                      dropDownTopBorderRadius: 2,
                      dropDownBGColor: colorBg,
                      elevation: 0,
                      padding: 1,
                      dropDownOverlayBGColor: colorBg,
                      dropStateChanged: (isOpened) {
                        FocusScope.of(Get.context!).unfocus();
                        controller.permIsDropDownOpened = isOpened;
                        if (!isOpened) {
                          controller.permIsBackPressedOrTouchedOutSide.value =
                              false;
                        }
                      },
                    ),
                  ),
                )
              : SizedBox(),
          //  Row(
          //   children: [
          //     Column(
          //       children: [
          //         Container(
          //             height: 32,
          //             width : 90,
          //             child: SingleChildScrollView(child: Text(permPOATypeSelected, style: TextStyle(color: colorBlack, fontSize: 16)))),
          //       ],
          //     ),
          //     SizedBox(width : 20),
          //     Image.asset(AssetsImagePath.down_arrow, height: 20, width: 20)
          //   ],
          // ),
          SizedBox(height: 5),
          Visibility(
            visible: !controller.permValidatorPOAType.value,
            child: Text("*Please select type", style: TextStyle(color: red)),
          ),
        ],
      ),
    );
  }

  Widget permPOABrowse() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Proof of Address*"),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              kycAddressArguments.isShowEdit!
                  ? GestureDetector(
                      onTap: () {
                        Utility.isNetworkConnection().then((isNetwork) async {
                          if (isNetwork) {
                            bool photoConsent =
                                await controller.preferences.getPhotoConsent();
                            if (!photoConsent) {
                              permPermissionYesNoDialog(Get.context!);
                            } else {
                              permUploadPhoto();
                            }
                          } else {
                            Utility.showToastMessage(
                                Strings.no_internet_message);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: colorBlack),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.all(4),
                        child: Text("Browse"),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: colorBlack),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Text("Browse"),
                    ),
              SizedBox(width: 6),
              kycAddressArguments.isShowEdit!
                  ? controller.permByteImageString != null &&
                          controller.permByteImageString!.isNotEmpty
                      ? SizedBox(
                          width: 60,
                          height: 25,
                          child: Image.file(controller.permPOAImage!,
                              fit: BoxFit.fill))
                      : SizedBox()
                  : SizedBox(
                      width: 60,
                      height: 25,
                      child: Image.network(controller.permPOAImageNew!,
                          fit: BoxFit.fill)),
            ],
          ),
          SizedBox(height: 5),
          Visibility(
            visible: !controller.permValidatorPOAImage.value,
            child: Text("*Please upload proof", style: TextStyle(color: red)),
          ),
          Visibility(
            visible: !controller.permValidatorPOAImageSize.value,
            child: Text("*Image should be less than 10MB",
                style: TextStyle(color: red)),
          ),
        ],
      ),
    );
  }

  Future<bool> permPermissionYesNoDialog(BuildContext context) async {
    return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
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
                          TextSpan(
                              text:
                                  'Why is LMS asking for my Storage access?\n\n',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              text: 'LMS asked for ',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              text: 'Storage Access',
                              style: boldTextStyle_12_gray_dark),
                          TextSpan(
                              text: ' to let you upload the required ',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              text: 'Documents & Image',
                              style: boldTextStyle_12_gray_dark),
                          TextSpan(
                              text: ' to avail the services.\nWe do ',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              text: 'collect /share',
                              style: boldTextStyle_12_gray_dark),
                          TextSpan(
                              text:
                                  ' the Uploaded Document/Images with us and any other third party based on the services availed.\n\nPermission can be changed at anytime from the device settings.\n\nIn case of any doubts, please visit our ',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) async {
                                    if (isNetwork) {
                                      String privacyPolicyUrl = await controller
                                          .preferences
                                          .getPrivacyPolicyUrl();
                                      //TODO Navigate to T&c Screen
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             TermsConditionWebView(
                                      //                 "",
                                      //                 true,
                                      //                 Strings.terms_privacy)));
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
                                    }
                                  });
                                },
                              text: "Privacy Policy.",
                              style: boldTextStyle_12_gray_dark.copyWith(
                                  color: Colors.lightBlue)),
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
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  side: BorderSide(color: red)),
                              elevation: 1.0,
                              color: colorWhite,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) {
                                    if (isNetwork) {
                                      Navigator.pop(context);
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
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
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              elevation: 1.0,
                              color: appTheme,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) async {
                                    if (isNetwork) {
                                      Navigator.pop(context);
                                      controller.preferences
                                          .setPhotoConsent(true);
                                      permUploadPhoto();
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
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
            );
          },
        ) ??
        false;
  }

  permUploadPhoto() async {
    try {
      controller.toChangeBoolValuesForDropdown();
      XFile? imagePicker =
          await controller.permPicker.pickImage(source: ImageSource.gallery);
      if (imagePicker != null) {
        CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: imagePicker.path,
          cropStyle: CropStyle.rectangle,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 50,
          uiSettings: [
            AndroidUiSettings(
                toolbarColor: appTheme,
                toolbarTitle: "Crop Image",
                toolbarWidgetColor: colorWhite,
                backgroundColor: colorBg),
          ],
        );
        if (cropped != null) {
          final bytes = File(cropped.path).readAsBytesSync();
          final bytesInt = File(cropped.path).readAsBytesSync().lengthInBytes;
          final cropKb = bytesInt / 1024;
          final cropMb = cropKb / 1024;
          controller.permByteImageString = base64Encode(bytes);
          controller.permValidatorPOAImage.value = true;
          if (cropMb > 10) {
            controller.permValidatorPOAImageSize.value = false;
          } else {
            controller.permValidatorPOAImageSize.value = true;
          }
          controller.permPOAImage = File(cropped.path);
        }
      }
    } catch (e) {
      Utility().showPhotoPermissionDialog(Get.context!);
      printLog(e.toString());
    }
  }

  Widget permEditButton() {
    return Expanded(
      child: Container(
        height: 45,
        width: 100,
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          elevation: 1.0,
          color: appTheme,
          child: MaterialButton(
            minWidth: MediaQuery.of(Get.context!).size.width,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            onPressed: () async {
              Utility.isNetworkConnection().then((isNetwork) {
                if (isNetwork) {
                  resetPermField();
                  controller.toChangeBoolValuesForDropdown();
                } else {
                  Utility.showToastMessage(Strings.no_internet_message);
                }
              });
            },
            child: Text(
              "Edit",
              style: TextStyle(
                  color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  resetPermField() {
    controller.permFieldsEnable.value = true;
    controller.permAddressLine1Controller.text = "";
    controller.permAddressLine2Controller.text = "";
    controller.permAddressLine3Controller.text = "";
    controller.permCityController.text = "";
    controller.permPinCodeController.text = "";
    controller.permDistrictController.text = "";
    controller.permStateController.text = "";
    controller.permCountryController.text = "";
    controller.permPOATypeSelected = "POA TYPE";
    controller.permByteImageString = null;
    controller.permPOAImage = null;
    controller.permValidatorAddress1.value = true;
    controller.permValidatorCity.value = true;
    controller.permValidatorPinCode.value = true;
    controller.permValidatorDistrict.value = true;
    controller.permValidatorState.value = true;
    controller.permValidatorCountry.value = true;
    controller.permValidatorValidCountry.value = true;
    controller.permValidatorPOAImage.value = true;
    controller.permValidatorPOAImageSize.value = true;
    controller.permValidatorPOAType.value = true;
  }

  Widget permSubmitButton() {
    return Expanded(
      child: Container(
        height: 45,
        width: 100,
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          elevation: 1.0,
          color: appTheme,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            minWidth: MediaQuery.of(Get.context!).size.width,
            onPressed: () async {
              Utility.isNetworkConnection().then((isNetwork) async {
                if (isNetwork) {
                  controller.toChangeBoolValuesForDropdown();
                  controller.validate = await validatePermAddressFields();
                  if (controller.validate!.isTrue) {
                    controller.permFieldsEnable.value = false;
                  }
                } else {
                  Utility.showToastMessage(Strings.no_internet_message);
                }
              });
            },
            child: Text(
              Strings.submit,
              style: TextStyle(
                  color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Future<RxBool> validatePermAddressFields() async {
    controller.permValidatorAddress1.value = true;
    controller.permValidatorCity.value = true;
    controller.permValidatorPinCode.value = true;
    controller.permValidatorDistrict.value = true;
    controller.permValidatorState.value = true;
    controller.permValidatorCountry.value = true;
    controller.permValidatorValidCountry.value = true;
    controller.permValidatorPOAType.value = true;
    controller.permValidatorPOAImage.value = true;

    if (controller.permAddressLine1Controller.text.toString().trim().isEmpty) {
      controller.permValidatorAddress1.value = false;
      controller.allValidated.value = false;
    }
    if (controller.permCityController.text.toString().trim().isEmpty) {
      controller.permValidatorCity.value = false;
      controller.allValidated.value = false;
    }
    if (controller.permPinCodeController.text.toString().trim().isEmpty) {
      controller.permValidatorPinCode.value = false;
      controller.allValidated.value = false;
    }
    if (controller.permDistrictController.text.toString().trim().isEmpty) {
      controller.permValidatorDistrict.value = false;
      controller.allValidated.value = false;
    }
    if (controller.permStateController.text.toString().trim().isEmpty) {
      controller.permValidatorState.value = false;
      controller.allValidated.value = false;
    }
    if (controller.permCountryController.text.toString().trim().isEmpty) {
      controller.permValidatorCountry.value = false;
      controller.allValidated.value = false;
    }
    if (controller.permCountryController.text.isNotEmpty &&
        !controller.countryList.contains(
            controller.permCountryController.text.toString().trim())) {
      controller.permValidatorValidCountry.value = false;
      controller.allValidated.value = false;
    }
    if (controller.permPOATypeSelected == "POA TYPE" ||
        controller.permPOATypeSelected.isEmpty) {
      controller.permValidatorPOAType.value = false;
      controller.allValidated.value = false;
    }
    if (controller.permByteImageString == null ||
        controller.permByteImageString!.isEmpty) {
      controller.permValidatorPOAImage.value = false;
      controller.allValidated.value = false;
    }
    if (!controller.permValidatorPOAImageSize.value) {
      controller.allValidated.value = false;
    }

    return controller.allValidated;
  }

  //Widgets for Corresponding Address

  Widget corrCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AbsorbPointer(
          absorbing: !controller.corrCheckboxEnable.value,
          child: Checkbox(
            value: controller.corrCheckbox.value,
            onChanged: (value) {
              controller.onCorrCheckBoxValueChanged();
              if (value!) {
                controller.corrFieldsEnable.value = true;
                controller.toChangeBoolValuesForDropdown();
                controller.corrAddressLine1Controller.text =
                    controller.permAddressLine1Controller.text;
                controller.corrAddressLine2Controller.text =
                    controller.permAddressLine2Controller.text;
                controller.corrAddressLine3Controller.text =
                    controller.permAddressLine3Controller.text;
                controller.corrCityController.text =
                    controller.permCityController.text;
                controller.corrPinCodeController.text =
                    controller.permPinCodeController.text;
                controller.corrDistrictController.text =
                    controller.permDistrictController.text;
                controller.corrStateController.text =
                    controller.permStateController.text;
                controller.corrCountryController.text =
                    controller.permCountryController.text;
                controller.corrPOATypeSelected = controller.permPOATypeSelected;
                controller.corrByteImageString = controller.permByteImageString;
                controller.corrPOAImage = controller.permPOAImage;
                controller.corrValidatorPOAImageSize =
                    controller.permValidatorPOAImageSize;
                validateCorrAddressFields();
              } else {
                resetCorrField();
              }
            },
          ),
        ),
        Text("Same as Permanent Address", style: regularTextStyle_18)
      ],
    );
  }

  resetCorrField() {
    controller.corrFieldsEnable.value = true;
    controller.corrAddressLine1Controller.text = "";
    controller.corrAddressLine2Controller.text = "";
    controller.corrAddressLine3Controller.text = "";
    controller.corrCityController.text = "";
    controller.corrPinCodeController.text = "";
    controller.corrDistrictController.text = "";
    controller.corrStateController.text = "";
    controller.corrCountryController.text = "";
    controller.corrPOATypeSelected = "POA TYPE";
    controller.corrByteImageString = null;
    controller.corrPOAImage = null;
    controller.corrValidatorAddress1.value = true;
    controller.corrValidatorCity.value = true;
    controller.corrValidatorPinCode.value = true;
    controller.corrValidatorDistrict.value = true;
    controller.corrValidatorState.value = true;
    controller.corrValidatorCountry.value = true;
    controller.corrValidatorValidCountry.value = true;
    controller.corrValidatorPOAImage.value = true;
    controller.corrValidatorPOAImageSize.value = true;
    controller.corrValidatorPOAType.value = true;
  }

  Widget corrAddressLineNumber1() {
    return TextField(
      controller: controller.corrAddressLine1Controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      enabled: true,
      readOnly: !controller.corrFieldsEnable.value,
      decoration: new InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: appTheme),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        errorStyle: TextStyle(color: red),
        hintStyle: TextStyle(color: colorGrey),
        labelStyle: TextStyle(color: appTheme),
        hintText: "ADDRESS LINE 1",
        labelText: "ADDRESS LINE 1*",
        errorText:
            controller.corrValidatorAddress1.isTrue ? null : '*Mandatory',
      ),
      onChanged: (value) {
        controller.corrValidatorAddress1.value = true;
      },
      onTap: () {
        controller.toChangeBoolValuesForDropdown();
      },
    );
  }

  Widget corrAddressLineNumber2() {
    return TextField(
      controller: controller.corrAddressLine2Controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      enabled: true,
      readOnly: !controller.corrFieldsEnable.value,
      decoration: new InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder:
            new OutlineInputBorder(borderSide: new BorderSide(color: appTheme)),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        hintStyle: TextStyle(color: colorGrey),
        labelStyle: TextStyle(color: appTheme),
        hintText: "ADDRESS LINE 2",
        labelText: "ADDRESS LINE 2",
      ),
      onTap: () {
        controller.toChangeBoolValuesForDropdown();
      },
    );
  }

  Widget corrAddressLineNumber3() {
    return TextField(
      controller: controller.corrAddressLine3Controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      enabled: true,
      readOnly: !controller.corrFieldsEnable.value,
      decoration: new InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: appTheme),
        ),
        errorBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.red, width: 0.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          borderSide: BorderSide(width: 1, color: Colors.red),
        ),
        hintStyle: TextStyle(color: colorGrey),
        labelStyle: TextStyle(color: appTheme),
        hintText: "ADDRESS LINE 3",
        labelText: "ADDRESS LINE 3",
      ),
      onTap: () {
        controller.toChangeBoolValuesForDropdown();
      },
    );
  }

  Widget corrCity() {
    return Expanded(
      child: TextField(
        controller: controller.corrCityController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.name,
        enabled: true,
        readOnly: !controller.corrFieldsEnable.value,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')),
        ],
        decoration: new InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          disabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          focusedBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: appTheme),
          ),
          errorBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.red, width: 0.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          errorStyle: TextStyle(color: red),
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
          hintText: "CITY",
          labelText: "CITY*",
          errorText: controller.corrValidatorCity.isTrue ? null : '*Mandatory',
        ),
        onChanged: (value) {
          controller.corrValidatorCity.value = true;
        },
        onTap: () {
          controller.toChangeBoolValuesForDropdown();
        },
      ),
    );
  }

  Widget corrPinCode() {
    return Expanded(
      child: TextField(
        controller: controller.corrPinCodeController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.number,
        maxLength: 6,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
        enabled: true,
        readOnly: !controller.corrFieldsEnable.value,
        decoration: new InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          disabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          focusedBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: appTheme),
          ),
          errorBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.red, width: 0.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          errorStyle: TextStyle(color: red),
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
          hintText: "PIN CODE",
          labelText: "PIN CODE*",
          errorText: controller.corrValidatorPinCode.isTrue
              ? controller.corrValidPinCode.isTrue
                  ? null
                  : "*Invalid Pin Code"
              : '*Mandatory',
        ),
        onChanged: (value) {
          controller.corrValidPinCode.value = true;
          controller.corrValidatorPinCode.value = true;
          if (value.toString().trim().length == 6) {
            FocusScope.of(Get.context!).unfocus();
            //TODO To call API
            // callAPIToGetPinCode(Strings.corresponding_address,
            //     controller.corrPinCodeController.text.toString().trim());
          } else {
            controller.corrDistrictController.text = "";
            controller.corrStateController.text = "";
          }
        },
        onTap: () {
          controller.toChangeBoolValuesForDropdown();
        },
      ),
    );
  }

  Widget corrDistrict() {
    return Expanded(
      child: TextField(
        controller: controller.corrDistrictController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.name,
        enabled: true,
        readOnly: true,
        decoration: new InputDecoration(
          counterText: "",
          disabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          focusedBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: appTheme),
          ),
          errorBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.red, width: 0.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          errorStyle: TextStyle(color: red),
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
          hintText: "DISTRICT",
          labelText: "DISTRICT*",
          errorText:
              controller.corrValidatorDistrict.isTrue ? null : '*Mandatory',
        ),
        onChanged: (value) {
          controller.corrValidatorDistrict.value = true;
        },
        onTap: () {
          controller.toChangeBoolValuesForDropdown();
        },
      ),
    );
  }

  Widget corrState() {
    return Expanded(
      child: TextField(
        controller: controller.corrStateController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.name,
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
            borderSide: new BorderSide(color: appTheme),
          ),
          errorBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.red, width: 0.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          errorStyle: TextStyle(color: red),
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
          hintText: "STATE",
          labelText: "STATE*",
          errorText: controller.corrValidatorState.isTrue ? null : '*Mandatory',
        ),
        onChanged: (value) {
          controller.corrValidatorState.value = true;
        },
        onTap: () {
          controller.toChangeBoolValuesForDropdown();
        },
      ),
    );
  }

  Widget corrCountry() {
    return Expanded(
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return controller.countryList.where((String option) {
            return controller.corrFieldsEnable.isTrue
                ? option.toString().toLowerCase().contains(
                    textEditingValue.text.toString().toLowerCase().trim())
                : false;
          });
        },
        displayStringForOption: (String option) {
          return option.toString();
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController countryController,
            fieldFocusNode,
            onFieldSubmitted) {
          controller.corrCountryController = countryController;
          if (controller.corrOnce == 1) {
            controller.corrCountryController.text =
                controller.corrCountryValue!;
            controller.corrOnce++;
          }
          return TextField(
            controller: countryController,
            focusNode: fieldFocusNode,
            enabled: true,
            readOnly: !controller.corrFieldsEnable.value,
            textCapitalization: TextCapitalization.words,
            decoration: new InputDecoration(
              counterText: '',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              disabledBorder: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.all(Radius.circular(4)),
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
              errorStyle: TextStyle(color: red),
              hintStyle: TextStyle(color: colorGrey),
              labelStyle: TextStyle(color: appTheme),
              hintText: "Country",
              labelText: "Country*",
              errorText: controller.corrValidatorCountry.isTrue
                  ? controller.corrValidatorValidCountry.isTrue
                      ? null
                      : "*Invalid Country"
                  : '*Mandatory',
            ),
            onChanged: (value) {
              controller.corrValidatorCountry.value = true;
              for (int i = 0; i < controller.countryList.length; i++) {
                if (controller.corrCountryController.text
                            .toString()
                            .trim()
                            .isNotEmpty &&
                        controller.countryList[i].contains(capitalize(controller
                            .corrCountryController.text
                            .toString()
                            .trim())) ||
                    controller.corrCountryController.text
                        .toString()
                        .trim()
                        .isEmpty) {
                  controller.corrValidatorValidCountry.value = true;
                  return;
                } else {
                  controller.corrValidatorValidCountry.value = false;
                }
              }
            },
            onTap: () {
              controller.toChangeBoolValuesForDropdown();
            },
          );
        },
        onSelected: (String selection) {
          FocusScope.of(Get.context!).unfocus();
          controller.corrValidatorCountry.value = true;
          for (int i = 0; i < controller.countryList.length; i++) {
            if (controller.countryList[i].contains(
                controller.corrCountryController.text.toString().trim())) {
              controller.corrValidatorValidCountry.value = true;
              return;
            } else {
              controller.corrValidatorValidCountry.value = false;
            }
          }
        },
        optionsViewBuilder: (BuildContext context,
            AutocompleteOnSelected<String> onSelected,
            Iterable<String> options) {
          return Align(
            alignment: Alignment.topLeft,
            child: Material(
              elevation: 2,
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
                width: (MediaQuery.of(context).size.width / 2) - 30,
                decoration: BoxDecoration(
                  color: colorBg,
                  border: Border.all(
                    color: Colors.black12,
                  ),
                ),
                child: Scrollbar(
                  controller: controller.corrScrollController,
                  //isAlwaysShown: true,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: controller.corrScrollController,
                    itemExtent: 40,
                    padding: EdgeInsets.all(2.0),
                    itemCount: options.length,
                    physics: AlwaysScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int index) {
                      final String option = options.elementAt(index);
                      return Container(
                        child: ListTile(
                          onTap: () {
                            onSelected(option);
                          },
                          title: Text(option.toString(),
                              style: const TextStyle(color: Colors.black)),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget corrPOAType() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Proof of Address Type*"),
          SizedBox(height: 2),
          kycAddressArguments.isShowEdit!
              ? Container(
                  height: 32,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: AwesomeDropDown(
                      isBackPressedOrTouchedOutSide:
                          controller.corrIsBackPressedOrTouchedOutSide.isTrue,
                      dropDownList: controller.poaTypeList,
                      dropDownIcon: Image.asset(AssetsImagePath.down_arrow,
                          height: 20, width: 20),
                      selectedItem: controller.corrPOATypeSelected,
                      dropDownListTextStyle:
                          TextStyle(color: colorLightGray, fontSize: 18),
                      onDropDownItemClick: (selectedItem) {
                        controller.corrValidatorPOAType.value = true;
                        controller.corrPOATypeSelected = selectedItem;
                      },
                      dropDownBottomBorderRadius: 2,
                      dropDownTopBorderRadius: 2,
                      dropDownBGColor: colorBg,
                      elevation: 0,
                      padding: 1,
                      dropDownOverlayBGColor: colorBg,
                      dropStateChanged: (isOpened) {
                        controller.corrIsDropDownOpened = isOpened;
                        if (!isOpened) {
                          controller.corrIsBackPressedOrTouchedOutSide.value =
                              false;
                        }
                      },
                    ),
                  ),
                )
              : SizedBox(),
          //  Row(
          //   children: [
          //     Column(
          //       children: [
          //         Container(
          //             height: 32,
          //             width : 90,
          //             child: SingleChildScrollView(child: Text(corrPOATypeSelected, style: TextStyle(color: colorBlack, fontSize: 16)))),
          //       ],
          //     ),
          //     SizedBox(width : 20),
          //     Image.asset(AssetsImagePath.down_arrow, height: 20, width: 20)
          //   ],
          // ),
          SizedBox(height: 5),
          Visibility(
            visible: !controller.corrValidatorPOAType.value,
            child: Text("*Please select type", style: TextStyle(color: red)),
          ),
        ],
      ),
    );
  }

  Widget corrPOABrowse() {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Proof of Address*"),
          SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              kycAddressArguments.isShowEdit!
                  ? GestureDetector(
                      onTap: () {
                        Utility.isNetworkConnection().then((isNetwork) async {
                          if (isNetwork) {
                            bool photoConsent =
                                await controller.preferences.getPhotoConsent();
                            if (!photoConsent) {
                              corrPermissionYesNoDialog(Get.context!);
                            } else {
                              corrUploadPhoto();
                            }
                          } else {
                            Utility.showToastMessage(
                                Strings.no_internet_message);
                          }
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: colorBlack),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        padding: EdgeInsets.all(4),
                        child: Text("Browse"),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: colorBlack),
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      padding: EdgeInsets.all(4),
                      child: Text("Browse"),
                    ),
              SizedBox(width: 6),
              kycAddressArguments.isShowEdit!
                  ? controller.corrByteImageString != null &&
                          controller.corrByteImageString!.isNotEmpty
                      ? SizedBox(
                          width: 60,
                          height: 25,
                          child: Image.file(controller.corrPOAImage!,
                              fit: BoxFit.fill))
                      : SizedBox()
                  : SizedBox(
                      width: 60,
                      height: 25,
                      child: Image.network(controller.corrPOAImageNew!,
                          fit: BoxFit.fill)),
            ],
          ),
          SizedBox(height: 5),
          Visibility(
            visible: !controller.corrValidatorPOAImage.value,
            child: Text("*Please upload proof", style: TextStyle(color: red)),
          ),
          Visibility(
            visible: !controller.corrValidatorPOAImageSize.value,
            child: Text("*Image should be less than 10MB",
                style: TextStyle(color: red)),
          ),
        ],
      ),
    );
  }

  Future<bool> corrPermissionYesNoDialog(BuildContext context) async {
    return await showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
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
                          TextSpan(
                              text:
                                  'Why is LMS asking for my Storage access?\n\n',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              text: 'LMS asked for ',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              text: 'Storage Access',
                              style: boldTextStyle_12_gray_dark),
                          TextSpan(
                              text: ' to let you upload the required ',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              text: 'Documents & Image',
                              style: boldTextStyle_12_gray_dark),
                          TextSpan(
                              text: ' to avail the services.\nWe do ',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              text: 'collect /share',
                              style: boldTextStyle_12_gray_dark),
                          TextSpan(
                              text:
                                  ' the Uploaded Document/Images with us and any other third party based on the services availed.\n\nPermission can be changed at anytime from the device settings.\n\nIn case of any doubts, please visit our ',
                              style: regularTextStyle_12_gray_dark),
                          TextSpan(
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) async {
                                    if (isNetwork) {
                                      String privacyPolicyUrl = await controller
                                          .preferences
                                          .getPrivacyPolicyUrl();
                                      //TODO Navigate to T&C Screen
                                      // Navigator.push(
                                      //     context,
                                      //     MaterialPageRoute(
                                      //         builder: (context) =>
                                      //             TermsConditionWebView(
                                      //                 "",
                                      //                 true,
                                      //                 Strings.terms_privacy)));
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
                                    }
                                  });
                                },
                              text: "Privacy Policy.",
                              style: boldTextStyle_12_gray_dark.copyWith(
                                  color: Colors.lightBlue)),
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
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  side: BorderSide(color: red)),
                              elevation: 1.0,
                              color: colorWhite,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) {
                                    if (isNetwork) {
                                      Navigator.pop(context);
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
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
                            child: Material(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(35)),
                              elevation: 1.0,
                              color: appTheme,
                              child: MaterialButton(
                                minWidth: MediaQuery.of(context).size.width,
                                onPressed: () async {
                                  Utility.isNetworkConnection()
                                      .then((isNetwork) async {
                                    if (isNetwork) {
                                      Navigator.pop(context);
                                      controller.preferences
                                          .setPhotoConsent(true);
                                      corrUploadPhoto();
                                    } else {
                                      Utility.showToastMessage(
                                          Strings.no_internet_message);
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
            );
          },
        ) ??
        false;
  }

  corrUploadPhoto() async {
    try {
      controller.toChangeBoolValuesForDropdown();
      XFile? imagePicker =
          await controller.corrPicker.pickImage(source: ImageSource.gallery);
      if (imagePicker != null) {
        CroppedFile? cropped = await ImageCropper().cropImage(
          sourcePath: imagePicker.path,
          cropStyle: CropStyle.rectangle,
          compressFormat: ImageCompressFormat.jpg,
          compressQuality: 50,
          uiSettings: [
            AndroidUiSettings(
                toolbarColor: appTheme,
                toolbarTitle: "Crop Image",
                toolbarWidgetColor: colorWhite,
                backgroundColor: colorBg),
          ],
        );

        if (cropped != null) {
          final bytes = File(cropped.path).readAsBytesSync();
          final bytesInt = File(cropped.path).readAsBytesSync().lengthInBytes;
          final cropKb = bytesInt / 1024;
          final cropMb = cropKb / 1024;
          controller.corrByteImageString = base64Encode(bytes);
          controller.corrValidatorPOAImage.value = true;
          if (cropMb > 10) {
            controller.corrValidatorPOAImageSize.value = false;
          } else {
            controller.corrValidatorPOAImageSize.value = true;
          }
          controller.corrPOAImage = File(cropped.path);
        }
      }
    } catch (e) {
      Utility().showPhotoPermissionDialog(Get.context);
      printLog(e.toString());
    }
  }

  Widget corrEditButton() {
    return Expanded(
      child: Container(
        height: 45,
        width: 100,
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          elevation: 1.0,
          color: appTheme,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            minWidth: MediaQuery.of(Get.context!).size.width,
            onPressed: () async {
              Utility.isNetworkConnection().then((isNetwork) {
                if (isNetwork) {
                  controller.corrCheckboxEnable.value = true;
                  controller.corrFieldsEnable.value = true;
                  controller.toChangeBoolValuesForDropdown();
                } else {
                  Utility.showToastMessage(Strings.no_internet_message);
                }
              });
            },
            child: Text(
              "Edit",
              style: TextStyle(
                  color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Widget corrSubmitButton() {
    return Expanded(
      child: Container(
        height: 45,
        width: 100,
        child: Material(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          elevation: 1.0,
          color: appTheme,
          child: MaterialButton(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            minWidth: MediaQuery.of(Get.context!).size.width,
            onPressed: () async {
              Utility.isNetworkConnection().then((isNetwork) async {
                if (isNetwork) {
                  controller.toChangeBoolValuesForDropdown();
                   controller.validation = await validateCorrAddressFields();
                  if (controller.validation!.isTrue) {
                    controller.corrFieldsEnable.value = false;
                    controller.corrCheckboxEnable.value = false;
                  }
                } else {
                  Utility.showToastMessage(Strings.no_internet_message);
                }
              });
            },
            child: Text(
              "Submit",
              style: TextStyle(
                  color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }

  Future<RxBool> validateCorrAddressFields() async {
      controller.corrValidatorAddress1.value = true;
      controller.corrValidatorCity.value = true;
      controller.corrValidatorPinCode.value = true;
      controller.corrValidatorDistrict.value = true;
      controller.corrValidatorState.value = true;
      controller.corrValidatorCountry.value = true;
      controller.corrValidatorValidCountry.value = true;
      controller.corrValidatorPOAType.value = true;
      controller.corrValidatorPOAImage.value = true;

      if (controller.corrAddressLine1Controller.text
          .toString()
          .trim()
          .isEmpty) {
        controller.corrValidatorAddress1.value = false;
        controller.allValidated.value = false;
      }
      if (controller.corrCityController.text.toString().trim().isEmpty) {
        controller.corrValidatorCity.value = false;
        controller.allValidated.value = false;
      }
      if (controller.corrPinCodeController.text.toString().trim().isEmpty) {
        controller.corrValidatorPinCode.value = false;
        controller.allValidated.value = false;
      }
      if (controller.corrDistrictController.text.toString().trim().isEmpty) {
        controller.corrValidatorDistrict.value = false;
        controller.allValidated.value = false;
      }
      if (controller.corrStateController.text.toString().trim().isEmpty) {
        controller.corrValidatorState.value = false;
        controller.allValidated.value = false;
      }
      if (controller.corrCountryController.text.toString().trim().isEmpty) {
        controller.corrValidatorCountry.value = false;
        controller.allValidated.value = false;
      }
      if (controller.corrCountryController.text.isNotEmpty &&
          !controller.countryList.contains(
              controller.corrCountryController.text.toString().trim())) {
        controller.corrValidatorValidCountry.value = false;
        controller.allValidated.value = false;
      }
      if (controller.corrPOATypeSelected == "POA TYPE" ||
          controller.corrPOATypeSelected.isEmpty) {
        controller.corrValidatorPOAType.value = false;
        controller.allValidated.value = false;
      }
      if (controller.corrByteImageString == null ||
          controller.corrByteImageString!.isEmpty) {
        controller.corrValidatorPOAImage.value = false;
        controller.allValidated.value = false;
      }
      if (!controller.corrValidatorPOAImageSize.value) {
        controller.allValidated.value = false;
      }
   
    return controller.allValidated;
  }

  // callAPIToGetPinCode(String isComingFrom, String pinCode) {
  //   showDialogLoading(Strings.please_wait);
  //   completeKYCBloc.getPinCodeDetails(pinCode).then((value) {
  //     Navigator.pop(context);
  //     if (value.isSuccessFull!) {
  //       setState(() {
  //         if (isComingFrom == Strings.permanent_address) {
  //           permDistrictController.text = value.data!.district!;
  //           permStateController.text = value.data!.state!;
  //           permValidatorDistrict = true;
  //           permValidatorState = true;
  //         } else {
  //           corrDistrictController.text = value.data!.district!;
  //           corrStateController.text = value.data!.state!;
  //           corrValidatorDistrict = true;
  //           corrValidatorState = true;
  //         }
  //       });
  //     } else if (value.errorCode == 403) {
  //       commonDialog(context, Strings.session_timeout, 4);
  //     } else {
  //       setState(() {
  //         if (isComingFrom == Strings.permanent_address) {
  //           permValidPinCode = false;
  //         } else {
  //           corrValidPinCode = false;
  //         }
  //       });
  //     }
  //   });
  // }

  // // call consent api with ckyc name and loanrenewal - 0/1
  // getConsentAPICall() {
  //   completeKYCBloc
  //       .consentDetails(ConsentDetailRequestBean(
  //           userKycName: widget.ckycName, isLoanRenewal: 0))
  //       .then((value) {
  //     if (value.isSuccessFull!) {
  //       setState(() {
  //         permAddressLine1Controller.text = value.data!.userKycDoc!.permLine1!;
  //         permAddressLine2Controller.text = value.data!.userKycDoc!.permLine2!;
  //         permAddressLine3Controller.text = value.data!.userKycDoc!.permLine3!;
  //         permCityController.text = value.data!.userKycDoc!.permCity!;
  //         permPinCodeController.text = value.data!.userKycDoc!.permPin!;
  //         permDistrictController.text = value.data!.userKycDoc!.permDist!;
  //         permStateController.text = value.data!.userKycDoc!.permState!;
  //         permCountryController.text = value.data!.userKycDoc!.permCountry!;
  //         permCountryValue = value.data!.userKycDoc!.permCountry!;
  //         if (!widget.isShowEdit! &&
  //             value.data!.address != null &&
  //             value.data!.address!.toString().isNotEmpty) {
  //           permPOATypeSelected = value.data!.address!.permPoa!;
  //           permPOAImageNew = value.data!.address!.permImage!;
  //         }
  //         corrAddressLine1Controller.text =
  //             value.data!.userKycDoc!.corresLine1!;
  //         corrAddressLine2Controller.text =
  //             value.data!.userKycDoc!.corresLine2!;
  //         corrAddressLine3Controller.text =
  //             value.data!.userKycDoc!.corresLine3!;
  //         corrCityController.text = value.data!.userKycDoc!.corresCity!;
  //         corrPinCodeController.text = value.data!.userKycDoc!.corresPin!;
  //         corrDistrictController.text = value.data!.userKycDoc!.corresDist!;
  //         corrStateController.text = value.data!.userKycDoc!.corresState!;
  //         corrCountryController.text = value.data!.userKycDoc!.corresCountry!;
  //         corrCountryValue = value.data!.userKycDoc!.corresCountry!;
  //         if (!widget.isShowEdit! &&
  //             value.data!.address != null &&
  //             value.data!.address!.toString().isNotEmpty) {
  //           corrPOATypeSelected = value.data!.address!.corresPoa!;
  //           corrPOAImageNew = value.data!.address!.corresPoaImage!;
  //         }
  //         poaTypeList = value.data!.poaType!.toSet().toList();
  //         countryList = value.data!.country!;
  //         consentText = value.data!.consentDetails!.consent;
  //         corrCheckbox =
  //             value.data!.userKycDoc!.permCorresSameflag!.toLowerCase() == "y"
  //                 ? true
  //                 : false;
  //         isAPICalling = false;
  //       });
  //     } else if (value.errorCode == 403) {
  //       setState(() {
  //         isAPICalling = true;
  //         isAPICallingText = value.errorMessage!;
  //       });
  //       commonDialog(context, Strings.session_timeout, 4);
  //     } else {
  //       Utility.showToastMessage(value.errorMessage!);
  //       setState(() {
  //         isAPICalling = true;
  //         isAPICallingText = value.errorMessage!;
  //       });
  //     }
  //   });
  // }

  // saveConsentAPICall() {
  //   LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
  //   ConsentDetailRequestBean consentDetailRequestBean =
  //       ConsentDetailRequestBean(
  //           userKycName: widget.ckycName,
  //           acceptTerms: consentCheckbox ? 1 : 0,
  //           addressDetails: AddressDetails(
  //               permanentAddress: PermanentAddress(
  //                 addressLine1: permAddressLine1Controller.text.toString(),
  //                 addressLine2: permAddressLine2Controller.text.toString(),
  //                 addressLine3: permAddressLine3Controller.text.toString(),
  //                 city: permCityController.text.toString(),
  //                 pinCode: permPinCodeController.text.toString(),
  //                 district: permDistrictController.text.toString(),
  //                 state: permStateController.text.toString(),
  //                 country: permCountryController.text.toString(),
  //                 poaType: permPOATypeSelected,
  //                 addressProofImage: permByteImageString,
  //               ),
  //               permCorresFlag: corrCheckbox! ? "yes" : "no",
  //               correspondingAddress: PermanentAddress(
  //                 addressLine1: corrAddressLine1Controller.text.toString(),
  //                 addressLine2: corrAddressLine2Controller.text.toString(),
  //                 addressLine3: corrAddressLine3Controller.text.toString(),
  //                 city: corrCityController.text.toString(),
  //                 pinCode: corrPinCodeController.text.toString(),
  //                 district: corrDistrictController.text.toString(),
  //                 state: corrStateController.text.toString(),
  //                 country: corrCountryController.text.toString(),
  //                 poaType: corrPOATypeSelected,
  //                 addressProofImage: corrByteImageString,
  //               )),
  //           isLoanRenewal: 0);
  //   completeKYCBloc.consentDetails(consentDetailRequestBean).then((value) {
  //     Navigator.pop(context);
  //     if (value.isSuccessFull!) {
  //       preferences.setOkClicked(true);
  //       showDialogOnCKYCSuccess(value.message!);
  //     } else if (value.errorCode == 403) {
  //       commonDialog(Strings.session_timeout, 4);
  //     } else {
  //       commonDialog(value.errorMessage!, 0);
  //     }
  //   });
  // }

  
}
showDialogOnCKYCSuccess(String msg) {
    return showDialog<void>(
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15.0))),
            content: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(msg, style: regularTextStyle_16_dark),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 45,
                    width: 100,
                    child: Material(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(35)),
                      elevation: 1.0,
                      color: appTheme,
                      child: MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(35)),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                         
                        },
                        child: Text(
                          Strings.ok,
                          style: buttonTextWhite,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
