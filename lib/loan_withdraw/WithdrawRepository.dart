import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/WithdrawDetailsResponse.dart';
import 'WithdrawDao.dart';

class WithdrawRepository {
  final withdrawDao = WithdrawDao();

  Future<WithdrawDetailsResponse> getWithdrawDetails(loanNAme) => withdrawDao.getWithdrawDetails(loanNAme);
  Future<CommonResponse> requestWithdrawOTP() => withdrawDao.requestWithdrawOTP();
  Future<CommonResponse> createPledgeRequest(loanName, amount, bankAccountName,otp) =>
      withdrawDao.createPledgeRequest(loanName, amount, bankAccountName,otp);
}