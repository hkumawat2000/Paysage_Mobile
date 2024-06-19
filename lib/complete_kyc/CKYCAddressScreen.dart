import 'dart:convert';
import 'dart:io';

// import 'package:awesome_dropdown/awesome_dropdown.dart';
import 'package:lms/additional_account_detail/AdditionalAccountDetailScreen.dart';
import 'package:lms/complete_kyc/CompleteKYCBloc.dart';
import 'package:lms/loan_renewal/LoanSummaryScreen.dart';
import 'package:lms/my_loan/MyLoansBloc.dart';
import 'package:lms/network/requestbean/ConsentDetailRequestBean.dart';
import 'package:lms/network/responsebean/AuthResponse/LoanDetailsResponse.dart';
import 'package:lms/new_dashboard/NewDashboardScreen.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import '../terms_conditions/TermsConditionWebView.dart';

class CKYCAddressScreen extends StatefulWidget {
  String ckycName;
  bool? isShowEdit; //used for loan renewal handling
  String? loanName;
  String? loanRenewalName;
  bool? forLoanRenewal;
  CKYCAddressScreen(this.ckycName, this.isShowEdit, this.loanName, this.loanRenewalName, this.forLoanRenewal);

  @override
  State<CKYCAddressScreen> createState() => _CKYCAddressScreenState();
}

class _CKYCAddressScreenState extends State<CKYCAddressScreen> {

  TextEditingController permAddressLine1Controller = TextEditingController();
  TextEditingController permAddressLine2Controller = TextEditingController();
  TextEditingController permAddressLine3Controller = TextEditingController();
  TextEditingController permCityController = TextEditingController();
  TextEditingController permPinCodeController = TextEditingController();
  TextEditingController permDistrictController = TextEditingController();
  TextEditingController permStateController = TextEditingController();
  TextEditingController corrAddressLine1Controller = TextEditingController();
  TextEditingController corrAddressLine2Controller = TextEditingController();
  TextEditingController corrAddressLine3Controller = TextEditingController();
  TextEditingController corrCityController = TextEditingController();
  TextEditingController corrPinCodeController = TextEditingController();
  TextEditingController corrDistrictController = TextEditingController();
  TextEditingController corrStateController = TextEditingController();
  TextEditingController permCountryController = TextEditingController();
  TextEditingController corrCountryController = TextEditingController();
  List<String> poaTypeList = [];
  List<String> countryList = [];
  String? consentText;
  String permPOATypeSelected = "POA TYPE";
  String corrPOATypeSelected = "POA TYPE";
  String? permByteImageString;
  String? corrByteImageString;
  final ImagePicker _permPicker = ImagePicker();
  final ImagePicker _corrPicker = ImagePicker();
  File? permPOAImage;
  String? permPOAImageNew;
  File? corrPOAImage;
  String? corrPOAImageNew;
  bool? corrCheckbox;
  bool consentCheckbox = true;
  bool corrCheckboxEnable = false;
  bool permFieldsEnable = false;
  bool corrFieldsEnable = false;
  bool isAPICalling = true;
  String isAPICallingText = Strings.please_wait;
  CompleteKYCBloc completeKYCBloc = CompleteKYCBloc();
  bool permValidatorAddress1 = true;
  bool permValidatorCity = true;
  bool permValidatorPinCode = true;
  bool permValidPinCode = true;
  bool permValidatorDistrict = true;
  bool permValidatorState = true;
  bool permValidatorCountry = true;
  bool permValidatorValidCountry = true;
  bool permValidatorPOAType = true;
  bool permValidatorPOAImage = true;
  bool permValidatorPOAImageSize = true;
  bool corrValidatorAddress1 = true;
  bool corrValidatorCity = true;
  bool corrValidatorPinCode = true;
  bool corrValidPinCode = true;
  bool corrValidatorDistrict = true;
  bool corrValidatorState = true;
  bool corrValidatorCountry = true;
  bool corrValidatorValidCountry = true;
  bool corrValidatorPOAType = true;
  bool corrValidatorPOAImage = true;
  bool corrValidatorPOAImageSize = true;
  Preferences preferences = new Preferences();
  String? permCountryValue;
  String? corrCountryValue;
  int permOnce = 1;
  int corrOnce = 1;
  ScrollController _permScrollController = ScrollController();
  ScrollController _corrScrollController = ScrollController();
  bool permIsBackPressedOrTouchedOutSide = false,
      permIsDropDownOpened = false;
  bool corrIsBackPressedOrTouchedOutSide = false,
      corrIsDropDownOpened = false;

  ScrollController _scrollController = new ScrollController();
  final myLoansBloc = MyLoansBloc();
  Loan? loan;

  @override
  void initState() {
    getConsentAPICall();
    preferences.setOkClicked(false);
    scrollListener();
    super.initState();
  }


