import 'dart:convert';

import 'package:lms/network/requestbean/LoanStatementRequestBean.dart';
import 'package:lms/account_statement//LoanStatementBloc.dart';
import 'package:lms/account_statement//SuccessDownloadEmailView.dart';
import 'package:lms/util/AssetsImagePath.dart';
import 'package:lms/util/Colors.dart';
import 'package:lms/util/Preferences.dart';
import 'package:lms/util/Style.dart';
import 'package:lms/util/Utility.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/LoadingDialogWidget.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:dio/dio.dart';
import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadStatementView extends StatefulWidget {
  final loanName;
  final isComingFrom;
  TabController tabController;

  DownloadStatementView(this.loanName, this.isComingFrom, this.tabController);

  @override
  State<StatefulWidget> createState() {
    return DownloadStatementViewState();
  }
}

class DownloadStatementViewState extends State<DownloadStatementView> {
  var dio = Dio();
  Preferences preferences = Preferences();
  final loanStatementBloc = LoanStatementBloc();
  DateTime selectedDate = DateTime.now();
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  String? dateFormatFrom;
  String? dateFormatTo;
  String? email, mobile;
  String? fromDate;
  String? toDate;
  String? _currentDuration;
  String? _currentFormat;
  String requestValue = '';
  bool isCustomDateVisible = false;
  bool isEmailVisible = false;
  bool isSpaceVisible = true;

  List<DropdownMenuItem<String>>? _dropDownFormatMenuFormat;
  List<TransactionDuration> duration = <TransactionDuration>[
    const TransactionDuration("curr_month", "Current Month"),
    const TransactionDuration("prev_1", "Last Month"),
    const TransactionDuration("prev_3", "Last 3 Months"),
    const TransactionDuration("prev_6", "Last 6 Months"),
    const TransactionDuration("current_year", "Current Financial Year"),
    const TransactionDuration("custom_date", "Select Custom Dates")
  ];
  TransactionDuration? durationSelected;
  String? durationValueSelected;
  List _formatList = ['pdf', 'excel'];
  List requestType = ["Download", "Email"];
  bool isDownloaded = true;

  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem = 'Download';
  var baseURL;

  List<DropdownMenuItem<String>> getDropDownFormatMenuItems() {
    List<DropdownMenuItem<String>> items = [];
    for (String status in _formatList) {
      items.add(
        DropdownMenuItem(
          value: status,
          child: Text(status),
        ),
      );
    }
    return items;
  }

  void changedDropDownFormatItem(String? selectedStatus) {
    setState(() {
        _currentFormat = selectedStatus;
      },
    );
  }

  @override
  void initState() {
    getPermission();
    getPreferences();
    _dropDownFormatMenuFormat = getDropDownFormatMenuItems();
    var now = DateTime.now();
    fromDate = now.toString().substring(0, 10);
    toDate = now.toString().substring(0, 10);
    super.initState();
  }

  void getPreferences() async {
    var base_url = await preferences.getBaseURL();
    email = await preferences.getEmail();
    mobile = await preferences.getMobile();
    setState(() {
      base_url = baseURL;
    });

  }

