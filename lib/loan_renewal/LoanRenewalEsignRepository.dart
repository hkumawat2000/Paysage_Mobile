import 'package:choice/loan_renewal/LoanRenewalEsignDao.dart';
import 'package:choice/network/responsebean/CommonResponse.dart';
import 'package:choice/network/responsebean/ESignResponse.dart';

class LoanRenewalEsignRepository {
  final loanRenewalEsignDao = LoanRenewalEsignDao();

  Future<ESignResponse> loanRenewalEsignVerification(String loanRenewalApplicationName) =>
      loanRenewalEsignDao.loanRenewalEsignVerification(loanRenewalApplicationName);

  Future<CommonResponse> loanRenewalEsignSuccess(String loanRenewalApplicationName, file_id) =>
      loanRenewalEsignDao.loanRenewalEsignSuccess(loanRenewalApplicationName, file_id);
}