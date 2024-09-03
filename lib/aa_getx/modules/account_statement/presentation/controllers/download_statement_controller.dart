import 'package:another_flushbar/flushbar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lms/aa_getx/core/constants/colors.dart';
import 'package:lms/aa_getx/core/constants/strings.dart';
import 'package:lms/aa_getx/core/utils/common_widgets.dart';
import 'package:lms/aa_getx/core/utils/connection_info.dart';
import 'package:lms/aa_getx/core/utils/data_state.dart';
import 'package:lms/aa_getx/core/utils/preferences.dart';
import 'package:lms/aa_getx/core/utils/utility.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/loan_statement_response_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/entities/request/loan_statement_request_entity.dart';
import 'package:lms/aa_getx/modules/account_statement/domain/usecases/submit_loan_statement_usecase.dart';
import 'package:lms/account_statement/LoanStatementBloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher_string.dart';

class DownloadStatementController extends GetxController {
  final ConnectionInfo _connectionInfo;
  final SubmitLoanStatementUseCase _submitLoanStatementUseCase;

  DownloadStatementController(this._connectionInfo, this._submitLoanStatementUseCase);

  Preferences preferences = Preferences();
  final loanStatementBloc = LoanStatementBloc();
  Rx<DateTime> selectedDate = DateTime.now().obs;
  TextEditingController fromDateController = TextEditingController();
  TextEditingController toDateController = TextEditingController();
  RxString dateFormatFrom="".obs;
  RxString dateFormatTo = "".obs;
  String? email, mobile;
  RxString fromDate = "".obs;
  RxString toDate = "".obs;
  RxString currentFormat = ''.obs;
  String requestValue = '';
  RxBool isCustomDateVisible = false.obs;
  RxBool isEmailVisible = false.obs;
  RxBool isSpaceVisible = true.obs;
  var loanName;
  var isComingFrom;
  TabController? tabController;

  List<DropdownMenuItem<String>>? dropDownFormatMenuFormat;
  RxList<TransactionDuration> duration = <TransactionDuration>[
    const TransactionDuration("curr_month", "Current Month"),
    const TransactionDuration("prev_1", "Last Month"),
    const TransactionDuration("prev_3", "Last 3 Months"),
    const TransactionDuration("prev_6", "Last 6 Months"),
    const TransactionDuration("current_year", "Current Financial Year"),
    const TransactionDuration("custom_date", "Select Custom Dates")
  ].obs;
  TransactionDuration? durationSelected;
  RxString durationValueSelected = "".obs;
  List _formatList = ['pdf', 'excel'];
  List requestType = ["Download", "Email"];
  RxBool isDownloaded = true.obs;

  // Default Radio Button Selected Item When App Starts.
  RxString radioButtonItem = 'Download'.obs;
  var baseURL;

  @override
  void onInit() {
    super.onInit();
    getPermission();
    getPreferences();
    dropDownFormatMenuFormat = getDropDownFormatMenuItems();
    var now = DateTime.now();
    fromDate.value = now.toString().substring(0, 10);
    toDate.value = now.toString().substring(0, 10);
  }

