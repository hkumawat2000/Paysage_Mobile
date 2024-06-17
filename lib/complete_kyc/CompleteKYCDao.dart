import 'package:lms/network/requestbean/ConsentDetailRequestBean.dart';
import 'package:lms/network/requestbean/UserKYCRequest.dart';
import 'package:lms/network/responsebean/CkycDownloadResponse.dart';
import 'package:lms/network/responsebean/CkycSearchResponse.dart';
import 'package:lms/network/responsebean/ConsentDetailResponseBean.dart';
import 'package:lms/network/responsebean/PinCodeResponseBean.dart';
import 'package:lms/network/responsebean/UserCompleteKYCResponseBean.dart';
import 'package:lms/network/responsebean/UserKYCResponse.dart';
import 'package:lms/util/base_dio.dart';
import 'package:lms/util/constants.dart';
import 'package:lms/util/strings.dart';
import 'package:lms/widgets/WidgetCommon.dart';
import 'package:dio/dio.dart';

class CompleteKYCDao extends BaseDio {

  Future<UserCompleteKYCResponseBean> saveUserKYC(UserKYCRequest userKYCRequest) async {
    Dio dio = await getBaseDio();
    UserCompleteKYCResponseBean wrapper = UserCompleteKYCResponseBean();
    try {
      Response response = await dio.post(Constants.userKyc, data: userKYCRequest.toJson());
      if (response.statusCode == 200) {
        wrapper = UserCompleteKYCResponseBean.fromJson(response.data);
        wrapper.isSuccessFull = true;
      }
      else {
        wrapper.isSuccessFull = false;
      }
    } on DioError catch (e) {
      if (e.response == null) {
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else{
          wrapper.isSuccessFull = false;
          wrapper.errorCode = e.response!.statusCode!;
          wrapper.errorMessage = e.response!.statusMessage!;
      }
    }
    return wrapper;
  }

  Future<UserKYCResponseBean> editUserKYC(String userName, String userAddress,String userId) async {
    Dio dio = await getBaseDio();
    UserKYCResponseBean wrapper = UserKYCResponseBean();
    try {
      Response response =
      await dio.put('api/resource/User KYC/$userId',
          data: {"investor_name": userName, "address": userAddress});
      if (response.statusCode == 200) {
        wrapper = UserKYCResponseBean.fromJson(response.data);
        wrapper.isSuccessFull = true;
      }else if(response.statusCode == 401){
        wrapper.isSuccessFull = false;
      }else if(response.statusCode == 504){
        wrapper.isSuccessFull = false;
      }

      else {
        wrapper.isSuccessFull = false;
      }

    } on DioError catch (e) {

      if (e.response == null) {
        printLog("${e.response}");
        wrapper.isSuccessFull = false;
        wrapper.errorMessage = Strings.server_error_message;
        wrapper.errorCode = Constants.noInternet;
      } else {
        if(e.response!.statusCode == 417){
          wrapper.isSuccessFull = false;
        wrapper.errorMessage = "weferfertertertertertert";
        wrapper.errorCode = 417;
        }
        else{
          wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
        wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }

  Future<CkycSearchResponse> getCKYC(panCard, acceptTerms) async {
    Dio dio = await getBaseDio();
    CkycSearchResponse wrapper = CkycSearchResponse();
    try {
      Response response = await dio.post(Constants.kycSearch,
          data: {ParametersConstants.pan : panCard, ParametersConstants.acceptTerms: acceptTerms});
      if (response.statusCode == 200) {
        wrapper = CkycSearchResponse.fromJson(response.data);
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
        if (e.response!.data["message"] != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }

  Future<CkycDownloadResponse> getDownloadApi(panCard, dob, ckycNo) async {
    Dio dio = await getBaseDio();
    CkycDownloadResponse wrapper = CkycDownloadResponse();
    try {
      Response response = await dio.post(Constants.kycDownload,
          data: {ParametersConstants.pan : panCard,
            ParametersConstants.birthDate : dob,
            ParametersConstants.ckycNo: ckycNo});
      if (response.statusCode == 200) {
        wrapper = CkycDownloadResponse.fromJson(response.data);
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
        if (e.response!.data["message"] != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage!;
        }
      }
    }
    return wrapper;
  }


  // Future<ConsentDetailResponse> getConsentInfo(ckycName, acceptTerms, addressList) async {
  //   Dio dio = await getBaseDio();
  //   ConsentDetailResponse wrapper = ConsentDetailResponse();
  //   try {
  //     Response response = await dio.post(Constants.KYC_DETAILS, queryParameters: {ParametersConstants.USER_KYC_NAME : ckycName, ParametersConstants.ACCEPT_TERMS : acceptTerms, ParametersConstants.ADDRESS_DETAILS: addressList
  //     } );
  //     if (response.statusCode == 200) {
  //       wrapper = ConsentDetailResponse.fromJson(response.data);
  //       wrapper.isSuccessFull = true;
  //     } else {
  //       wrapper.isSuccessFull = false;
  //     }
  //   } on DioError catch (e) {
  //     if (e.response == null) {
  //       wrapper.isSuccessFull = false;
  //       wrapper.errorMessage = Strings.server_error_message;
  //       wrapper.errorCode = Constants.NO_INTERNET;
  //     } else {
  //       wrapper.isSuccessFull = false;
  //       wrapper.errorCode = e.response!.statusCode!;
  //       if (e.response!.data != null) {
  //         wrapper.errorMessage = e.response!.data["message"];
  //       } else {
  //         wrapper.errorMessage = e.response!.statusMessage!;
  //       }
  //     }
  //   }
  //   return wrapper;
  // }


  Future<PinCodeResponseBean> getPinCodeDetails(String pinCode) async {
    Dio dio = await getBaseDio();
    PinCodeResponseBean wrapper = PinCodeResponseBean();
    try {
      Response response = await dio.get(Constants.getPinCode, queryParameters: {ParametersConstants.pinCode : pinCode});
      if (response.statusCode == 200) {
        wrapper = PinCodeResponseBean.fromJson(response.data);
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
        if(e.response!.statusCode == 404){
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = e.response!.statusMessage!;
        }
        wrapper.isSuccessFull = false;
        wrapper.errorCode = e.response!.statusCode!;
      }
    }
    return wrapper;
  }

  Future<ConsentDetailResponseBean> consentDetails(ConsentDetailRequestBean consentDetailRequestBea) async {
    Dio dio = await getBaseDio();
    ConsentDetailResponseBean wrapper = ConsentDetailResponseBean();
    try {
      Response response = await dio.post(Constants.consentDetails, data: consentDetailRequestBea.toJson());
      if (response.statusCode == 200) {
        wrapper = ConsentDetailResponseBean.fromJson(response.data);
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
        if(e.response!.data["message"] != null) {
          wrapper.errorMessage = e.response!.data["message"];
        } else {
          wrapper.errorMessage = Strings.something_went_wrong;
        }
      }
    }
    return wrapper;
  }
}
