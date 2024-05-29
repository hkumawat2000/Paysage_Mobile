import 'package:lms/complete_kyc/CkycConsentScreen1.dart';
import 'package:lms/complete_kyc/CompleteKYCBloc.dart';
import 'package:lms/consent_text_api/ConsentTextBloc.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class CompleteKYCScreen extends StatefulWidget {

  @override
  CompleteKYCScreenState createState() => CompleteKYCScreenState();
}

class CompleteKYCScreenState extends State<CompleteKYCScreen> {
  final completeKYCBloc = CompleteKYCBloc();
  TextEditingController panController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  DateTime selectedbirthDate = DateTime.now();
  Preferences preferences = Preferences();
  bool checkBoxValue = true;
  int acceptTerms = 1;
  FocusNode dobDateFocus = FocusNode();
  ConsentTextBloc consentTextBloc = ConsentTextBloc();
  String? consentKYCText;
  bool isAPICalling = true;
  String isAPICallingText = Strings.please_wait;


  @override
  void initState() {
    consentTextAPI();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: colorBg,
        body: isAPICalling ? Center(child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(isAPICallingText),
          ],
        )): SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 60,
                ),
                Image.asset(AssetsImagePath.updateKyc, width: 195, height: 200),
                SizedBox(
                  height: 20,
                ),
                largeHeadingText(Strings.KYC_info),
                SizedBox(
                  height: 40,
                ),
                panField(),
                SizedBox(
                  height: 14,
                ),
                dOBWidget(context),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: Checkbox(
                        value: checkBoxValue,
                        activeColor: appTheme,
                        onChanged: (bool? newValue) {
                          setState(() {
                            checkBoxValue = newValue!;
                            if (checkBoxValue) {
                              acceptTerms = 1;
                            } else {
                              acceptTerms = 0;
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Text(consentKYCText ?? "",
                          style: mediumTextStyle_16_dark,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 60,
                ),
                nextPreWidget(),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget panField() {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(primaryColor: appTheme),
      child: TextFormField(
        maxLength: 10,
        controller: panController,
        style: textFiledInputStyle,
        cursorColor: appTheme,
        onChanged: (text) {
          if (text.length == 10) {
            FocusScope.of(context).requestFocus(dobDateFocus);
          }
        },
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appTheme),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appTheme),
          ),
          errorBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.red, width: 0.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          counterText: "",
          hintText: Strings.pan_no,
          labelText: Strings.pan_no,
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
        ),
        keyboardType: TextInputType.text,
        textCapitalization: TextCapitalization.characters,
      ),
    );
  }

  Widget dOBWidget(BuildContext context) {
    return Stack(
      alignment: Alignment.centerRight,
      children: [
        dobField(),
        dOBCalendar(context),
      ],
    );
  }

  Widget dobField() {
    final theme = Theme.of(context);
    return Theme(
      data: theme.copyWith(primaryColor: appTheme),
      child: TextFormField(
        controller: dobController,
        style: textFiledInputStyle,
        cursorColor: appTheme,
        focusNode: dobDateFocus,
        keyboardType: TextInputType.numberWithOptions(decimal: false),
        inputFormatters: [
          FilteringTextInputFormatter.allow(RegExp("[0-9/]")),
          LengthLimitingTextInputFormatter(10),
          _DateFormatter(),
        ],
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appTheme),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: appTheme),
          ),
          errorBorder: new OutlineInputBorder(
            borderSide: new BorderSide(color: Colors.red, width: 0.0),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            borderSide: BorderSide(width: 1, color: Colors.red),
          ),
          hintText: Strings.dob,
          labelText: Strings.dob,
          hintStyle: TextStyle(color: colorGrey),
          labelStyle: TextStyle(color: appTheme),
        ),
        onChanged: (val){
          if(val.length == 10){
            FocusScope.of(context).unfocus();
            if(panController.text.trim().length == 10){
              checkFourthPValidation();
            }
          }
        },
      ),
    );
  }

  Widget dOBCalendar(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
        selectDate(context);
      },
      child: Padding(
        padding: EdgeInsets.only(right: 10),
        child: Image.asset(
          AssetsImagePath.calendar,
          width: 24,
          height: 24,
          fit: BoxFit.fill
        ),
      ),
    );
  }

  Widget nextPreWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: ArrowBackwardNavigation(),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        Container(
          height: 45,
          width: 100,
          child: Material(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            elevation: 1.0,
            color: appTheme,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () async {
                Utility.isNetworkConnection().then((isNetwork) {
                  if (isNetwork) {
                     FocusScope.of(context).unfocus();
                     checkFourthPValidation();
                  } else {
                    Utility.showToastMessage(Strings.no_internet_message);
                  }
                });
              },
              child: ArrowForwardNavigation(),
            ),
          ),
        )
      ],
    );
  }

  Future<Null> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedbirthDate,
        firstDate: DateTime(1900, 1),
        lastDate: DateTime.now());
    if (picked != null) {
      setState(() {
        selectedbirthDate = picked;
        DateTime todaysDate = DateTime.now();

        var displayDateFormatter = new DateFormat('dd/MM/yyyy');
        var date = DateTime.parse(selectedbirthDate.toString());
        String formattedDate = displayDateFormatter.format(date);
        if (selectedbirthDate.isBefore(todaysDate)) {
          int age = todaysDate.year - selectedbirthDate.year;
          if (age > 18) {
            dobController.clear();
            dobController.text = formattedDate.toString().substring(0, 10);
          } else {
            dobController.clear();
            Utility.showToastMessage(Strings.age_above_18);
          }
        } else {
          dobController.clear();
          Utility.showToastMessage(Strings.invalid_dob);
        }
      });
    }
  }

  //validation for pan number
  checkFourthPValidation() async {
    String? baseURL = await preferences.getBaseURL();
    if(baseURL == Constants.baseUrlProd){
      if (panController.text.length == 0) {
        Utility.showToastMessage(Strings.message_empty_panNo);
      } else if (panController.text.length < 10) {
        Utility.showToastMessage(Strings.message_valid_panNo);
      } else if (panController.text[3].toLowerCase() != "p") {
        commonDialog(context, Strings.kyc_fourth_letter_validation, 0);
      } else {
        submitKYCApi();
      }
    } else {
      submitKYCApi();
    }
  }

  Future<void> submitKYCApi() async {
    if (panController.text.length == 0) {
      Utility.showToastMessage(Strings.message_empty_panNo);
    } else if (panController.text.length < 10) {
      Utility.showToastMessage(Strings.message_valid_panNo);
    } else if (dobController.text.length == 0) {
      Utility.showToastMessage(Strings.message_valid_DOB);
    } else if (acceptTerms == 0) {
      Utility.showToastMessage(Strings.kyc_check_validation);
    } else {
      try {
        DateTime todaysDate = DateTime.now();
        var displayDateFormatter = DateFormat('dd/MM/yyyy');
        var ddMmYyFormat = displayDateFormatter.parse(dobController.value.text);
        if (ddMmYyFormat.isBefore(todaysDate)) {
          int age = todaysDate.year - ddMmYyFormat.year;
          if (age > 18) {
            dobController.text = dobController.value.text;
            LoadingDialogWidget.showLoadingWithoutBack(context, Strings.please_wait);
            completeKYCBloc.getCKYC(panController.text, acceptTerms).then((value) { // search api
              if(value.isSuccessFull!){
                if(value.searchData != null){
                  cKycDownloadAPI(value.searchData!.ckycNo!); //download api
                } else {
                  Navigator.pop(context);
                  Utility.showToastMessage(Strings.something_went_wrong);
                }
              } else if (value.errorCode == 403) {
                Navigator.pop(context);
                commonDialog(context, Strings.session_timeout, 4);
              } else {
                Navigator.pop(context);
                commonDialog(context, value.errorMessage!, 0);
              }
            });
          } else {
            dobController.clear();
            Utility.showToastMessage(Strings.age_above_18);
          }
        } else {
          dobController.clear();
          Utility.showToastMessage(Strings.invalid_dob);
        }
      } catch (e) {
        dobController.clear();
        Utility.showToastMessage(Strings.correct_dob);
      }
    }
  }

  cKycDownloadAPI(String ckycNo) {
      Utility.isNetworkConnection().then((isNetwork) {
        if (isNetwork) {
          completeKYCBloc.getDownloadApi(panController.text, dobController.text.replaceAll("/", "-"), ckycNo).then((value) {
            Navigator.pop(context);
            if (value.isSuccessFull!) {
              Navigator.push(context, MaterialPageRoute(
                  builder: (BuildContext context) => CkycConsentScreen1(value.downloadData!.userKycName!, false, true, "", "")));
            } else if (value.errorCode == 403) {
              commonDialog(context, Strings.session_timeout, 4);
            } else {
              commonDialog(context, value.errorMessage, 0);
            }
          });
        } else {
          Navigator.pop(context);
          Utility.showToastMessage(Strings.no_internet_message);
        }
      });
  }

  // get consent text from backend
  consentTextAPI() {
    Utility.isNetworkConnection().then((isNetwork) {
      if (isNetwork) {
        consentTextBloc.getConsentText("Kyc").then((value) {
          if (value.isSuccessFull!) {
            setState(() {
              consentKYCText = value.data!.consent;
              isAPICalling = false;
            });
          }else if (value.errorCode == 403) {
            setState(() {
              isAPICallingText = Strings.session_timeout;
            });
            commonDialog(context, Strings.session_timeout, 4);
          } else {
            setState(() {
              isAPICallingText = value.errorMessage!;
            });
          }
        });
      } else {
        setState(() {
          isAPICallingText = Strings.no_internet_message;
        });
      }
    });
  }

}