  //get storage permission
  void getPermission() async {
    printLog("getPermission");
    // await Permission.storage.request();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorBg,
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        'Which period do you need a statement?',
                        style: TextStyle(color: appTheme, fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 25,
                ),
                periodDropDown(),
                Divider(
                  thickness: 0.2,
                  color: colorLightGray,
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: isCustomDateVisible,
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text('Select custom date of your choice',
                              style: TextStyle(
                                  color: appTheme, fontSize: 18, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Expanded(child: loanFromDate()),
                          SizedBox(
                            width: 20,
                          ),
                          Expanded(child: loanToDate()),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: <Widget>[
                    formatDropDown(),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                requestRadioSection(),
                Visibility(
                  visible: isSpaceVisible,
                  child: SizedBox(
                    height: 40,
                  ),
                ),
                Visibility(visible: isEmailVisible, child: showEmail()),
                nextPreWidget(),
                SizedBox(
                  height: 30,
                ),
         // loanStatementOperationButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget periodDropDown() {
    return Container(
      height: 30,
      child: DropdownButtonHideUnderline(
        child: DropdownButton<TransactionDuration>(
          isDense: true,
          isExpanded: true,
          hint: Text('Duration'),
          value: durationSelected,
          icon: Image.asset(AssetsImagePath.down_arrow, height: 20, width: 20),
          iconSize: 20,
          elevation: 16,
          onChanged: (TransactionDuration? newValue) {
            setState(() {
              durationSelected = newValue;
              durationValueSelected = durationSelected
                  !.id;
              printLog(durationSelected!.id);
              if (durationSelected!.id == 'custom_date') {
                isCustomDateVisible = !isCustomDateVisible;
              } else {
                isCustomDateVisible = false;
                dateFormatFrom = null;
                dateFormatTo = null;
              }
            });
          },
          items: duration.map((TransactionDuration user) {
            return new DropdownMenuItem<TransactionDuration>(
              value: user,
              child: new Text(
                user.name,
                style: new TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget formatDropDown() {
    return Container(
      // padding: EdgeInsets.only(left: 10, right: 10),
      height: 40,
      width: 150,
      child: DropdownButton<String>(
        isDense: true,
        isExpanded: true,
        value: _currentFormat,
        hint: Text('Format'),
        icon: Image.asset(AssetsImagePath.down_arrow, height: 20, width: 20),
        iconSize: 24,
        elevation: 16,
        onChanged: changedDropDownFormatItem,
        items: _dropDownFormatMenuFormat,
      ),
    );
  }

  Widget loanFromDate() {
    return GestureDetector(
      child: TextFormField(
        controller: fromDateController,
        obscureText: false,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "From",
          focusColor: colorLightGray,
          suffixIcon: IconButton(
            icon: Image.asset(
              AssetsImagePath.calendar,
              width: 21.0,
              height: 21.05,
            ),
            onPressed: () {},
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: appTheme,
              width: 0.2,
            ),
          ),
        ),
        onTap: () {
          selectFromDate(context);
        },
        keyboardType: TextInputType.datetime,
      ),
    );
  }

  Widget loanToDate() {
    return GestureDetector(
      child: TextFormField(
        controller: toDateController,
        obscureText: false,
        readOnly: true,
        decoration: InputDecoration(
          hintText: "To",
          focusColor: colorLightGray,
          suffixIcon: IconButton(
            icon: Image.asset(
              AssetsImagePath.calendar,
              width: 21.0,
              height: 21.05,
            ),
            onPressed: () {},
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: appTheme,
              width: 0.2,
            ),
          ),
        ),
        onTap: () {
          selectToDate(context);
        },
        keyboardType: TextInputType.datetime,
      ),
    );
  }

  Widget requestRadioSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Request",
          style: TextStyle(color: appTheme, fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Row(
          children: <Widget>[
            Expanded(child: addRadioButton(0, "Download")),
            Expanded(child: addRadioButton(1, "Email")),
          ],
        ),
      ],
    );
  }

  Row addRadioButton(int btnValue, String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Radio<String>(
          activeColor: appTheme,
          value: requestType[btnValue],
          groupValue: radioButtonItem,
          onChanged: (value) {
            setState(() {
              radioButtonItem = value.toString();
              if (radioButtonItem == "Download") {
                isEmailVisible = false;
                isSpaceVisible = true;
                isDownloaded = true;
              } else {
                isDownloaded = false;
                // isEmailVisible = !isEmailVisible;
                // isSpaceVisible = !isSpaceVisible;
              }
            });
          },
        ),
        Text(title, style: title == radioButtonItem ? boldTextStyle_18 : boldTextStyle_18_gray)
      ],
    );
  }

  Widget showEmail() {
    return email != null ? Column(
      children: <Widget>[
        SizedBox(height: 10),
        Row(
          children: <Widget>[
            Text(
              'Email',
              style: TextStyle(color: appTheme, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 4),
        Row(
          children: <Widget>[
            Text(
              '$email',
              style: TextStyle(color: colorDarkGray, fontSize: 18),
            ),
          ],
        ),
        SizedBox(height: 40),
      ],
    ) :  SizedBox();
  }

  Widget loanStatementOperationButton() {
    return Container(
      width: 200,
      height: 40,
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
        elevation: 1.0,
        color: appTheme,
        child: MaterialButton(
          minWidth: MediaQuery.of(context).size.width,
          onPressed: () async {
            _downloadSuccessBottomSheet(context);
          },
          child: Text(
            'Download',
            style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  //Show FromDatePicker
  Future<Null> selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(0001, 1),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        selectedDate = picked;
        fromDate = selectedDate.toString().substring(0, 10);
        dateFormatFrom = DateFormat("dd-MM-yyyy").format(DateTime.parse(fromDate!));
        fromDateController.text = dateFormatFrom!;
      });
  }

  //Show ToDatePicker
  Future<Null> selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(0001, 1),
        lastDate: DateTime.now());
    if (picked != null)
      setState(() {
        selectedDate = picked;
        toDate = selectedDate.toString().substring(0, 10);
        dateFormatTo = DateFormat("dd-MM-yyyy").format(DateTime.parse(toDate!));
        toDateController.text = dateFormatTo!;
      });
  }

  void _downloadSuccessBottomSheet(context) {
    showModalBottomSheet(
      backgroundColor: Colors.transparent,
      context: context,
      isScrollControlled: true,
      builder: (BuildContext bc) {
        return SuccessDownloadEmailView();
      },
    );
  }

  Widget nextPreWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          icon: ArrowBackwardNavigation(),
          onPressed: () {
            widget.tabController.animateTo(widget.tabController.index - 1);
            // Navigator.pop(context);
          },
        ),
        Container(
          height: 45,
          width: 100,
          child: Material(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(35)),
            elevation: 1.0,
            color: appTheme,
            child: MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(35)),
              minWidth: MediaQuery.of(context).size.width,
              onPressed: () async {
                Utility.isNetworkConnection().then((isNetwork) {
                  if (isNetwork) {
                    submitStatement();
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

  void submitStatement() {
    if (durationValueSelected == null) {
      Utility.showToastMessage(Strings.valid_duration);
    } else if (_currentFormat == null) {
      Utility.showToastMessage(Strings.valid_format);
    } else {
      if (durationValueSelected == "custom_date") {
        if (fromDateController.value.text.isEmpty) {
          Utility.showToastMessage(Strings.valid_from_date);
        } else if (toDateController.value.text.isEmpty) {
          Utility.showToastMessage(Strings.valid_to_date);
        } else {
          loanStatement();
        }
      } else {
        loanStatement();
      }
    }
  }

  void loanStatement() {
    LoadingDialogWidget.showDialogLoading(context, Strings.please_wait);
    LoanStatementRequestBean? loanStatementRequestBean;
    if(widget.isComingFrom == Strings.loan_statement) {
      loanStatementRequestBean = LoanStatementRequestBean(
          loanName: widget.loanName,
          type: "Account Statement",
          duration: durationValueSelected != "custom_date" ? durationValueSelected : null,
          fromDate: dateFormatFrom,
          toDate: dateFormatTo,
          fileFormat: _currentFormat,
          isDownload: isDownloaded ? 1 : 0,
          isEmail: !isDownloaded ? 1 : 0);
    } else if(widget.isComingFrom == Strings.recent_transactions) {
      loanStatementRequestBean = LoanStatementRequestBean(
          loanName: widget.loanName,
          type: "Pledged Securities Transactions",
          duration: durationValueSelected != "custom_date" ? durationValueSelected : null,
          fromDate: dateFormatFrom,
          toDate: dateFormatTo,
          fileFormat: _currentFormat,
          isDownload: isDownloaded ? 1 : 0,
          isEmail: !isDownloaded ? 1 : 0);
    }
    printLog("Loan statement ==> ${jsonEncode(loanStatementRequestBean)}");
    loanStatementBloc.submitLoanStatements(loanStatementRequestBean!).then((value) async {
      Navigator.pop(context);
      if (value.isSuccessFull!) {
        // Firebase Event
        Map<String, dynamic> parameter = new Map<String, dynamic>();
        parameter[Strings.mobile_no] = mobile;
        parameter[Strings.email] = email;
        parameter[Strings.loan_number] = widget.loanName;
        parameter[Strings.statement_type] = durationSelected!.name;
        parameter[Strings.email_or_download] = isDownloaded ? "Download" : "Email";
        parameter[Strings.date_time] = getCurrentDateAndTime();
        if(widget.isComingFrom == Strings.loan_statement) {
          firebaseEvent(Strings.download_loan_statement_event, parameter);
        } else if(widget.isComingFrom == Strings.recent_transactions) {
          firebaseEvent(Strings.download_pledge_statement, parameter);
        }

        if (isDownloaded) {
          if (value.loanData!.pdfFileUrl!.isNotEmpty) {
            printLog("value.loanData.pdfFileUrl ::: ${value.loanData!.pdfFileUrl}");
            _launchURL(value.loanData!.pdfFileUrl);
//            download2(dio, value.loanData.pdfFileUrl, path, "pdf");
          } else {
            printLog("value.loanData.excelFileUrl ::: ${value.loanData!.excelFileUrl}");
            _launchURL(value.loanData!.excelFileUrl);
//            download2(dio, value.loanData.excelFileUrl, path, "excel");
          }
        } else {
          showFlushBar(Strings.email_sent);
        }
      } else if (value.errorCode == 403) {
        commonDialog(context, Strings.session_timeout, 4);
      } else {
        Utility.showToastMessage(value.errorMessage!);
      }
    });
  }

  _launchURL(pathURL) async {
//    String dummy = pathPDF;
//    String loan_agreementStr = dummy;
//    var loan_agreementArray = loan_agreementStr.split('.pdf');
////    var loan_agreement = loan_agreementArray[1];
//    printLog("loan_agreement$loan_agreementArray");
    if (await canLaunch(pathURL)) {
      await launch(pathURL);
    } else {
      throw 'Could not launch $pathURL';
    }
  }

  Future download2(Dio dio, String url, String savePath, String isFor) async {
    final permissionStatus = await Permission.storage.request();
    if(permissionStatus.isGranted){
      printLog('granted');

      // final id = await FlutterDownloader.enqueue(
      //     url: url,
      //     savedDir: savePath,
      //     fileName: isFor == "pdf" ? "file${DateTime.now().toString()}.pdf" : "file${DateTime.now().toString()}.xlsx",
      //     showNotification: true,
      //     openFileFromNotification: true
      // );
      showFlushBar("Statement downloading...");
    } else {
      Utility.showToastMessage('Permission deined');
    }


    // //get pdf from link
    // LoadingDialogWidget.showDialogLoading(context, Strings.downloading_file);
    // Response response = await dio.get(
    //   url,
    //   // onReceiveProgress: showDownloadProgress,
    //   //Received data with List<int>
    //   options: Options(
    //       responseType: ResponseType.bytes,
    //       followRedirects: false,
    //       validateStatus: (status) {
    //         return status < 500;
    //       }),
    // );
    // Navigator.pop(context);
    // showFlushBar("Statement downloaded successfully");
    // //write in download folder
    // File file = File(savePath);
    // var raf = file.openSync(mode: FileMode.write);
    // raf.writeFromSync(response.data);
    // await raf.close();
  }

  void showFlushBar(String msg) {
    Flushbar(
      flushbarPosition: FlushbarPosition.TOP,
      backgroundColor: appTheme,
      //title:  "",
      messageText: Column(
        children: <Widget>[
          Text(msg,
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300, fontSize: 13)),
        ],
      ),
      duration: Duration(seconds: 2),
    )..show(context);
  }
}

class TransactionDuration {
  const TransactionDuration(this.id, this.name);

  final String id;
  final String name;
}
