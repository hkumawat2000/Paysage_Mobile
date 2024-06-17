
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/ESignResponse.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:dio/dio.dart';

class LoanRenewalEsignDao extends BaseDio {
  Future<ESignResponse> loanRenewalEsignVerification(String loanRenewalApplicationName) async {
    Dio dio = await getBaseDio();
    ESignResponse wrapper = ESignResponse();
    try {
      Response response =
      await dio.post(Constants.eSign, data: {ParametersConstants.loanNo: "" , ParametersConstants.topUpApplicationName: "", ParametersConstants.loanRenewalApplicationName: loanRenewalApplicationName});
      if (response.statusCode == 200) {
        wrapper = ESignResponse.fromJson(response.data);
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
        if (e.response!.data != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }

  Future<CommonResponse> loanRenewalEsignSuccess(String loanRenewalApplicationName, fileID) async {
    Dio dio = await getBaseDio();
    CommonResponse wrapper = CommonResponse();
    try {
      Response response = await dio.post(Constants.eSignSuccess,
          data: {
            ParametersConstants.loanNo: "",
            ParametersConstants.topUpApplicationName: "",
            ParametersConstants.loanRenewalApplicationName: loanRenewalApplicationName,
            ParametersConstants.fileId: fileID
          });
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
        wrapper.errorCode = e.response!.statusCode;
        if (e.response!.data != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }
}