class _DateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue prevText, TextEditingValue currText) {
    int selectionIndex;
    String pText = prevText.text;
    String cText = currText.text;
    int cLen = cText.length;
    int pLen = pText.length;

    if (cLen == 1) {
      if (int.parse(cText) > 3) {
        cText = '';
      }
    } else if (cLen == 2 && pLen == 1) {
      int dd = int.parse(cText.substring(0, 2));
      if (dd == 0 || dd > 31) {
        cText = cText.substring(0, 1);
      } else {
        cText += '/';
      }
    } else if (cLen == 4) {
      if (int.parse(cText.substring(3, 4)) > 1) {
        cText = cText.substring(0, 3);
      }
    } else if (cLen == 5 && pLen == 4) {
      int mm = int.parse(cText.substring(3, 5));
      if (mm == 0 || mm > 12) {
        cText = cText.substring(0, 4);
      } else {
        cText += '/';
      }
    } else if ((cLen == 3 && pLen == 4) || (cLen == 6 && pLen == 7)) {
      cText = cText.substring(0, cText.length - 1);
    } else if (cLen == 3 && pLen == 2) {
      if (int.parse(cText.substring(2, 3)) > 1) {
        cText = cText.substring(0, 2) + '/';
      } else {
        cText = cText.substring(0, pLen) + '/' + cText.substring(pLen, pLen + 1);
      }
    } else if (cLen == 6 && pLen == 5) {
      int y1 = int.parse(cText.substring(5, 6));
      if (y1 < 1 || y1 > 2) {
        cText = cText.substring(0, 5) + '/';
      } else {
        cText = cText.substring(0, 5) + '/' + cText.substring(5, 6);
      }
    } else if (cLen == 7) {
      int y1 = int.parse(cText.substring(6, 7));
      if (y1 < 1 || y1 > 2) {
        cText = cText.substring(0, 6);
      }
    } else if (cLen == 8) {
      int y2 = int.parse(cText.substring(6, 8));
      if (y2 < 19 || y2 > 20) {
        cText = cText.substring(0, 7);
      }
    }

    selectionIndex = cText.length;
    return TextEditingValue(text: cText,
      selection: TextSelection.collapsed(offset: selectionIndex));
  }
}