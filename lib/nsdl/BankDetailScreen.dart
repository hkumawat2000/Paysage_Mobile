import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:lms/complete_kyc/CompleteKYCBloc.dart';
import 'package:lms/network/requestbean/ValidateBankRequestBean.dart';
import 'package:lms/network/responsebean/AtrinaBankResponseBean.dart';
import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/nsdl/BankDetailBloc.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../terms_conditions/TermsConditionWebView.dart';
import '../util/Preferences.dart';
import 'BankMasterResponse.dart';

class BankDetailScreen extends StatefulWidget {
  @override
  _BankDetailScreenState createState() => _BankDetailScreenState();
}

class _BankDetailScreenState extends State<BankDetailScreen> {
  bool accHolderNameValidator = true;
  bool iFSCValidator = true;
  bool validatorIFSC = true;
  bool isAvailable = false;
  bool isAPICalled = false;
  bool iFSCTextLen = true;
  bool accNumberValidator = true;
  bool reEnterAccNumberValidator = true;
  bool _isVisible = false;
  bool reEnterAccNumberIsCorrect = false;
  List<BankData> bankData = [];
  BankMasterResponse? iFSCDetails;
  BankDetailBloc bankDetailBloc = BankDetailBloc();
  BankAccount bankAccount = BankAccount();
  Timer? timer;
  int pennyAPICallCount = 0;
  String? iFSCText = "HDFC BANK";
  final completeKYCBloc = CompleteKYCBloc();
  final ImagePicker chequePicker = ImagePicker();
  String? chequeByteImageString;
  File? chequeImage;
  double? cropKb ;
  double? cropMb ;
  bool imageInMb = false;
  FocusNode ifscFocusNode = FocusNode();
  Preferences preferences = Preferences();
  // String? faId;
  // String? favId;

  TextEditingController accHolderNameController = TextEditingController();
  TextEditingController iFSCController = TextEditingController();
  TextEditingController fieldTextEditingController = TextEditingController();
  TextEditingController accNumberController = TextEditingController();
  TextEditingController reEnterAccNumberController = TextEditingController();
  TextEditingController branchController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController bankController = TextEditingController();
  TextEditingController accTypeController = TextEditingController();

  @override
  void initState() {
    choiceKYC();
    super.initState();
  }

  @override
  void dispose() {
    accHolderNameController.dispose();
    accNumberController.dispose();
    reEnterAccNumberController.dispose();
    super.dispose();
  }

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

  // Widget _buildLoadingWidget() {
  //   return Visibility(
  //     visible: _isVisible,
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
  //       children: [
  //         Center(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               SizedBox(
  //                   height: 16,
  //                   width: 16,
  //                   child: CircularProgressIndicator(
  //                     strokeWidth: 2,
  //                   )),
  //             ],
  //           ),
  //         ),
  //         Text(Strings.verifying_details)
  //       ],
  //     ),
  //   );
  // }