  // used to close the poa type dropdown when clicked outside or scrolled outside of dropdown (call on every tap of widget in this file)
  scrollListener(){
    _scrollController.addListener(() {
      if (permIsDropDownOpened) {
        setState(() {
          permIsBackPressedOrTouchedOutSide = true;
        });
      }
      if (corrIsDropDownOpened) {
        setState(() {
          corrIsBackPressedOrTouchedOutSide = true;
        });
      }
      FocusScope.of(context).unfocus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        if (permIsDropDownOpened) {
          setState(() {
            permIsBackPressedOrTouchedOutSide = true;
          });
        }
        if (corrIsDropDownOpened) {
          setState(() {
            corrIsBackPressedOrTouchedOutSide = true;
          });
        }
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(

        onWillPop: () async {
          if (permIsDropDownOpened) {
            setState(() {
              permIsBackPressedOrTouchedOutSide = true;
            });
          }
          if (corrIsDropDownOpened) {
            setState(() {
              corrIsBackPressedOrTouchedOutSide = true;
            });
          }
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
                if (permIsDropDownOpened) {
                  setState(() {
                    permIsBackPressedOrTouchedOutSide = true;
                  });
                }
                if (corrIsDropDownOpened) {
                  setState(() {
                    corrIsBackPressedOrTouchedOutSide = true;
                  });
                }
                Navigator.pop(context);
              }
            ),
          ),
          body: isAPICalling ? Center(child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(isAPICallingText),
            ],
          )): SingleChildScrollView(
            controller: _scrollController,
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
    );
  }

  //Permanent address field
  Widget permanentAddressFields(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
        color: colorBg,
          border: Border.all(color: colorBlack)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10,top: 10, bottom: 10),
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
                  children: [
                    permCity(),
                    SizedBox(width: 10),
                    permPinCode()
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    permDistrict(),
                    SizedBox(width: 10),
                    permState()
                  ],
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
                    widget.isShowEdit! ? permEditButton() : Container(),
                    SizedBox(width: 10),
                    widget.isShowEdit! ? permSubmitButton() : Container()
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
  Widget correspondingAddressFields(){
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 10, right: 10),
      decoration: BoxDecoration(
          color: colorBg,
          border: Border.all(color: colorBlack)
      ),
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
                  children: [
                    corrCity(),
                    SizedBox(width: 10),
                    corrPinCode()
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    corrDistrict(),
                    SizedBox(width: 10),
                    corrState()
                  ],
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
                    widget.isShowEdit! ? corrEditButton() : Container(),
                    SizedBox(width: 10),
                    widget.isShowEdit! ? corrSubmitButton() : Container()
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
                value: consentCheckbox,
                onChanged: (value){
                  setState(() {
                    consentCheckbox = value!;
                      if (permIsDropDownOpened) {
                        setState(() {
                          permIsBackPressedOrTouchedOutSide = true;
                        });
                      }
                      if (corrIsDropDownOpened) {
                        setState(() {
                          corrIsBackPressedOrTouchedOutSide = true;
                        });
                      }
                  });
                },
              ),
              Expanded(child: Text(consentText!, style: regularTextStyle_14_gray_dark)),
            ],
          ),
          SizedBox(height: 20),
          Container(
            height: 45,
            width: 100,
            child: Material(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
              elevation: 1.0,
              color: widget.isShowEdit! ? !permFieldsEnable && permPOATypeSelected != "POA TYPE" && permValidatorPOAImageSize && !corrCheckboxEnable && permPOAImage != null
                  && !corrFieldsEnable && corrPOATypeSelected != "POA TYPE" && corrValidatorPOAImageSize && consentCheckbox && corrPOAImage != null ? appTheme : colorLightGray : consentCheckbox ? appTheme : colorLightGray,
              child: MaterialButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                minWidth: MediaQuery.of(context).size.width,
                onPressed: () async {
                  Utility.isNetworkConnection().then((isNetwork) {
                    if (isNetwork) {
                      if (permIsDropDownOpened) {
                        setState(() {
                          permIsBackPressedOrTouchedOutSide = true;
                        });
                      }
                      if (corrIsDropDownOpened) {
                        setState(() {
                          corrIsBackPressedOrTouchedOutSide = true;
                        });
                      }
                      if(widget.isShowEdit!){
                        if( !permFieldsEnable && permPOATypeSelected != "POA TYPE" && permValidatorPOAImageSize && !corrCheckboxEnable && permPOAImage != null
                            && !corrFieldsEnable && corrPOATypeSelected != "POA TYPE" && corrValidatorPOAImageSize && consentCheckbox && corrPOAImage != null){
                          saveConsentAPICall();
                        } else {
                          Utility.showToastMessage("Please submit the data or rectify error(s), if any.");
                        }
                      } else {
                        if(consentCheckbox){
                          Navigator.push(context, MaterialPageRoute(builder: (context) => LoanSummaryScreen(false, widget.loanRenewalName, widget.loanName!)));
                        }else{
                          Utility.showToastMessage("Please submit the data or rectify error(s), if any.");
                        }
                      }
                    } else {
                      Utility.showToastMessage(Strings.no_internet_message);
                    }
                  });
                },
                child: Text(Strings.ok, style: TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold),),
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
      controller: permAddressLine1Controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      enabled: true,
      readOnly: !permFieldsEnable,
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
        errorText: permValidatorAddress1
            ? null
            : '*Mandatory',
      ),
      onChanged: (value){
        setState(() {
          permValidatorAddress1 = true;
        });
      },
      onTap: () {
        if (permIsDropDownOpened) {
          setState(() {
            permIsBackPressedOrTouchedOutSide = true;
          });
        }
        if (corrIsDropDownOpened) {
          setState(() {
            corrIsBackPressedOrTouchedOutSide = true;
          });
        }
      },
    );
  }

  Widget permAddressLineNumber2() {
    return TextField(
      controller: permAddressLine2Controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      enabled: true,
      readOnly: !permFieldsEnable,
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
        if (permIsDropDownOpened) {
          setState(() {
            permIsBackPressedOrTouchedOutSide = true;
          });
        }
        if (corrIsDropDownOpened) {
          setState(() {
            corrIsBackPressedOrTouchedOutSide = true;
          });
        }
      },
    );
  }

  Widget permAddressLineNumber3() {
    return TextField(
      controller: permAddressLine3Controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      enabled: true,
      readOnly: !permFieldsEnable,
      decoration: new InputDecoration(
        counterText: "",
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        disabledBorder: new OutlineInputBorder(
          borderSide: new BorderSide(color: Colors.grey),
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        focusedBorder:OutlineInputBorder(
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
        if (permIsDropDownOpened) {
          setState(() {
            permIsBackPressedOrTouchedOutSide = true;
          });
        }
        if (corrIsDropDownOpened) {
          setState(() {
            corrIsBackPressedOrTouchedOutSide = true;
          });
        }
      },
    );
  }

  Widget permCity() {
    return Expanded(
      child: TextField(
        controller: permCityController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.name,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[A-Za-z]')),
        ],
        enabled: true,
        readOnly: !permFieldsEnable,
        decoration: new InputDecoration(
          counterText: "",
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
          disabledBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.grey),
            borderRadius: BorderRadius.all(Radius.circular(4)),
          ),
          focusedBorder:OutlineInputBorder(
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
          errorText: permValidatorCity
              ? null
              : '*Mandatory',
        ),
        onChanged: (value){
          setState(() {
            permValidatorCity = true;
          });
        },
        onTap: () {
          if (permIsDropDownOpened) {
            setState(() {
              permIsBackPressedOrTouchedOutSide = true;
            });
          }
          if (corrIsDropDownOpened) {
            setState(() {
              corrIsBackPressedOrTouchedOutSide = true;
            });
          }
        },
      ),
    );
  }

  Widget permPinCode() {
    return Expanded(
      child: TextField(
        controller: permPinCodeController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.number,
        enabled: true,
        readOnly: !permFieldsEnable,
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
          focusedBorder:OutlineInputBorder(
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
          errorText: permValidatorPinCode
              ? permValidPinCode ? null : "*Invalid Pin Code"
              : '*Mandatory',
        ),
        onChanged: (value) {
          permValidPinCode = true;
          permValidatorPinCode = true;
          if(value.toString().trim().length == 6){
            FocusScope.of(context).unfocus();
            callAPIToGetPinCode(Strings.permanent_address, permPinCodeController.text.toString().trim());
          } else {
            setState(() {
              permDistrictController.text = "";
              permStateController.text = "";
            });
          }
        },
        onTap: () {
          if (permIsDropDownOpened) {
            setState(() {
              permIsBackPressedOrTouchedOutSide = true;
            });
          }
          if (corrIsDropDownOpened) {
            setState(() {
              corrIsBackPressedOrTouchedOutSide = true;
            });
          }
        },
      ),
    );
  }

  Widget permDistrict() {
    return Expanded(
      child: TextField(
        controller: permDistrictController,
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
          focusedBorder:OutlineInputBorder(
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
          errorText: permValidatorDistrict
              ? null
              : '*Mandatory',
        ),
        onChanged: (value){
          setState(() {
            permValidatorDistrict = true;
          });
        },
        onTap: () {
          if (permIsDropDownOpened) {
            setState(() {
              permIsBackPressedOrTouchedOutSide = true;
            });
          }
          if (corrIsDropDownOpened) {
            setState(() {
              corrIsBackPressedOrTouchedOutSide = true;
            });
          }
        },
      ),
    );
  }

  Widget permState() {
    return Expanded(
      child: TextField(
        controller: permStateController,
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
          focusedBorder:OutlineInputBorder(
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
          errorText: permValidatorState
              ? null
              : '*Mandatory',
        ),
        onChanged: (value){
          setState(() {
            permValidatorState = true;
          });
        },
        onTap: () {
          if (permIsDropDownOpened) {
            setState(() {
              permIsBackPressedOrTouchedOutSide = true;
            });
          }
          if (corrIsDropDownOpened) {
            setState(() {
              corrIsBackPressedOrTouchedOutSide = true;
            });
          }
        },
      ),
    );
  }

  String capitalize(String s) {  //kajal tiwari ==> Kajal Tiwari
    List<String> splitList = s.split(" ");
    String capString = "";
    for(int i=0; i< splitList.length ; i++){
      capString = capString + splitList[i][0].toUpperCase() + splitList[i].substring(1).toLowerCase() + " ";
    }
    return capString.trim();
  }

  Widget permCountry() {
    return Expanded(
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return countryList.where((String option) {
            return permFieldsEnable ? option.toString().toLowerCase().trim().contains(textEditingValue.text.toString().toLowerCase().trim()) : false;
          });
        },
        displayStringForOption: (String option) {
          return permFieldsEnable ? option.toString() : "";
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController countryController,
            fieldFocusNode,
            onFieldSubmitted) {
          permCountryController = countryController;
          if(permOnce == 1){
            permCountryController.text = permCountryValue!;
            permOnce++;
          }
          return TextField(
            controller: countryController,
            focusNode: fieldFocusNode,
            enabled: true,
            readOnly: !permFieldsEnable,
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
              errorText: permValidatorCountry
                  ? permValidatorValidCountry ? null : "*Invalid Country"
                  : '*Mandatory',
            ),
            onChanged: (value){
              setState(() {
                permValidatorCountry = true;
                for(int i=0; i<countryList.length; i++){
                  if(permCountryController.text.toString().trim().isNotEmpty && countryList[i].contains(capitalize(permCountryController.text.toString().trim()))|| permCountryController.text.toString().trim().isEmpty){
                    permValidatorValidCountry = true;
                    return;
                  } else {
                    permValidatorValidCountry = false;
                  }
                }
              });
            },
            onTap: () {
              if (permIsDropDownOpened) {
                setState(() {
                  permIsBackPressedOrTouchedOutSide = true;
                });
              }
              if (corrIsDropDownOpened) {
                setState(() {
                  corrIsBackPressedOrTouchedOutSide = true;
                });
              }
            },
          );
        },
        onSelected: (String selection) {
          FocusScope.of(context).unfocus();
          setState(() {
            permValidatorCountry = true;
            permValidatorValidCountry = true;
            if(countryList.contains(permCountryController.text.toString().trim())){
              permValidatorValidCountry = true;
            } else {
              permValidatorValidCountry = false;
            }
          });
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
                    controller: _permScrollController,
                    //isAlwaysShown: true,
                    child: ListView.builder(
                      controller: _permScrollController,
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
          // widget.isShowEdit! ? Container(
          //   height: 32,
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: AwesomeDropDown(
          //       isBackPressedOrTouchedOutSide: permIsBackPressedOrTouchedOutSide,
          //       dropDownList: poaTypeList,
          //       dropDownIcon: Image.asset(AssetsImagePath.down_arrow, height: 20, width: 20),
          //       selectedItem: permPOATypeSelected,
          //       dropDownListTextStyle: TextStyle(color: colorLightGray, fontSize: 18),
          //       onDropDownItemClick: (selectedItem) {
          //         setState(() {
          //           permValidatorPOAType = true;
          //           permPOATypeSelected = selectedItem;
          //         });
          //       },
          //       dropDownBottomBorderRadius: 2,
          //       dropDownTopBorderRadius: 2,
          //       dropDownBGColor: colorBg,
          //       elevation: 0,
          //       padding: 1,
          //       dropDownOverlayBGColor: colorBg,
          //       dropStateChanged: (isOpened) {
          //         FocusScope.of(context).unfocus();
          //         permIsDropDownOpened = isOpened;
          //         if (!isOpened) {
          //           permIsBackPressedOrTouchedOutSide = false;
          //         }
          //       },
          //     ),
          //   ),
           Row(
            children: [
              Column(
                children: [
                  Container(
                      height: 32,
                      width : 90,
                      child: SingleChildScrollView(child: Text(permPOATypeSelected, style: TextStyle(color: colorBlack, fontSize: 16)))),
                ],
              ),
              SizedBox(width : 20),
              Image.asset(AssetsImagePath.down_arrow, height: 20, width: 20)
            ],
          ),
          SizedBox(height: 5),
          Visibility(
            visible: !permValidatorPOAType,
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
              widget.isShowEdit! ? GestureDetector(
                onTap: (){
                  Utility.isNetworkConnection().then((isNetwork) async {
                    if (isNetwork) {
                      bool photoConsent = await preferences.getPhotoConsent();
                      if(!photoConsent) {
                        permPermissionYesNoDialog(context);
                      }else{
                        permUploadPhoto();
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
                  child: Text("Browse"),
                ),
              ): Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colorBlack),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.all(4),
                child: Text("Browse"),
              ),
              SizedBox(width: 6),
              widget.isShowEdit! ? permByteImageString != null && permByteImageString!.isNotEmpty
                  ? SizedBox(width: 60, height: 25, child: Image.file(permPOAImage!,fit: BoxFit.fill))
                  : SizedBox() : SizedBox(width: 60, height: 25, child: Image.network(permPOAImageNew!,fit: BoxFit.fill)),
            ],
          ),
          SizedBox(height: 5),
          Visibility(
            visible: !permValidatorPOAImage,
            child: Text("*Please upload proof", style: TextStyle(color: red)),
          ),
          Visibility(
            visible: !permValidatorPOAImageSize,
            child: Text("*Image should be less than 10MB", style: TextStyle(color: red)),
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
                                  permUploadPhoto();
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

  permUploadPhoto() async{
    try {
      if (permIsDropDownOpened) {
        setState(() {
          permIsBackPressedOrTouchedOutSide = true;
        });
      }
      if (corrIsDropDownOpened) {
        setState(() {
          corrIsBackPressedOrTouchedOutSide = true;
        });
      }
      XFile? imagePicker = await _permPicker.pickImage(source: ImageSource.gallery);
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
          permByteImageString = base64Encode(bytes);
          setState(() {
            permValidatorPOAImage = true;
            if(cropMb > 10){
              permValidatorPOAImageSize = false;
            } else {
              permValidatorPOAImageSize = true;
            }
            permPOAImage = File(cropped.path);
          });
        }
      }
    } catch (e) {
      Utility().showPhotoPermissionDialog(context);
      printLog(e.toString());
    }
  }

  Widget permEditButton() {
    return Expanded(
      child: Container(
        height: 45,
        width: 100,
        child: Material(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          elevation: 1.0,
          color: appTheme,
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            onPressed: () async {
              Utility.isNetworkConnection().then((isNetwork) {
                if (isNetwork) {
                  setState(() {
                    resetPermField();
                      if (permIsDropDownOpened) {
                        setState(() {
                          permIsBackPressedOrTouchedOutSide = true;
                        });
                      }
                      if (corrIsDropDownOpened) {
                        setState(() {
                          corrIsBackPressedOrTouchedOutSide = true;
                        });
                      }
                  });
                } else {
                  Utility.showToastMessage(Strings.no_internet_message);
                }
              });
            },
            child: Text("Edit", style: TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold),),
          ),
        ),
      ),
    );
  }

  resetPermField(){
    permFieldsEnable = true;
    permAddressLine1Controller.text = "";
    permAddressLine2Controller.text = "";
    permAddressLine3Controller.text = "";
    permCityController.text = "";
    permPinCodeController.text = "";
    permDistrictController.text = "";
    permStateController.text = "";
    permCountryController.text = "";
    permPOATypeSelected = "POA TYPE";
    permByteImageString = null;
    permPOAImage = null;
    permValidatorAddress1 = true;
    permValidatorCity = true;
    permValidatorPinCode = true;
    permValidatorDistrict = true;
    permValidatorState = true;
    permValidatorCountry = true;
    permValidatorValidCountry = true;
    permValidatorPOAImage = true;
    permValidatorPOAImageSize = true;
    permValidatorPOAType = true;
  }

  Widget permSubmitButton() {
    return Expanded(
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
            onPressed: () async {
              Utility.isNetworkConnection().then((isNetwork) async {
                if (isNetwork) {
                  if (permIsDropDownOpened) {
                    setState(() {
                      permIsBackPressedOrTouchedOutSide = true;
                    });
                  }
                  if (corrIsDropDownOpened) {
                    setState(() {
                      corrIsBackPressedOrTouchedOutSide = true;
                    });
                  }
                 bool validate = await validatePermAddressFields();
                 if(validate){
                   permFieldsEnable = false;
                 }
                } else {
                  Utility.showToastMessage(Strings.no_internet_message);
                }
              });
            },
            child: Text(Strings.submit, style: TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold),),
          ),
        ),
      ),
    );
  }

  Future<bool> validatePermAddressFields() async {
    bool allValidated = true;
    setState(() {
      permValidatorAddress1 = true;
      permValidatorCity = true;
      permValidatorPinCode = true;
      permValidatorDistrict = true;
      permValidatorState = true;
      permValidatorCountry = true;
      permValidatorValidCountry = true;
      permValidatorPOAType = true;
      permValidatorPOAImage = true;

      if(permAddressLine1Controller.text.toString().trim().isEmpty){
        permValidatorAddress1 = false;
        allValidated = false;
      }
      if(permCityController.text.toString().trim().isEmpty){
        permValidatorCity = false;
        allValidated = false;
      }
      if(permPinCodeController.text.toString().trim().isEmpty){
        permValidatorPinCode = false;
        allValidated = false;
      }
      if(permDistrictController.text.toString().trim().isEmpty){
        permValidatorDistrict = false;
        allValidated = false;
      }
      if(permStateController.text.toString().trim().isEmpty){
        permValidatorState = false;
        allValidated = false;
      }
      if(permCountryController.text.toString().trim().isEmpty){
        permValidatorCountry = false;
        allValidated = false;
      }
      if(permCountryController.text.isNotEmpty && !countryList.contains(permCountryController.text.toString().trim())){
        permValidatorValidCountry = false;
        allValidated = false;
      }
      if(permPOATypeSelected == "POA TYPE" || permPOATypeSelected.isEmpty){
        permValidatorPOAType = false;
        allValidated = false;
      }
      if(permByteImageString == null || permByteImageString!.isEmpty){
        permValidatorPOAImage = false;
        allValidated = false;
      }
      if(!permValidatorPOAImageSize){
        allValidated = false;
      }
    });
    return allValidated;
  }


  //Widgets for Corresponding Address

  Widget corrCheckBox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        AbsorbPointer(
          absorbing: !corrCheckboxEnable,
          child: Checkbox(
            value: corrCheckbox,
            onChanged: (value){
              setState(() {
                corrCheckbox = value!;
                if(value){
                  corrFieldsEnable = true;
                    if (permIsDropDownOpened) {
                      setState(() {
                        permIsBackPressedOrTouchedOutSide = true;
                      });
                    }
                    if (corrIsDropDownOpened) {
                      setState(() {
                        corrIsBackPressedOrTouchedOutSide = true;
                      });
                    }
                  corrAddressLine1Controller.text = permAddressLine1Controller.text;
                  corrAddressLine2Controller.text = permAddressLine2Controller.text;
                  corrAddressLine3Controller.text = permAddressLine3Controller.text;
                  corrCityController.text = permCityController.text;
                  corrPinCodeController.text = permPinCodeController.text;
                  corrDistrictController.text = permDistrictController.text;
                  corrStateController.text = permStateController.text;
                  corrCountryController.text = permCountryController.text;
                  corrPOATypeSelected = permPOATypeSelected;
                  corrByteImageString = permByteImageString;
                  corrPOAImage = permPOAImage;
                  corrValidatorPOAImageSize = permValidatorPOAImageSize;
                  validateCorrAddressFields();
                } else {
                  resetCorrField();
                }
              });
            },
          ),
        ),
        Text("Same as Permanent Address", style: regularTextStyle_18)
      ],
    );
  }

  resetCorrField(){
    corrFieldsEnable = true;
    corrAddressLine1Controller.text = "";
    corrAddressLine2Controller.text = "";
    corrAddressLine3Controller.text = "";
    corrCityController.text = "";
    corrPinCodeController.text = "";
    corrDistrictController.text = "";
    corrStateController.text = "";
    corrCountryController.text = "";
    corrPOATypeSelected = "POA TYPE";
    corrByteImageString = null;
    corrPOAImage = null;
    corrValidatorAddress1 = true;
    corrValidatorCity = true;
    corrValidatorPinCode = true;
    corrValidatorDistrict = true;
    corrValidatorState = true;
    corrValidatorCountry = true;
    corrValidatorValidCountry = true;
    corrValidatorPOAImage = true;
    corrValidatorPOAImageSize = true;
    corrValidatorPOAType = true;
  }

  Widget corrAddressLineNumber1() {
    return TextField(
      controller: corrAddressLine1Controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      enabled: true,
      readOnly: !corrFieldsEnable,
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
        errorText: corrValidatorAddress1
            ? null
            : '*Mandatory',
      ),
      onChanged: (value){
        setState(() {
          corrValidatorAddress1 = true;
        });
      },
      onTap: () {
        if (permIsDropDownOpened) {
          setState(() {
            permIsBackPressedOrTouchedOutSide = true;
          });
        }
        if (corrIsDropDownOpened) {
          setState(() {
            corrIsBackPressedOrTouchedOutSide = true;
          });
        }
      },
    );
  }

  Widget corrAddressLineNumber2() {
    return TextField(
      controller: corrAddressLine2Controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      enabled: true,
      readOnly: !corrFieldsEnable,
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
        if (permIsDropDownOpened) {
          setState(() {
            permIsBackPressedOrTouchedOutSide = true;
          });
        }
        if (corrIsDropDownOpened) {
          setState(() {
            corrIsBackPressedOrTouchedOutSide = true;
          });
        }
      },
    );
  }

  Widget corrAddressLineNumber3() {
    return TextField(
      controller: corrAddressLine3Controller,
      textCapitalization: TextCapitalization.sentences,
      keyboardType: TextInputType.name,
      enabled: true,
      readOnly: !corrFieldsEnable,
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
        if (permIsDropDownOpened) {
          setState(() {
            permIsBackPressedOrTouchedOutSide = true;
          });
        }
        if (corrIsDropDownOpened) {
          setState(() {
            corrIsBackPressedOrTouchedOutSide = true;
          });
        }
      },
    );
  }

  Widget corrCity() {
    return Expanded(
      child: TextField(
        controller: corrCityController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.name,
        enabled: true,
        readOnly: !corrFieldsEnable,
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
          errorText: corrValidatorCity
              ? null
              : '*Mandatory',
        ),
        onChanged: (value){
          setState(() {
            corrValidatorCity = true;
          });
        },
        onTap: () {
          if (permIsDropDownOpened) {
            setState(() {
              permIsBackPressedOrTouchedOutSide = true;
            });
          }
          if (corrIsDropDownOpened) {
            setState(() {
              corrIsBackPressedOrTouchedOutSide = true;
            });
          }
        },
      ),
    );
  }

  Widget corrPinCode() {
    return Expanded(
      child: TextField(
        controller: corrPinCodeController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.number,
        maxLength: 6,
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp('[0-9]')),
        ],
        enabled: true,
        readOnly: !corrFieldsEnable,
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
          errorText: corrValidatorPinCode
              ? corrValidPinCode ? null : "*Invalid Pin Code"
              : '*Mandatory',
        ),
        onChanged: (value) {
          corrValidPinCode = true;
          corrValidatorPinCode = true;
          if(value.toString().trim().length == 6){
            FocusScope.of(context).unfocus();
            callAPIToGetPinCode(Strings.corresponding_address, corrPinCodeController.text.toString().trim());
          } else {
            setState(() {
              corrDistrictController.text = "";
              corrStateController.text = "";
            });
          }
        },
        onTap: () {
          if (permIsDropDownOpened) {
            setState(() {
              permIsBackPressedOrTouchedOutSide = true;
            });
          }
          if (corrIsDropDownOpened) {
            setState(() {
              corrIsBackPressedOrTouchedOutSide = true;
            });
          }
        },
      ),
    );
  }

  Widget corrDistrict() {
    return Expanded(
      child: TextField(
        controller: corrDistrictController,
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
          errorText: corrValidatorDistrict
              ? null
              : '*Mandatory',
        ),
        onChanged: (value){
          setState(() {
            corrValidatorDistrict = true;
          });
        },
        onTap: () {
          if (permIsDropDownOpened) {
            setState(() {
              permIsBackPressedOrTouchedOutSide = true;
            });
          }
          if (corrIsDropDownOpened) {
            setState(() {
              corrIsBackPressedOrTouchedOutSide = true;
            });
          }
        },
      ),
    );
  }

  Widget corrState() {
    return Expanded(
      child: TextField(
        controller: corrStateController,
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
          errorText: corrValidatorState
              ? null
              : '*Mandatory',
        ),
        onChanged: (value){
          setState(() {
            corrValidatorState = true;
          });
        },
        onTap: () {
          if (permIsDropDownOpened) {
            setState(() {
              permIsBackPressedOrTouchedOutSide = true;
            });
          }
          if (corrIsDropDownOpened) {
            setState(() {
              corrIsBackPressedOrTouchedOutSide = true;
            });
          }
        },
      ),
    );
  }

  Widget corrCountry() {
    return Expanded(
      child: Autocomplete<String>(
        optionsBuilder: (TextEditingValue textEditingValue) {
          return countryList.where((String option) {
            return corrFieldsEnable ? option.toString().toLowerCase().contains(textEditingValue.text.toString().toLowerCase().trim()) : false;
          });
        },
        displayStringForOption: (String option) {
          return option.toString();
        },
        fieldViewBuilder: (BuildContext context,
            TextEditingController countryController,
            fieldFocusNode,
            onFieldSubmitted) {
          corrCountryController = countryController;
          if(corrOnce == 1){
            corrCountryController.text = corrCountryValue!;
            corrOnce++;
          }
          return TextField(
            controller: countryController,
            focusNode: fieldFocusNode,
            enabled: true,
            readOnly: !corrFieldsEnable,
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
              errorText: corrValidatorCountry
                  ? corrValidatorValidCountry ? null : "*Invalid Country"
                  : '*Mandatory',
            ),
            onChanged: (value){
              setState(() {
                corrValidatorCountry = true;
                for(int i=0; i<countryList.length; i++){
                  if(corrCountryController.text.toString().trim().isNotEmpty && countryList[i].contains(capitalize(corrCountryController.text.toString().trim())) || corrCountryController.text.toString().trim().isEmpty){
                    corrValidatorValidCountry = true;
                    return;
                  } else {
                    corrValidatorValidCountry = false;
                  }
                }
              });
            },
            onTap: () {
              if (permIsDropDownOpened) {
                setState(() {
                  permIsBackPressedOrTouchedOutSide = true;
                });
              }
              if (corrIsDropDownOpened) {
                setState(() {
                  corrIsBackPressedOrTouchedOutSide = true;
                });
              }
            },
          );
        },
        onSelected: (String selection) {
          FocusScope.of(context).unfocus();
          setState(() {
            corrValidatorCountry = true;
            for(int i=0; i<countryList.length; i++){
              if(countryList[i].contains(corrCountryController.text.toString().trim())){
                corrValidatorValidCountry = true;
                return;
              } else {
                corrValidatorValidCountry = false;
              }
            }
          });
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
                  controller: _corrScrollController,
                  //isAlwaysShown: true,
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    controller: _corrScrollController,
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
          // widget.isShowEdit! ? Container(
          //   height: 32,
          //   child: Align(
          //     alignment: Alignment.centerLeft,
          //     child: AwesomeDropDown(
          //       isBackPressedOrTouchedOutSide: corrIsBackPressedOrTouchedOutSide,
          //       dropDownList: poaTypeList,
          //       dropDownIcon: Image.asset(AssetsImagePath.down_arrow, height: 20, width: 20),
          //       selectedItem: corrPOATypeSelected,
          //       dropDownListTextStyle: TextStyle(color: colorLightGray, fontSize: 18),
          //       onDropDownItemClick: (selectedItem) {
          //         setState(() {
          //           corrValidatorPOAType = true;
          //           corrPOATypeSelected = selectedItem;
          //         });
          //       },
          //       dropDownBottomBorderRadius: 2,
          //       dropDownTopBorderRadius: 2,
          //       dropDownBGColor: colorBg,
          //       elevation: 0,
          //       padding: 1,
          //       dropDownOverlayBGColor: colorBg,
          //       dropStateChanged: (isOpened) {
          //         corrIsDropDownOpened = isOpened;
          //         if (!isOpened) {
          //           corrIsBackPressedOrTouchedOutSide = false;
          //         }
          //       },
          //     ),
          //   ),
           Row(
            children: [
              Column(
                children: [
                  Container(
                      height: 32,
                      width : 90,
                      child: SingleChildScrollView(child: Text(corrPOATypeSelected, style: TextStyle(color: colorBlack, fontSize: 16)))),
                ],
              ),
              SizedBox(width : 20),
              Image.asset(AssetsImagePath.down_arrow, height: 20, width: 20)
            ],
          ),
          SizedBox(height: 5),
          Visibility(
            visible: !corrValidatorPOAType,
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
              widget.isShowEdit! ? GestureDetector(
                onTap: (){
                  Utility.isNetworkConnection().then((isNetwork) async {
                    if (isNetwork) {
                      bool photoConsent = await preferences.getPhotoConsent();
                      if(!photoConsent) {
                        corrPermissionYesNoDialog(context);
                      }else{
                        corrUploadPhoto();
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
                  child: Text("Browse"),
                ),
              ): Container(
                decoration: BoxDecoration(
                  border: Border.all(color: colorBlack),
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.all(4),
                child: Text("Browse"),
              ),
              SizedBox(width: 6),
              widget.isShowEdit! ? corrByteImageString != null && corrByteImageString!.isNotEmpty
                  ? SizedBox(width: 60, height: 25, child: Image.file(corrPOAImage!, fit: BoxFit.fill))
                  : SizedBox() : SizedBox(width: 60, height: 25, child: Image.network(corrPOAImageNew!,fit: BoxFit.fill)),
            ],
          ),
          SizedBox(height: 5),
          Visibility(
            visible: !corrValidatorPOAImage,
            child: Text("*Please upload proof", style: TextStyle(color: red)),
          ),
          Visibility(
            visible: !corrValidatorPOAImageSize,
            child: Text("*Image should be less than 10MB", style: TextStyle(color: red)),
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
                                  corrUploadPhoto();
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

  corrUploadPhoto() async{
    try {
      if (permIsDropDownOpened) {
        setState(() {
          permIsBackPressedOrTouchedOutSide = true;
        });
      }
      if (corrIsDropDownOpened) {
        setState(() {
          corrIsBackPressedOrTouchedOutSide = true;
        });
      }
      XFile? imagePicker = await _corrPicker.pickImage(source: ImageSource.gallery);
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
          corrByteImageString = base64Encode(bytes);
          setState(() {
            corrValidatorPOAImage = true;
            if(cropMb > 10){
              corrValidatorPOAImageSize = false;
            } else {
              corrValidatorPOAImageSize = true;
            }
            corrPOAImage = File(cropped.path);
          });
        }
      }
    } catch (e) {
      Utility().showPhotoPermissionDialog(context);
      printLog(e.toString());
    }
  }

  Widget corrEditButton() {
    return Expanded(
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
            onPressed: () async {
              Utility.isNetworkConnection().then((isNetwork) {
                if (isNetwork) {
                  setState(() {
                    corrCheckboxEnable = true;
                    corrFieldsEnable = true;
                      if (permIsDropDownOpened) {
                        setState(() {
                          permIsBackPressedOrTouchedOutSide = true;
                        });
                      }
                      if (corrIsDropDownOpened) {
                        setState(() {
                          corrIsBackPressedOrTouchedOutSide = true;
                        });
                      }
                  });
                } else {
                  Utility.showToastMessage(Strings.no_internet_message);
                }
              });
            },
            child: Text("Edit", style: TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold),),
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
          elevation: 1.0,
          color: appTheme,
          child: MaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            minWidth: MediaQuery.of(context).size.width,
            onPressed: () async {
              Utility.isNetworkConnection().then((isNetwork) async {
                if (isNetwork) {

                    if (permIsDropDownOpened) {
                      setState(() {
                        permIsBackPressedOrTouchedOutSide = true;
                      });
                    }
                    if (corrIsDropDownOpened) {
                      setState(() {
                        corrIsBackPressedOrTouchedOutSide = true;
                      });
                    }
                  bool validation = await validateCorrAddressFields();
                  if(validation){
                    corrFieldsEnable = false;
                    corrCheckboxEnable = false;
                  }
                } else {
                  Utility.showToastMessage(Strings.no_internet_message);
                }
              });
            },
            child: Text("Submit", style: TextStyle(color: colorWhite, fontSize: 16, fontWeight: FontWeight.bold),),
          ),
        ),
      ),
    );
  }

  Future<bool> validateCorrAddressFields() async {
    bool allValidated = true;
    setState(() {
      corrValidatorAddress1 = true;
      corrValidatorCity = true;
      corrValidatorPinCode = true;
      corrValidatorDistrict = true;
      corrValidatorState = true;
      corrValidatorCountry = true;
      corrValidatorValidCountry = true;
      corrValidatorPOAType = true;
      corrValidatorPOAImage = true;

      if(corrAddressLine1Controller.text.toString().trim().isEmpty){
        corrValidatorAddress1 = false;
        allValidated = false;
      }
      if(corrCityController.text.toString().trim().isEmpty){
        corrValidatorCity = false;
        allValidated = false;
      }
      if(corrPinCodeController.text.toString().trim().isEmpty){
        corrValidatorPinCode = false;
        allValidated = false;
      }
      if(corrDistrictController.text.toString().trim().isEmpty){
        corrValidatorDistrict = false;
        allValidated = false;
      }
      if(corrStateController.text.toString().trim().isEmpty){
        corrValidatorState = false;
        allValidated = false;
      }
      if(corrCountryController.text.toString().trim().isEmpty){
        corrValidatorCountry = false;
        allValidated = false;
      }
      if(corrCountryController.text.isNotEmpty &&!countryList.contains(corrCountryController.text.toString().trim())){
        corrValidatorValidCountry = false;
        allValidated = false;
      }
      if(corrPOATypeSelected == "POA TYPE" || corrPOATypeSelected.isEmpty){
        corrValidatorPOAType = false;
        allValidated = false;
      }
      if(corrByteImageString == null || corrByteImageString!.isEmpty){
        corrValidatorPOAImage = false;
        allValidated = false;
      }
      if(!corrValidatorPOAImageSize){
        allValidated = false;
      }
    });
    return allValidated;
  }

  callAPIToGetPinCode(String isComingFrom, String pinCode){
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    completeKYCBloc.getPinCodeDetails(pinCode).then((value) {
      Navigator.pop(context);
      if(value.isSuccessFull!){
        setState(() {
          if(isComingFrom == Strings.permanent_address){
            permDistrictController.text = value.data!.district!;
            permStateController.text = value.data!.state!;
            permValidatorDistrict = true;
            permValidatorState = true;
          } else {
            corrDistrictController.text = value.data!.district!;
            corrStateController.text = value.data!.state!;
            corrValidatorDistrict = true;
            corrValidatorState = true;
          }
        });
      } else if(value.errorCode == 403){
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        setState(() {
          if(isComingFrom == Strings.permanent_address){
            permValidPinCode = false;
          } else {
            corrValidPinCode = false;
          }
        });
      }
    });
  }

  // call consent api with ckyc name and loanrenewal - 0/1
  getConsentAPICall(){
    completeKYCBloc.consentDetails(ConsentDetailRequestBean(userKycName: widget.ckycName, isLoanRenewal: 0)).then((value) {
      if(value.isSuccessFull!){
        setState(() {
          permAddressLine1Controller.text = value.data!.userKycDoc!.permLine1!;
          permAddressLine2Controller.text = value.data!.userKycDoc!.permLine2!;
          permAddressLine3Controller.text = value.data!.userKycDoc!.permLine3!;
          permCityController.text = value.data!.userKycDoc!.permCity!;
          permPinCodeController.text = value.data!.userKycDoc!.permPin!;
          permDistrictController.text = value.data!.userKycDoc!.permDist!;
          permStateController.text = value.data!.userKycDoc!.permStateName!;
          permCountryController.text = value.data!.userKycDoc!.permCountryName!;
          permCountryValue = value.data!.userKycDoc!.permCountryName!;
          if(!widget.isShowEdit! && value.data!.address != null && value.data!.address!.toString().isNotEmpty) {
            permPOATypeSelected = value.data!.address!.permPoa!;
            permPOAImageNew = value.data!.address!.permImage!;
          }
          corrAddressLine1Controller.text = value.data!.userKycDoc!.corresLine1!;
          corrAddressLine2Controller.text = value.data!.userKycDoc!.corresLine2!;
          corrAddressLine3Controller.text = value.data!.userKycDoc!.corresLine3!;
          corrCityController.text = value.data!.userKycDoc!.corresCity!;
          corrPinCodeController.text = value.data!.userKycDoc!.corresPin!;
          corrDistrictController.text = value.data!.userKycDoc!.corresDist!;
          corrStateController.text = value.data!.userKycDoc!.corresStateName!;
          corrCountryController.text = value.data!.userKycDoc!.corresCountryName!;
          corrCountryValue = value.data!.userKycDoc!.corresCountryName!;
          if(!widget.isShowEdit! && value.data!.address != null && value.data!.address!.toString().isNotEmpty) {
            corrPOATypeSelected = value.data!.address!.corresPoa!;
            corrPOAImageNew = value.data!.address!.corresPoaImage!;
          }
          poaTypeList = value.data!.poaType!.toSet().toList();
          countryList = value.data!.country!;
          consentText = value.data!.consentDetails!.consent;
          corrCheckbox = value.data!.userKycDoc!.permCorresSameflag!.toLowerCase() == "y" ? true : false;
          isAPICalling = false;
        });
      } else if(value.errorCode == 403){
        setState(() {
          isAPICalling = true;
          isAPICallingText = value.errorMessage!;
        });
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
        setState(() {
          isAPICalling = true;
          isAPICallingText = value.errorMessage!;
        });
      }
    });
  }

  saveConsentAPICall(){
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    ConsentDetailRequestBean consentDetailRequestBean = ConsentDetailRequestBean(
      userKycName: widget.ckycName,
      acceptTerms: consentCheckbox ? 1 : 0,
      addressDetails: AddressDetails(
        permanentAddress: PermanentAddress(
          addressLine1: permAddressLine1Controller.text.toString(),
          addressLine2: permAddressLine2Controller.text.toString(),
          addressLine3: permAddressLine3Controller.text.toString(),
          city: permCityController.text.toString(),
          pinCode: permPinCodeController.text.toString(),
          district: permDistrictController.text.toString(),
          state: permStateController.text.toString(),
          country: permCountryController.text.toString(),
          poaType: permPOATypeSelected,
          addressProofImage: permByteImageString,
        ),
        permCorresFlag: corrCheckbox! ? "yes" : "no",
        correspondingAddress: PermanentAddress(
          addressLine1: corrAddressLine1Controller.text.toString(),
          addressLine2: corrAddressLine2Controller.text.toString(),
          addressLine3: corrAddressLine3Controller.text.toString(),
          city: corrCityController.text.toString(),
          pinCode: corrPinCodeController.text.toString(),
          district: corrDistrictController.text.toString(),
          state: corrStateController.text.toString(),
          country: corrCountryController.text.toString(),
          poaType: corrPOATypeSelected,
          addressProofImage: corrByteImageString,
        )
      ),
        isLoanRenewal: 0
    );
    completeKYCBloc.consentDetails(consentDetailRequestBean).then((value) {
      Navigator.pop(context);
      if(value.isSuccessFull!){
        preferences.setOkClicked(true);
        showDialogOnCKYCSuccess(value.message!);
      } else if(value.errorCode == 403){
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        commonDialog(context, value.errorMessage!, 0);
      }
    });
  }

  showDialogOnCKYCSuccess(String msg) {
    return showDialog<void>(
      barrierDismissible: false,
      context: context,
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
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
                        minWidth: MediaQuery.of(context).size.width,
                        onPressed: () async {
                          String camsEmail = await preferences.getCamsEmail();
                          preferences.setOkClicked(false);
                          Navigator.pop(context);
                          if(widget.forLoanRenewal!){
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashBoard()));
                          } else {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          AdditionalAccountDetailScreen(1, "", "", "")));
                          }
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
}
