import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:lms/aa_getx/config/routes.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/modules/bank/presentation/controllers/add_bank_controller.dart';
import 'package:lms/aa_getx/modules/dashboard/presentation/arguments/dashboard_arguments.dart';

import '../../../../core/assets/assets_image_path.dart';
import '../../../../core/constants/strings.dart';
import '../../../../core/utils/style.dart';
import '../../../../core/utils/utility.dart';
import '../../../../core/widgets/common_widgets.dart';

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
            onPressed: () => Navigator.pop(context),
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
                          Navigator.pop(context);
                          Get.offAll(dashboardView, arguments: DashboardArguments(
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

  Widget iFSCField() {
    return Row(
      children: [
        Expanded(
          child: Autocomplete<BankData>(
            optionsBuilder: (TextEditingValue textEditingValue) {
              if (textEditingValue.text.toString().trim().length >=  9) {
                controller.isAPICalled = true;
                bankDetailAPI(textEditingValue.text.toString().trim());
              }
              if (textEditingValue.text.toString().trim().length > 9) {
                List<String> iFSCList;
                iFSCList = List.generate(
                    controller.bankData.length, (index) => controller.bankData[index].ifsc!)
                    .toSet()
                    .toList();
                printLog("IFSC CODES ===> ${iFSCList.toSet().toList()}");
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
                    controller.validatorIFSC = false;
                  } else if (iFSCList.length == 0) {
                    controller.validatorIFSC = false;
                  } else {
                    controller.validatorIFSC = true;
                  }
                }
              }
              if (textEditingValue.text.toString().trim() == '') {
                return const Iterable<BankData>.empty();
              } else if (textEditingValue.text.toString().trim().length < 10) {
                return const Iterable<BankData>.empty();
              } else if (controller.bankData.length != 0 &&
                  textEditingValue.text.length == 10 || textEditingValue.text.length == 11) {
                return controller.bankData.where((BankData option) {
                  return option.ifsc.toString()
                      .contains(textEditingValue.text.toString().trim());
                });
              } else {
                return const Iterable<BankData>.empty();
              }
            },
            displayStringForOption: (BankData option) {
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
                  errorText: controller.iFSCValidator ? controller.iFSCTextLen ? !controller.isAPICalled
                      ? !controller.validatorIFSC
                      ? !controller.isAvailable ? "*" + Strings.invalid_ifsc_msg : null
                      : null : null : "*" + Strings.invalid_ifsc_msg
                      : "*" + Strings.ifsc_code + Strings.is_mandatory,
                ),
                onChanged: (value) {
                  setState(() {
                    if (controller.iFSCController.text != value.toUpperCase())
                      controller.iFSCController.value = controller.iFSCController.value
                          .copyWith(text: value.toUpperCase());
                    controller.isVisible = true;
                    // iFSCControllerr.text.isEmpty
                    //     ? iFSCValidator = false
                    //     : iFSCValidator = true;
                    controller.branchController.clear();
                    controller.bankController.clear();
                    controller.cityController.clear();

                    fieldFocusNode.addListener(() {
                      if(fieldFocusNode.hasFocus){
                        controller.iFSCValidator = true;
                        controller.iFSCTextLen = true;
                        // if(iFSCController.text.length == 11 && iFSCController.text.isEmpty) {
                        //   iFSCTextLen = true;
                        // }
                      }else{
                        if(controller.iFSCController.text.isNotEmpty) {
                          controller.iFSCValidator = true;
                          if (controller.iFSCController.text.length < 11) {
                            controller.iFSCTextLen = false;
                          } else {
                            controller.iFSCTextLen = true;
                          }
                          printLog("focus length ==> ${controller.iFSCTextLen.toString()}");
                        }else{
                          controller.iFSCValidator = false;
                        }
                      }
                    });
                  });
                },
              );
            },
            onSelected: (BankData selection) {
              setState(() {
                FocusScope.of(context).unfocus();
                controller.bankController.text = selection.bank.toString();
                controller.branchController.text = selection.branch.toString();
                controller.cityController.text = selection.city.toString();
              });
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<BankData> onSelected,
                Iterable<BankData> options) {
              controller.isAvailable = true;
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
                                final BankData option =
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
              onTap: () => commonDialog(context, Strings.ifsc_info, 0),
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
            controller: bankController,
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
        controller: branchController,
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
        controller: cityController,
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
      controller: accHolderNameController,
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
        errorText: controller.accHolderNameValidator
            ? null
            : "*" + Strings.account_holder_name + Strings.is_mandatory,
      ),
      onChanged: (value) {
        setState(() {
          controller.isVisible = true;
          accHolderNameController.text.isEmpty
              ? controller.accHolderNameValidator = false
              : controller.accHolderNameValidator = true;
        });
      },
    );
  }

  Widget accountNumberFiled() {
    return TextFormField(
      obscureText: true,
      controller: accNumberController,
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
        errorText: controller.accNumberValidator
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
      onChanged: (value) {
        setState(() {
          controller.isVisible = true;
          accNumberController.text.isEmpty
              ? controller.accNumberValidator = false
              : controller.accNumberValidator = true;
          if(controller.accNumberController.text.isNotEmpty && reEnterAccNumberController.text.isNotEmpty){
            if ((accNumberController.text.trim()
                .compareTo(reEnterAccNumberController.text.trim())) == 0) {
              controller.reEnterAccNumberIsCorrect = false;
            } else {
              controller.reEnterAccNumberIsCorrect = true;
            }
          }
        });
      },
    );
  }

  Widget accountReNumberFiled() {
    return TextFormField(
      controller: reEnterAccNumberController,
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
        errorText: controller.reEnterAccNumberValidator
            ? !controller.reEnterAccNumberIsCorrect
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
      onChanged: (value) {
        return setState(() {
          controller.isVisible = true;
          reEnterAccNumberController.text.isEmpty
              ? controller.reEnterAccNumberValidator = false
              : controller.reEnterAccNumberValidator = true;
          if(accNumberController.text.isNotEmpty && reEnterAccNumberController.text.isNotEmpty) {
            if ((accNumberController.text.trim()
                .compareTo(reEnterAccNumberController.text.trim())) == 0) {
              controller.reEnterAccNumberIsCorrect = false;
            } else {
              controller.reEnterAccNumberIsCorrect = true;
            }
          }
        });
      },
    );
  }

  Widget accountTypeFiled() {
    return TextField(
      controller: accTypeController,
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
                      permissionYesNoDialog(context);
                    }else{
                      uploadPhoto();
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
            controller.chequeByteImageString != null && controller.chequeByteImageString!.isNotEmpty
                ? SizedBox(width: 60, height: 25, child: Image.file(controller.chequeImage!, fit: BoxFit.fill))
                : SizedBox(),
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
        absorbing: controller.bankController.text.toString().trim().isNotEmpty &&
            controller.iFSCController.text.toString().trim().isNotEmpty &&
            controller.accHolderNameController.text.toString().trim().isNotEmpty &&
            controller.accNumberController.text.toString().trim().isNotEmpty &&
            controller.reEnterAccNumberController.text.toString().trim().isNotEmpty &&
            !controller.reEnterAccNumberIsCorrect && controller.cropMb != null && controller.imageInMb == true
            ? false
            : true,
        child: Container(
          height: 45,
          width: 120,
          child: Material(
            color: controller.bankController.text.toString().trim().isNotEmpty &&
                controller.iFSCController.text.toString().trim().isNotEmpty &&
                controller.accHolderNameController.text.toString().trim().isNotEmpty &&
                controller.accNumberController.text.toString().trim().isNotEmpty &&
                controller.reEnterAccNumberController.text.toString().trim().isNotEmpty &&
                !controller.reEnterAccNumberIsCorrect && controller.cropMb != null && controller.imageInMb == true
                ? appTheme
                : colorLightGray,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
            elevation: 1.0,
            child: MaterialButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(45)),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () {
                Utility.isNetworkConnection().then((isNetwork) async {
                  if (isNetwork) {
                    FocusScope.of(context).unfocus();
                    if (controller.bankController.text.toString().trim().isNotEmpty) {
                      if (controller.accHolderNameValidator == true &&
                          controller.accNumberValidator == true &&
                          controller.reEnterAccNumberValidator == true &&
                          controller.iFSCValidator == true && controller.imageInMb == true) {
                        validateBank();
                        // createFundAccountAPI();
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

}