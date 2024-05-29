import 'package:lms/network/requestbean/SellCollateralRequestBean.dart';
import 'package:lms/network/responsebean/CommonResponse.dart';
import 'package:lms/network/responsebean/SellCollateralResponseBean.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:dio/dio.dart';

class SellCollateralDao with BaseDio {
  Future<CommonResponse> requestSellCollateralOTP() async {
    Dio dio = await getBaseDio();
    CommonResponse wrapper = CommonResponse();
    try {
      Response response = await dio.post(Constants.sellCollateralOtp);
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


  Future<SellCollateralResponseBean> requestSellCollateralSecurities(securities, loanName, otp,loanMarginShortfallName) async {
    SellCollateralRequestBean sellCollateralRequestBean =
        new SellCollateralRequestBean(securities: securities, loanName: loanName, otp: otp,loanMarginShortfallName: loanMarginShortfallName);
    Dio dio = await getBaseDio();
    SellCollateralResponseBean wrapper = SellCollateralResponseBean();
    try {
      Response response = await dio.post(Constants.sellCollateral,
          data: sellCollateralRequestBean.toJson());
      if (response.statusCode == 200) {
        wrapper = SellCollateralResponseBean.fromJson(response.data);
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
