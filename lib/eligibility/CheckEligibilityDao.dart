import 'package:choice/network/responsebean/CheckEligibilityResponseBean.dart';
import 'package:choice/network/responsebean/LenderResponseBean.dart';
import 'package:choice/util/base_dio.dart';
import 'package:choice/util/constants.dart';
import 'package:choice/util/strings.dart';
import 'package:dio/dio.dart';

class CheckEligibilityDao with BaseDio {

  Future<CheckEligibilityResponseBean> getEligibility(String lender, String searchData) async {
    Dio dio = await getBaseDio();
    CheckEligibilityResponseBean wrapper = CheckEligibilityResponseBean();
    try {
      Response response = await dio.get(Constants.checkEligibility,
          queryParameters: {ParametersConstants.lender: lender, ParametersConstants.search: searchData});
      if (response.statusCode == 200) {
        wrapper = CheckEligibilityResponseBean.fromJson(response.data);
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


  Future<CheckEligibilityResponseBean> getEligibilityWithKYC(String lender, String searchData) async {
    Dio dio = await getBaseDio();
    CheckEligibilityResponseBean wrapper = CheckEligibilityResponseBean();
    try {
      Response response = await dio.get(Constants.securitiesList,
          queryParameters: {ParametersConstants.lender: lender});
      if (response.statusCode == 200) {
        wrapper = CheckEligibilityResponseBean.fromJson(response.data);
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
}
