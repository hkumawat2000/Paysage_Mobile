import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/WithdrawDetailsResponse.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:dio/dio.dart';

class WithdrawDao with BaseDio{
  Future<WithdrawDetailsResponse> getWithdrawDetails(loanName) async {
    Dio dio = await getBaseDio();
    WithdrawDetailsResponse wrapper = WithdrawDetailsResponse();
    try {
      Response response = await dio.get(Constants.withdrawDetails,
            queryParameters: {ParametersConstants.loanName: loanName});
      printLog("loanNameloanNameloanName${loanName}");
      if (response.statusCode == 200) {
        wrapper = WithdrawDetailsResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        }else{
          wrapper.errorMessage = e.response!.statusMessage!;
        }

      }
    }
    return wrapper;
  }

  Future<CommonResponse> requestWithdrawOTP() async {
    Dio dio = await getBaseDio();
    CommonResponse wrapper = CommonResponse();
    try {
      Response response = await dio.post(Constants.withdrawOtp);
      if (response.statusCode == 200) {
        wrapper = CommonResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        }else{
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }

  Future<CommonResponse> createPledgeRequest(loanName,amount,bankAccountName,otp) async {
    Dio dio = await getBaseDio();
    CommonResponse wrapper = CommonResponse();
    try {
      Response response = await dio.post(Constants.withdrawRequest,data:{
        ParametersConstants.loanName: loanName,
        ParametersConstants.amount: amount,
        ParametersConstants.bankAccountName: bankAccountName,
        ParametersConstants.otp: otp });
      if (response.statusCode == 200) {
        wrapper = CommonResponse.fromJson(response.data);
        wrapper.isSuccessFull = true;
      } else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        if(e.response!.data != null) {
          wrapper.errorMessage = e.response!.data["message"];
        }else{
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }
}