  void getPreferences() async {
    var base_url = await preferences.getBaseURL();
    email = await preferences.getEmail();
    mobile = await preferences.getMobile();
    //setState(() {
      base_url = baseURL;
    //});
  }

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
        currentFormat.value = selectedStatus!;
  }

  //get storage permission
  void getPermission() async {
    debugPrint("getPermission");
    // await Permission.storage.request();
  }

  void submitStatement() {
    if (durationValueSelected.isEmpty ) {
      Utility.showToastMessage(Strings.valid_duration);
    } else if (currentFormat.isEmpty) {
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

  Future<void> loanStatement() async {
    if(await _connectionInfo.isConnected){
      LoanStatementRequestEntity? loanStatementRequestEntity;
      if (isComingFrom == Strings.loan_statement) {
         loanStatementRequestEntity = LoanStatementRequestEntity(
            loanName: loanName,
            type: "Account Statement",
            duration: durationValueSelected.value != "custom_date"
                ? durationValueSelected.value
                : null,
            fromDate: dateFormatFrom.value,
            toDate: dateFormatTo.value,
            fileFormat: currentFormat.value,
            isDownload: isDownloaded.value ? 1 : 0,
            isEmail: !isDownloaded.value ? 1 : 0);
      } else if (isComingFrom == Strings.recent_transactions) {
        loanStatementRequestEntity = LoanStatementRequestEntity(
            loanName: loanName,
            type: "Pledged Securities Transactions",
            duration: durationValueSelected.value != "custom_date"
                ? durationValueSelected.value
                : null,
            fromDate: dateFormatFrom.value,
            toDate: dateFormatTo.value,
            fileFormat: currentFormat.value,
            isDownload: isDownloaded.value ? 1 : 0,
            isEmail: !isDownloaded.value ? 1 : 0);
      }
     // debugPrint("Loan statement ==> ${jsonEncode(loanStatementRequestEntity)}");
      showDialogLoading(Strings.please_wait);
      DataState<LoanStatementResponseEntity> response =
          await _submitLoanStatementUseCase.call(LoanStatementParams(
              loanStatementRequestEntity: loanStatementRequestEntity!));
      Get.back();

      if(response is DataSuccess){
        if(response.data != null){
          // Firebase Event
          Map<String, dynamic> parameter = new Map<String, dynamic>();
          parameter[Strings.mobile_no] = mobile;
          parameter[Strings.email] = email;
          parameter[Strings.loan_number] = loanName;
          parameter[Strings.statement_type] = durationSelected!.name;
          parameter[Strings.email_or_download] =
          isDownloaded.value ? "Download" : "Email";
          parameter[Strings.date_time] = getCurrentDateAndTime();
          if (isComingFrom == Strings.loan_statement) {
            firebaseEvent(Strings.download_loan_statement_event, parameter);
          } else if (isComingFrom == Strings.recent_transactions) {
            firebaseEvent(Strings.download_pledge_statement, parameter);
          }

          if (isDownloaded.value) {
            if (response.data!.loanData!.pdfFileUrl!.isNotEmpty) {
              debugPrint(
                  "value.loanData.pdfFileUrl ::: ${response.data !.loanData!.pdfFileUrl}");
              _launchURL(response.data !.loanData!.pdfFileUrl);
//            download2(dio, value.loanData.pdfFileUrl, path, "pdf");
            } else {
              debugPrint(
                  "value.loanData.excelFileUrl ::: ${response.data !.loanData!.excelFileUrl}");
              _launchURL(response.data !.loanData!.excelFileUrl);
//            download2(dio, value.loanData.excelFileUrl, path, "excel");
            }
          } else {
            showFlushBar(Strings.email_sent);
          }
        }
      } else if(response is DataFailed) {
        if (response.error!.statusCode == 403) {
          commonDialog(Strings.session_timeout, 4);
        } else {
          Utility.showToastMessage(response.error!.message);
        }
      }
    } else {
      Utility.showToastMessage(Strings.no_internet_message);
    }

  }

  _launchURL(pathURL) async {
//    String dummy = pathPDF;
//    String loan_agreementStr = dummy;
//    var loan_agreementArray = loan_agreementStr.split('.pdf');
////    var loan_agreement = loan_agreementArray[1];
//    printLog("loan_agreement$loan_agreementArray");
    if (await canLaunchUrlString(pathURL)) {
      await launchUrlString(pathURL);
    } else {
      throw 'Could not launch $pathURL';
    }
  }

  //Show FromDatePicker
  Future<Null> selectFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(0001, 1),
        lastDate: DateTime.now());
    if (picked != null)
        selectedDate.value = picked;
        fromDate.value = selectedDate.toString().substring(0, 10);
        dateFormatFrom.value =
            DateFormat("dd-MM-yyyy").format(DateTime.parse(fromDate.value));
        fromDateController.text = dateFormatFrom.value;
  }

  //Show ToDatePicker
  Future<Null> selectToDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate.value,
        firstDate: DateTime(0001, 1),
        lastDate: DateTime.now());
    if (picked != null)
        selectedDate.value = picked;
        toDate.value = selectedDate.toString().substring(0, 10);
        dateFormatTo.value = DateFormat("dd-MM-yyyy").format(DateTime.parse(toDate.value));
        toDateController.text = dateFormatTo.value;
  }

  Future download2(Dio dio, String url, String savePath, String isFor) async {
    final permissionStatus = await Permission.storage.request();
    if (permissionStatus.isGranted) {
      debugPrint('granted');

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
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w300,
                  fontSize: 13)),
        ],
      ),
      duration: Duration(seconds: 2),
    )..show(Get.context!);
  }

  durationSelectedFunction(TransactionDuration? newValue) {
      durationSelected = newValue!;
      debugPrint("durationSelected?.value ==>${durationSelected?.id}");
      durationValueSelected.value = durationSelected!.id;
      debugPrint(durationSelected!.id);
      if (durationSelected!.id == 'custom_date') {
        isCustomDateVisible.value = !isCustomDateVisible.value;
      } else {
        isCustomDateVisible.value = false;
        dateFormatFrom.value = "";
        dateFormatTo.value = "";
      }
  }

  radioButtonChanged(String? value) {
      radioButtonItem.value = value.toString();
      if (radioButtonItem.value == "Download") {
        isEmailVisible.value = false;
        isSpaceVisible.value = true;
        isDownloaded.value = true;
      } else {
        isDownloaded.value = false;
        // isEmailVisible = !isEmailVisible;
        // isSpaceVisible = !isSpaceVisible;
      }
  }
}

class TransactionDuration {
  const TransactionDuration(this.id, this.name);

  final String id;
  final String name;
}

class DownloadStatementArguments{
  final loanName;
  final isComingFrom;
  TabController tabController;

  DownloadStatementArguments(this.loanName, this.isComingFrom, this.tabController);
}