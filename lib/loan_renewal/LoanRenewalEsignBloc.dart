import 'dart:async';
import 'package:lms/loan_renewal/LoanRenewalEsignRepository.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/ESignResponse.dart';
import 'package:lms/widgets/WidgetCommon.dart';

class LoanRenewalEsignBloc {
  LoanRenewalEsignBloc();

  final loanRenewalEsignRepository = LoanRenewalEsignRepository();

  Future<ESignResponse> loanRenewalEsignVerification(String loanRenewalApplicationName) async {
    ESignResponse wrapper = await loanRenewalEsignRepository.loanRenewalEsignVerification(loanRenewalApplicationName);
    if (wrapper.isSuccessFull!) {
      printLog("-----SUCESS-----");
    } else {
      printLog("-----FAIL-----");
    }
    return wrapper;
  }

  Future<CommonResponse> esignSuccess(loan_name, file_id) async {
    CommonResponse wrapper = await loanRenewalEsignRepository.loanRenewalEsignSuccess(loan_name, file_id);
    if (wrapper.isSuccessFull!) {
      printLog("-----SUCESS-----");
    } else {
      printLog("-----FAIL-----");
    }
    return wrapper;
  }
}
