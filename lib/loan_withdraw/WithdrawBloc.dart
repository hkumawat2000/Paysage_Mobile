import 'dart:async';
import 'package:choice/network/responsebean/CommonResponse.dart';
import 'package:choice/network/responsebean/WithdrawDetailsResponse.dart';
import 'package:choice/widgets/WidgetCommon.dart';
import 'WithdrawRepository.dart';

class WithdrawBloc {
  WithdrawBloc();
  final withdrawRepository = WithdrawRepository();
  final withdrawController = StreamController<WithdrawDetailsData>.broadcast();
  get withdrawLoan => withdrawController.stream;

  Future<WithdrawDetailsResponse> getWithdrawDetails(loamName) async {
    WithdrawDetailsResponse wrapper = await withdrawRepository.getWithdrawDetails(loamName);
    if (wrapper.isSuccessFull!) {
      printLog("-----SUCESS-----");
      withdrawController.sink.add(wrapper.data!);
    } else {
      printLog("-----FAIL-----");
    }
    return wrapper;
  }

  Future<CommonResponse> requestWithdrawOTP() async {
    CommonResponse wrapper = await withdrawRepository.requestWithdrawOTP();
    return wrapper;
  }

  Future<CommonResponse> createPledgeRequest(loanName, amount, bankAccountName,otp) async {
    CommonResponse wrapper = await withdrawRepository.createPledgeRequest(loanName, amount, bankAccountName,otp);
    return wrapper;
  }
}