  showSuccessDialog(String msg, bool isSuccess) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DashBoard()));
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
      context: context,
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
              setState(() {
                if (textEditingValue.text.toString().trim().length >=  9) {
                  isAPICalled = true;
                  bankDetailAPI(textEditingValue.text.toString().trim());
                }
                if (textEditingValue.text.toString().trim().length > 9) {
                  List<String> iFSCList;
                  iFSCList = List.generate(
                      bankData.length, (index) => bankData[index].ifsc!)
                      .toSet()
                      .toList();
                  printLog("IFSC CODES ===> ${iFSCList.toSet().toList()}");
                  if (textEditingValue.text.length == 10 || textEditingValue.text.length == 11) {
                    if(textEditingValue.text.length == 11){
                        if(textEditingValue.text.toString().toUpperCase() == iFSCList[0].toString().toUpperCase()){
                          setState(() {
                            bankController.text = bankData[0].bank.toString();
                            branchController.text = bankData[0].branch.toString();
                            cityController.text = bankData[0].city.toString();
                          });
                        }
                    }
                    if (!iFSCList
                        .toString()
                        .trim()
                        .contains(textEditingValue.text.toString().trim())) {
                      validatorIFSC = false;
                    } else if (iFSCList.length == 0) {
                      validatorIFSC = false;
                    } else {
                      validatorIFSC = true;
                    }
                  }
                }
              });
              if (textEditingValue.text.toString().trim() == '') {
                return const Iterable<BankData>.empty();
              } else if (textEditingValue.text.toString().trim().length < 10) {
                return const Iterable<BankData>.empty();
              } else if (bankData.length != 0 &&
                  textEditingValue.text.length == 10 || textEditingValue.text.length == 11) {
                return bankData.where((BankData option) {
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
              iFSCController = iFSCControllerr;
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
                  errorText: iFSCValidator ? iFSCTextLen ? !isAPICalled
                      ? !validatorIFSC
                      ? !isAvailable ? "*" + Strings.invalid_ifsc_msg : null
                      : null : null : "*" + Strings.invalid_ifsc_msg
                      : "*" + Strings.ifsc_code + Strings.is_mandatory,
                ),
                onChanged: (value) {
                  setState(() {
                    if (iFSCController.text != value.toUpperCase())
                      iFSCController.value = iFSCController.value
                          .copyWith(text: value.toUpperCase());
                    _isVisible = true;
                    // iFSCControllerr.text.isEmpty
                    //     ? iFSCValidator = false
                    //     : iFSCValidator = true;
                    branchController.clear();
                    bankController.clear();
                    cityController.clear();

                    fieldFocusNode.addListener(() {
                      setState(() {
                        if(fieldFocusNode.hasFocus){
                          iFSCValidator = true;
                          iFSCTextLen = true;
                          // if(iFSCController.text.length == 11 && iFSCController.text.isEmpty) {
                          //   iFSCTextLen = true;
                          // }
                        }else{
                          if(iFSCController.text.isNotEmpty) {
                            iFSCValidator = true;
                            if (iFSCController.text.length < 11) {
                              iFSCTextLen = false;
                            } else {
                              iFSCTextLen = true;
                            }
                            printLog("focus length ==> ${iFSCTextLen.toString()}");
                          }else{
                            iFSCValidator = false;
                          }
                        }
                      });
                    });


                  });
                },
              );
            },
            onSelected: (BankData selection) {
              setState(() {
                FocusScope.of(context).unfocus();
                bankController.text = selection.bank.toString();
                branchController.text = selection.branch.toString();
                cityController.text = selection.city.toString();
              });
            },
            optionsViewBuilder: (BuildContext context,
                AutocompleteOnSelected<BankData> onSelected,
                Iterable<BankData> options) {
              isAvailable = true;
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
        errorText: accHolderNameValidator
            ? null
            : "*" + Strings.account_holder_name + Strings.is_mandatory,
      ),
      onChanged: (value) {
        setState(() {
          _isVisible = true;
          accHolderNameController.text.isEmpty
              ? accHolderNameValidator = false
              : accHolderNameValidator = true;
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
        errorText: accNumberValidator
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
          _isVisible = true;
          accNumberController.text.isEmpty
              ? accNumberValidator = false
              : accNumberValidator = true;
          if(accNumberController.text.isNotEmpty && reEnterAccNumberController.text.isNotEmpty){
            if ((accNumberController.text.trim()
              .compareTo(reEnterAccNumberController.text.trim())) == 0) {
            reEnterAccNumberIsCorrect = false;
            } else {
              reEnterAccNumberIsCorrect = true;
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
        errorText: reEnterAccNumberValidator
            ? !reEnterAccNumberIsCorrect
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
          _isVisible = true;
          reEnterAccNumberController.text.isEmpty
              ? reEnterAccNumberValidator = false
              : reEnterAccNumberValidator = true;
          if(accNumberController.text.isNotEmpty && reEnterAccNumberController.text.isNotEmpty) {
            if ((accNumberController.text.trim()
                .compareTo(reEnterAccNumberController.text.trim())) == 0) {
              reEnterAccNumberIsCorrect = false;
            } else {
              reEnterAccNumberIsCorrect = true;
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

  Widget submitButton() {
    return Center(
      child: AbsorbPointer(
        absorbing: bankController.text.toString().trim().isNotEmpty &&
            iFSCController.text.toString().trim().isNotEmpty &&
            accHolderNameController.text.toString().trim().isNotEmpty &&
            accNumberController.text.toString().trim().isNotEmpty &&
            reEnterAccNumberController.text.toString().trim().isNotEmpty &&
            !reEnterAccNumberIsCorrect && cropMb != null && imageInMb == true
            ? false
            : true,
        child: Container(
          height: 45,
          width: 120,
          child: Material(
            color: bankController.text.toString().trim().isNotEmpty &&
                iFSCController.text.toString().trim().isNotEmpty &&
                accHolderNameController.text.toString().trim().isNotEmpty &&
                accNumberController.text.toString().trim().isNotEmpty &&
                reEnterAccNumberController.text.toString().trim().isNotEmpty &&
                !reEnterAccNumberIsCorrect && cropMb != null && imageInMb == true
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
                    if (bankController.text.toString().trim().isNotEmpty) {
                      if (accHolderNameValidator == true &&
                          accNumberValidator == true &&
                          reEnterAccNumberValidator == true &&
                          iFSCValidator == true && imageInMb == true) {
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

  void bankDetailAPI(String ifsc) async {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        await bankDetailBloc.getBankDetails(ifsc).then((value) {
          if (value.isSuccessFull!) {
            setState(() {
              if (value.bankList != null) {
                value.bankList!.forEach((element) {
                  if(element.ifsc == iFSCController.text.toString().trim()){
                    isAvailable = true;
                  } else {
                    isAvailable = false;
                  }
                });
                bankData.clear();
                bankData.addAll(value.bankList!);
                isAPICalled = false;
              } else {
                isAvailable = false;
                isAPICalled = false;
              }
            });
          } else {
            setState(() {
              isAvailable = false;
              isAPICalled = false;
            });
          }
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  // void createFundAccountAPI() {
  //   LoadingDialogWidget.showLoadingWithoutBack(context, Strings.verifying_details);
  //   CreateFundAccountRequestBean createFundAccountRequestBean =
  //   CreateFundAccountRequestBean(ifsc: iFSCController.text.toString().trim(),
  //       accountHolderName: accHolderNameController.text.toString().trim(),
  //       accountNumber: accNumberController.text.toString().trim());
  //   bankDetailBloc.createFundAccountAPI(createFundAccountRequestBean)
  //       .then((value) {
  //     if (value.isSuccessFull!) {
  //       fundAccountValidationAPI(value.fundData!.faId.toString());
  //     } else if (value.errorCode == 403) {
  //       Navigator.pop(context);
  //       commonDialog(context, Strings.session_timeout, 4);
  //     } else {
  //       Navigator.pop(context);
  //       Utility.showToastMessage(value.errorMessage!);
  //     }
  //   });
  // }

  // void fundAccountValidationAPI(String? faId) {
  //   Utility.isNetworkConnection().then((isNetwork) async {
  //     if (isNetwork) {
  //       FundAccValidationRequestBean fundAccValidationRequestBean =
  //       FundAccValidationRequestBean(faId: faId.toString(),
  //           bankAccountType: accTypeController.text.toString().trim(),
  //           branch: branchController.text.toString().trim(),
  //           city: cityController.text.toString().trim(),
  //           personalizedCheque: chequeByteImageString);
  //       bankDetailBloc.fundAccValidationAPI(fundAccValidationRequestBean)
  //           .then((value) {
  //         Navigator.pop(context);
  //         if (value.isSuccessFull!) {
  //           if (value.fundAccValidationData!.status.toString().toLowerCase() == "completed") {
  //             showSuccessDialog(value.message!);
  //           } else if (value.fundAccValidationData!.status.toString().toLowerCase() == "created") {
  //             printLog("TIMER START");
  //             LoadingDialogWidget.showLoadingWithoutBack(context, value.message.toString());
  //             Future.delayed(Duration(seconds: 10)).then((valuee) {
  //               printLog("TIMER END");
  //               setState(() {
  //                 pennyAPICallCount ++;
  //               });
  //               fundAccountValidationByIdAPI(value.fundAccValidationData!.favId.toString());
  //             });
  //             printLog("TIMER STOP");
  //           } else if (value.fundAccValidationData!.status.toString().toLowerCase() == "failed") {
  //             showFailedDialog(value.message!);
  //           } else {
  //             commonDialog(context, value.message!, 0);
  //           }
  //         } else if (value.errorCode == 403) {
  //           commonDialog(context, Strings.session_timeout, 4);
  //         } else {
  //           Utility.showToastMessage(value.errorMessage!);
  //         }
  //       });
  //     } else {
  //       Navigator.pop(context);
  //       Utility.showToastMessage(Strings.no_internet_message);
  //     }
  //   });
  // }

  // void fundAccountValidationByIdAPI(favId) {
  //   Utility.isNetworkConnection().then((isNetwork) async {
  //     if (isNetwork) {
  //       bankDetailBloc.fundAccValidationByIdAPI(favId, chequeByteImageString).then((value) {
  //         if (value.isSuccessFull!) {
  //           if (value.fundAccValidationData!.status == "completed") {
  //             Navigator.pop(context);
  //             showSuccessDialog(value.message!);
  //           } else if (value.fundAccValidationData!.status == "created") {
  //             Future.delayed(Duration(seconds: 10)).then((valuee) async {
  //               if (pennyAPICallCount <= 4) {
  //                 pennyAPICallCount++;
  //                 fundAccountValidationByIdAPI(favId);
  //               } else {
  //                 Navigator.pop(context);
  //                 showFailedDialog(Strings.bank_detail_failed_msg);
  //               }
  //             });
  //           } else if (value.fundAccValidationData!.status.toString().toLowerCase() == "failed") {
  //             Navigator.pop(context);
  //             showFailedDialog(value.message!);
  //           } else {
  //             Navigator.pop(context);
  //             commonDialog(context, value.message!, 0);
  //           }
  //         } else if (value.errorCode == 403) {
  //           Navigator.pop(context);
  //           commonDialog(context, Strings.session_timeout, 4);
  //         }else {
  //           Navigator.pop(context);
  //           Utility.showToastMessage(value.errorMessage!);
  //         }
  //       });
  //     } else {
  //       Navigator.pop(context);
  //       Utility.showToastMessage(Strings.no_internet_message);
  //     }
  //   });
  // }

  void choiceKYC() {
    Utility.isNetworkConnection().then((isNetwork) async {
      if (isNetwork) {
        LoadingDialogWidget.showLoadingWithoutBack(context, Strings.please_wait);
        bankDetailBloc.getChoiceBankKYC().then((value) {
          Navigator.pop(context);
          if (value.isSuccessFull!) {
            if(value.atrinaBankData != null){
              if(value.atrinaBankData!.bankAccount != null
                  && value.atrinaBankData!.bankAccount!.isNotEmpty){
                bankAccount = value.atrinaBankData!.bankAccount![0];
                choiceUserConfirmationDialog();
              }
            }
          } else if (value.errorCode == 403) {
            commonDialog(context, Strings.session_timeout, 4);
          } else {
            // Utility.showToastMessage(value.errorMessage!);
          }
        });
      } else {
        Utility.showToastMessage(Strings.no_internet_message);
      }
    });
  }

  void validateBank(){
    LoadingDialogWidget.showLoadingWithoutBack(context, Strings.verifying_details);
    ValidateBankRequestBean validateBankRequestBean = ValidateBankRequestBean(
      ifsc: iFSCController.text.toString().trim(),
      accountHolderName: accHolderNameController.text.toString().trim(),
      accountNumber: accNumberController.text.toString().trim(),
      bankAccountType: accTypeController.text.toString().trim(),
      branch: branchController.text.toString().trim(),
      city: cityController.text.toString().trim(),
      bank: bankController.text.toString().trim(),
      personalizedCheque: chequeByteImageString,
    );
    bankDetailBloc.validateBank(validateBankRequestBean).then((value) {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        showSuccessDialog(value.message!, true);
      } else if (value.errorCode == 201) {
        showSuccessDialog(value.message!, false);
      } else if (value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        showFailedDialog(value.errorMessage!);
      }
    });
  }

  // void createContactAPI() {
  //   Utility.isNetworkConnection().then((isNetwork) async {
  //     if (isNetwork) {
  //       LoadingDialogWidget.showLoadingWithoutBack(context, Strings.please_wait);
  //       bankDetailBloc.createContactAPI().then((value) {
  //         if (value.isSuccessFull!) {
  //            choiceKYC();
  //         } else if (value.errorCode == 403) {
  //           Navigator.pop(context);
  //           commonDialog(context, Strings.session_timeout, 4);
  //         } else {
  //           Navigator.pop(context);
  //           Navigator.pop(context);
  //           Utility.showToastMessage(value.errorMessage!);
  //         }
  //       });
  //     } else {
  //       Utility.showToastMessage(Strings.no_internet_message);
  //     }
  //   });
  // }

  Future<bool> choiceUserConfirmationDialog() async {
    return await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
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
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  Navigator.pop(context);
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
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  setState(() {
                                    iFSCController.text = bankAccount.ifsc.toString();
                                    bankController.text = bankAccount.bank.toString();
                                    branchController.text = bankAccount.branch.toString();
                                    cityController.text = bankAccount.city.toString();
                                    // accNumberController.text = bankAccount.accountNumber.toString();
                                    // reEnterAccNumberController.text = bankAccount.accountNumber.toString();
                                    accTypeController.text = bankAccount.accountType.toString();
                                    isAvailable = true;
                                    Navigator.pop(context);
                                  });
                                } else {
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
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
        );
      },
    ) ?? false;
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
                    bool photoConsent = await preferences.getPhotoConsent();
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
            chequeByteImageString != null && chequeByteImageString!.isNotEmpty
                ? SizedBox(width: 60, height: 25, child: Image.file(chequeImage!, fit: BoxFit.fill))
                : SizedBox(),
          ],
        ),
        SizedBox(height: 5),
        cropMb != null
            ? cropMb! > 10
            ? Text("*Image should be less than 10MB", style: TextStyle(color: red))
            : Text("")
            : Text(""),
      ],
    );
  }

  Future<bool> permissionYesNoDialog(BuildContext context) async {
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
                            ..onTap = () {
                              Utility.isNetworkConnection().then((isNetwork) async {
                                if (isNetwork) {
                                  String privacyPolicyUrl = await preferences.getPrivacyPolicyUrl();
                                  printLog("privacyPolicyUrl ==> $privacyPolicyUrl");
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => TermsConditionWebView("", true, Strings.terms_privacy)));
                                } else {
                                  Utility.showToastMessage(Strings.no_internet_message);
                                }
                              });
                            },
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
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              Utility.isNetworkConnection().then((isNetwork) {
                                if (isNetwork) {
                                  Navigator.pop(context);
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
                            minWidth: MediaQuery.of(context).size.width,
                            onPressed: () async {
                              Utility.isNetworkConnection().then((isNetwork) async {
                                if (isNetwork) {
                                  Navigator.pop(context);
                                  preferences.setPhotoConsent(true);
                                  uploadPhoto();
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
        );
      },
    ) ?? false;
  }

  uploadPhoto() async {
    try {
      XFile? imagePicker = await chequePicker.pickImage(source: ImageSource.gallery);
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
              backgroundColor: colorBg,
            ),
          ],
        );

        if (cropped != null) {
          final bytes = File(cropped.path).readAsBytesSync();
          final bytesint = File(cropped.path).readAsBytesSync().lengthInBytes;
          cropKb = bytesint / 1024;
          cropMb = cropKb! / 1024;
          printLog("Bytes ==> $bytesint");
          printLog("cropKb ==> $cropKb");
          printLog("cropMb ==> $cropMb");
          chequeByteImageString = base64Encode(bytes);
          setState(() {
            chequeImage = File(cropped.path);
            if(cropMb! > 10){
              imageInMb = false;
            } else {
              imageInMb = true;
            }
          });
        }
      }
    } catch (e) {
      Utility().showPhotoPermissionDialog(context);
      printLog(e.toString());
    }
  }

}
