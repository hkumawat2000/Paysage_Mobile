import 'package:lms/network/requestbean/UnpledgeRequestBean.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/UnpledgeDetailsResponse.dart';
import 'package:lms/network/responsebean/UnpledgeRequestResponse.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:dio/dio.dart';

class UnpledgeDao with BaseDio {

  Future<UnpledgeDetailsResponse> unpledgeDetails(loanName) async {
    Dio dio = await getBaseDio();
    UnpledgeDetailsResponse wrapper = UnpledgeDetailsResponse();
    try {
      Response response = await dio.get(Constants.unpledgeDetails,
          queryParameters: {ParametersConstants.loanName: loanName});
      if (response.statusCode == 200) {
        wrapper = UnpledgeDetailsResponse.fromJson(response.data);
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
        wrapper.errorMessage = e.response!.statusMessage;
      }
    }
    return wrapper;
  }


  Future<CommonResponse> requestUnpledgeOTP() async {
    Dio dio = await getBaseDio();
    CommonResponse wrapper = CommonResponse();
    try {
      Response response = await dio.post(Constants.unpledgeOtp);
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
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }


  Future<UnpledgeRequestResponse> unpledgeRequest(UnpledgeRequestBean unpledgeRequestBean) async {
    Dio dio = await getBaseDio();
    UnpledgeRequestResponse wrapper = UnpledgeRequestResponse();
    try {
      Response response = await dio.post(Constants.unpledgeRequest, data: unpledgeRequestBean.toJson());
      if (response.statusCode == 200) {
        wrapper = UnpledgeRequestResponse.fromJson(response.data);
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
        if(e.response!.data !=null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage;
        }
      }
    }
    return wrapper;
  }
}