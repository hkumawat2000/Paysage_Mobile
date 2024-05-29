import 'package:lms/loan_renewal/LoanRenewalEsignDao.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/ESignResponse.dart';

class LoanRenewalEsignRepository {
  final loanRenewalEsignDao = LoanRenewalEsignDao();

  Future<ESignResponse> loanRenewalEsignVerification(String loanRenewalApplicationName) =>
      loanRenewalEsignDao.loanRenewalEsignVerification(loanRenewalApplicationName);

  Future<CommonResponse> loanRenewalEsignSuccess(String loanRenewalApplicationName, file_id) =>
      loanRenewalEsignDao.loanRenewalEsignSuccess(loanRenewalApplicationName, file_id);
}